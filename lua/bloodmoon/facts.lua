local M = {}

local highlighter = require("infra.highlighter")
local ni = require("infra.ni")

do --design: only foreground color, single color
  local hi = highlighter(0)
  if vim.go.background == "light" then
    hi("BloodMoon", { fg = 1 })
  else
    hi("BloodMoon", { fg = 9 })
  end
end

M.xmark_ns = ni.create_namespace("bloodmoon.xmark")

--in nanoseconds
M.idle_gap = 5 * 60 * (1000 * 1000 * 1000)

--in milliseconds
M.check_interval = 5 * 1000

return M
