return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && bun install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown', 'Avante' }
  end,
  ft = { 'markdown', 'Avante' },
  config = function()
    vim.cmd [[do FileType]]
  end,
}
