local global = {}

function global:local_variables()
  self.home = os.getenv('HOME')
  self.cache_dir = self.home .. '/.cache/nvim/'
  self.vim_path = vim.fn.stdpath('config')
  self.module_dir = self.vim_path .. '/lua/module/'
end

global:local_variables()

return global
