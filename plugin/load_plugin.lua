vim.api.nvim_create_user_command("QuickRight", function(details)
    local args = details.fargs
    require("quickRight").pyright(args[1])
  end,
  { nargs = "*" }
)

vim.api.nvim_create_user_command("QuickTest", function(details)
    local args = details.fargs
    require("quickRight").pytest(args[1])
  end,
  { nargs = "*" }
)
