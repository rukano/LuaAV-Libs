local gl = require("opengl")
local GL = gl

local color = require("color")
local RGBtoHSL = color.RGBtoHSL
local HSLtoRGB = color.HSLtoRGB

--------------------------------------------------------------------------------
-- EZ GL
function initgl (mode)
   local mode = mode or "alpha"
   print(mode)
   -- TODO: init GL with blend func!
end


function clearscreen ()
   -- TODO: clear screen
end

function setcolor (r, g, b, a)
   gl.Color(r, g, b, a)
end

function setcolor255(r,g,b,a)
   setColor(r/255,g/255,b/255,a/255)
end

function setcolorhsl(h,s,l,a)
   setColor(unpack(HSLtoRGB({h,s,l,a})))
end

function setlinewidth(width)
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