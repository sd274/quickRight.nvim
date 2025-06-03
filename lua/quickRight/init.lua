print("Quick Right Loaded...")

local M = {}

M.setup = function()
  -- nothing
end

---@class quickWrite.Stuff
---@fields stuff string[]

---@param dir_name string: The name of the file to run
---@return quickWrite.Stuff
local run_pyright = function(dir_name)
  vim.print('Running PyRight on ', dir_name)
  local handle = io.popen("pyright " .. dir_name .. " --outputjson")
  local output = handle:read("*a")
  local parsed_checks = vim.json.decode(output)
  local bad_files = parsed_checks['generalDiagnostics']
  local bad_file_names = {}
  for i = 1, #bad_files, 1
  do
    table.insert(
      bad_file_names,
      {
        filename = bad_files[i]['file'],
        lnum = 1
      }
    )
  end
  local testing = {
    {
      filename = "app/api/main.py",
      lnum = 1
    },
    {
      filename = "app/api/config.py",
      lnum = 1
    },
  }
  vim.fn.setqflist({}, 'r', {  items = testing })
  return {
    Stuff = {
      stuff = bad_file_names
    }

  }
end

M.doit = function()
  local output = run_pyright('app')
  vim.print(output['Stuff']['stuff'])
end

-- vim.print(
--   run_pyright('test')
-- )

return M
