return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		vim.g.nvim_tree_respect_buf_cwd = 1

		local gwidth = vim.api.nvim_list_uis()[1].width
		local gheight = vim.api.nvim_list_uis()[1].height
		local width = 80
		local height = 40

		nvimtree.setup({

			-- Below block ensures the nvim does not open on starting nvim
			hijack_unnamed_buffer_when_opening = true,
			disable_netrw = true, -- disable :Explore
			hijack_directories = {
				enable = true,
				auto_open = false,
			},

			-- old view config - open on the left side vertically
			-- view = {
			-- 	width = 35,
			-- 	relativenumber = false,
			-- },

			-- new old view config - floating in the center
			view = {
				float = {
					enable = true,
					open_win_config = {
						relative = "editor",
						width = width,
						height = height,
						row = (gheight - height) * 0.4,
						col = (gwidth - width) * 0.2,
					},
				},
			},

			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- below block ensures that the tree navigates to the currently opened file
		--
		update_focused_file =
			{
				enable = true,
				update_cwd = true,
			}, vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
		vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
	end,
}
