vim.keymap.set("n", "ga", "<Plug>(EasyAlign)")
vim.keymap.set("x", "ga", "<Plug>(EasyAlign)")

vim.cmd [[
  " Format current file when writing
  augroup Autoformat
    au!
    au BufWritePost *.rs,*.py,*.lua,*.html,*.css,*.toml,*.sql,*.js FormatWrite
  augroup end
]]

require "formatter".setup {
  filetype = {
    rust = {
      -- rustfmt
      function()
        return {
          exe = "rustfmt",
          args = {"--emit=stdout", "--edition=2021"},
          stdin = true
        }
      end
    },
    python = {
      function()
        return {
          exe = "black",
          args = {},
          stdin = false
        }
      end
    },
    lua = {
      function()
        return {
          exe = "luafmt",
          args = {"--indent-count", 2, "--stdin"},
          stdin = true
        }
      end
    },
    javascript = {
      function()
        return {
          exe = "js-beautify",
          stdin = true,
          try_node_modules = true
        }
      end
    },
    html = {
      function()
        return {
          exe = "html-beautify",
          args = {"--indent-size", 2, "--wrap-line-length", "80"},
          stdin = true
        }
      end
    },
    css = {
      -- css-beautify,
      function()
        return {
          exe = "css-beautify",
          args = {"--indent-size", 2, "--newline-between-rules"},
          stdin = true
        }
      end
    },
    toml = {
      function()
        return {
          exe = "taplo",
          args = {"fmt", "-"},
          stdin = true,
          try_node_modules = true
        }
      end
    },
    sql = {
      function()
        return {
          exe = "pg_format -i -p '\\s#.*' -",
          stdin = true
        }
      end
    }
  }
}

-- Vim-easy-align
vim.cmd [[
let g:easy_align_delimiters = {
    \ '>': { 'pattern': '>>\|=>\|>' },
    \ '/': {
    \     'pattern':         '//\+\|/\*\|\*/',
    \     'delimiter_align': 'l',
    \     'ignore_groups':   ['!Comment'] },
    \ 'c': {
    \     'pattern':      '\s\(#\|//\|;\)\s\(.\+\)\@<=',
    \     'left_margin':  1,
    \     'right_margin': 0
    \   },
    \ 'd': {
    \     'pattern':      ' \(\S\+\s*[;=]\)\@=',
    \     'left_margin':  0,
    \     'right_margin': 0
    \   }
    \ }
]]
