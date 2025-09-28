-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- ~/.config/nvim/lua/user/keymaps.lua
-- All custom keymaps live here
-- This file is loaded in init.lua with: require("user.keymaps")

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- =====================
-- NORMAL MODE KEYMAPS
-- =====================
--
map("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })
map("n", "<leader>qw", ":w<CR>", { desc = "Save current buffer" })

-- Buffer navigation
map("n", "]b", function()
  require("astrocore.buffer").nav(vim.v.count1)
end, { desc = "Next buffer" })
map("n", "[b", function()
  require("astrocore.buffer").nav(-vim.v.count1)
end, { desc = "Previous buffer" })

-- Delete all lines in current buffer
map("n", "<leader>da", ":%d<CR>", { desc = "Delete all lines in buffer" })

-- Format JSON using jq
map("n", "<leader>fj", ":%!jq .<CR>", { desc = "Fix JSON formatting" })

-- Delete all instances of word under cursor globally
map("n", "<leader>dw", [[:%s/\<\<<C-r><C-w>\>\>//g<CR>]], { desc = "Delete word under cursor globally" })

-- Scroll down 15 lines without moving cursor
map("n", "<leader>gu", [[15<C-e><CR>]], { desc = "Scroll down 15 lines" })

-- Paste after cursor inline (no newline)
map("n", "gp", function()
  vim.api.nvim_put({ vim.fn.getreg('"') }, "c", true, true)
end, { desc = "Paste after cursor inline" })

-- Find config file (your custom picker)
map("n", "<leader>fd", function()
  require("user.config_picker").open()
end, { desc = "Find config file" })

-- Close buffer from tabline (AstroNvim heirline picker)
map("n", "<leader>bd", function()
  require("astroui.status.heirline").buffer_picker(function(bufnr)
    require("astrocore.buffer").close(bufnr)
  end)
end, { desc = "Close buffer from tabline" })

-- =====================
-- VISUAL MODE KEYMAPS
-- =====================
-- Delete blank lines in selection
map("v", "<leader>dw", [[:<C-u>'<,'>g/^\s*$/d<CR>]], { desc = "Delete blank lines in selection" })

-- Wrap the current paragraph in { ... } and indent body
map("n", "<leader>wp", function()
  require("user.wrap").wrap_paragraph({ open = "{", close = "}" })
end, { desc = "Wrap paragraph with {}" })
