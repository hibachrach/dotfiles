vim.lsp.start({
  name = 'tsserver',
  init_options = { hostInfo = 'neovim' },
  cmd = {'typescript-language-server', '--stdio'},
  root_dir = vim.fs.dirname(vim.fs.find({'package.json'}, { upward = true })[1]),
  single_file_support = true
})

