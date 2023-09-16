vim.api.nvim_create_autocmd(
  "BufEnter",
  {
    pattern = "*.sh",
    callback = function()
      vim.cmd [[
        let @r=":set splitbelow\<bar>new\<bar>set ft=sh bt=nofile\<bar>read !sh #\<cr>"
      ]]
    end
  }
)

vim.keymap.set("n", "<leader>t<space>", "<cmd>ToggleTermSendCurrentLine<cr>")
vim.keymap.set("v", "<leader>t<space>", "<cmd>ToggleTermSendVisualLines<cr><Esc>")
vim.keymap.set("t", "<C-p>", "<C-t>")
vim.keymap.set("t", "<C-s>", "<C-r>")
if vim.api.nvim_eval("exists('$TMUX')") then
  vim.keymap.set("i", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
  vim.keymap.set("i", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
  vim.keymap.set("i", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
  vim.keymap.set("i", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
  vim.keymap.set("n", "<C-y>", "<Plug>SlimeLineSend<bar>j")
  vim.keymap.set("i", "<C-y>", "<C-o><Plug>SlimeLineSend<bar>j")
  vim.keymap.set("x", "<C-y>", "<Plug>SlimeRegionSend<bar>'>j")
  vim.keymap.set("n", "<leader>ty", "<Plug>SlimeSendCell")
  vim.keymap.set("n", "<leader>tv", "<Plug>SlimeConfig")

  -- Vim-slime
  vim.g.slime_target = "tmux"
  vim.g.slime_paste_file = vim.fn.tempname()
  vim.g.slime_dont_ask_default = 1
  vim.g.slime_default_config = {["socket_name"] = "default", ["target_pane"] = "{last}"}
  vim.g.slime_no_mappings = 1
  vim.g.slime_python_ipython = 1
  vim.g.slime_cell_delimiter = "# "

  -- Python
  vim.api.nvim_create_autocmd(
    "BufEnter",
    {
      pattern = "*.py",
      callback = function()
        vim.cmd [[
          let @e=":w\<cr>:exec \"!tmux send -t 3 ^c Enter 'pk text-generation && inotipy -r -p '\".expand('%:p:h').\"' /home/dev/python/text-generation-webui/server.py --chat --model-menu  --model TheBloke_Llama-2-7b-Chat-GPTQ --loader exllama --extensions guide --xformers --triton' Enter\"\<cr>"
          let @r=":w\<cr>:exec \"!tmux send -t 2 ^c Enter 'inotipy -r -p '\".expand('%:p:h').\"' -m '\".substitute(substitute(expand('%'), '.py$', '', ''), '/', '.', 'g').\" Enter\"\<cr>"
          let @t=":w\<cr>:exec \"!tmux send -t 2 ^c Enter 'cd \".getcwd().\" && inotipy -t -p '\".expand('%:p:h').\" Enter\"\<cr>"
          let @i=":w\<cr>:exec \"!tmux send -t 3 ^c Enter 'pip3 install -e .;$VENV' Enter\"\<cr>"
          let @p=":w\<cr>:exec \"!tmux send -t 2 ^c Enter 'pyprof -m \".substitute(substitute(expand('%'), '.py', '', 'g'), '/', '.', 'g').\" && prof2img' Enter\"\<cr>"
          let @c=":w\<cr>:exec \"!tmux send -t 2 ^c Enter 'pycprof -m \".substitute(substitute(expand('%'), '.py', '', 'g'), '/', '.', 'g').\" && lprof2img' Enter\"\<cr>"
          let @l=":w\<cr>:exec \"!tmux send -t 2 ^c Enter 'pylprof -m \".substitute(substitute(expand('%'), '.py', '', 'g'), '/', '.', 'g').\" && lprof' Enter\"\<cr>"
        ]]
      end
    }
  )

  -- Rust
  vim.api.nvim_create_autocmd(
    "BufEnter",
    {
      pattern = {"*.rs", "*.toml"},
      callback = function()
        vim.cmd [[
          let @e=":w\<cr>:exec \"!tmux send -t 2 ^c Enter 'cd \".getcwd().\" && inoticargo -c -p '\".getcwd().\" Enter\"\<cr>"
          let @r=":w\<cr>:exec \"!tmux send -t 2 ^c Enter 'cd \".getcwd().\" && inoticargo -r -p '\".getcwd().\" Enter\"\<cr>"
          let @t=":w\<cr>:exec \"!tmux send -t 2 ^c Enter 'cd \".getcwd().\" && inoticargo -t -p '\".getcwd().\" Enter\"\<cr>"
          let @s=":w\<cr>:exec \"!tmux send -t 2.3 ^c Enter 'cd \".getcwd().\" && cd .. && cd client && trunk build && cd .. && cd server-service && cargo run' Enter\"\<cr>"
          let @y=":w\<cr>:TermExec cmd='inoticargo -t'\<cr>"
          let @l=":w\<cr>:TermExec cmd=^C\<cr>cd .. && cd client && trunk build && cd .. && cd server-service && cargo run\<cr>"
          let @i=":w\<cr>:TermExec cmd=^C\<cr>inoticargo -c \| bunyan -o short\<cr>"
        ]]
      end
    }
  )
end

-- Toggleterm
require("toggleterm").setup {
  open_mapping = [[<leader>.]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  direction = "float",
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = "single",
    highlights = {
      border = "Normal",
      background = "Normal"
    }
  }
}
