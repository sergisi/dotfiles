-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvim-neorg/neorg',
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '', -- Pin Neorg to the latest stable release
    config = function()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {}, -- Loads default behaviour
          ['core.concealer'] = {}, -- Adds pretty icons to your documents
          ['core.ui.calendar'] = {},
          ['core.completion'] = { config = { engine = 'nvim-cmp', name = '[Norg]' } },
          ['core.integrations.nvim-cmp'] = {},
          -- ["core.concealer"] = { config = { icon_preset = "diamond" } },
          ['core.esupports.metagen'] = { config = { type = 'auto', update_date = true } },
          ['core.qol.toc'] = {},
          ['core.qol.todo_items'] = {},
          ['core.looking-glass'] = {},
          ['core.presenter'] = { config = { zen_mode = 'zen-mode' } },
          ['core.export'] = {},
          ['core.export.markdown'] = { config = { extensions = 'all' } },
          ['core.summary'] = {},
          ['core.tangle'] = { config = { report_on_empty = false } },
          ['core.dirman'] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = '~/notes/notes',
                work = '~/notes/work',
              },
              default_workspace = 'work',
            },
          },
        },
      }
    end,
  },

  {
    'lervag/vimtex',
    config = function()
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_method = 'latexmk'
    end,
  },

  {
    'ggandor/leap.nvim',
    lazy = false,
    config = function()
      require 'leap'
      vim.keymap.set({ 'n', 'x', 'o' }, '<leader>l', '<Plug>(leap-forward)', { desc = '[L]eap find forward' })
      vim.keymap.set({ 'n', 'x', 'o' }, '<leader>L', '<Plug>(leap-backward)', { desc = '[L]eap find backward' })
      vim.keymap.set({ 'n', 'x', 'o' }, '<leader>gl', '<Plug>(leap-from-window)', { desc = '[L]eap from window' })
    end,
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      -- NOTE: I try the default configuration
      harpoon:setup()
      -- basic telescope configuration
      require('which-key').add {
        { '<leader>h', desc = '[H]arpoon menu' },
      }
      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, { desc = '[H]arpoon [A]dd' })
      vim.keymap.set('n', '<leader>hl', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = '[H]arpoon [l]ist' })
      for i = 1, 4, 1 do
        vim.keymap.set('n', string.format('<leader>h%d', i), function()
          harpoon:list():select(i)
        end, { desc = string.format('Jump to %d', i) })
      end
      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<leader>h<C-p>', function()
        harpoon:list():prev()
      end, { desc = 'Previous harpoon' })
      vim.keymap.set('n', '<leader>h<C-n>', function()
        harpoon:list():next()
      end, { desc = 'Next harpoon' })
    end,
  },
}
