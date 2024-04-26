local M = {}

local facts = require("bloodmoon.facts")

local api = vim.api
local uv = vim.loop

local ns = api.nvim_create_namespace("bloodmoon:idle")

local last = uv.hrtime()
local enable = false

function M.enable()
  if enable then return end
  enable = true

  vim.on_key(function() last = uv.hrtime() end, ns)
end

function M.disable()
  if not enable then return end
  enable = false

  ---@diagnostic disable-next-line: param-type-mismatch
  vim.on_key(nil, ns)
end

---@return boolean
function M.is_idle()
  assert(enable)

  return uv.hrtime() - last > facts.idle_gap
end

return setmetatable(M, { __call = M.is_idle })
