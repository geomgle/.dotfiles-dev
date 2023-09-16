_G.PACKAGE_PATH = vim.fn.stdpath("data") .. "/site/pack/packer/start"
_G.MASON = vim.fn.stdpath("data") .. "/mason"
vim.g.python3_host_prog = "/usr/bin/python3"

require("packer")
require("autocmd")
require("set")
require("remap")
