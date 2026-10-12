require'nvim-treesitter'.install {
  "ruby", "javascript", "embedded_template", "html",
  "go", "rust", "python", "php", "typescript", "tsx", "json",
}

-- Highlight every filetype that has a parser. Regex syntax keeps running
-- underneath (Treesitter's colors win): indent scripts for Ruby, JS, TS, PHP,
-- Python and others use its syntax groups to skip strings and comments, and
-- indent wrongly without them.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter_start', {}),
  callback = function(args)
    if pcall(vim.treesitter.start, args.buf) then
      vim.bo[args.buf].syntax = 'ON'
    end
  end,
})
