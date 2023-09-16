vim.keymap.set("n", "<leader>vd", "<cmd>Diff<cr>")
vim.cmd [[command! Diff :vs | :edit # | :windo diffthis | :execute("normal \<C-w>W")]]

-- Vim-visual-multi and vimwiki conflict with each other.  The symptom of the
-- conflict is that if there is a change in the buffer, <C-n> in visual-multi
-- does not work. The reason is that there is a part of visual-multi that uses
-- the final change position for the final change position, and that part
-- changes on vimwiki. The solution is to execute the yank before pressing <C-n>
-- to change the final change and yank position before executing the plug.
vim.keymap.set("n", "<C-n>", "yiw<Plug>(VM-Find-Under)", {noremap = true})
vim.keymap.set(
  "x",
  "<C-n>",
  "ygv<Plug>(VM-Find-Subword-Under)",
  {
    noremap = true
  }
)

-- Vim-visual-multi
vim.g.VM_Mono_hl = "DiffText"
vim.g.VM_Extend_hl = "DiffAdd"
vim.g.VM_Cursor_hl = "Visual"
vim.g.VM_Insert_hl = "DiffChange"
vim.g.VM_theme = "sand"
vim.g.VM_maps = {
  ["Select Operator"] = "v",
  ["Find Under"] = "",
  ["Find Subword Under"] = ""
}

-- Nvim-comment
require("nvim_comment").setup(
  {
    comment_empty = true,
    comment_empty_trim_whitespace = true,
    create_mappings = true,
    line_mapping = "gcc",
    operator_mapping = "gc",
    comment_chunk_text_object = "i#"
  }
)

-- Nvim-autopairs
local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.setup(
  {
    disable_in_macro = true,
    disable_in_visualblock = true,
    check_ts = true,
    ts_config = {
      lua = {"string"},
      -- it will not add a pair on that treesitter node
      javascript = {"template_string"},
      java = false
      -- don't check treesitter on java
    }
  }
)

local ts_conds = require("nvim-autopairs.ts-conds")
-- press % => %% only while inside a comment or string
npairs.add_rules(
  {
    Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({"comment"})),
    Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({"string", "function"}))
  }
)
