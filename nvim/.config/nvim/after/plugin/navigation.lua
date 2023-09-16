-- Jump to function definition: <C-]>
-- Jump to original location: <C-o>
vim.keymap.set({"n", "i"}, "<F2>", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>f<Space>", ":FzfLua ")
vim.keymap.set("n", "<leader>fk", "<cmd>FzfLua keymaps<cr>")
vim.keymap.set("n", "<C-t>", "<cmd>lua require('fzf-lua').files()<cr>")
vim.keymap.set("n", "<C-f><C-f>", "<cmd>lua require('fzf-lua').oldfiles()<cr>")
vim.keymap.set("n", "<C-f><C-g>", "<cmd>lua require('fzf-lua').live_grep({search = ' '})<cr>")
vim.keymap.set("n", "<C-r>", "<cmd>lua require('fzf-lua').command_history()<cr>")
vim.keymap.set(
  {"n", "i"},
  "<F1>",
  "<cmd>lua require('fzf-lua').live_grep_native({ prompt = 'Wiki> ', search = ':', cwd = '~/Dropbox/wiki/' })<cr>"
)

-- NvimTree
local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return {desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true}
  end

  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "<cr>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "c", api.tree.change_root_to_node, opts("CD"))
  vim.keymap.set("n", "a", api.fs.create, opts("Create"))
  vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
  vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
  vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
  vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
  vim.keymap.set("n", "r", api.tree.reload, opts("Refresh"))
  vim.keymap.set("n", "y", api.fs.copy.node, opts("Copy"))
  vim.keymap.set("n", "gy", api.fs.copy.filename, opts("Copy Name"))
  vim.keymap.set("n", "gyy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
  vim.keymap.set("n", "h", api.tree.change_root_to_parent, opts("Up"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
  vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
  vim.keymap.set("n", "m", api.fs.rename, opts("Rename"))
  vim.keymap.set("n", "O", api.tree.collapse_all, opts("Collapse"))
  vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
  vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
end

require "nvim-tree".setup {
  on_attach = on_attach,
  respect_buf_cwd = true,
  disable_netrw = true,
  open_on_tab = true,
  hijack_cursor = false,
  update_cwd = true,
  -- show diagnostics in file view
  diagnostics = {
    enable = true
  },
  system_open = {
    cmd = "xdg-open",
    args = {}
  },
  view = {
    width = 45,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false
  },
  renderer = {
    highlight_opened_files = "all",
    highlight_git = true,
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  "
      }
    }
  },
  actions = {
    change_dir = {
      enable = true,
      global = false
    },
    open_file = {
      quit_on_open = true,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = {"notify", "packer", "qf", "diff", "fugitive", "fugitiveblame"},
          buftype = {"nofile", "terminal", "help"}
        }
      }
    }
  },
  filters = {
    dotfiles = false
  }
}

-- Fzf-lua
-- https://github.com/ibhagwan/nvim-lua
local actions = require "fzf-lua.actions"

