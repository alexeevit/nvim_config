" Colorscheme
colorscheme PaperColor
set termguicolors
" set background=dark

let g:lightline.colorscheme = 'PaperColor_light'

lua << EOF
local auto_dark_mode = require('auto-dark-mode')
auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = function()
		vim.api.nvim_set_option('background', 'dark')
    vim.api.nvim_command("let g:lightline.colorscheme = 'PaperColor_dark'")
    vim.api.nvim_command("call lightline#disable()")
    vim.api.nvim_command("call lightline#enable()")
	end,

	set_light_mode = function()
		vim.api.nvim_set_option('background', 'light')
    vim.api.nvim_command("let g:lightline.colorscheme = 'PaperColor_light'")
    vim.api.nvim_command("call lightline#disable()")
    vim.api.nvim_command("call lightline#enable()")
	end,
})
auto_dark_mode.init()
EOF
