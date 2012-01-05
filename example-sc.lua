-- highly experimental....!!! 
-- not everything works....!!!

sc = require("lib.SuperCollider")
Synth = sc.SynthLib

--[[
boot the server manually from the terminal:
./scsynth -u 57117
sc:boot() not working yet...
--]]

a = Synth:new()
go(1, function ()
      a:set("freq", 1234.0)
      wait(0.5)
      a:set("freq", math.random(400, 800))
      wait(0.5)
      a:set("freq", math.random(400, 800))
      wait(0.5)
      a:set("freq", math.random(400, 800))
      wait(1)
      a:set("gate", 0)
      wait(1)
      end)

-- Panic?
-- sc:freeAll()