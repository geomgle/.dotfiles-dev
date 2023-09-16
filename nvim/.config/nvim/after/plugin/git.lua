-- How to use worktrees
-- git clone --bare <repository>
-- :lua require("git-worktree").create_worktree(<alias>, <branch>, <upstream: origin if null>)
-- vim.keymap.set("", "<F8>", "<Esc><cmd>lcd %:p:h <bar> G ac<cr><cmd>lcd -<cr>")
-- vim.keymap.set("", "<F9>", "<Esc><cmd>lcd %:p:h <bar> G fetch --all && git reset --hard HEAD<cr><cmd>lcd -<cr>")
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.cmd [[
  command! -nargs=* WTCreate :lua require("git-worktree").create_worktree(<f-args>)
  command! -nargs=1 WTSwitch :lua require("git-worktree").switch_worktree(<f-args>)
  command! -nargs=1 WTDelete :lua require("git-worktree").delete_worktree(<f-args>, {force = true})
  nnoremap <leader>gg :exec ":WTSwitch ".g:prev_repo<cr>
  nnoremap <leader>gc :WTCreate 
  nnoremap <leader>g<space> :WTSwitch 
  nnoremap <leader>gd :exec ":WTSwitch ".g:prev_repo<cr>:WTDelete 
]]

-- Git Worktree
local Worktree = require("git-worktree")

require("git-worktree").setup(
  {
    change_directory_command = "tcd", -- default: "cd",
    update_on_change = true -- default: true,
  }
)

Worktree.on_tree_change(
  function(op, metadata)
    if op == Worktree.Operations.Switch then
      vim.g.prev_repo = metadata.prev_path:gsub("[^/]*/", "")
      vim.g.curr_repo_path = metadata.path
      print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
    end
  end
)
