-- Set comment strings and tabwidths
vim.cmd("setglobal commentstring=#%s")
vim.api.nvim_create_autocmd(
  "Filetype",
  {pattern = {"r", "html", "html.mustache", "lua", "vim"}, command = "setlocal ts=2 sts=2 sw=2"}
)
vim.api.nvim_create_autocmd("Filetype", {pattern = "autohotkey", command = "setlocal commentstring=;%s"})
vim.api.nvim_create_autocmd("Filetype", {pattern = "sql", command = "setlocal commentstring=--%s"})

-- When editing a file, always jump to the last known cursor position.
-- Don't do it when the position is invalid or when inside an event handler
-- (happens when dropping a file on gvim).
-- Also don't do it when the mark is in the first line, that is the default
-- position when opening a file.
-- Create an autocmd for when a buffer is read after being loaded
vim.api.nvim_create_autocmd(
  "BufReadPost",
  {
    callback = function()
      -- Check if the last edited position is inside the current buffer
      if vim.fn.line('\'"') > 1 and (vim.fn.line('\'"') <= vim.fn.line("$")) then
        -- Move the cursor to the last edited position
        vim.cmd('normal! g`"')
      end
    end
  }
)

-- Ibus can toggle input method by itself, so this autocmd is not needed.
-- Create an autocmd that is triggered when leaving insert mode.
-- The callback function is set to 'toggle_input_method'.
vim.api.nvim_create_autocmd("InsertLeave", {callback = require("utils").toggle_input_method})

--- Sets up an autocmd to highlight text after a yank operation
vim.api.nvim_create_autocmd(
  "TextYankPost",
  {
    -- The function to call when the autocmd is triggered
    -- Highlights the yanked text with "IncSearch" highlight group
    callback = function()
      vim.highlight.on_yank {higroup = "IncSearch", timeout = 700}
    end
  }
)

vim.cmd [[
  " Never do this again --> :set paste <ctrl-v> :set no paste
  let &t_SI .= "\<Esc>[?2004h"
  let &t_EI .= "\<Esc>[?2004l"

  function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
  endfunction
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
]]

-- Nice mappings for quickfix window. nvim_create_autocmd is not working with
-- fzf-lua.
-- vim.cmd [[
--  au FileType qf map D <cmd>lua require("utils").remove_qf_item()<cr>
--  au FileType qf map K [f
--  au FileType qf map J ]f
-- ]]
