local Array = require("Array")

function copyrange(o, x, y, w, h)
   local a = Array{components=4,type=Array.UInt8,dim={w,h},align=4}
   for i=0, w do
      for j=0, h do
	 a:setcell(i,j,o:getcell(i+x, j+y))
      end
   end
   return a
end

function colornoise (dim, alpha)
   local alpha = alpha or 1
   local dim = dim or {512, 512}
   local a = Array{components=4, type=Array.Float32, dim=dim, align=4}
   for i=0, a.dim[1] do
      for j=0, a.dim[2] do
	 a:setcell(
	    i,
	    j,
	    {
	       math.random(),
	       math.random(),
	       math.random(),
	       alpha
	    }
		  )
      end
   end
   return a
end

function noise (dim, alpha)
   local alpha = alpha or 1
   local dim = dim or {512, 512}
   local a = Array{components=4, type=Array.Float32, dim=dim, align=4}
   for i=0, a.dim[1] do
      for j=0, a.dim[2] do
	 local val = math.random()
	 a:setcell( i, j, {val, val, val, alpha} )
      end
   end
   return a
end


function colornoise255 (dim, alpha)
   local alpha = alpha or 255
   local dim = dim or {512, 512}
   local a = Array{components=4, type=Array.UInt8, dim=dim, align=4}
   for i=0, a.dim[1] do
      for j=0, a.dim[2] do
	 a:setcell(
	    i,
	    j,
	    {
	       math.random(256)-1,
	       math.random(256)-1,
	       math.random(256)-1,
	       alpha
	    }
		  )
      end
   end
   return a
end

function noise255 (dim, alpha)
   local alpha = alpha or 255
   local dim = dim or {512, 512}
   local a = Array{components=4, type=Array.UInt8, dim=dim, align=4}
   for i=0, a.dim[1] do
      for j=0, a.dim[2] do
	 local val = math.random(256)-1
	 a:setcell(i, j, {val, val, val, alpha})
      end
   end
   return a
end

