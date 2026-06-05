
function ColorMyPencils(color)
--	color = color or "rose-pine"
--	color = color or "miasma"
--	color = color or "tokyonight-night"
	color = color or "coppernight"

	local status_ok = pcall(vim.cmd.colorscheme, color)
	if not status_ok then
		return
	end
end

ColorMyPencils()
