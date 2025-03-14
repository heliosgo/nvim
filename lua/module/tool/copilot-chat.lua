return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim', branch = 'master' },
  },
  keys = {
    { 'sk', '<cmd>CopilotChatOpen<cr>' },
  },
  build = 'make tiktoken', -- Only on MacOS or Linux
  opts = {},
}
