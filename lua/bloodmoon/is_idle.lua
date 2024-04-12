local facts = require("bloodmoon.facts")

local api = vim.api
local uv = vim.loop

local ns = api.nvim_create_namespace("iusenvimbtw:isidle")
local last = uv.hrtime()

vim.on_key(function() last = uv.hrtime() end, ns)

---@return boolean
return function() return uv.hrtime() - last > facts.idle_gap end
