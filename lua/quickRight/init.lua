print("Quick Right Loaded...")

local M = {}

M.setup = function()
  -- nothing
end

---@class QuickList
---@fields filename string
---@fields lnum int
---@fields col int
---@fields text str

---@param dir_name string: The name of the file to run
---@return QuickList[] | nil
local run_pyright = function(dir_name)
  if not dir_name then
    -- If no argument, prompt the user for input
    dir_name = vim.fn.input('Enter the directory to check: ')
    if dir_name == '' then
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
        lnum = 1 + bad_files[i]["range"]["start"]["line"],
        col = 1 + bad_files[i]["range"]["start"]["character"],
        text = bad_files[i]["rule"]
      }
    )
  end
  return bad_file_names
end

---@param dir_name string: The name of the file to run
---@return QuickList[] | nil
local run_pytest = function(dir_name)
  if not dir_name then
    -- If no argument, prompt the user for input
    dir_name = vim.fn.input('Enter the directory to check: ')
    if dir_name == '' then
      vim.print('No directory entered. Aborting.')
      return
    end
  end
  vim.print('Running PyTest on ' .. dir_name)
  local handle = io.popen("pytest " .. dir_name)
  local output = handle:read("*a")
  print(output)
  return
end

---@param dir_name string: The name of the file to run
M.pyright = function(dir_name)
  local bad_file_names = run_pyright(dir_name)
  if not bad_file_names then
    vim.print("no pyright errors found")
    return
  end
  if #bad_file_names == 0 then
    vim.print("no pyright errors found")
    return
  end

  vim.fn.setqflist(bad_file_names)
  vim.cmd("copen")
end

M.pytest = function(dir_name)
  local bad_file_names = run_pytest(dir_name)
  if not bad_file_names then
    vim.print("no pytest errors found")
    return
  end
  if #bad_file_names == 0 then
    vim.print("no pytest errors found")
    return
  end
end

return M
