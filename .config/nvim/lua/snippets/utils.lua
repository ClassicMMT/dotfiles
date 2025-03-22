local ls = require "luasnip"
local rmd_snippets = require "snippets.rmd"

local M = {}

M.get_cursor_position = function()
  -- returns the position of the cursor
  return vim.api.nvim_win_get_cursor(0)
end

M.check_if_inside_r_chunk = function()
  -- returns true if there's a line starting with ```{r above, otherwise returns false
  local unpack = unpack or table.unpack
  local cursor_row, _ = unpack(M.get_cursor_position())

  while cursor_row > 0 do
    local line = vim.api.nvim_buf_get_lines(0, cursor_row - 1, cursor_row, false)[1]
    -- return true if line begins with ```{r
    if line:match "^```{r.+" then
      return true
      -- return false if line begins with just ```
    elseif line:match "^```$" then
      return false
    end
    cursor_row = cursor_row - 1
  end

  -- return false if BOF is reached
  return false
end

M.insert_r_chunk = function()
  local is_inside_chunk = M.check_if_inside_r_chunk()
  if is_inside_chunk then
    ls.snip_expand(rmd_snippets.r_chunk_inverted)
  else
    ls.snip_expand(rmd_snippets.r_chunk)
  end
end

M.insert_r_chunk_visual = function()
  -- yank text to z register
  vim.cmd 'silent normal! "zy'
  -- reselect the text and delete it to the black hole register
  vim.cmd 'silent normal! gv"_d'
  -- expand code chunk
  ls.snip_expand(rmd_snippets.r_chunk_visual)
  -- exit insert mode
  vim.cmd "stopinsert"
  -- paste text
  vim.cmd 'normal! "zP>'
end

return M
