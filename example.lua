local gl = require("opengl")
local GL = gl

require("lib.Math")
require("lib.Graphics")
require("lib.Patterns")
win = require("lib.Window") -- easy window test
Model = require("lib.Model")

win.autoclear = false

initGL("alpha")

local monkOBJ = Model.readfile("monkey.raw")
local monkRAW = Model.readfile("monkey.obj")

seq = Pseq{1,2,3,4}
for i=1, 20 do print(seq:next()) end

function win:draw ()
   -- draw tests
   setColorHSL(wrap(now()/3), 0.5, 0.5, 0.3)
   rectangle("fill", -1 + sin(now()*TAU)*0.1, -1 + cos(now()*TAU)*0.1, 1.9, 1.9)
   setColorHSL(0.3, 0.5, 0.5, 0.3)
   rectangle("line", -1, -1, 2, 2)

   -- MDOEL TEST
   gl.PushMatrix()
   local s = 0.25
   gl.Scale(s, s, s)
   gl.Translate(0, 0, 1)
   gl.Rotate(0 + math.sin(now())*5, 0, 3, 4)
   for i,t in ipairs(monkOBJ) do
      gl.Color(i/#monkOBJ, 0.5, 0.6, 0.3)
      gl.Begin(GL.TRIANGLES)
      for j,v in ipairs(t) do gl.Vertex(unpack(v)) end
      gl.End()
   end
   gl.PopMatrix()


end



