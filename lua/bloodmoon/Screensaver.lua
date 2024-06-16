---design choices
---* no hidding cursor, it's too tricky

local Ephemeral = require("infra.Ephemeral")
local ex = require("infra.ex")
local iuv = require("infra.iuv")
local ni = require("infra.ni")
local prefer = require("infra.prefer")
local rifts = require("infra.rifts")

local facts = require("bloodmoon.facts")

local uv = vim.uv

---@param interval integer @in millisecond
---@param callback fun()
---@return userdata
local function set_interval(interval, callback)
  local timer = iuv.new_timer()
  timer:start(interval, interval, callback)
  return timer
end

---@class bloodmoon.Screensaver
---@field private scene bloodmoon.Scene
---@field private winid integer
---@field private timer userdata
---@field private is_idle fun(): boolean
local Screensaver = {}
Screensaver.__index = Screensaver

---@private
---@param screen_width integer
---@param screen_height integer
---@return integer
function Screensaver:create_buf(screen_width, screen_height)
  local lines = {}
  do
    assert(screen_width > self.scene.width)
    assert(screen_height > self.scene.height)
    --todo: what if screen_{width,height} are not long enough?
    local row_offset = math.ceil((screen_height - self.scene.height) / 2)
    local col_offset = math.ceil((screen_width - self.scene.width) / 2)
    for _ = 1, row_offset do
      table.insert(lines, "")
    end
    for _, line in ipairs(self.scene.lines) do
      if line ~= "" then line = string.rep(" ", col_offset) .. line end
      table.insert(lines, line)
    end
    for _ = 1, screen_height - #lines do
      table.insert(lines, "")
    end
  end

  return Ephemeral({ namepat = "screensaver://{bufnr}" }, lines)
end

function Screensaver:enter()
  if self.winid and ni.win_is_valid(self.winid) then return end

  --todo: VimResized
  local screen_width = vim.go.columns
  local screen_height = vim.go.lines - vim.go.cmdheight

  local bufnr = self:create_buf(screen_width, screen_height)

  self.winid = rifts.open.fullscreen(bufnr, true, { relative = "editor" })
  prefer.wo(self.winid, "list", false)

  do --press any key to dismiss
    ex("mode") --it clears cmdline, while :redraw! not
    vim.fn.getchar()

    ni.win_close(self.winid, true)
    self.winid = nil
  end
end

function Screensaver:enable()
  if self.timer ~= nil then return end

  self.timer = set_interval(
    facts.check_interval,
    vim.schedule_wrap(function()
      if not self.is_idle() then return end
      self:enter()
    end)
  )
end

function Screensaver:disable()
  if self.timer == nil then return end

  uv.timer_stop(self.timer)
  self.timer = nil
end

---@param scene bloodmoon.Scene
---@param is_idle fun(): boolean
---@return bloodmoon.Screensaver
return function(scene, is_idle) return setmetatable({ scene = scene, is_idle = is_idle }, Screensaver) end
