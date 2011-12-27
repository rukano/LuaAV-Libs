local gl = require("opengl")
local GL = gl

local color = require("color")
local RGBtoHSL = color.RGBtoHSL
local HSLtoRGB = color.HSLtoRGB

--------------------------------------------------------------------------------
-- Common GL Functions
function clearColor ()
   gl.Clear(GL.COLOR_BUFFER_BIT)
end

function clearAll ()
   gl.Clear(GL.COLOR_BUFFER_BIT)
   gl.Clear(GL.DEPTH_BUFFER_BIT)
   gl.Clear(GL.ACCUM_BUFFER_BIT)   
end

function setBlend (mode)
   local mode = mode or "alpha"
   if mode == "add" then
      gl.BlendFunc(GL.ONE, GL.ONE);
   elseif mode == "alpha" then
      gl.BlendFunc(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA)
   elseif mode == "filter" then
      gl.BlendFunc(GL.DST_COLOR, GL.ZERO)      
   elseif mode == "normal" then -- WTF?
      gl.BlendFunc(GL.SRC_ALPHA, GL.ONE)
   end
end

function initGL (mode)
   if win then  gl.ClearColor(win.clearcolor) else gl.ClearColor(0, 0, 0, 1) end
   gl.Enable(GL.BLEND)
   gl.Enable(GL.POINT_SMOOTH)
   gl.Disable(GL.DEPTH_TEST)
   gl.DepthFunc(GL.NEVER)
   setBlend(mode)
end

--------------------------------------------------------------------------------
-- DRAW STUFF

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

--------------------------------------------------------------------------------
-- Textures, Images, Framebuffer, Screenshot...

function crop_quad(tex, t, q)
   local t = t or {0, 0, w, h}
   local q = q or {-1, 1, 2, 2}

   gl.TexCoord(t[1], t[2])            gl.Vertex(q[1], q[2])
   gl.TexCoord(t[1]+t[3], t[2])       gl.Vertex(q[1] + q[3], q[2])
   gl.TexCoord(t[1]+t[3], t[2]+t[4])  gl.Vertex(q[1] + q[3], q[2] + q[4])
   gl.TexCoord(t[1], t[2]+t[4])       gl.Vertex(q[1], q[2] + q[4])
end

function crop_pixquad(tex, t, q)
   local w, h = unpack(tex.dim) -- for pixel mode
   local t = t or {0, 0, w, h}
   local q = q or {-1, 1, 2, 2}
   -- convert pixels to normalized
   t[1] = t[1] / w
   t[2] = t[2] / h
   t[3] = t[3] / w
   t[4] = t[4] / h

   crop_quad(tex, t, q)
end

function copy_framebuffer(tex)
   gl.ReadBuffer(GL.FRONT)
   tex:bind()
   gl.CopyTexImage(tex.target, 0, tex.format, 0, 0, tex.dim[1], tex.dim[2], 0)
   tex:unbind()
   gl.ReadBuffer(GL.BACK)
end

function screenshot(filename)
   local dest = Texture{ ctx = ctx, dim = win.dim}
   local img = Image()
   local path = script.path .. "/" .. filename

   print("making screenshot...")
   copy_framebuffer(dest)
   dest:toarray()
   img:fromarray(dest:array())
   img:save(path)
   print("screenshot saved in :", path)
   return img
end

