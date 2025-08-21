-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- General Keymaps -------------------

-- use jk to exit insert mode.. but not always works..
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers.. i am using native Ctrl A and X instead
-- keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
-- keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management, not using these but will keep them for now... may be i will ジ
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split" }) -- close current split window

-- bellow are tabs, they work OK but I just do not use them, so commenting them out ジ
-- keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
-- keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
-- keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
-- my personal keymap for the buffers back and forth
keymap.set("n", "<tab>", ":bnext<CR>", { desc = "Go to the next buffer" })
keymap.set("n", "<S-tab>", ":bprev<CR>", { desc = "Go to the previous buffer" })

keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- in visual mode when a block is selected J and K will move that block up and down
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z") -- when the bottom line is appended to the current line the cursor does not jump to the very end of the line.

keymap.set("n", "<C-d>", "<C-d>zz") -- when paging up and down keeps the cursor in the middle of the page
keymap.set("n", "<C-u>", "<C-u>zz") -- when paging up and down keeps the cursor in the middle of the page
-- these seem like keeping the cursor in the middle of the page when searching for the next or previous
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "n", "nzzzv")
-- insert Japanese Smiley ジ ジ㋛㋡ッツツ゚ｼ
-- keymap.set("n", "<leader>js", "iジ<ESC>", { desc = "Japanese smiley ジ" })

-- Full list of JDTLS commands:
-- ======> just run ===> :lua for k, _ in pairs(require('jdtls')) do print(k) end
-- update_projects_config
-- update_project_config
-- build_projects
-- _complete_compile
-- compile
-- javap
-- jshell
-- start_or_attach
-- settings
-- extract_method
-- extract_variable_all
-- _complete_set_runtime
-- extendedClientCapabilities
-- extract_variable
-- pick_test
-- test_nearest_method
-- test_class
-- setup_dap
-- organize_imports
-- set_runtime
-- setup
-- open_classfile
-- jol
-- super_implementation
-- commands
-- extract_constant
-- JDTLS keymaps
keymap.set("n", "<leader>js", ":lua require'jdtls'.organize_imports()<CR>", { desc = "JDTLS organize imports" })
keymap.set("n", "<leader>jm", ":lua require'jdtls'.extract_method()<CR>", { desc = "JDTLS extract method" })
keymap.set("n", "<leader>jv", ":lua require'jdtls'.extract_variable()<CR>", { desc = "JDTLS extract variable" })
keymap.set("n", "<leader>jb", ":lua require'jdtls'.build_projects()<CR>", { desc = "JDTLS build projects" })
keymap.set("n", "<leader>jc", ":lua require'jdtls'.compile()<CR>", { desc = "JDTLS compile" })

-- this one does not seem to work in nvim, so removing it.
keymap.set("n", "<leader>p", '"_dP') -- preserves original highlighted buffer when copying it over another highlighted word.

-- this set deletes stuff into the blackhole register so that it does not overwrite the system clipboard register
keymap.set("n", "<leader>D", '"_D') -- deletes to the end of the line into the black hole 
keymap.set("n", "<leader>dd", '"_dd') -- deletes entire line into the black hole 

-- keymap.set("n", "<leader>y", '"+y', { desc = "Yank into system buffer" }) -- yanks into the system buffer that can be copied pasted via Ctrl-V somewhere else
-- keymap.set("v", "<leader>y", '"+y', { desc = "Yank into system buffer" }) -- yanks into the system buffer that can be copied pasted via Ctrl-V somewhere else
-- keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank into system buffer" }) -- yanks into the system buffer that can be copied pasted via Ctrl-V somewhere else

-- global replace of the current word everywhere
keymap.set(
	"n",
	"<leader>sr",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Global replace of the word everywhere" }
)

keymap.set("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Makes file executable" }) -- makes the file executable

--Harpoon keymaps
--local mark = require("harpoon.mark")
-- local ui = require("harpoon.ui")
--:
keymap.set("n", "<leader>a", ":lua require('harpoon.mark').add_file()<CR>", { desc = "Add Harpoon Mark, then C-e/p/n" })
-- keymap.set("n", "<C-e>", ":Telescope harpoon marks<CR>")
keymap.set("n", "<C-e>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
keymap.set("n", "<C-p>", ":lua require('harpoon.ui').nav_prev()<CR>")
keymap.set("n", "<C-n>", ":lua require('harpoon.ui').nav_next()<CR>")
-- <C-d> to delete marked file
--
--
-- LSP
keymap.set("n", "<leader>gg", "<cmd>lua vim.lsp.buf.hover()<CR>")
keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
keymap.set("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
keymap.set("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
keymap.set("n", "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>")
keymap.set("n", "<leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
keymap.set("n", "<leader>rr", "<cmd>lua vim.lsp.buf.rename()<CR>")
keymap.set("n", "<leader>gf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
keymap.set("v", "<leader>gf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
keymap.set("n", "<leader>ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
keymap.set("n", "<leader>gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
keymap.set("n", "<leader>gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
keymap.set("n", "<leader>gn", "<cmd>lua vim.diagnostic.goto_next()<CR>")
keymap.set("n", "<leader>tr", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
keymap.set("i", "<C-Space>", "<cmd>lua vim.lsp.buf.completion()<CR>")
--
-- -- Filetype-specific keymaps (these can be done in the ftplugin directory instead if you prefer)
-- keymap.set("n", "<leader>go", function()
-- 	if vim.bo.filetype == "java" then
-- 		require("jdtls").organize_imports()
-- 	end
-- end)
--
-- keymap.set("n", "<leader>gu", function()
-- 	if vim.bo.filetype == "java" then
-- 		require("jdtls").update_projects_config()
-- 	end
-- end)
--
-- keymap.set("n", "<leader>tc", function()
-- 	if vim.bo.filetype == "java" then
-- 		require("jdtls").test_class()
-- 	end
-- end)
--
-- keymap.set("n", "<leader>tm", function()
-- 	if vim.bo.filetype == "java" then
-- 		require("jdtls").test_nearest_method()
-- 	end
-- end)
--
-- -- Debugging
keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
keymap.set("n", "<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<cr>")
keymap.set("n", "<leader>ba", "<cmd>Telescope dap list_breakpoints<cr>")
-- keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
keymap.set("n", "<F9>", "<cmd>lua require'dap'.continue()<cr>")
-- -- keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
keymap.set("n", "<F8>", "<cmd>lua require'dap'.step_over()<cr>")
-- -- keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
keymap.set("n", "<F7>", "<cmd>lua require'dap'.step_into()<cr>")
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
keymap.set("n", "<leader>dd", function()
	require("dap").disconnect()
	require("dapui").close()
end)
keymap.set("n", "<leader>dt", function()
	require("dap").terminate()
	require("dapui").close()
end)
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
keymap.set("n", "<leader>di", function()
	require("dap.ui.widgets").hover()
end)
keymap.set("n", "<leader>d?", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end)
keymap.set("n", "<leader>df", "<cmd>Telescope dap frames<cr>")
keymap.set("n", "<leader>dh", "<cmd>Telescope dap commands<cr>")
keymap.set("n", "<leader>de", function()
	require("telescope.builtin").diagnostics({ default_text = ":E:" })
end)
