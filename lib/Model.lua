local Model = {}

local function strsplit (str, char)
   local t = {}
   for v in string.gmatch(str, "[^" .. char .. "]+") do
      table.insert(t, v)
   end
   return t
end

function Model.readfile (path, kind)
   local ext = strsplit(path, ".")
   ext = ext[#ext]
   local kind = kind or ext
   if kind == "obj" then
      -- OBJ
      local vertices = {}
      local path = LuaAV.findfile(path)
      for line in io.lines(path) do
	 if line:find("v ", 1, 2) then
	    local t = strsplit(line, " ")
	    local vertex = {}
	    for i=1, #t-1 do
	       vertex[i] = tonumber(t[i+1])
	    end
	    table.insert(vertices, vertex)
	 end
      end
      return vertices

      -- RAW
   elseif kind == "raw" then
      local triangles = {}
      local path = LuaAV.findfile(path)
      for line in io.lines(path) do
	 local l = strsplit(line, " ")
	 local t = {}
	 
	 for i=1, 9, 3 do
	    local v = {}
	    table.insert(v, tonumber(l[i]))
	    table.insert(v, tonumber(l[i+1]))
	    table.insert(v, tonumber(l[i+2]))
	    table.insert(t, v)
	 end
	 table.insert(triangles, t)
      end
      return triangles
   else
      -- OTHERS
      print(kind .. " files not yet supported")
   end
end

return Model