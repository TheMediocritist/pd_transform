local pd <const> = playdate
local gfx <const> = pd.graphics
local geom <const> = pd.geometry

local ground = 220

class('Circle').extends(Item)

function Circle:init(x, y, width, height)
	Circle.super.init(self, x, y, width, height)
	self.velx = math.random(-40, 0)/10
	self.geoms[1] = geom.arc.new(x, y, width/2, 0, 360)
end

function Circle:updateGeometry()
	self.geoms[1] = geom.arc.new(self.x, self.y, self.width/2, 0, 360)
	self.transform:reset()
end

function Circle:draw()
	gfx.drawArc(self.geoms[1])
end