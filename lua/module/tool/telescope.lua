return {
  'nvim-telescope/telescope.nvim',
  lazy = true,
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
    { 'nvim-lua/popup.nvim', lazy = true },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', lazy = true },
  },
  keys = {
    { '<leader>b', '<cmd>Telescope buffers<cr>' },
    { '<leader>fa', '<cmd>Telescope live_grep<cr>' },
    { '<leader>ff', '<cmd>Telescope find_files<cr>' },
  },
  config = function()
    require('telescope').setup({
      defaults = {
        layout_config = {
          horizontal = { prompt_position = 'top', results_width = 0.6 },
          vertical = { mirror = false },
        },
        sorting_strategy = 'ascending',
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
      require('telescope').load_extension('fzf'),
    })
  end,
}
