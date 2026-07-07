 
vim.pack.add({
    -- "https://github.com/bluz71/vim-moonfly-colors",
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/tpope/vim-fugitive",
})

---- mini files ----
local minifiles = require("mini.files")
minifiles.setup()
vim.keymap.set("n", "<leader>pv", "<cmd>lua MiniFiles.open()<CR>", {desc = "Toggle mini files explorer"})

require("mini.cmdline").setup()
require("mini.surround").setup()


local pick = require('mini.pick')
local extra = require('mini.extra')


-- Helper for directory pickers
-- quickfix list <Alt-Enter>
-- quickfix list select <C-x>
local pick_in_dir = function(picker_type)
  local dir = vim.fn.input("Directory: ", "", "dir")
  if dir == "" then return end
  if picker_type == "files" then
    pick.builtin.files({}, { source = { cwd = dir } })
  elseif picker_type == "grep" then
    pick.builtin.grep_live({}, { source = { cwd = dir } })
  end
end

vim.keymap.set("n", "<leader>sh", function() pick.builtin.help() end, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", function() extra.pickers.keymaps() end, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<C-p>", function() pick.builtin.files() end, { desc = "[S]earch [F]iles" })
-- vim.keymap.set("n", "<leader>ss", function() pick.builtin.registry() end, { desc = "[S]earch [S]elect Picker" })
vim.keymap.set("n", "<leader>sw", function() pick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sm", function() extra.pickers.git_commits() end, { desc = "[S]earch Git co[M]mits" })
vim.keymap.set("n", "<leader>qf", function() extra.pickers.list({ scope = "quickfix" }) end, { desc = "Quick fix list" })
-- vim.keymap.set("n", "<leader>qh", function() extra.pickers.history({ scope = "quickfix" }) end, { desc = "Quick fix history" })
vim.keymap.set("n", "<leader>sg", function() pick.builtin.grep_live() end, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", function() extra.pickers.diagnostic() end, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>re", function() pick.resume() end, { desc = "[R][E]sume" })
vim.keymap.set("n", "<leader>bu", function() pick.builtin.buffers() end, { desc = "Find existing [B][U]ffers" })
vim.keymap.set("n", "<leader>sr", function() extra.pickers.registers() end, { desc = "[R]egisters [S]earch" })
vim.keymap.set("n", "<leader>so", function() extra.pickers.oldfiles() end, { desc = "[S]earch Recent Files" })

-- Directory pickers matching your customized Telescope behavior
vim.keymap.set("n", "<leader>fd", function() pick_in_dir("grep") end, { desc = "[F]ind Search Grep in a [D]irectory" })
vim.keymap.set("n", "<leader>pd", function() pick_in_dir("files") end, { desc = "Search find files in a directory" })

extra.setup()


local minicompletion = require("mini.completion")
minicompletion.setup({
    lsp_completion = {
        auto_setup = true,
        process_items = function(items, base)
            return minicompletion.default_process_items(items, base, {
                filtersort = "fuzzy",
            })
        end,
    }
})


--- mini snippets ---
local minisnip = require("mini.snippets")
minisnip.setup({
    snippets = {
        minisnip.gen_loader.from_lang(), -- loads friendly-snippets
    },
})
minisnip.start_lsp_server({ match = false })

require("lsp")


vim.keymap.set("n", "<leader>gs", function() vim.cmd("vert Git") end, {desc = "Open git"})
