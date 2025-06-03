# Quick Right

This is a basic nvim plugin to run pyright and put the errors into a quick fix list.

## Installation

To install with lazy add the following to your config file

```lua
return {
  dir = "~/Documents/personal/pyright.nvim",
  config = function()
    require("quickRight")
  end
}
```

QuickRight can then be ran via `:QuickRight dir_to_check`, if no directory is given then it will prompt you to give one.

Note: This is a very rough plugin, to do some stuff that i find useful, it is not intended to solve all your issues.
