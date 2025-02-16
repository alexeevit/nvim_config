call ddu#custom#action('kind', 'file', 'tabopen', { args -> execute('tabnew ' . args.items[0].action.path) })
call ddu#custom#action('kind', 'file', 'vsplit', { args -> execute('vsplit ' . args.items[0].action.path) })
call ddu#custom#action('kind', 'file', 'split', { args -> execute('split ' . args.items[0].action.path) })

execut 'source' $"{'<sfile>'->expand()->fnamemodify(':h')}/ddu/files-browser.vim"
