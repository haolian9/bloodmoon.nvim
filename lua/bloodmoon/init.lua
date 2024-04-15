---design choices
---* no hidding cursor, it's too tricky

local M = {}

local is_idle = require("bloodmoon.is_idle")
local scenes = require("bloodmoon.scenes")
local Screensaver = require("bloodmoon.Screensaver")

---@type bloodmoon.Screensaver
local screensaver = Screensaver(vim.go.background == "light" and scenes.iusenvimbtw_light or scenes.iusenvimbtw_dark, is_idle.is_idle)

function M.show() screensaver:enter() end

function M.enable()
  is_idle.enable()
  screensaver:enable()
end

function M.disable()
  is_idle.disable()
  screensaver:disable()
end

return M
