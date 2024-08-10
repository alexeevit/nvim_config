" Colorscheme
colorscheme iceberg
set termguicolors
let g:lightline.colorscheme = 'iceberg'

lua << EOF
local auto_dark_mode = require('auto-dark-mode')

auto_dark_mode.setup({
  update_interval = 1000,
  set_dark_mode = function()
    vim.api.nvim_set_option('background', 'dark')
    vim.api.nvim_command('hi IndentGuidesOdd guibg=#262a3f guifg=NONE')
    vim.api.nvim_command('hi IndentGuidesEven guibg=#202330 guifg=NONE')
    reload_iceberg()
  end,

  set_light_mode = function()
    vim.api.nvim_set_option('background', 'light')
    vim.api.nvim_command('hi IndentGuidesOdd guibg=#dcdfe8 guifg=NONE')
    vim.api.nvim_command('hi IndentGuidesEven guibg=#e1deea guifg=NONE')
    reload_iceberg()
  end,
})

function reload_iceberg()
  vim.api.nvim_command("execute 'source' globpath(&rtp, 'autoload/lightline/colorscheme/iceberg.vim')")
  vim.api.nvim_command("call lightline#colorscheme()")
end

auto_dark_mode.init()
EOF
