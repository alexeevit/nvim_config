require'nvim-treesitter.configs'.setup {
  ensure_installed = { "ruby", "javascript", "embedded_template", "html" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
