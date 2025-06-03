vim.api.nvim_create_user_command("QuickRight", function(details)
    local args = details.fargs
    require("quickRight").doit(args[1])
  end,
  { nargs = "*" }
)
