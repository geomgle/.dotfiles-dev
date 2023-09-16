--=============================================================================
--# Editor settings
--=============================================================================

-- For Plugins
vim.g.hardtime_default_on = 1
vim.g.VM_leader = "<leader><leader>"
vim.g.VM_maps = {
  ["Select Operator"] = "v",
  ["Find Under"] = "",
  ["Find Subword Under"] = ""
}

-- Basic
vim.opt.shell = "/bin/bash"
vim.opt.termguicolors = true
vim.opt.fileencodings = "utf-8,euc-kr"
vim.opt.compatible = false
vim.opt.updatetime = 250
vim.opt.mouse = "nvi"
vim.opt.clipboard = ""
vim.opt.guicursor =
  "n-v-c-sm:block-blinkwait50-blinkon50-blinkoff50,i-ci-ve:ver25-Cursor-blinkon100-blinkoff100,r-cr-o:hor20"

vim.opt.backspace = "indent,eol,start"
-- vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.history = 1000
vim.opt.startofline = true
vim.opt.mps:append("<:>")

-- Time out on key codes but not mappings.
-- Basically this makes terminal Vim work sanely.
vim.opt.timeout = false
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 1

-- Display
vim.opt.showmode = false -- do not show the mode change(instead, may use lualine)
vim.opt.showmatch = true -- show matching brackets
vim.opt.scrolloff = 3 -- always show 3 rows from edge of the screen
vim.opt.synmaxcol = 300 -- stop syntax highlight after x lines for performance
vim.opt.laststatus = 2 -- always show status line

-- Sidebar
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.modelines = 0
vim.opt.showcmd = true -- display command in bottom bar

-- Windows
vim.opt.wrap = true
vim.opt.textwidth = 80
vim.opt.colorcolumn = "80"
vim.opt.cursorcolumn = false
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Tab
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Indent
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.cinoptions = "m1"

-- Search
vim.opt.incsearch = true -- starts searching as soon as typing, without enter needed
vim.opt.ignorecase = true -- ignore letter case when searching
vim.opt.smartcase = true -- case insentive unless capitals used in search
vim.opt.jumpoptions:append("stack")

-- Format vim.options
-- q - allow formatting comments with gq.
-- c - Auto-wrap comments using textwidth, inserting the current comment leader
--     automatically.
-- t - auto-wrap using the text width (you can change it, i.e. :set tw=80)
-- a - automatic formatting of paragraphs. Every time text is inserted or deleted
--     the paragraph will be reformatted.
-- r - Automatically insert the current comment leader after hitting <Enter> in
--     Insert mode.
-- o - Automatically insert the current comment leader after hitting 'o' or
--    'O' in Normal mode.
vim.opt.formatoptions:append("ct")
vim.opt.formatoptions:append("b")
vim.opt.formatoptions:append("q")
vim.opt.formatoptions:append("r")
vim.opt.formatoptions:append("n")
vim.opt.formatoptions:remove("o")

-- Fold
vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldtext = "CustomFoldText('.')"

-- Files
vim.opt.backup = false -- do not use backup files
vim.opt.writebackup = false
vim.opt.swapfile = false -- do not use swap file
vim.opt.hidden = true -- Do not save when switching buffers
vim.opt.autoread = true
vim.opt.undofile = true

-- Commands mode
vim.opt.inccommand = "nosplit" -- show effects of command
vim.opt.wildmenu = true -- on TAB, complete options for system command
vim.opt.wildignore =
  "deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc"

-- Make diffing better: https://vimways.org/2018/the-power-of-diff/
vim.opt.diffopt:append("algorithm:patience")
vim.opt.diffopt:append("indent-heuristic")

-- Langmap
-- Normal mode can recognize hangul characters
-- vim.opt.langmap = "ㅁa,ㅠb,ㅊc,ㅇd,ㄷe,ㄹf,ㅎg,ㅗh,ㅑi,ㅓj,ㅏk,ㅣl,ㅡm,ㅜn,ㅐo,ㅔp,ㅂq,ㄱr,ㄴs,ㅅt,ㅕu,ㅍv,ㅈw,ㅌx,ㅛy,ㅋz"
