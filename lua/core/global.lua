local global = {}

function global:local_variables()
  self.home = os.getenv('HOME')
  self.cache_dir = self.home .. '/.cache/nvim/'
end

global:local_variables()

return global
