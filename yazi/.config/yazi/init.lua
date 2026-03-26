-- Starship prompt
require("starship"):setup()
-- Border
require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
})
-- Git signs for files
require("git"):setup({
	-- Order of status signs showing in the linemode
	order = 1500,
})
