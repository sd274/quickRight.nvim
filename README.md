# Quick Right

This is a basic nvim plugin to run pyright and put the errors into a quick fix list.

## Installation

To install with lazy add the following to your config file

```lua
{
    require("quickRight").setup()
}
```

QuickRight can then be ran via `require("quickRight").doit()`.
