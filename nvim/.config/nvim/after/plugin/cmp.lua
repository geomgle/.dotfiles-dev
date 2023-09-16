vim.keymap.set("n", "<leader>ue", "<cmd>UltiSnipsEdit<cr>")
vim.keymap.set("n", "<leader>ca", "<cmd>Copilot! attach<cr>")
vim.keymap.set("n", "<leader>cd", "<cmd>Copilot! detach<cr>")

vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {"sql", "mysql", "plsql"},
    callback = function()
      require("cmp").setup.buffer(
        {
          sources = {
            {name = "copilot"},
            {name = "vim-dadbod-completion"}
          }
        }
      )
    end
  }
)

local cmp = require("cmp")
local compare = require("cmp.config.compare")
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

local t = require("utils").t
local feedkeys = require("utils").feedkeys

-- https://github.com/ibhagwan/nvim-lua
-- https://github.com/elmarsto/nvim-config/blob/main/lattice.lua
-- https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/cmp.lua
-- https://gist.github.com/mengwangk/324c3aed377b94bf6d0da07f53205a7a
-- https://github.com/MunifTanjim/dotfiles/blob/3d81d787b5a7a745598e623d6cdbd61fb10cef97/private_dot_config/nvim/lua/plugins/cmp.lua
local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
-- local has_words_before = function()
--   if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
--     return false
--   end
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   res = col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
--   return res
-- end

cmp_mapping = {
  ["<CR>"] = cmp.mapping(
    function(fallback)
      if cmp.visible() and cmp.get_active_entry() ~= nil then
        cmp.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true})
      elseif
        vim.call("empty", vim.call("matchstr", vim.call("getline", "."), '^\\s*\\(//\\|#\\|"\\|--\\|\\*\\)\\s*$')) == 0
       then
        feedkeys("<C-u>")
      else
        fallback()
      end
    end,
    {"i", "s"}
  ),
  ["<Tab>"] = cmp.mapping(
    function(fallback)
      -- if not has_words_before() then
      --   feedkeys("<Tab>")
      --   -- fallback()
      --   return
      -- end

      if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 or vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        cmp_ultisnips_mappings.compose {"expand", "jump_forwards"}(fallback)
      elseif require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").accept()
      elseif cmp.visible() then
        cmp.select_next_item({behavior = cmp.SelectBehavior.Replace})
      elseif has_words_before() then
        cmp.complete()
      else
        feedkeys("<Tab>")
      end
    end,
    {"i", "s"}
  ),
  ["<S-Tab>"] = cmp.mapping(
    function(fallback)
      cmp_ultisnips_mappings.jump_backwards(fallback)
    end,
    {"i", "s"}
  ),
  ["<Up>"] = cmp.mapping(
    function(fallback)
      if require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").prev()
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    {"i", "s"}
  ),
  ["<Down>"] = cmp.mapping(
    function(fallback)
      if require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").next()
      elseif cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    {"i", "s", "c"}
  )
}

cmp.setup(
  {
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end
    },
    completion = {
      keyword_length = 3,
      completeopt = "menu,menuone,noselect,noinsert"
    },
    experimental = {
      ghost_text = true
    },
    mapping = cmp_mapping,
    formatting = {
      format = function(entry, vim_item)
        vim_item.menu =
          ({
          nvim_lsp = "[LSP]",
          ultisnips = "[Snippet]",
          nvim_lua = "[Nvim Lua]",
          buffer = "[Buffer]"
        })[entry.source.name]

        vim_item.dup =
          ({
          ultisnips = 0,
          nvim_lsp = 0,
          nvim_lua = 0,
          buffer = 0
        })[entry.source.name] or 0

        return vim_item
      end
    },
    sources = cmp.config.sources(
      {
        {
          name = "copilot",
          max_item_count = 2,
          trigger_characters = {
            {
              ".",
              ":",
              "(",
              "'",
              '"',
              "[",
              ",",
              "*",
              "@",
              "|",
              "=",
              "-",
              "{",
              "<",
              "/",
              "\\",
              "+",
              "?"
              -- " "
              -- "#",
              -- "\t",
              -- "\n",
            }
          },
          priority = 1000
        },
        {name = "buffer", priority = 100},
        {name = "nvim_lsp", priority = 100},
        {name = "cmp_tabnine", priority = 90},
        {name = "path", priority = 80},
        {name = "ultisnips", priority = 500}
      }
    ),
    sorting = {
      priority_weight = 2,
      comparators = {
        compare.offset,
        compare.exact,
        compare.score,
        compare.recently_used,
        compare.locality,
        compare.sort_text,
        compare.length,
        compare.order
      }
    }
  }
)

-- Set configuration for specific filetype.
cmp.setup.filetype(
  "gitcommit",
  {
    sources = cmp.config.sources(
      {
        {name = "cmp_git"}, -- You can specify the `cmp_git` source if you were installed it.
        {name = "buffer"}
      }
    )
  }
)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  "/",
  {
    sources = {
      {name = "buffer"}
    }
  }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  ":",
  {
    sources = cmp.config.sources(
      {
        {name = "path"},
        {name = "cmdline"}
      }
    )
  }
)

cmp.event:on(
  "menu_opened",
  function()
    vim.b.copilot_suggestion_hidden = true
  end
)

cmp.event:on(
  "menu_closed",
  function()
    vim.b.copilot_suggestion_hidden = false
  end
)

-- UltiSnips
vim.g.UltiSnipsExpandTrigger = "<Tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<Tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<S-Tab>"
vim.g.UltiSnipsEditSplit = "vertical"
vim.g.UltiSnipsSnippetDirectories = {"ultisnips"}
