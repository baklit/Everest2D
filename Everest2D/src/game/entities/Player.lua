--client
repeat wait() until _G.Import
_G.Import("Import")

Import("Extends")
Import("Mob")

do Player = Extends(Mob)
	_G.Player = Player
	Player.__index = Player
		
	Import("SpriteSheet")
	
	function Player.new(game, level, posX, posY, input)
		local player = Mob.new(game, level, "Player", 0.2, posX, posY)
		setmetatable(player, Player)
		
		player.input = input	
		player.scale = 2
		player.game = game
		player.frame.Name = "Player"
		player.frame.Image = SpriteSheet.BasicSpriteSheet.url
		player.frame.ImageRectSize = Vector2.new(31, 31)
		player.frame.ImageRectOffset = Vector2.new(0, (14 * 16) + 1)
		
		return player
	end
	
	function Player:tick()
		local xa = 0
		local ya = 0
		
		if self.input.keys["w"] then
			ya = ya - 1
		end
		if self.input.keys["s"] then
			ya = ya + 1
		end
		if self.input.keys["a"] then
			xa = xa - 1
		end
		if self.input.keys["d"] then
			xa = xa + 1
		end
		
		if xa ~= 0 or ya ~= 0 then
			self:move(xa, ya)
			self.isMoving = true
		else
			self.isMoving = false
		end
		
	end	
	
	function Player:render()
		if self.frame.Size ~= UDim2.new((1 * self.scale) / self.game.screen.sizeX, 0, (1 * self.scale) / self.game.screen.sizeY) then
			self.frame:TweenSize(UDim2.new((1 * self.scale) / self.game.screen.sizeX, 0, (1 * self.scale) / self.game.screen.sizeY), "Out", "Linear", 0.2, true)
		end	
		self.frame:TweenPosition(UDim2.new(self.posX / self.game.screen.sizeX, 0, self.posY / self.game.screen.sizeY, 0), "Out", "Linear", 0.1, true)	
		
		if self.movingDir == "WEST" then
			self.frame.ImageRectOffset = Vector2.new(0, (14 * 16) + 1)
			self.frame.ImageRectSize = Vector2.new(31, 31)
		end
		if self.movingDir == "EAST" then
			self.frame.ImageRectOffset = Vector2.new(31, (14 * 16) + 1)
			self.frame.ImageRectSize = Vector2.new(-31, 31)			
		end
	end
	
	function Player:hasCollided()
		
	end
	
end