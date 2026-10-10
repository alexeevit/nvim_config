require'nvim-treesitter'.install { "ruby", "javascript", "embedded_template", "html" }

-- Highlight every filetype that has a parser, with regex syntax turned off
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
