--Used to create the maps, extend this to make new ones

repeat wait() until _G.Import
_G.Import("Import")

Import("Class")

do Level = Class("Level")
	Level.allLevels = {}
	
	function Level.new(width, height, tiles, name)
		local level = {}
		setmetatable(level, Level)
		
		level.width = width
		level.height = height
		level.tiles = tiles or {}
		level.entities = {}
		level.name = name
		
		Level.allLevels[name] = level
		
		if not tiles then
			for x = 0, level.width do
				level.tiles[x] = {}
			end	
		end	
		
		return level
	end
	
	function Level:tick()
		for _, entity in pairs(self.entities) do
			entity:tick()
		end
		
	end	
	
	function Level:render(deltaTime)
		for _, entity in pairs(self.entities) do
			entity:render(deltaTime)
		end
	end
	
	function Level:getEntityFromId(id)
		return self.entities[id]
	end
	
	Import("Tile")
	
	function Level:rayCast(pos, dirVec)
		for i = 1, 30 do
			local id = self.tiles[math.floor(pos.X + dirVec.X * i)] and self.tiles[math.floor(pos.X + dirVec.X * i)][math.floor(pos.Y + dirVec.Y * i)]
			if id then
				local tile = Tile.Tiles[id]
				if not tile.isWalkable then 
					return Vector2.new(pos.X + math.floor(dirVec.X * i), pos.Y + math.floor(dirVec.Y * i)) + Vector2.new(0.5,0.5) - dirVec
				end
			end
		end
		return pos + dirVec * 30
	end
	
	function Level:testRandomGenerate()
		
		repeat wait() until Tile.GRASS
		
		for x = 1, self.width do
			if x%100 == 0 then wait() print(x) end
			for y = 1, self.height do
				local rand = math.random(1, 30)
				if rand == 10  and y > 2 then
					self.tiles[x][y] = Tile.FLOWER1.id
				elseif rand == 20 and y > 2 then
					self.tiles[x][y] = Tile.FLOWER2.id
				elseif rand == 28 and y > 2 then
					self.tiles[x][y] = Tile.GRASS.id
				else
					self.tiles[x][y] = Tile.GRASS.id
				end
			end
		end	
		
		self.ready = true
		return self
	end		
		
end

