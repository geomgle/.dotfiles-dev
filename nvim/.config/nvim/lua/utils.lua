local M = {}

local loop = vim.loop
local ts_utils = require "nvim-treesitter.ts_utils"

-- This function moves the cursor to the first floating window that is focusable and not relative.
M.goto_first_float = function()
  -- Iterating through all the windows of the current tabpage
  for w = 1, vim.fn.winnr("$") do
    -- Retrieving the configuration of the current window
    local c = vim.api.nvim_win_get_config(vim.fn.win_getid(w))

    -- Checking if the window is focusable and not relative
    if c.focusable and not (c.relative == "") then
      -- Moving the cursor to the window
      vim.api.nvim_command(w .. "wincmd w")
      break -- We found our floating window, so no need to iterate further
    end
  end
end

-- Toggles zoom state of the current window.
-- If the window is the only window open, then it toggles full-screen zoom.
-- If the window is not the only window open, then it toggles a split-screen zoom.
M.toggle_zoom = function()
  -- If only one window is open, toggle full-screen zoom.
  if vim.fn.winnr("$") == 1 then
    vim.cmd("silent !tmux resize-pane -Z")
    return
  end

  -- If more than one window is open, toggle split-screen zoom.
  if vim.fn.eval('exists("t:zoomed") && t:zoomed') ~= 0 then
    vim.cmd [[
      execute t:zoom_winrestcmd
      let t:zoomed = 0
    ]]
  else
    vim.cmd [[
      let t:zoom_winrestcmd = winrestcmd()
      resize
      vertical resize
      let t:zoomed = 1
    ]]
  end
end

-- This function will check if the current buffer is the last open buffer in the editor.
-- If it is, then it will ask the user to confirm if they want to quit the editor.
-- If it is not the last buffer, then it will ask the user to confirm if they want to delete the buffer.
M.quit_if_last_buffer = function()
  -- Get the total number of open buffers
  local bufcnt = #vim.fn.filter(vim.fn.range(1, vim.fn.bufnr("$")), "buflisted(v:val)")
  -- If there is only one buffer open (the current buffer), then prompt the user to confirm quitting the editor
  if bufcnt < 2 then
    -- If there are more than one buffer open (other than the current buffer), then prompt the user to confirm deleting the buffer
    vim.cmd [[confirm quit]]
  else
    vim.cmd [[confirm bdelete]]
  end
end

-- Removes the current quickfix item and updates the quickfix window accordingly.
M.remove_qf_item = function()
  -- Get the index of the current quickfix item
  local curqfidx = vim.fn.line(".")

  -- Get all the quickfix items
  local qfall = vim.fn.getqflist()

  -- Remove the current quickfix item
  table.remove(qfall, curqfidx)

  -- Update the quickfix list
  vim.fn.setqflist(qfall, "r")

  -- Go to the next quickfix item and open the quickfix window
  vim.cmd(curqfidx .. "cfirst")
  vim.cmd("copen")
end

-- Prints a table, key-value pairs of the table
-- @param table The table to print
M.print_table = function(table)
  if type(table) ~= "table" then
    return
  end

  for k, v in pairs(table) do
    print(k .. ": " .. tostring(v))
  end
end

-- Prints a node, and optionally its children
-- @param node The node to print
-- @param show_child Whether or not to print the node's children
M.print_node = function(node, show_child)
  if node ~= nil then
    print("Current node type: " .. node:type())
    M.print_table(ts_utils.get_node_text(node, 0))
    if show_child then
      print("Child: ")
      for ch in node:iter_children() do
        print("Type: " .. ch:type())
        M.print_table(ts_utils.get_node_text(ch, 0))
      end
    end
  else
    print("node is empty")
  end
end

-- Replaces special characters in a string with their termcode equivalents
-- @param str The string to replace
-- @return The string with replaced special characters
M.t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Sends keystrokes to vim
-- @param key The keystrokes to send
M.feedkeys = function(key)
  vim.fn.feedkeys(M.t(key), "n")
end

M.expand_ultisnips_snippet = function(snippet_name)
  M.feedkeys("i" .. snippet_name .. "<C-r>=UltiSnips#ExpandSnippetOrJump()<CR>")
end

return M
