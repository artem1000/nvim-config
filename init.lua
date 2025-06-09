require("artem.core")
require("artem.lazy")

-- If using the above, then `python3 -m debugpy --version`
-- must work in the shell

--this is required so that NVIM uses new java version as opposed to the 261
vim.fn.setenv("JAVA_HOME", "/usr/local/opt/openjdk")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
vim.api.nvim_create_autocmd("BufReadCmd", {
	pattern = "jdt://*",
	callback = function(args)
		vim.bo[args.buf].filetype = "java"
	end,
})
