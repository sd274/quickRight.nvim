# Quick Right

This is a basic nvim plugin to run pyright and put the errors into a quick fix list.

## Installation

To install with lazy add the following to your config file

```lua
return {
  "sd274/quickRight.nvim",
  config = function()
    require("quickRight")
  end
}
```

QuickRight can then be ran via `:QuickRight dir_to_check`, if no directory is given then it will prompt you to give one.

Note: This is a very rough plugin, to do some stuff that I find useful and have a play with creating plugins, it is not intended to be a perfect working plugin.
