-- To create a breakpoint, type: <leader>dbt or <F8>
-- To run your debugger, first, you need to install the needed debugger. To do this, run: :DIInstall followed by a tab. Go here to view the documentation on it.
-- Finally, to run your debugger, type: <leader>dsc. Then, select the first option.
-- If you want to step into the line where you're currently on, type: <enter>
-- To move out from current function, type: <leader>dh
-- If you want to run everything until the next breakpoint, type: <F9>
vim.keymap.set("n", "<F7>", ":lua require('dap').close()<cr>")
vim.keymap.set("n", "<F8>", ":lua require('dap').toggle_breakpoint()<cr>")
vim.keymap.set("n", "<F9>", ":lua require('dap').continue()<cr>")
vim.keymap.set(
  "n",
  "<F10>",
  ":lua require('dapui').open({reset=true})<cr>:lua require('dapui').open({reset=true})<cr>:lua require('dapui').open({reset=true})<cr>"
) -- rerender ui

vim.keymap.set("n", "<enter>", ":lua require('dap').step_into()<cr>")
vim.keymap.set("n", "<leader>dj", ":lua require('dap').step_over()<cr>")
vim.keymap.set("n", "<leader>dh", ":lua require('dap').step_out()<cr>")
vim.keymap.set("n", "<leader>dl", ":lua require('dap').goto_()<cr>")

vim.keymap.set("n", "<leader>dvl", "<cmd>FzfLua dap_variables<cr>")

vim.keymap.set("n", "<leader>dt", ":lua require('dapui').toggle()<cr>")
vim.keymap.set("n", "<leader>dwh", ":lua require('dap.ui.widgets').hover()<cr>")
vim.keymap.set(
  "n",
  "<leader>dwf",
  ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<cr>"
)

vim.keymap.set("n", "<leader>dro", ":lua require('dap').repl.open()<cr>")
vim.keymap.set("n", "<leader>drl", ":lua require('dap').repl.run_last()<cr>")

vim.keymap.set("n", "<leader>dbd", ":lua require('dap').clear_breakpoints()<cr>")
vim.keymap.set("n", "<leader>dbl", "<cmd>FzfLua dap_breakpoints<cr>")
vim.keymap.set("n", "<leader>dbc", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
vim.keymap.set(
  "n",
  "<leader>dbm",
  ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<cr>"
)
vim.keymap.set("n", "<leader>dbt", ":lua require('dap').toggle_breakpoint()<cr>")

vim.keymap.set("n", "<leader>dc", ":lua require('dap.ui.variables').scopes()<cr>")
vim.keymap.set("n", "<leader>di", ":lua require('dapui').toggle()<cr>")
vim.keymap.set("n", "<leader>dor", ":lua require('osv').run_this()<cr>")

local dap = require("dap")

local signs = {
  breakpoint = {
    text = "",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = ""
  },
  breakpoint_rejected = {
    text = "",
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl = ""
  },
  stopped = {
    text = "",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "LspDiagnosticsSignInformation"
  }
}

vim.fn.sign_define("DapBreakpoint", signs.breakpoint)
vim.fn.sign_define("DapBreakpointRejected", signs.breakpoint_rejected)
vim.fn.sign_define("DapStopped", signs.stopped)

dap.defaults.fallback.terminal_win_cmd = "tabnew"

-- Python
-- Install debugpy:
--   mkdir .virtualenvs
--   cd .virtualenvs
--   python -m venv debugpy
--   debugpy/bin/python -m pip install debugpy
require("dap-python").setup("~/.virtualenvs/debugpy/bin/python", {include_configs = false})

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Module",
    console = "integratedTerminal",
    module = function()
      return vim.fn.expand("%:.:r:gs?/?.?")
    end,
    cwd = "${workspaceFolder}"
  }
}

-- C/C++
-- https://github.com/simrat39/dotfiles
-- Install codelldb-vscode:
--   wget https://github.com/vadimcn/vscode-lldb/releases/download/v1.7.0/codelldb-x86_64-linux.vsix
--   unzip codelldb-vscode*
--
-- Install lldb-vscode:
--   sudo apt-get install -y liblldb-11-dev
--   ln -sf /usr/lib/llvm-11/bin/lldb-vscode /home/.local/bin
--
-- Install vscode-cpptools:
--   wget https://github.com/microsoft/vscode-cpptools/releases/download/1.8.1/cpptools-linux.vsix
--   unzip cpptools-linux.vsix
--   chmod +x extension/debugAdapters/bin/OpenDebugAD7
dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = "lldb-vscode"
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true
  },
  {
    name = "Attach to gdbserver :1234",
    type = "cppdbg",
    request = "launch",
    MIMode = "gdb",
    miDebuggerServerAddress = "localhost:1234",
    miDebuggerPath = "/usr/bin/gdb",
    cwd = "${workspaceFolder}",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end
  }
}

dap.configurations.c = dap.configurations.cpp

-- Lua
-- To create a breakpoint, type: <leader>dbt or <F8>. Breakpoints should be
-- posed on the execution line, not the definition line.
-- Example:
--  function foo()
--    print("Hello")
--  end
--* foo() <-- Breakpoint should be here
-- To run debugging server: type: <leader>dor
-- To run code repeatly, run server again with <leader>dor
dap.adapters.nlua = function(callback, config)
  print("Connecting to DAP server")
  callback({type = "server", host = config.host, port = config.port})
end

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
    host = "127.0.0.1",
    port = 8086
  }
}

-- Bash
local BASH_DEBUG_ADAPTER_BIN = MASON .. "/bin/bash-debug-adapter"
local BASHDB_DIR = MASON .. "/packages/bash-debug-adapter/extension/bashdb_dir"

dap.adapters.sh = {type = "executable", command = BASH_DEBUG_ADAPTER_BIN}
dap.configurations.sh = {
  {
    name = "Launch Bash debugger",
    type = "sh",
    request = "launch",
    program = "${file}",
    cwd = "${fileDirname}",
    pathBashdb = BASHDB_DIR .. "/bashdb",
    pathBashdbLib = BASHDB_DIR,
    pathBash = "bash",
    pathCat = "cat",
    pathMkfifo = "mkfifo",
    pathPkill = "pkill",
    env = {},
    args = {} -- showDebugOutput = true, -- trace = true,
  }
}

-- DAP UI
local dapui = require("dapui")
dapui.setup(
  {
    mappings = {
      edit = "e",
      expand = {"<CR>", "l"},
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "gt"
    },
    layouts = {
      {
        elements = {
          {
            id = "breakpoints",
            size = 0.25
          },
          {
            id = "stacks",
            size = 0.25
          },
          {
            id = "watches",
            size = 0.25
          }
        },
        position = "left",
        size = 0.15
      },
      {
        elements = {
          {
            id = "console",
            size = 0.3
          },
          {
            id = "scopes",
            size = 0.3
          },
          {
            id = "repl",
            size = 0.4
          }
        },
        position = "right",
        size = 0.35
      }
    }
  }
)

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({reset = true})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- DAP Virtual Text
require("nvim-dap-virtual-text").setup {
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = true,
  show_stop_reason = true,
  commented = false,
  virt_text_pos = "eol",
  all_frames = false,
  virt_lines = false,
  virt_text_win_col = nil
}
