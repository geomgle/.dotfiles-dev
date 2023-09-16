vim.keymap.set("n", "<leader>so", "<cmd>Startify<cr>")
vim.keymap.set("n", "<leader>ss", "<cmd>SSave<cr>")
vim.keymap.set("n", "<leader>sd", "<cmd>SDelete<cr>")
vim.keymap.set("n", "<leader>sq", "<cmd>SClose<cr>")

vim.keymap.set(
  "n",
  "<leader>vz",
  "<cmd>lua require('zen-mode').toggle({ window = { width = 83, options = { number = false, relativenumber = false, cursorline = false }}, plugins = { tmux = { enabled = false }, alacritty = { enabled = true, font = '16' } } })<cr>"
)
vim.keymap.set({"n", "i", "v"}, "<C-z>", require("utils").toggle_zoom)

require("twilight").setup(
  {
    context = 0,
    expand = {
      -- markdown
      "paragraph",
      "fenced_code_block",
      "list"
    }
  }
)

-- Lualine
require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "powerline",
    component_separators = {left = "", right = ""},
    section_separators = {left = "", right = ""},
    disabled_filetypes = {},
    always_divide_middle = true
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch", "diff", "diagnostics"},
    lualine_c = {
      {
        "filename",
        path = 1,
        shorting_target = 30
      }
    },
    -- lualine_x = {CodeGPTModule.get_status, "encoding", "fileformat", "filetype"},
    lualine_x = {"encoding", "fileformat", "filetype"},
    lualine_y = {"progress"},
    lualine_z = {"location"}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {
    "nvim-tree"
  }
}

-- Bufferline
local bufferline = require "bufferline"

bufferline.setup {
  options = {
    numbers = "none",
    max_name_length = 13,
    max_prefix_length = 3, -- prefix used when a buffer is deduplicated
    tab_size = 13,
    show_tab_indicators = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = true,
    -- diagnostics = "nvim_lsp",
    -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
    --   local s = ""
    --   for e, n in pairs(diagnostics_dict) do
    --     local sym = diagnostics_signs[e] or diagnostics_signs.default
    --     s = s .. (#s > 1 and " " or "") .. sym .. " " .. n
    --   end
    --   return s
    -- end,
    separator_style = "thin"
  },
  highlights = {
    fill = {
      fg = "#000000",
      bg = normal_bg
    },
    background = {
      fg = "#9ba1ab",
      bg = "#202020"
    },
    buffer_selected = {
      fg = "#adddff",
      bg = "#585858",
      bold = true
    },
    buffer_visible = {
      fg = "#9ba1ab",
      bg = "#202020"
    },
    modified = {
      fg = "#b9e892",
      bg = "#202020"
    },
    modified_selected = {
      fg = "#b9e892",
      bg = "#585858"
    }
  }
}

-- Indent-blankline
vim.g.indent_blankline_filetype_exclude = {"startify"}
vim.g.indent_blankline_show_first_indent_level = false

require("indent_blankline").setup {
  char = "",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2"
  },
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2"
  },
  show_trailing_blankline_indent = false
}

-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#444444 gui=nocombine]]

-- require("indent_blankline").setup {
--   space_char_blankline = " ",
--   char_highlight_list = {
--     "IndentBlanklineIndent1"
--   }
-- }

-- Startify
vim.g.startify_files_number = 10
vim.g.startify_session_persistence = 1
vim.g.startify_padding_left = 7
vim.g.startify_lists = {
  {type = "sessions", header = {"       Saved sessions"}},
  {type = "dir", header = {"       Recent files"}}
}
vim.g.startify_change_to_dir = 1
vim.g.startify_custom_indices = {
  "f",
  "d",
  "e",
  "r",
  "c",
  "v",
  "s",
  "w",
  "t",
  "x",
  "b",
  "q",
  "a",
  "z",
  "y",
  "j",
  "n",
  "u",
  "k",
  "m",
  "i",
  "l",
  "o",
  "p"
}
vim.cmd [[
let s:startify_ascii = [
     \ '   __     _                     ',
     \ '  /\ \  /| |                    ',
     \ '  \ \ \ || |                    ',
     \ '   \ \ \|| | __   __            ',
     \ '    \ \ \| |/\_\ /\ `¯¯`v¯¯`\   ',
     \ '     \ \   |\/\¯\\ \ \¯\ \¯\ \  ',
     \ '      \ \__| \ \_\\ \_\ \_\ \_\ ',
     \ '       \/_/   \/_/ \/_/\/_/\/_/ ',
     \ '']
let g:startify_custom_header = map(s:startify_ascii, '"       ".v:val')
]]
