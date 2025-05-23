-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap', enabled = true,
  -- -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve', 'cppdbg'
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '++', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '--', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<Leader>==', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '+=', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    require("neodev").setup({
        library = {plugins = {"nvim-dap-ui"}, types = true},

    })
    dapui.setup()
    dap.adapters.gdb = {
        id = 'gdb',
        type = "executable",
        command = "gdb",
        args = { "--quiet", "interpreter=dap"}
    }

    -- dap.configurations.c = {
    --     {
    --         name = "Launch",
    --         type = "gdb",
    --         request = "launch",
    --         program = function ()
    --             local path = vim.fn.input({
    --                 probmpt = 'Path to executable: ',
    --                 default = vim.fn.getcwd() ..'/',
    --                 completion = 'file',
    --             })
    --             return (path and path ~= '') and path or dap.ABORT
    --         end,
    --         stopAtBeginningOfMainSubProgram = true,
    --     },

    -- },
    dap.configurations.rust = {
        {
            name = "Launch",
            type = "gdb",
            request = "launch",
            program = function ()
                local path = vim.fn.input({
                    probmpt = 'Path to executable: ',
                    default = vim.fn.getcwd() ..'/',
                    completion = 'file',
                })
                return (path and path ~= '') and path or dap.ABORT
            end,
            stopAtBeginningOfMainSubProgram = true,
        },

    },
    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    -- dapui.setup {
    --   -- Set icons to characters that are more likely to work in every terminal.
    --   --    Feel free to remove or use ones that you like more! :)
    --   --    Don't feel like these are good choices.
    --   icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    --   controls = {
    --     icons = {
    --       pause = '⏸',
    --       play = '▶',
    --       step_into = '⏎',
    --       step_over = '⏭',
    --       step_out = '⏮',
    --       step_back = 'b',
    --       run_last = '▶▶',
    --       terminate = '⏹',
    --       disconnect = '⏏',
    --     },
    --     enabled = true,
    --   },
    -- }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

  end,
}
