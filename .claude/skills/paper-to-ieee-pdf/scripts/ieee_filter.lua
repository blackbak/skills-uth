-- ieee_filter.lua
-- Pandoc Lua filter for IEEE-formatted LaTeX output.
-- Handles: citations, tables (with overflow prevention), section numbers, horizontal rules.

--- Convert pandoc citations [@key] to raw \cite{key} for BibTeX.
function Cite(cite)
  local keys = {}
  for _, c in ipairs(cite.citations) do
    table.insert(keys, c.id)
  end
  return pandoc.RawInline("latex", "\\cite{" .. table.concat(keys, ", ") .. "}")
end

--- Measure the visible plain-text length of a cell's content.
-- Strips footnotes (Note elements) before measuring so that
-- footnote body text does not inflate column width calculations.
local function cell_text_len(cell)
  local wrapper = pandoc.Div(cell.contents)
  local stripped = pandoc.walk_block(wrapper, {
    Note = function() return {} end
  })
  local text = pandoc.write(pandoc.Pandoc(stripped.content), "plain")
  text = text:gsub("%s+$", "")
  return #text
end

--- Render a cell's content to LaTeX.
local function cell_to_latex(cell)
  local content = pandoc.write(pandoc.Pandoc(cell.contents), "latex")
  content = content:gsub("\n$", "")
  return content
end

--- Build a p{} column spec string with proper alignment.
-- Requires \usepackage{array} in the template.
local function make_col_spec(alignment, width_str)
  if alignment == pandoc.AlignCenter then
    return ">{\\centering\\arraybackslash}p{" .. width_str .. "}"
  elseif alignment == pandoc.AlignRight then
    return ">{\\raggedleft\\arraybackslash}p{" .. width_str .. "}"
  else
    return ">{\\raggedright\\arraybackslash}p{" .. width_str .. "}"
  end
end

