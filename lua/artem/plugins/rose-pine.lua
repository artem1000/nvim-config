-- lua/plugins/rose-pine.lua

function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#6e6a86" })
	vim.api.nvim_set_hl(0, "Visual", { bg = "#908caa" }) -- https://rosepinetheme.com/palette/ingredients/
end

return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		vim.cmd("colorscheme rose-pine")
		ColorMyPencils()
	end,
}
