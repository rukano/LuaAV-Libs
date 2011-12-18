local gl = require("opengl")
local GL = gl
local sketch = require("opengl.sketch")
local Draw = require("opengl.Draw")
local Window = Window

local color = require("color")
local RGBtoHSL = color.RGBtoHSL
local HSLtoRGB = color.HSLtoRGB

local unpack = unpack
local print = print
local pairs, ipairs = pairs, ipairs
local require = require

local math = math
local sin = math.sin
local cos = math.cos
local tan = math.tan
local pi = math.pi

local now = now
local wait = wait
local event = event
local go = go

local _G = _G


module("ezlib")

--------------------------------------------------------------------------------
-- EZ MATH -- should be in modue? or global?

pi = math.pi
sin = math.sin
cos = math.cos
tan = math.tan
-- max = math.max
-- min = math.min
-- ceil = math.ceil
-- floor = math.floor
rand = math.rand

--------------------------------------------------------------------------------
-- EZ WRAPPERS

function even (num)
   if math.floor(num % 2) == 0 then
      return true
   else
      return false
   end
end

function odd (num)
   if math.floor(num % 2) == 1 then
      return true
   else
      return false
   end
end


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
