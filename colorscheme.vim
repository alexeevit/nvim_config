" Colorscheme
colorscheme iceberg
set termguicolors
" set background=dark

let g:lightline.colorscheme = 'iceberg'

lua << EOF
local auto_dark_mode = require('auto-dark-mode')

auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = function()
		vim.api.nvim_set_option('background', 'dark')
    reload_iceberg()
	end,

	set_light_mode = function()
		vim.api.nvim_set_option('background', 'light')
    reload_iceberg()
	end,
})

function reload_iceberg()
  vim.api.nvim_command("execute 'source' globpath(&rtp, 'autoload/lightline/colorscheme/iceberg.vim')")
  vim.api.nvim_command("call lightline#init()")
  vim.api.nvim_command("call lightline#colorscheme()")
end

auto_dark_mode.init()
EOF
