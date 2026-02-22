---
name: paper-to-ieee-pdf
description: "Converts a Markdown research paper to a submission-ready IEEE-formatted PDF. Handles two-column layout, IEEE typography, BibTeX citations, figures, tables, and equations. Supports conference and journal formats. Use when the user wants to generate an IEEE PDF from a markdown paper, convert a draft to IEEE format, or prepare a camera-ready submission."
---

# Paper to IEEE PDF

Convert a Markdown research paper with YAML frontmatter and BibTeX references into a submission-ready IEEE-formatted PDF (conference or journal).

## Quick Start

```bash
python scripts/convert_to_pdf.py paper.md --bib references.bib
```

Output: `paper.pdf` in IEEE two-column format.

## Prerequisites

Install pandoc and a LaTeX distribution:

```bash
bash scripts/setup_deps.sh
```

Required tools: `pandoc` (3.0+), `pdflatex`, `bibtex`. The setup script installs them via Homebrew (macOS) or apt (Linux) and adds the `ieeetran` LaTeX class.

## Markdown Format

Papers must include YAML frontmatter with title, authors, and abstract. See [references/markdown_guide.md](references/markdown_guide.md) for the complete format specification.

Minimal example:

```yaml
---
title: "Your Paper Title"
author:
  - name: "Author Name"
    affiliation: "University"
    email: "author@example.com"
abstract: |
  Your abstract here.
keywords:
  - keyword1
  - keyword2
bibliography: references.bib
---

## Introduction

Your paper body here. Cite with [@key] syntax.
```

## Conversion Workflow

1. **Validate** the markdown has required YAML frontmatter fields
2. **Preprocess** the markdown (strip manual section numbers, handle H1 title)
3. **Convert** to LaTeX via pandoc using the IEEE template and Lua filter
4. **Compile** via the standard `pdflatex -> bibtex -> pdflatex -> pdflatex` pipeline
5. **Output** the final PDF

## Usage

```bash
# Conference paper (default)
python scripts/convert_to_pdf.py paper.md

# Journal paper
python scripts/convert_to_pdf.py paper.md --type journal

# Explicit bibliography and output path
python scripts/convert_to_pdf.py paper.md --bib refs.bib -o output.pdf

# Keep intermediate .tex for debugging
python scripts/convert_to_pdf.py paper.md --keep-tex
```

### Arguments

| Argument | Description |
|----------|-------------|
| `input` | Path to markdown file (required) |
| `--bib` | Path to BibTeX file (auto-detected if omitted) |
| `--output, -o` | Output PDF path (defaults to `input.pdf`) |
| `--type` | `conference` (default) or `journal` |
| `--keep-tex` | Preserve intermediate `.tex` file |

## Citation Styles

**Recommended:** Use pandoc citation syntax linked to BibTeX keys:

```markdown
Prior work [@smith2023, @jones2024] demonstrates this.
```

This generates `\cite{smith2023, jones2024}` and BibTeX resolves numbering automatically.

**Manual citations** (`[1]`, `[2, 3]`) pass through as plain text. The bibliography must then be written manually in the markdown body — BibTeX will not process them.

## Bundled Resources

| File | Purpose |
|------|---------|
| `scripts/convert_to_pdf.py` | Main conversion pipeline |
| `scripts/setup_deps.sh` | Dependency installer |
| `scripts/ieee_filter.lua` | Pandoc Lua filter (citations, tables, figures) |
| `assets/ieee-conference.tex` | Pandoc template for IEEE conference papers |
| `assets/ieee-journal.tex` | Pandoc template for IEEE journal papers |
| `references/markdown_guide.md` | Complete markdown format specification |

## Troubleshooting

**"Missing dependencies"** — Run `bash scripts/setup_deps.sh` to install pandoc and LaTeX.

**"IEEEtran.cls not found"** — Run `sudo tlmgr install ieeetran` to install the IEEE LaTeX class.

**Tables overflow columns** — The Lua filter converts tables to single-column `tabular`. For wide tables, use fewer columns or abbreviate content.

**Citations show as [?]** — Verify `.bib` keys match `[@key]` references. Run with `--keep-tex` and check the `.blg` file for BibTeX errors.

**Figures not found** — Use paths relative to the markdown file. The script copies referenced images to the build directory.
