return {
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		local jdtls = require("jdtls")

		local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
		if not root_dir then
			root_dir = vim.fn.getcwd()
		end

		-- print("Using root_dir: " .. root_dir)

		-- Setup DAP configs *only* if function exists
		if jdtls.setup_dap_main_class_configs then
			jdtls.setup_dap_main_class_configs()
		end

		local home = os.getenv("HOME")
		local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"

		-- Tell our JDTLS language features it is capable of
		local capabilities = {
			workspace = {
				configuration = true,
			},
			textDocument = {
				completion = {
					snippetSupport = false,
				},
			},
		}

		local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

		for k, v in pairs(lsp_capabilities) do
			capabilities[k] = v
		end

		-- Get the default extended client capablities of the JDTLS language server
		local extendedClientCapabilities = jdtls.extendedClientCapabilities
		-- Modify one property called resolveAdditionalTextEditsSupport and set it to true
		extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

		-- Resolve the exact launcher JAR (wildcards don't work with -jar)
		local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
		-- if launcher_jar == "" then
		-- 	vim.notify("JDTLS launcher jar not found!", vim.log.levels.ERROR)
		-- 	return
		-- end

		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = home .. "/.local/share/eclipse/" .. project_name

		-- print("Home dir is: " .. home)
		local config = {
			cmd = {
				"java",
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xms1g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",
				"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
				"-jar",
				vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
				-- launcher_jar,
				"-configuration",
				jdtls_path .. "/config_mac",
				"-data",
				workspace_dir,
			},
			root_dir = root_dir,
			settings = {
				-- java = {},
				java = {
					-- Enable code formatting
					format = {
						enabled = true,
						-- Use the Google Style guide for code formattingh
						settings = {
							url = vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml",
							profile = "GoogleStyle",
						},
					},
					-- Enable downloading archives from eclipse automatically
					eclipse = {
						downloadSource = true,
					},
					-- Enable downloading archives from maven automatically
					maven = {
						downloadSources = true,
					},
					-- Enable method signature help
					signatureHelp = {
						enabled = true,
					},
					-- Use the fernflower decompiler when using the javap command to decompile byte code back to java code
					contentProvider = {
						preferred = "fernflower",
					},
					-- Setup automatical package import oranization on file save
					saveActions = {
						organizeImports = true,
					},
					-- Customize completion options
					completion = {
						-- When using an unimported static method, how should the LSP rank possible places to import the static method from
						favoriteStaticMembers = {
							"org.hamcrest.MatcherAssert.assertThat",
							"org.hamcrest.Matchers.*",
							"org.hamcrest.CoreMatchers.*",
							"org.junit.jupiter.api.Assertions.*",
							"java.util.Objects.requireNonNull",
							"java.util.Objects.requireNonNullElse",
							"org.mockito.Mockito.*",
						},
						-- Try not to suggest imports from these packages in the code action window
						filteredTypes = {
							"com.sun.*",
							"io.micrometer.shaded.*",
							"java.awt.*",
							"jdk.*",
							"sun.*",
						},
						-- Set the order in which the language server should organize imports
						importOrder = {
							"java",
							"jakarta",
							"javax",
							"com",
							"org",
						},
					},
					sources = {
						-- How many classes from a specific package should be imported before automatic imports combine them all into a single import
						organizeImports = {
							starThreshold = 9999,
							staticThreshold = 9999,
						},
					},
					-- How should different pieces of code be generated?
					codeGeneration = {
						-- When generating toString use a json format
						toString = {
							template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
						},
						-- When generating hashCode and equals methods use the java 7 objects method
						hashCodeEquals = {
							useJava7Objects = true,
						},
						-- When generating code use code blocks
						useBlocks = true,
					},
					-- If changes to the project will require the developer to update the projects configuration advise the developer before accepting the change
					configuration = {
						updateBuildConfiguration = "interactive",
					},
					-- enable code lens in the lsp
					referencesCodeLens = {
						enabled = true,
					},
					-- enable inlay hints for parameter names,
					inlayHints = {
						parameterNames = {
							enabled = "all",
						},
					},
				},
			},
			init_options = {
				bundles = {
					vim.fn.glob(
						home
							.. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
						1
					),
				},
				extendedClientCapabilities = extendedClientCapabilities,
			},
			on_attach = function(_, bufnr)
				require("jdtls.dap").setup_dap()
				require("jdtls.dap").setup_dap_main_class_configs()
				-- Enable jdtls commands to be used in Neovim
				require("jdtls.setup").add_commands()
				-- Refresh the codelens
				-- Code lens enables features such as code reference counts, implemenation counts, and more.
				vim.lsp.codelens.refresh()
				-- Setup a function that automatically runs every time a java file is saved to refresh the code lens
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.java" },
					callback = function()
						local _, _ = pcall(vim.lsp.codelens.refresh)
					end,
				})
			end,
		}

		-- Start or attach jdtls
		jdtls.start_or_attach(config)

		vim.api.nvim_create_autocmd("BufReadCmd", {
			pattern = "jdt://*",
			callback = function(args)
				require("jdtls").open_classfile(args.file)
			end,
		})

		local jdtls = require("jdtls")

		vim.keymap.set("n", "<leader>gd", function()
			local params = vim.lsp.util.make_position_params()

			vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx, _)
				if err then
					vim.notify("LSP error: " .. err.message, vim.log.levels.ERROR)
					return
				end

				if not result or vim.tbl_isempty(result) then
					vim.notify("No definition found", vim.log.levels.INFO)
					return
				end

				local location = result[1]
				local uri = location.uri or location.targetUri

				if uri:match("^jdt://") then
					-- Open .class file via jdtls
					-- vim.cmd("tabnew")
					local current_buf = vim.api.nvim_get_current_buf()
					jdtls.open_classfile(uri)
					vim.cmd("set ma")

					-- Try to jump to method after .class buffer loads
					local tries = 0
					local max_tries = 40

					vim.defer_fn(function()
						-- Switch to the class file buffer and jump
						local bufnr = vim.uri_to_bufnr(uri)
						if vim.api.nvim_buf_is_loaded(bufnr) then
							vim.api.nvim_set_current_buf(bufnr)
							vim.lsp.util.jump_to_location(location, "utf-8", true)
						else
							vim.notify("Classfile not ready", vim.log.levels.WARN)
						end

						-- Optionally, jump back to the original buffer
						vim.api.nvim_set_current_buf(current_buf)
					end, 200)
				else
					-- Normal LSP location
					vim.lsp.util.jump_to_location(location, "utf-8", true)
				end
			end)
		end)
	end,
}
