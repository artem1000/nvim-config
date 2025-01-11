-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("n", "<tab>", ":bnext<CR>", { desc = "Go to the next buffer" })
keymap.set("n", "<S-tab>", ":bprev<CR>", { desc = "Go to the previous buffer" })

keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- in visual mode when a block is selected J and K will move that block up and down
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z") -- when the bottom line is appended to the current line the cursor does not jump to the very end of the line.

keymap.set("n", "<C-d>", "<C-d>zz") -- when paging up and down keeps the cursor in the middle of the page
keymap.set("n", "<C-u>", "<C-d>zz") -- when paging up and down keeps the cursor in the middle of the page

keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "n", "nzzzv")

keymap.set("n", "<leader>p", '"_dP') -- preserves original highlighted buffer when copying it over another highlighted word.

keymap.set("n", "<leader>y", '"+y', { desc = "Yank into system buffer" }) -- yanks into the system buffer that can be copied pasted via Ctrl-V somewhere else
keymap.set("v", "<leader>y", '"+y', { desc = "Yank into system buffer" }) -- yanks into the system buffer that can be copied pasted via Ctrl-V somewhere else
keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank into system buffer" }) -- yanks into the system buffer that can be copied pasted via Ctrl-V somewhere else

keymap.set(
	"n",
	"<leader>sr",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Global replace of the word everywhere" }
) -- global replace of the current word everywhere
keymap.set("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Makes file executable" }) -- makes the file executable

--Harpoon keymaps
--local mark = require("harpoon.mark")
-- local ui = require("harpoon.ui")
--:
keymap.set("n", "<leader>a", ":lua require('harpoon.mark').add_file()<CR>")
keymap.set("n", "<C-e>", ":Telescope harpoon marks<CR>")
keymap.set("n", "<C-p>", ":lua require('harpoon.ui').nav_prev()<CR>")
keymap.set("n", "<C-n>", ":lua require('harpoon.ui').nav_next()<CR>")
-- <C-d> to delete marked file
