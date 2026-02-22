-- ieee_filter.lua
-- Pandoc Lua filter for IEEE-formatted LaTeX output.
-- Handles: citations, tables, section numbers, horizontal rules.

--- Convert pandoc citations [@key] to raw \cite{key} for BibTeX.
function Cite(cite)
  local keys = {}
  for _, c in ipairs(cite.citations) do
    table.insert(keys, c.id)
  end
  return pandoc.RawInline("latex", "\\cite{" .. table.concat(keys, ", ") .. "}")
end

--- Convert tables to IEEE-compatible tabular (not longtable).
-- IEEEtran uses two-column layout; longtable does not work in columns.
function Table(tbl)
  local caption = ""
  if tbl.caption and tbl.caption.long and #tbl.caption.long > 0 then
    local cap_blocks = tbl.caption.long
    caption = pandoc.write(pandoc.Pandoc(cap_blocks), "latex")
    caption = caption:gsub("%s+$", "")
  end

  local ncols = #tbl.colspecs
  local align_str = ""
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

  local lines = {}
  table.insert(lines, "\\begin{table}[htbp]")
  if caption ~= "" then
    table.insert(lines, "\\caption{" .. caption .. "}")
  end
  table.insert(lines, "\\centering")
  table.insert(lines, "\\begin{tabular}{" .. align_str .. "}")
  table.insert(lines, "\\toprule")

  -- Header rows
  if tbl.head and tbl.head.rows and #tbl.head.rows > 0 then
    for _, row in ipairs(tbl.head.rows) do
      local cells = {}
      for _, cell in ipairs(row.cells) do
        local content = pandoc.write(pandoc.Pandoc(cell.contents), "latex")
        content = content:gsub("\n$", "")
        table.insert(cells, content)
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
        local content = pandoc.write(pandoc.Pandoc(cell.contents), "latex")
        content = content:gsub("\n$", "")
        table.insert(cells, content)
      end
      table.insert(lines, table.concat(cells, " & ") .. " \\\\")
    end
  end

  table.insert(lines, "\\bottomrule")
  table.insert(lines, "\\end{tabular}")
  table.insert(lines, "\\end{table}")

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
