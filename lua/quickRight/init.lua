print("Quick Right Loaded...")

local M = {}

M.setup = function()
  -- nothing
end

---@class quickWrite.Stuff
---@fields stuff string[]

---@param dir_name string: The name of the file to run
---@return quickWrite.Stuff | nil
local run_pyright = function(dir_name)
  if not dir_name then
    -- If no argument, prompt the user for input
    dir_name = vim.fn.input('Enter the directory to check: ')
    if name == '' then
      vim.print('No directory entered. Aborting.')
      return
    end
  end
  vim.print('Running PyRight on ' .. dir_name)
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
        lnum = bad_files[i]["range"]["start"]["line"],
        col = bad_files[i]["range"]["start"]["character"],
        text = bad_files[i]["rule"]
      }
    )
  end
  vim.fn.setqflist(bad_file_names)
  if #bad_file_names > 0 then
    vim.cmd("copen")
  else
    vim.print("No pyright errors found")
  end

  return {
    Stuff = {
      stuff = bad_file_names
    }
  }
end

---@param dir_name string: The name of the file to run
M.doit = function(dir_name)
  run_pyright(dir_name)
end

return M
