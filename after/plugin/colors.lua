
function ColorMyPencils(color)
	color = color or "rose-pine"
--	color = color or "miasma"
--	color = color or "cyber"

	local status_ok = pcall(vim.cmd.colorscheme, color)
	if not status_ok then
		return
	end

	vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
end

ColorMyPencils()
