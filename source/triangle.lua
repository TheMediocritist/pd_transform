local pd <const> = playdate
local gfx <const> = pd.graphics
local geom <const> = pd.geometry

local ground = 220

class('Triangle').extends(Item)

function Triangle:init(x, y, width, height)
	Triangle.super.init(self, x, y, width, height)
	self.velx = math.random(0, 40)/10
	self.geoms[1] = geom.polygon.new(
		x - width/2, y - height/2,
		x + width/2, y - height/2,
		x + width/2, y + height/2,
		x - width/2, y - height/2
	)
end