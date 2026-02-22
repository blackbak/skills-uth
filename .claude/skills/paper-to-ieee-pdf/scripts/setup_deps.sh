#!/bin/bash
# Install dependencies for paper-to-ieee-pdf conversion.
# Supports macOS (Homebrew) and Linux (apt).
set -e

echo "=== IEEE PDF Conversion: Dependency Check ==="
echo ""

MISSING=0

# --- pandoc ---
if command -v pandoc &> /dev/null; then
    VERSION=$(pandoc --version | head -1)
    echo "[OK] $VERSION"
else
    echo "[MISSING] pandoc"
    MISSING=1
    if command -v brew &> /dev/null; then
        echo "  Installing via Homebrew..."
        brew install pandoc
        echo "[OK] $(pandoc --version | head -1)"
    elif command -v apt-get &> /dev/null; then
        echo "  Installing via apt..."
        sudo apt-get update && sudo apt-get install -y pandoc
        echo "[OK] $(pandoc --version | head -1)"
    else
        echo "  Install manually: https://pandoc.org/installing.html"
    fi
fi

# --- LaTeX (pdflatex) ---
if command -v pdflatex &> /dev/null; then
    VERSION=$(pdflatex --version | head -1)
    echo "[OK] $VERSION"
else
    echo "[MISSING] pdflatex (LaTeX distribution)"
    MISSING=1
    if command -v brew &> /dev/null; then
        echo "  Installing BasicTeX via Homebrew (this may take a few minutes)..."
        brew install --cask basictex
        # Update PATH for current session
        eval "$(/usr/libexec/path_helper)"
        export PATH="/Library/TeX/texbin:$PATH"
        echo "[OK] BasicTeX installed"
    elif command -v apt-get &> /dev/null; then
        echo "  Installing texlive via apt..."
        sudo apt-get update && sudo apt-get install -y \
            texlive-base \
            texlive-latex-recommended \
            texlive-publishers \
            texlive-bibtex-extra \
            texlive-science
        echo "[OK] texlive installed"
    else
        echo "  Install a TeX distribution:"
        echo "    macOS:  brew install --cask basictex"
        echo "    Linux:  sudo apt install texlive-base texlive-publishers"
        echo "    All:    https://www.tug.org/texlive/"
    fi
fi

# --- bibtex ---
if command -v bibtex &> /dev/null; then
    echo "[OK] bibtex available"
else
    echo "[MISSING] bibtex (should come with your TeX distribution)"
    MISSING=1
fi

# --- IEEEtran LaTeX class ---
if command -v kpsewhich &> /dev/null; then
    if kpsewhich IEEEtran.cls &> /dev/null; then
        echo "[OK] IEEEtran.cls found: $(kpsewhich IEEEtran.cls)"
    else
        echo "[MISSING] IEEEtran.cls"
        echo "  Installing via tlmgr..."
        if command -v tlmgr &> /dev/null; then
            sudo tlmgr update --self 2>/dev/null || true
            sudo tlmgr install ieeetran
            echo "[OK] IEEEtran installed"
        else
            echo "  tlmgr not found. Install IEEEtran manually."
        fi
    fi
fi

# --- Required LaTeX packages (BasicTeX may not have all of these) ---
if command -v tlmgr &> /dev/null; then
    PACKAGES=(
        "ieeetran"
        "cite"
        "amsmath"
        "booktabs"
        "xcolor"
        "hyperref"
        "url"
        "etoolbox"
        "fancyvrb"
        "upquote"
        "microtype"
    )
    echo ""
    echo "Checking LaTeX packages..."
    TO_INSTALL=()
    for pkg in "${PACKAGES[@]}"; do
        if ! kpsewhich "$pkg.sty" &> /dev/null && ! kpsewhich "$pkg.cls" &> /dev/null; then
            TO_INSTALL+=("$pkg")
        fi
    done
    if [ ${#TO_INSTALL[@]} -gt 0 ]; then
        echo "  Installing: ${TO_INSTALL[*]}"
        sudo tlmgr install "${TO_INSTALL[@]}" 2>/dev/null || {
            echo "  WARNING: Some packages failed to install via tlmgr."
            echo "  Try: sudo tlmgr update --self && sudo tlmgr install ${TO_INSTALL[*]}"
        }
    else
        echo "[OK] All required LaTeX packages present"
    fi
fi

echo ""
if command -v pandoc &> /dev/null && command -v pdflatex &> /dev/null && command -v bibtex &> /dev/null; then
    echo "=== All dependencies ready ==="
else
    echo "=== Some dependencies are still missing. See messages above. ==="
    exit 1
fi
