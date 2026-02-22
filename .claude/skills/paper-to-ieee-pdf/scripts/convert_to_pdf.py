#!/usr/bin/env python3
"""Convert a Markdown paper to IEEE-formatted PDF.

Usage:
    python convert_to_pdf.py <input.md> [--bib refs.bib] [-o out.pdf] [--type conference|journal]
"""

import argparse
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
SKILL_DIR = SCRIPT_DIR.parent
ASSETS_DIR = SKILL_DIR / "assets"

REQUIRED_FIELDS = ["title", "author", "abstract"]


def check_dependencies():
    """Verify pandoc and pdflatex are available."""
    missing = []
    for cmd in ["pandoc", "pdflatex", "bibtex"]:
        if shutil.which(cmd) is None:
            missing.append(cmd)
    if missing:
        setup = SCRIPT_DIR / "setup_deps.sh"
        print(f"ERROR: Missing dependencies: {', '.join(missing)}")
        print(f"Install them: bash {setup}")
        sys.exit(1)


def parse_args():
    parser = argparse.ArgumentParser(
        description="Convert Markdown paper to IEEE-formatted PDF"
    )
    parser.add_argument("input", help="Path to markdown file")
    parser.add_argument("--bib", help="Path to BibTeX bibliography file")
    parser.add_argument("--output", "-o", help="Output PDF path")
    parser.add_argument(
        "--type",
        choices=["conference", "journal"],
        default="conference",
        help="IEEE paper type (default: conference)",
    )
    parser.add_argument(
        "--keep-tex",
        action="store_true",
        help="Keep intermediate .tex file",
    )
    return parser.parse_args()


def split_frontmatter(content):
    """Split YAML frontmatter from markdown body."""
    match = re.match(r"^---\s*\n(.*?\n)---\s*\n(.*)$", content, re.DOTALL)
    if match:
        return match.group(1), match.group(2)
    return "", content


def validate_frontmatter(frontmatter_text):
    """Check that required YAML fields are present."""
    missing = []
    for field in REQUIRED_FIELDS:
        pattern = rf"^{field}\s*:"
        if not re.search(pattern, frontmatter_text, re.MULTILINE):
            missing.append(field)
    if missing:
        print(f"ERROR: Missing required YAML frontmatter fields: {', '.join(missing)}")
        print("Required format:")
        print("---")
        print('title: "Paper Title"')
        print("author:")
        print('  - name: "Author Name"')
        print('    affiliation: "University"')
        print("abstract: |")
        print("  Your abstract text.")
        print("---")
        print(
            "\nSee references/markdown_guide.md for the complete format specification."
        )
        sys.exit(1)


def detect_citation_style(body):
    """Detect if citations use pandoc [@key] or manual [N] style."""
    pandoc_cites = re.findall(r"\[@[\w][\w.-]*(?:;\s*@[\w][\w.-]*)*\]", body)
    return "pandoc" if pandoc_cites else "manual"


def strip_h1_title(body):
    """Remove H1 header from body (title comes from YAML metadata)."""
    return re.sub(r"^#\s+.+\n+", "", body, count=1)


def strip_metadata_lines(body):
    """Remove lines like **Target venue:** and **Preprint:** after the title."""
    body = re.sub(r"^\*\*Target venue:\*\*.*\n?", "", body, flags=re.MULTILINE)
    body = re.sub(r"^\*\*Preprint:\*\*.*\n?", "", body, flags=re.MULTILINE)
    body = re.sub(r"^\*\*Keywords:\*\*.*\n?", "", body, flags=re.MULTILINE)
    return body


def strip_horizontal_rules(body):
    """Remove markdown horizontal rules (--- dividers between sections)."""
    return re.sub(r"^\s*---\s*$", "", body, flags=re.MULTILINE)


def preprocess_body(body):
    """Clean up markdown body for IEEE conversion."""
    body = strip_h1_title(body)
    body = strip_metadata_lines(body)
    body = strip_horizontal_rules(body)
    return body


def resolve_bib_path(md_path, bib_arg, frontmatter_text):
    """Find the bibliography file."""
    md_dir = Path(md_path).parent

    if bib_arg:
        bib = Path(bib_arg)
        if bib.exists():
            return bib
        bib = md_dir / bib_arg
        if bib.exists():
            return bib
        print(f"ERROR: Bibliography file not found: {bib_arg}")
        sys.exit(1)

    bib_match = re.search(r"bibliography:\s*(.+)", frontmatter_text)
    if bib_match:
        bib_name = bib_match.group(1).strip().strip("\"'")
        bib = md_dir / bib_name
        if bib.exists():
            return bib

    bib_files = list(md_dir.glob("*.bib"))
    if len(bib_files) == 1:
        return bib_files[0]
    if len(bib_files) > 1:
        print(f"NOTE: Multiple .bib files found. Using: {bib_files[0].name}")
        return bib_files[0]

    return None


def copy_figures(md_path, body, work_dir):
    """Copy referenced figures to the work directory."""
    md_dir = Path(md_path).parent
    fig_paths = re.findall(r"!\[.*?\]\((.+?)\)", body)
    for fig in fig_paths:
        if fig.startswith("http://") or fig.startswith("https://"):
            continue
        src = md_dir / fig
        if src.exists():
            dst = Path(work_dir) / fig
            dst.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(src, dst)
        else:
            print(f"WARNING: Figure not found: {src}")


