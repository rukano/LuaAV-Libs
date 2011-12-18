-- initialize a window with custom dimensions on the global var win
-- put initgl() on resize
-- pass keys and mouse

local ctx = "rukano lib"
local win = Window(ctx, 0, 0, 512, 512)
win.origin = {0, 0}
win.autoclear = false

function win:key (e, k)
   if e == "down" then
      if k == 27 then -- ESC -> fullscreen
	 self.fullscreen = not self.fullscreen
      elseif k == 32 then -- SPACE -> clear()
	 print("should call crearscreen()")
	 -- TODO: call clear!!!
      end
   end
end

function win:resize ()
   -- TODO: init GL again
end

return win