--- Convert tables to IEEE-compatible format with overflow prevention.
-- Automatically determines single-column vs two-column spanning,
-- uses p{} columns with proportional widths for text wrapping.
function Table(tbl)
  local caption = ""
  if tbl.caption and tbl.caption.long and #tbl.caption.long > 0 then
    local cap_blocks = tbl.caption.long
    caption = pandoc.write(pandoc.Pandoc(cap_blocks), "latex")
    caption = caption:gsub("%s+$", "")
  end

  local ncols = #tbl.colspecs

  -- Measure max content length per column (in plain-text characters)
  local col_max = {}
  for i = 1, ncols do col_max[i] = 0 end

  if tbl.head and tbl.head.rows and #tbl.head.rows > 0 then
    for _, row in ipairs(tbl.head.rows) do
      for i, cell in ipairs(row.cells) do
        local len = cell_text_len(cell)
        if len > col_max[i] then col_max[i] = len end
      end
    end
  end

  for _, body in ipairs(tbl.bodies) do
    for _, row in ipairs(body.body) do
      for i, cell in ipairs(row.cells) do
        local len = cell_text_len(cell)
        if len > col_max[i] then col_max[i] = len end
      end
    end
  end

  -- Calculate total max character width across all columns
  local total_chars = 0
  local any_long_cell = false
  for i = 1, ncols do
    total_chars = total_chars + col_max[i]
    if col_max[i] > 30 then any_long_cell = true end
  end

  -- Decide layout: simple l/c/r vs p{} columns, single vs two-column span
  -- IEEE single column is ~3.5in; simple l/c/r works for short, narrow tables
  local use_p_cols = any_long_cell or total_chars > 40 or ncols > 4
  local use_star = ncols > 4 or (ncols > 2 and total_chars > 70) or total_chars > 100

  local env = use_star and "table*" or "table"
  local width_cmd = use_star and "\\textwidth" or "\\columnwidth"

  -- Build column alignment string
  local align_str = ""
  if use_p_cols then
    -- Calculate proportional widths based on content length
    -- Ensure minimum width per column
    local total_weight = 0
    local col_weight = {}
    for i = 1, ncols do
      col_weight[i] = math.max(col_max[i], 3)
      total_weight = total_weight + col_weight[i]
    end

    -- Reserve space for column separators: each column has 2×\tabcolsep (12pt)
    -- \columnwidth ≈ 252pt, \textwidth ≈ 504pt in IEEE two-column layout
    local ref_width_pt = use_star and 504 or 252
    local padding_frac = (ncols * 12) / ref_width_pt
    local usable_frac = math.max(1.0 - padding_frac, 0.5)
    local specs = {}
    for i = 1, ncols do
      local frac = (col_weight[i] / total_weight) * usable_frac
      -- Enforce minimum column width of 4% to prevent collapse
      if frac < 0.04 then frac = 0.04 end
      local w = string.format("%.3f%s", frac, width_cmd)
      table.insert(specs, make_col_spec(tbl.colspecs[i][1], w))
    end
    align_str = table.concat(specs, "")
  else
    -- Simple alignment for small tables
    for _, spec in ipairs(tbl.colspecs) do
      local a = spec[1]
      if a == pandoc.AlignCenter then
        align_str = align_str .. "c"
      elseif a == pandoc.AlignRight then
        align_str = align_str .. "r"
      else
        align_str = align_str .. "l"
      end
    end
  end

  -- Choose font size: \small for most tables, \footnotesize for very wide ones
  local font_size = "\\small"
  if ncols > 5 or (use_star and total_chars > 120) then
    font_size = "\\footnotesize"
  end

  -- Build the LaTeX output
  local lines = {}
  table.insert(lines, "\\begin{" .. env .. "}[htbp]")
  if caption ~= "" then
    table.insert(lines, "\\caption{" .. caption .. "}")
  end
  table.insert(lines, "\\centering")
  table.insert(lines, font_size)
  table.insert(lines, "\\begin{tabular}{" .. align_str .. "}")
  table.insert(lines, "\\toprule")

  -- Header rows
  if tbl.head and tbl.head.rows and #tbl.head.rows > 0 then
    for _, row in ipairs(tbl.head.rows) do
      local cells = {}
      for _, cell in ipairs(row.cells) do
        table.insert(cells, cell_to_latex(cell))
      end
      table.insert(lines, table.concat(cells, " & ") .. " \\\\")
    end
    table.insert(lines, "\\midrule")
  end

  -- Body rows
  for _, body in ipairs(tbl.bodies) do
    for _, row in ipairs(body.body) do
      local cells = {}
      for _, cell in ipairs(row.cells) do
        table.insert(cells, cell_to_latex(cell))
      end
      table.insert(lines, table.concat(cells, " & ") .. " \\\\")
    end
  end

  table.insert(lines, "\\bottomrule")
  table.insert(lines, "\\end{tabular}")
  table.insert(lines, "\\end{" .. env .. "}")

  return pandoc.RawBlock("latex", table.concat(lines, "\n"))
end

--- Strip leading section numbers from headers.
-- Markdown "## 1. Introduction" becomes \section{Introduction}
-- (IEEEtran handles numbering automatically).
function Header(el)
  -- Remove H1 entirely (title is in YAML metadata)
  if el.level == 1 then
    return {}
  end

  -- Strip leading "N." or "N.N" or "N.N.N" patterns
  if el.content[1] and el.content[1].t == "Str" then
    local s = el.content[1].text
    local stripped = s:match("^%d+%.?%d*%.?%d*%.?%s*(.+)$")
    if stripped then
      el.content[1].text = stripped
    elseif s:match("^%d+%.?%d*%.?%d*%.?$") then
      -- Number is the entire first Str element; remove it and trailing space
      table.remove(el.content, 1)
      if el.content[1] and el.content[1].t == "Space" then
        table.remove(el.content, 1)
      end
    end
  end

  return el
end

--- Remove horizontal rules (markdown --- dividers).
function HorizontalRule()
  return {}
end
