# NICE-TEAS EUROPE 2026 — Submission Package

Springer **LNNS** (Lecture Notes in Networks and Systems) camera-ready format,
matching the conference's `Sample-Latex-paper.pdf` (Springer `llncs` class).

**Paper:** Skill Architecture Matters: How Autonomous Feedback Loops Transform
LLM Agent Design Quality
**Authors:** Ioannis Bakagiannis, Vassilis C. Gerogiannis (Dept. of Digital
Systems, University of Thessaly, Larisa, Greece)

## Files

| File | Purpose |
|------|---------|
| `paper.pdf` | **Submission PDF** — 12 pages, A4, fonts embedded |
| `paper.tex` | LaTeX source (`llncs` class, `a4paper`) |
| `references.bib` | BibTeX database (24 references) |
| `paper.bbl` | Compiled bibliography (so it builds without re-running BibTeX) |
| `llncs.cls` | Springer LNCS/LNNS class v2.26 (official, from CTAN) |
| `splncs04.bst` | Springer LNCS BibTeX style |
| `screenshots/` | Figure images (desktop + mobile, 3 each) |

## Recompile

```sh
pdflatex paper
bibtex   paper
pdflatex paper
pdflatex paper
```

## Conformance to the Call for Papers

- **Format:** Springer `llncs` (LNNS proceedings), matching the sample LaTeX paper.
- **Paper size:** A4 (`\documentclass[a4paper]{llncs}`).
- **No page numbers / headers / footers:** `\pagestyle{empty}`.
- **Required elements:** title, abstract (~140 words, within the 70–150 limit),
  keywords, authors, affiliation, emails — all present.
- **Length:** 12 pages. The CFP sets a 10-page included limit with a **€50/page**
  charge beyond it, so this incurs ~**€100** overage (2 pages). This was a
  deliberate choice to keep all 6 tables and both figures; a 10-page variant
  would require removing core results evidence.
- **Submit via:** Microsoft CMT (per the CFP).

## Notes

- The paper was adapted from the IEEE-formatted draft in `../final/`; content is
  unchanged except for tightening to LNCS and removing venue-specific (CHI)
  framing.
- Fonts are Latin Modern (vector, embedded) — not bitmap.
