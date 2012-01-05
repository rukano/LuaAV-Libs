--[[
Testing scsynth from Lua -> !!! highly experimental !!! almost nothing works !!!

-- sc:boot() not working yet!

start scsynth from the terminal like:

> cd /you/path/to/SuperCollider
> ./scsynth -u 57117

--]]

local sc = require("lib.SuperCollider")
local Synth = sc.SynthLib

go(function ()
      a = Synth:new()
      wait(1)
      for i=1, 20 do
	 a:set("freq", math.random(400, 800))
	 wait(i/100)
      end
      a:set("freq", 2000)
      a:set("gate", 0)
      end)

-- Panic:
-- sc:freeAll()


