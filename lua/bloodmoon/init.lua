---design choices
---* no hidding cursor, it's too tricky

local M = {}

local Idle = require("bloodmoon.Idle")
local scenes = require("bloodmoon.scenes")
local Screensaver = require("bloodmoon.Screensaver")

---@type bloodmoon.Screensaver
local screensaver = Screensaver(vim.go.background == "light" and scenes.iusenvimbtw_light or scenes.iusenvimbtw_dark, Idle.is_idle)

function M.show() screensaver:enter() end

function M.enable()
  Idle.enable()
  screensaver:enable()
end

function M.disable()
  Idle.disable()
  screensaver:disable()
end

return M
