--Simplified images

repeat wait() until _G.Import
_G.Import("Import")

Import("Class")

do SpriteSheet = Class("SpriteSheet")
	
	function SpriteSheet.new(name, urlId, spriteSizeX, spriteSizeY)
		local spriteSheet = {}
		setmetatable(spriteSheet, SpriteSheet)
	
		spriteSheet.name = name
		spriteSheet.url = "http://www.roblox.com/asset/?id=" .. urlId
		spriteSheet.spriteSizeX = spriteSizeX
		spriteSheet.spriteSizeY = spriteSizeY
		spriteSheet.vector2Size = Vector2.new(spriteSizeX, spriteSizeY)
	
		return spriteSheet
	end
	
	SpriteSheet.BasicSpriteSheet = SpriteSheet.new("basic", 150041331, 32, 32)		
	
end