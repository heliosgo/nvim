local global = require('core.global')

local Lazy = {}

function Lazy:load_lazy()
  local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      lazy_path,
    })
  end
  vim.opt.rtp:prepend(lazy_path)
end

function Lazy:load_plugins()
  local get_plugins_list = function()
    local list = {}
    local plugins_list =
      vim.split(vim.fn.globpath(global.module_dir, '*/*.lua'), '\n')
    for _, f in ipairs(plugins_list) do
      list[#list + 1] = string.match(f, 'lua/(.+).lua')
    end
    return list
  end

  self.modules = {}
  if not vim.env.KITTY_SCROLLBACK then
    local plugins_file = get_plugins_list()
    for _, m in ipairs(plugins_file) do
      self.modules[#self.modules + 1] = require(m)
    end
  else
    self.modules[#self.modules + 1] = require('module.ui.kanagawa')
  end
  require('lazy').setup(self.modules)
end

function Lazy:load()
  self:load_lazy()
  self:load_plugins()
end

Lazy:load()