def run_pandoc(md_path, work_dir, template, lua_filter, bib_path):
    """Convert markdown to LaTeX using pandoc."""
    tex_path = Path(work_dir) / "paper.tex"

    extensions = "+".join([
        "yaml_metadata_block",
        "citations",
        "raw_tex",
        "implicit_figures",
        "pipe_tables",
        "grid_tables",
        "fenced_code_blocks",
        "backtick_code_blocks",
        "inline_code_attributes",
        "tex_math_dollars",
        "tex_math_double_backslash",
        "strikeout",
        "superscript",
        "subscript",
        "footnotes",
    ])

    cmd = [
        "pandoc",
        str(md_path),
        f"--from=markdown+{extensions}",
        "--to=latex",
        f"--template={template}",
        f"--lua-filter={lua_filter}",
        f"--output={tex_path}",
        "--standalone",
        "--wrap=none",
        "--shift-heading-level-by=-1",
    ]

    if bib_path:
        bib_stem = Path(bib_path).stem
        cmd.append(f"--metadata=bibliography:{bib_stem}")

    result = subprocess.run(cmd, capture_output=True, text=True, cwd=work_dir)
    if result.returncode != 0:
        print(f"ERROR: pandoc conversion failed:\n{result.stderr}")
        sys.exit(1)
    if result.stderr:
        for line in result.stderr.strip().split("\n"):
            if line.strip():
                print(f"  pandoc: {line}")

    return tex_path


def run_latex(cmd, desc, work_dir):
    """Run a LaTeX tool and handle errors."""
    result = subprocess.run(
        cmd,
        capture_output=True,
        text=True,
        cwd=work_dir,
        timeout=120,
    )
    if result.returncode != 0:
        log_content = result.stdout + result.stderr
        fatal_lines = [
            line
            for line in log_content.split("\n")
            if line.startswith("!") or "Fatal error" in line
        ]
        if fatal_lines:
            print(f"ERROR: {desc} failed:")
            for line in fatal_lines[:10]:
                print(f"  {line}")
            return False
    return True


def run_latex_pipeline(work_dir, has_bib):
    """Run pdflatex -> bibtex -> pdflatex -> pdflatex."""
    pdflatex_cmd = [
        "pdflatex",
        "-interaction=nonstopmode",
        "-halt-on-error",
        "paper.tex",
    ]

    if not run_latex(pdflatex_cmd, "pdflatex (pass 1)", work_dir):
        sys.exit(1)

    if has_bib:
        aux_path = Path(work_dir) / "paper.aux"
        if aux_path.exists():
            aux_content = aux_path.read_text()
            if "\\citation" in aux_content or "\\bibdata" in aux_content:
                run_latex(["bibtex", "paper"], "bibtex", work_dir)

    if not run_latex(pdflatex_cmd, "pdflatex (pass 2)", work_dir):
        sys.exit(1)

    if not run_latex(pdflatex_cmd, "pdflatex (pass 3)", work_dir):
        sys.exit(1)


def main():
    check_dependencies()
    args = parse_args()

    input_path = Path(args.input).resolve()
    if not input_path.exists():
        print(f"ERROR: Input file not found: {input_path}")
        sys.exit(1)

    content = input_path.read_text(encoding="utf-8")
    frontmatter, body = split_frontmatter(content)

    if not frontmatter.strip():
        print("ERROR: No YAML frontmatter found.")
        print("The markdown file must start with --- delimited YAML metadata.")
        print("See references/markdown_guide.md for the required format.")
        sys.exit(1)

    validate_frontmatter(frontmatter)

    cite_style = detect_citation_style(body)
    if cite_style == "manual":
        print(
            "NOTE: Detected manual [N] citations. For automatic bibliography,\n"
            "      use pandoc-style [@key] citations with a .bib file.\n"
            "      See references/markdown_guide.md for details."
        )

    body = preprocess_body(body)

    bib_path = resolve_bib_path(input_path, args.bib, frontmatter)

    template = ASSETS_DIR / f"ieee-{args.type}.tex"
    lua_filter = SCRIPT_DIR / "ieee_filter.lua"

    if not template.exists():
        print(f"ERROR: Template not found: {template}")
        sys.exit(1)
    if not lua_filter.exists():
        print(f"ERROR: Lua filter not found: {lua_filter}")
        sys.exit(1)

    with tempfile.TemporaryDirectory(prefix="ieee-pdf-") as work_dir:
        if bib_path:
            shutil.copy2(bib_path, work_dir)
            print(f"  Bibliography: {bib_path.name}")

        copy_figures(input_path, body, work_dir)

        work_md = Path(work_dir) / "paper.md"
        preprocessed = f"---\n{frontmatter}---\n\n{body}"
        work_md.write_text(preprocessed, encoding="utf-8")

        print(f"  Format: IEEE {args.type}")
        print(f"  Converting to LaTeX...")
        tex_path = run_pandoc(
            work_md, work_dir, template, lua_filter, bib_path
        )

        print(f"  Compiling PDF...")
        run_latex_pipeline(work_dir, bib_path is not None)

        pdf_path = Path(work_dir) / "paper.pdf"
        if not pdf_path.exists():
            print("\nERROR: PDF was not generated. Check errors above.")
            log_path = Path(work_dir) / "paper.log"
            if log_path.exists():
                log_text = log_path.read_text()
                error_lines = [
                    l for l in log_text.split("\n") if l.startswith("!")
                ]
                if error_lines:
                    print("LaTeX errors:")
                    for line in error_lines[:10]:
                        print(f"  {line}")
            sys.exit(1)

        output = Path(args.output) if args.output else input_path.with_suffix(".pdf")
        output.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(pdf_path, output)

        size_kb = output.stat().st_size / 1024
        print(f"\n  PDF: {output} ({size_kb:.0f} KB)")

        if args.keep_tex:
            tex_out = output.with_suffix(".tex")
            shutil.copy2(tex_path, tex_out)
            print(f"  TeX: {tex_out}")


if __name__ == "__main__":
    main()
