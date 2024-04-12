local M = {}

local fn = require("infra.fn")

local api = vim.api

---@class bloodmoon.Scene
---@field lines string[]
---@field width integer
---@field height integer

---@param str string
---@return bloodmoon.Scene
local function Scene(str)
  local lines = fn.split(str, "\n")

  --trim blank lines
  for i = 1, #lines do
    if lines[i] ~= "" then break end
    table.remove(lines, 1)
  end
  for i = #lines, 1, -1 do
    if lines[i] ~= "" then break end
    table.remove(lines, #lines)
  end

  local width = fn.max(fn.map(api.nvim_strwidth, lines))
  local height = #lines

  return { lines = lines, width = width, height = height }
end

M.iusenvimbtw_dark = Scene([[
██╗    ██╗   ██╗███████╗███████╗    ███╗   ██╗██╗   ██╗██╗███╗   ███╗
██║    ██║   ██║██╔════╝██╔════╝    ████╗  ██║██║   ██║██║████╗ ████║
██║    ██║   ██║███████╗█████╗      ██╔██╗ ██║██║   ██║██║██╔████╔██║
██║    ██║   ██║╚════██║██╔══╝      ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║    ╚██████╔╝███████║███████╗    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║▄█╗
╚═╝     ╚═════╝ ╚══════╝╚══════╝    ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝

                      ██████╗ ████████╗██╗    ██╗
                      ██╔══██╗╚══██╔══╝██║    ██║
                      ██████╔╝   ██║   ██║ █╗ ██║
                      ██╔══██╗   ██║   ██║███╗██║
                      ██████╔╝   ██║   ╚███╔███╔╝
                      ╚═════╝    ╚═╝    ╚══╝╚══╝
]])

M.iusenvimbtw_light = Scene([[
 __      __    __       _______. _______    .__   __. ____    ____  __  .___  ___.
|  |    |  |  |  |     /       ||   ____|   |  \ |  | \   \  /   / |  | |   \/   |
|  |    |  |  |  |    |   (----`|  |__      |   \|  |  \   \/   /  |  | |  \  /  |
|  |    |  |  |  |     \   \    |   __|     |  . `  |   \      /   |  | |  |\/|  |
|  |    |  `--'  | .----)   |   |  |____    |  |\   |    \    /    |  | |  |  |  |  __
|__|     \______/  |_______/    |_______|   |__| \__|     \__/     |__| |__|  |__| (_ )

                      .______   .___________.____    __    ____
                      |   _  \  |           |\   \  /  \  /   /
                      |  |_)  | `---|  |----` \   \/    \/   /
                      |   _  <      |  |       \            /
                      |  |_)  |     |  |        \    /\    /
                      |______/      |__|         \__/  \__/
]])

return M
