--------------------------------------------------------------------------------
-- MATH

pi = math.pi
tau = pi * 2
PI = pi
TAU = tau

sin = math.sin
cos = math.cos
tan = math.tan
tanh = math.tanh

ceil = math.ceil
floor = math.floor

rand = math.random

--------------------------------------------------------------------------------
-- NUMBERS
function even (num)
   if math.floor(num % 2) == 0 then return true else return false end
end

function odd (num)
   if math.floor(num % 2) == 1 then return true else return false end
end

function rand2 ()
   return math.random() * 2 - 1
end

--[[
function linlin (num, inmin, inmax, outmin, outmax)
   local inmin = inmin or 0
   local inmax = inmin or 1
   local outmin = outmin or 1
   local outmax = outmax or 100
   -- TODO !!!!
   return num
end

-- TODO: linlin, linexp, explin, expexp
--]]

--------------------------------------------------------------------------------
-- NUMBERS RANGE
function clip (num, min, max)
   if (not min) and (not max) then
      max = 1
      min = 0
   elseif not max then
      max = min
      min = 0
   end

   return math.max(math.min(num, max), min)
end

function fold (num, min, max)
   if (not min) and (not max) then
      max = 1
      min = 0
   elseif not max then
      max = min
      min = 0
   end
   return ((num - min) % (max - min)) + min
end

function wrap (num, min, max)
   if (not min) and (not max) then
      max = 1
      min = 0
   elseif not max then
      max = min
      min = 0
   end

   local range = max-min
   local norm = num-min

   if even(num / range) then
      return (num % (range*2)) + min
   else
      return (range - (num % range)) + min
   end
end
--------------------------------------------------------------------------------
-- TABLES
function choose (t)
   return t[ rand(#t) ]
end

function wrapindex (t, i)
   return t[ ((i-1) % #t) +1 ]
end

function clipindex (t, i)
   if i > #t then i = #t elseif i < 1 then i = 1 end
   return t[i]
end

function foldindex (t, i)
   --  TODO
end