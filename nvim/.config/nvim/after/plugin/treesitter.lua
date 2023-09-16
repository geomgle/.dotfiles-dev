require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "rust",
    "lua",
    "python",
    "make",
    "cmake",
    "comment",
    "cpp",
    "cuda",
    "css",
    "dockerfile",
    "dot",
    "html",
    "json",
    "latex",
    "markdown",
    "regex",
    "scss",
    "toml",
    "vim",
    "yaml"
  },
  sync_install = false,
  ignore_install = {""},
  highlight = {
    enable = true,
    disable = {""},
    additional_vim_regex_highlighting = false
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = "v",
      node_decremental = "V",
      scope_incremental = "gt"
    }
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        ["ac"] = "@comment.outer",
        ["ic"] = "@comment.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner"
      },
      include_surrounding_whitespace = true
    }
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" },
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {
      "#cccc00",
      "#df9b5f",
      "#5fdf87",
      "#df5f87",
      "#5fcedf",
      "#875fdf",
      "#87df5f"
    }
  },
  indent = {
    enable = false
  }
}
