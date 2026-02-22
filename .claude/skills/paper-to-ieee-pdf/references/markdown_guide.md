# Markdown Format for IEEE Papers

Complete guide to writing markdown that converts cleanly to IEEE-formatted PDF.

## YAML Frontmatter (Required)

Every paper must start with YAML frontmatter between `---` delimiters.

### Conference Paper

```yaml
---
title: "Your Paper Title Here"
author:
  - name: "First Author"
    department: "Department of Computer Science"
    affiliation: "University Name"
    city: "City, State, Country"
    email: "first@university.edu"
  - name: "Second Author"
    department: "School of Engineering"
    affiliation: "Other University"
    city: "City, Country"
    email: "second@other.edu"
abstract: |
  Write the abstract as a single block of text. Use the pipe (|)
  character to preserve line breaks in YAML. The abstract should
  be 150-250 words for conference papers.
keywords:
  - keyword one
  - keyword two
  - keyword three
bibliography: references.bib
---
```

### Journal Paper

```yaml
---
title: "Your Journal Paper Title"
author:
  - name: "First Author"
    affiliation: "University Name"
    email: "first@university.edu"
  - name: "Second Author"
    affiliation: "Other University"
journal-name: "IEEE Transactions on Your Field"
thanks: "This work was supported by Grant XYZ."
abstract: |
  Journal abstracts are typically 200-300 words.
keywords:
  - keyword one
  - keyword two
bibliography: references.bib
bio:
  - name: "First Author"
    photo: "figures/author1.jpg"
    text: "received the Ph.D. degree from..."
---
```

### Required Fields

| Field | Description |
|-------|-------------|
| `title` | Paper title (quoted string) |
| `author` | List of authors with `name` (required), `affiliation`, `email`, `department`, `city` |
| `abstract` | Abstract text (use `\|` for multiline) |

### Optional Fields

| Field | Description |
|-------|-------------|
| `keywords` | List of IEEE keywords |
| `bibliography` | Path to `.bib` file (relative to markdown file) |
| `journal-name` | Journal name for header (journal papers only) |
| `thanks` | Acknowledgment footnote |
| `bio` | Author biographies with photos (journal papers only) |

## Sections

Use markdown headers **without manual numbering**. IEEEtran numbers sections automatically.

```markdown
## Introduction

Your introduction text.

## Related Work

### Multi-Agent Systems

Subsection content.

### Evaluation Methods

Another subsection.

## Methodology

## Results

## Conclusion
```

If your markdown has numbered sections (`## 1. Introduction`), the converter strips the numbers automatically.

## Citations

### Recommended: Pandoc Citation Syntax

Use `[@key]` where `key` matches a BibTeX entry:

```markdown
Prior work [@smith2023] demonstrates this approach.
Multiple citations [@smith2023; @jones2024] support the claim.
```

This generates `\cite{smith2023}` and `\cite{smith2023, jones2024}` in LaTeX, and BibTeX resolves the numbered references automatically.

### BibTeX File Format

```bibtex
@article{smith2023,
  title={Paper Title},
  author={Smith, John and Doe, Jane},
  journal={IEEE Transactions on Example},
  year={2023},
  volume={42},
  number={3},
  pages={100--110}
}

@inproceedings{jones2024,
  title={Conference Paper Title},
  author={Jones, Alice},
  booktitle={Proceedings of IEEE Conference},
  year={2024},
  pages={1--8}
}
```

### Manual Citations

If you use `[1]`, `[2, 3]` style, they pass through as plain text. You must then write the references section manually in markdown. BibTeX will not process them.

## Figures

```markdown
![Caption text for the figure](figures/diagram.png){#fig:diagram}
```

Supported formats: PNG, PDF, EPS, JPG. Use PDF or EPS for vector graphics (best quality). The converter copies figures from paths relative to the markdown file.

For wide figures spanning both columns, use raw LaTeX:

```markdown
\begin{figure*}[htbp]
\centering
\includegraphics[width=\textwidth]{figures/wide-diagram.png}
\caption{A wide figure spanning both columns.}
\label{fig:wide}
\end{figure*}
```

## Tables

Standard markdown pipe tables convert to IEEE `tabular` format:

```markdown
| Method | Precision | Recall | F1 |
|--------|-----------|--------|----|
| Baseline | 0.72 | 0.68 | 0.70 |
| Ours | **0.89** | **0.85** | **0.87** |

: Comparison of methods on the benchmark dataset.
```

The line starting with `:` becomes the table caption.

For wide tables spanning both columns, use raw LaTeX:

```markdown
\begin{table*}[htbp]
\caption{Wide table spanning both columns}
\centering
\begin{tabular}{lcccccc}
\toprule
Method & Metric 1 & Metric 2 & Metric 3 & Metric 4 & Metric 5 & Metric 6 \\
\midrule
Baseline & 0.5 & 0.6 & 0.7 & 0.8 & 0.9 & 1.0 \\
\bottomrule
\end{tabular}
\end{table*}
```

## Equations

Inline math uses single dollars: `$E = mc^2$`

Display equations use double dollars:

```markdown
$$
\mathcal{L}(\theta) = -\sum_{i=1}^{N} \log p(y_i | x_i; \theta)
$$
```

For numbered equations with labels, use raw LaTeX:

```markdown
\begin{equation}
\label{eq:loss}
\mathcal{L}(\theta) = -\sum_{i=1}^{N} \log p(y_i | x_i; \theta)
\end{equation}

As shown in Equation~\ref{eq:loss}, the loss function...
```

## Code Blocks

Fenced code blocks with syntax highlighting:

````markdown
```python
def train(model, data):
    for batch in data:
        loss = model(batch)
        loss.backward()
```
````

## Lists

Standard markdown lists work directly:

```markdown
- First item
- Second item
  - Nested item
- Third item

1. Numbered item
2. Another item
```

## Cross-References

Use raw LaTeX for cross-references to figures, tables, and equations:

```markdown
As shown in Fig.~\ref{fig:diagram}, the architecture...
Table~\ref{tab:results} summarizes the findings.
Equation~\ref{eq:loss} defines the objective.
```

## Footnotes

```markdown
This claim requires clarification[^1].

[^1]: Additional detail about the claim.
```

## Raw LaTeX

Any raw LaTeX passes through directly. Use this for IEEE-specific commands:

```markdown
\IEEEPARstart{T}{his} paper presents a novel approach...
```

## Tips

- Keep lines under 80 characters for readable diffs
- Use one sentence per line for easier revision tracking
- Place each figure in a `figures/` directory next to the markdown file
- Use PDF figures for vector graphics, PNG for rasterized content
- Run the converter with `--keep-tex` to inspect the intermediate LaTeX
