-- SuperCollider + LuaAV
--[[
SC Module for Lua AV (easily portable to other lua stuff with osc)
I just wanted basic communication from lua to scsynth. Communicating with the language is pretty easy and you can make your own responders.

At the moment there is only basic support for starting synth with names and setting node IDs.

-- BIG TODOS:
* Make functions for all the node server commands (head, tail, etc...)
* Keep Node ID generation with internal bookkeeping (?)
* or -> Get responses from server and store given ID for a synth
* Synth:grain w/o node ID bookkeeping

-- TODOS:
* Support Groups
* Support loading Buffers
* Support loading .synthdef files

-- Would be nice:
* Get more messages from server, status replies, and print errors
* Write sclang code strings and compile them through sc lang
* ^eventually get the response of this or at least compile synthdef code directly to .synthdef and load it to the server.

-- Will probably never happen:
* compile .synthdef file from Lua and send it to server (there's some hope with a new synth def file format which your ease the creation of a binary file with the server format, which I don't understand)

--]]

local osc = require("osc")

local sc = {}
sc.app = "/Applications/SuperCollider/scsynth"
sc.addr = '127.0.0.1'
sc.port =  57117
sc.langPort = 57120
sc.luaPort = 57127
sc.osc =   osc.Send(sc.addr, sc.port)
sc.lang =  osc.Send(sc.addr, sc.langPort) -- sc.lang:send("/cmd", args)

--sc.resp = osc.Recv(sc.luaport)

-- local function get_osc() 
--    for msg in sc.resp:recv() do	
--       print("received:", msg.addr, unpack(msg))
--    end
-- end

--------------------------------------------------------------------------------
-- SERVER
function sc:boot ()
   local opt = " -u " .. self.port
   local cmd = self.app .. opt .. " &"
   local code = os.execute(cmd)
--   local process = io.popen(cmd, 'r')
--    print("file:", process:read("*all"))
   if code == 0 then
      print("Server booted on port " .. self.port)
      self.isRunning = true
   else
      print("\n\n\n*** ERROR ***")
   end
   -- TODO: get response from server
   -- TODO: store PID and so on
end


function sc:freeAll (arg)
   sc.osc:send("/g_freeAll", 0)
end

function sc:quit()
   self.osc:send("/quit")
end

function sc:kill()
   -- TODO: kill PID
end

--------------------------------------------------------------------------------
-- SYNTHS (via osc)
function sc:synth(name, id, args)
   local name = name or "default"
   local id = id or 1000
   local args = args or {}
   self.osc:send("/s_new", name, id)
end

function sc:set(id, args)
   self.osc:send("/n_set", id, unpack(args))
end

function sc:free(id)
   self.osc:send("/n_free", id)
end

-- go(0, function () sc:synth("default", 1000) end)
-- go(1, function () sc:set(1000, {"gate", 0}) end)

--------------------------------------------------------------------------------
-- Synth Objects

-- Protoype / Defualt synth
-- local proto = {}
-- proto.__index = proto
-- proto.id = 1000
-- proto.name = "default"

-- Synth Class
local mt = { __call = function (self, ...) return self:new(...) end, __index = mt }
Synth = {}
Synth.__index = Synth
Synth.defaultID = 1000

setmetatable(Synth, mt)

function Synth:init ()
   local s = {}
   setmetatable(s, self)
   s.__index = s
   return s
end

function Synth:new (name, args)
   local s = self:init()
   s.name = name or "default"
   s.args = args or {}
   s.id = math.random(5000) + 1000 -- BIG TODO! get ordered ID's or reply from server
   sc:synth(s.name, s.id)
   return s
end

function Synth:set (...)
   local args = {...}
   sc:set(self.id, args)
end

sc.SynthLib = Synth

return sc