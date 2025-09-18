return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  options = {},
  config = function(_, options)
    local harpoon = require 'harpoon'
    harpoon:setup(options)

    local keymap = vim.keymap.set

    keymap('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add file to Harpoon' })

    keymap('n', '<leader><leader>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Toggle Harpoon menu' })

    for i = 1, 9 do
      keymap('n', '<leader>' .. i, function()
        harpoon:list():select(i)
      end, { desc = 'Navigate to Harpoon file ' .. i })
    end
  end,
}
