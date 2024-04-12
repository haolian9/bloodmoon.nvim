---design choices
---* no hidding cursor, it's too tricky

local M = {}

local scenes = require("bloodmoon.scenes")
local Screensaver = require("bloodmoon.Screensaver")

---@type bloodmoon.Screensaver
local screensaver = Screensaver(vim.go.background == "light" and scenes.iusenvimbtw_light or scenes.iusenvimbtw_dark)

function M.show() screensaver:enter() end
function M.enable() screensaver:enable() end
function M.disable() screensaver:disable() end

return M
