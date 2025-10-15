return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		-- local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.INFO] = " ",
						[vim.diagnostic.severity.HINT] = "󰠠 ",
					},
					linehl = {
						[vim.diagnostic.severity.ERROR] = "Error",
						[vim.diagnostic.severity.WARN] = "Warn",
						[vim.diagnostic.severity.INFO] = "Info",
						[vim.diagnostic.severity.HINT] = "Hint",
					},
				},
			})
		end

		local lsp_attach = function(client, bufnr) end
		vim.api.nvim_command("MasonToolsInstall")

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				if server_name ~= "jdtls" then -- i have to do this otherwise there are 2 instance of JDTLS launched
					vim.lsp.config (server_name, {
						on_attach = lsp_attach,
						capabilities = capabilities,
					})
				end
        vim.lsp.enable({server_name})
			end,
			["groovyls"] = function()
				vim.lsp.config("groovyls", {
					capabilities = capabilities,
					filetypes = { "groovy", "ncfg", "bjs", "bjd" },
					cmd = {
						"/usr/local/opt/openjdk/bin/java",
						"-jar",
						"/Users/agrinchenko/Documents/DEV/groovy-lsp/groovy-language-server/build/libs/groovy-language-server-all.jar",
					},
				})
        vim.lsp.enable({"groovyls"})
			end,
			["gopls"] = function()
				vim.lsp.config("gopls", {
					capabilities = capabilities,
					settings = {
						gopls = {
							analyses = {
								unusedparams = true, -- highlight unused parameters
								unreachable = true, -- highlight unreachable code
							},
							staticcheck = true, -- enable staticcheck for better linting
							usePlaceholders = true, -- enable placeholders in completions
							completeUnimported = true,
							gofumpt = true, -- format code with gofumpt
							semanticTokens = true, -- enable semantic tokens
						},
					},
					on_attach = function(client, bufnr)
						local opts = { buffer = bufnr, silent = true }
						-- Additional Go-specific keymaps
						vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts) -- Go to definition
						vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- Go to declaration
						vim.keymap.set("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts) -- Go to references
						vim.keymap.set("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- Go to implementation
						vim.keymap.set("n", "gt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts) -- Go to type definition
						vim.keymap.set("n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts) -- Rename
						vim.keymap.set("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts) -- Code actions
						vim.keymap.set("n", "<leader>D", "<Cmd>Telescope diagnostics bufnr=0<CR>", opts) -- Show diagnostics
					end,
				})
        vim.lsp.enable({"gopls"})
			end,
			["lua_ls"] = function()
				-- lspconfig["lua_ls"].setup({
				vim.lsp.config("lua_ls", {
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
      vim.lsp.enable({"lua_ls"})
			end,
		})
	end,
}
