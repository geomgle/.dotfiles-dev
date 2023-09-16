vim.keymap.set("n", "<up>", "changes#MoveToNextChange(0, v:count1)", {silent = true, expr = true})
vim.keymap.set("n", "<down>", "changes#MoveToNextChange(1, v:count1)", {silent = true, expr = true})
vim.keymap.set("n", "K", "<Plug>(VindentMotion_prev_same)", {silent = true})
vim.keymap.set("x", "K", "<Plug>(VindentMotion_prev_same)", {silent = true})
vim.keymap.set("n", "J", "<Plug>(VindentMotion_next_same)", {silent = true})
vim.keymap.set("x", "J", "<Plug>(VindentMotion_next_same)", {silent = true})
vim.keymap.set("x", "ii", "<Plug>(VindentObject_XX_ii)", {silent = true})
vim.keymap.set("x", "ai", "<Plug>(VindentObject_XX_aI)", {silent = true})
vim.keymap.set("n", "s", "<Plug>Lightspeed_omni_s")
vim.keymap.set("x", "s", "<Plug>Lightspeed_omni_s")
vim.keymap.set({"n", "i"}, "<C-w><C-w>", require("utils").goto_first_float)
vim.keymap.set({"n", "i"}, "<C-tab>", require("utils").goto_first_float)

vim.api.nvim_create_autocmd("FileType", {pattern = {"startify,codelldb"}, command = "HardTimeOff"})

-- Hardtime
vim.g.hardtime_timeout = 500
vim.g.hardtime_maxcount = 7
vim.g.hardtime_motion_with_count_resets = 1
vim.g.hardtime_ignore_buffer_patterns = {
  ".*wiki",
  "NvimTree",
  "Tagbar",
  "DAP ",
  "dbui",
  ".*dbout",
  "fugitive.*"
}
vim.g.hardtime_ignore_quickfix = 1
vim.g.list_of_normal_keys = {"h", "j", "k", "l", "-", "+"}
vim.g.list_of_visual_keys = {"h", "j", "k", "l", "-", "+"}
vim.g.list_of_insert_keys = {}

-- ChangesPlugin
vim.g.changes_vcs_check = 1
vim.g.changes_vcs_system = "git"
local function buf_enter_git_project()
  local git_root =
    vim.fn.systemlist("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse --is-inside-work-tree 2>/dev/null")
  if #git_root == 0 then
    vim.api.nvim_buf_set_var(0, "changes_vcs_check", 0)
  else
    vim.api.nvim_buf_set_var(0, "changes_vcs_check", 1)
  end
end
vim.api.nvim_create_autocmd("BufEnter", {pattern = "*", callback = buf_enter_git_project})

-- Lightspeed
require "lightspeed".setup {
  ignore_case = true,
  exit_after_idle_msecs = {unlabeled = nil, labeled = nil},
  --- s/x ---
  jump_to_unique_chars = {safety_timeout = 400},
  match_only_the_start_of_same_char_seqs = true,
  force_beacons_into_match_width = false,
  safe_labels = {
    "f",
    "s",
    "j",
    "k",
    "l",
    "g",
    "r",
    "e",
    "w",
    "t",
    "h",
    "n",
    "m",
    "o",
    "u",
    "z"
  },
  -- Display characters in a custom way in the highlighted matches.
  substitute_chars = {["\r"] = "¬"},
  -- Leaving the appropriate list empty effectively disables "smart" mode,
  --- f/t ---
  limit_ft_matches = 4,
  repeat_ft_with_target_char = true
}
