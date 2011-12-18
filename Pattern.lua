-- helper functions
function wrap (t, i)
   return t[ ((i-1) % #t) + 1]
end

function inheritsFrom ( base_class )
   local new_class = {}
   new_class.__index = new_class
   new_class.__call = function (self, ...) return self:create(...) end

   function new_class:new ()
      local new_inst = {}
      setmetatable(new_inst, new_class)
      return new_inst
   end

   if base_class then
      setmetatable( new_class, base_class )
   end

   return new_class
end

-- Pattern
Pattern = inheritsFrom( )

function Pattern:create (...)
   local instance = self:new()
   instance:init(...)
   return instance
end

function Pattern:init (x)
   self.list = x
end

function Pattern:func ()
   return self.list
end

function Pattern:next ()
   return self:func()
end

-- Pseq
Pseq = inheritsFrom( Pattern )
function Pseq:init(list, length)
   self.list = list or {1,2,3,4}
   self.length = length or 'inf'
   self.counter = 0
   return self
end

function Pseq:func ()
   self.counter = self.counter + 1
   if self.length ~= 'inf' and self.counter > self.length then
      return nil
   end
   return wrap(self.list, self.counter)
end

-- Prand
Prand = inheritsFrom( Pattern )
function Prand:init(list, length)
   self.list = list or {1,2,3,4}
   self.length = length or 'inf'
   self.counter = 0
   return self
end

function Prand:func ()
   self.counter = self.counter + 1
   if self.length ~= 'inf' and self.counter > self.length then
      return nil
   end
   return self.list[math.random(#self.list)]
end

-- Pwhite
Pwhite = inheritsFrom( Pattern )
function Pwhite:init(min, max, length)
   self.min = min or 0
   self.max = max or 1
   self.length = length or 'inf'
   self.counter = 0
   return self
end

function Pwhite:func ()
   local min, max = self.min, self.max
   self.counter = self.counter + 1
   if self.length ~= 'inf' and self.counter > self.length then
      return nil
   end
   return math.random() * (max-min) + min
end

-- Piwhite
Piwhite = inheritsFrom( Pattern )
function Piwhite:init(min, max, length)
   self.min = min or 0
   self.max = max or 10
   self.length = length or 'inf'
   self.counter = 0
   return self
end

function Piwhite:func ()
   local min, max = self.min, self.max
   self.counter = self.counter + 1
   if self.length ~= 'inf' and self.counter > self.length then
      return nil
   end
   return math.random((max-min)+1) - 1 + min
end


--[[ TODO:
Pxrand
Pbrown
Pseries
Place
Pclump
Pstutter
Pn
   --]]


-- test
b = Pseq({1,2,3,4})
c = Prand({10, 20})
d = Pwhite(0.5, 0.6)
e = Piwhite(0, 10)

for i=1, 10 do
   print("******************************* Iteration: ", i)
   print("Pseq:", b:next())
   print("Prand:", c:next())
   print("Pwhite:", d:next())
   print("Piwhite:", e:next())
end