require "fzf-lua".setup {
  global_resume = true, -- enable global `resume`?
  -- can also be sent individually:
  -- `<any_function>.({ gl ... })`
  global_resume_query = true, -- include typed query in `resume`?
  winopts = {
    preview = {
      -- default     = 'bat',           -- override the default previewer?
      -- default uses the 'builtin' previewer
      border = "border", -- border|noborder, applies only to
      -- native fzf previewers (bat/cat/git/etc)
      wrap = "nowrap", -- wrap|nowrap
      hidden = "nohidden", -- hidden|nohidden
      vertical = "down:50%", -- up|down:size
      horizontal = "right:60%", -- right|left:size
      layout = "flex", -- horizontal|vertical|flex
      flip_columns = 150, -- #cols to switch to horizontal on flex
      -- Only used with the builtin previewer:
      title = true, -- preview border title (file/buf)?
      title_align = "left", -- left|center|right, title alignment
      scrollbar = "float", -- `false` or string:'float|border'
      -- float:  in-window floating border
      -- border: in-border chars (see below)
      scrolloff = "-2", -- float scrollbar offset from right
      -- applies only when scrollbar = 'float'
      scrollchars = {"█", ""}, -- scrollbar chars ({ <full>, <empty> }
      -- applies only when scrollbar = 'border'
      delay = 100, -- delay(ms) displaying the preview
      -- prevents lag on fast scrolling
      winopts = {
        -- builtin previewer window options
        number = true,
        relativenumber = false,
        cursorline = true,
        cursorlineopt = "both",
        cursorcolumn = false,
        signcolumn = "no",
        list = false,
        foldenable = false,
        foldmethod = "manual"
      }
    }
  },
  files = {
    -- previewer      = "bat",          -- uncomment to override previewer
    -- (name from 'previewers' table)
    -- set to 'false' to disable
    prompt = "File❯ ",
    multiprocess = true, -- run command in a separate process
    git_icons = true, -- show git icons?
    file_icons = true, -- show file icons?
    color_icons = true, -- colorize file|git icons
    fd_opts = "-uu -H -i --exclude .git",
    actions = {
      -- inherits from 'actions.files', here we can override
      -- or set bind to 'false' to disable a default action
      ["default"] = actions.file_edit
    }
  },
  keymap = {
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      ["?"] = "toggle-help",
      ["<F2>"] = "toggle-fullscreen",
      -- Only valid with the 'builtin' previewer
      ["<F3>"] = "toggle-preview-wrap",
      ["<F4>"] = "toggle-preview",
      -- Rotate preview clockwise/counter-clockwise
      ["<F5>"] = "toggle-preview-ccw",
      ["<F6>"] = "toggle-preview-cw",
      ["<S-down>"] = "preview-page-down",
      ["<S-up>"] = "preview-page-up",
      ["<S-left>"] = "preview-page-reset"
    },
    fzf = {
      -- fzf '--bind=' options
      ["ctrl-z"] = "abort",
      ["ctrl-w"] = "select-all",
      ["ctrl-u"] = "unix-line-discard",
      ["ctrl-f"] = "half-page-down",
      ["ctrl-b"] = "half-page-up",
      ["ctrl-s"] = "beginning-of-line",
      ["ctrl-e"] = "end-of-line",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["f3"] = "toggle-preview-wrap",
      ["f4"] = "toggle-preview",
      ["shift-down"] = "preview-page-down",
      ["shift-up"] = "preview-page-up"
    }
  },
  actions = {
    -- These override the default tables completely
    -- no need to set to `false` to disable an action
    -- delete or modify is sufficient
    files = {
      -- providers that inherit these actions:
      --   files, git_files, git_status, grep, lsp
      --   oldfiles, quickfix, loclist, tags, btags
      --   args
      -- default action opens a single selection
      -- or sends multiple selection to quickfix
      -- replace the default action with the below
      -- to open all files whether single or multiple
      -- ["default"]     = actions.file_edit,
      ["default"] = actions.file_edit_or_qf,
      ["ctrl-s"] = actions.file_split,
      ["ctrl-v"] = actions.file_vsplit,
      ["ctrl-q"] = actions.file_sel_to_qf
    },
    buffers = {
      -- providers that inherit these actions:
      --   buffers, tabs, lines, blines
      ["default"] = actions.buf_edit,
      ["ctrl-s"] = actions.buf_split,
      ["ctrl-v"] = actions.buf_vsplit
    }
  },
  grep = {
    prompt = "Rg❯ ",
    input_prompt = "Grep For❯ ",
    multiprocess = true, -- run command in a separate process
    git_icons = true, -- show git icons?
    file_icons = true, -- show file icons?
    color_icons = true, -- colorize file|git icons
    rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=75",
    rg_glob = false, -- default to glob parsing?
    glob_flag = "--iglob", -- for case sensitive globs use '--glob'
    glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
    no_header = false, -- hide grep|cwd header?
    no_header_i = false -- hide interactive header?
  }
}

-- Vim-rooter
vim.g.rooter_change_directory_for_non_project_files = ""
vim.g.rooter_patterns = {".git", "Cargo.toml", "init.lua", ".env"}
vim.g.rooter_cd_cmd = "tcd"
vim.g.rooter_manual_only = 0

-- Gutentags
vim.g.gutentags_ctags_extra_args = {"--tag-relative=yes", "--fields=+ailmnS"}
vim.g.gutentags_ctags_exclude = {
  "*.git",
  "*.svg",
  "*.hg",
  "*.cache",
  "target",
  "*/tests/*",
  "build",
  "dist",
  "*sites/*/files/*",
  "bin"
}
