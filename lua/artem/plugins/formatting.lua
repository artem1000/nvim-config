return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				black = {
					prepend_args = { "--fast" },
				},
			},
			formatters_by_ft = {
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				java = { "astyle" },
				xml = { "xmlformatter" },
				json = { "prettier" },
				yaml = { "prettier" },
				sh = { "beautysh" },
				groovy = { "npm-groovy-lint" },
				markdown = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 6000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 6000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
