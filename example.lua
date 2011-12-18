local gl = require("opengl")
local GL = gl

require("lib.Math")
require("lib.Graphics")
require("lib.Patterns")
win = require("lib.Window")

win.autoclear = true

seq = Pseq{1,2,3,4}
for i=1, 20 do print(seq:next()) end

function win:draw ()
   setColorHSL(wrap(now()/3), 0.5, 0.5, 1)
   rectangle("fill", -1 + sin(now()*TAU)*0.1, -1 + cos(now()*TAU)*0.1, 1.9, 1.9)
   setColorHSL(0.3, 0.5, 0.5, 1)
   rectangle("line", -1, -1, 2, 2)
end


