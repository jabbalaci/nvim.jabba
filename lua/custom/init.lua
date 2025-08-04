return {
  require 'custom.options', -- my options
  require 'custom.mappings', -- my key mappings
  require 'custom.commands', -- my custom commands

  require 'custom.autocmds', -- auto commands

  -- my plugins
  require 'custom.goto_line',
  require 'custom.surround',
  require 'custom.terminal',
}
