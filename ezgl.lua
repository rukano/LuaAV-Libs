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


module("ezgl")
--------------------------------------------------------------------------------
-- SETUP

-- gl.Clear (GL.COLOR_BUFFER_BIT)
-- gl.Enable(GL.DEPTH_TEST)
-- gl.ClearDepth(1.0)						
-- gl.DepthFunc(GL.LEQUAL)						
-- gl.BlendFunc(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA)		
-- gl.Enable(GL.BLEND)						
-- gl.AlphaFunc(GL.GREATER,0.1)
-- gl.Enable(GL.ALPHA_TEST)						
-- gl.Enable(GL.TEXTURE_2D)						
-- gl.Enable(GL.CULL_FACE)

--------------------------------------------------------------------------------
-- EZ GL
function initGL (mode)
   local mode = mode or "alpha"
   print(mode)
end

function setColor (r, g, b, a)
   gl.Color(r, g, b, a)
end

function setColor255(r,g,b,a)
   setColor(r/255,g/255,b/255,a/255)
end

function setColorHSL(h,s,l,a)
   setColor(unpack(HSLtoRGB({h,s,l,a})))
end

function setLineWidth(width)
   gl.LineWidth(width)
end

function circle(mode, ox,oy,r,seg) -- mode, x value, y value, radius, segements
   if mode == "fill" then
      gl.Begin(GL.POLYGON)
   else
      gl.Begin(GL.LINE_LOOP)
   end
   for i=1,seg do
      local theta = 2.0 * 3.1415926 * i / seg
      local x = r * cos(theta)
      local y = r * sin(theta)
      gl.Vertex(ox+x, oy+y)
   end
   gl.End()	
end

function rectangle(mode, ox, oy, w, h)
   if mode == "fill" then
      gl.Begin(GL.POLYGON)
   else
      gl.Begin(GL.LINE_LOOP)
   end
   gl.Vertex(ox,oy)
   gl.Vertex(ox+w,oy)
   gl.Vertex(ox+w,oy+h)
   gl.Vertex(ox,oy+h)
   gl.End()
end

function line(a,b,c,d)
   polyline(a,b,c,d)
end

function polyline(a,b,c,d,...)
   local arg = {...}
   gl.Begin(GL.LINE_STRIP)
   gl.Vertex(a,b)
   gl.Vertex(c,d)
   for i,v in ipairs(arg) do
      if i%2 ~= 0 then
	 gl.Vertex(v, arg[i+1])
      end
   end
   gl.End()
end