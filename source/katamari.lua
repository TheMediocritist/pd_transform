local pd <const> = playdate
local gfx <const> = pd.graphics
local geom <const> = pd.geometry

--local ground = 220

class('Katamari').extends(Item)

function Katamari:init(x, y, width, height)
    Katamari.super.init(self, x, y - width/2, width, height)
    self.velx = 0
    self.vely = 0
    self.geoms[1] = geom.arc.new(x, y, y - width/2, 0, 360)
    self.geoms[2] = geom.lineSegment.new(x, y - width/2, x, y)
end

function Katamari:updateGeometry()
    self.geoms[1] = geom.arc.new(self.x, self.y, self.width/2, 0, 360)
    self.geoms[2] = self.transform:transformedLineSegment(self.geoms[2])
    self.transform:reset()
end

function Katamari:draw()
    gfx.drawArc(self.geoms[1])
    gfx.drawLine(self.geoms[2].x1, self.geoms[2].y1, self.geoms[2].x2, self.geoms[2].y2)
    
    -- debug
    gfx.drawText('Position: ' .. math.floor(self.x * 10)/10 .. ', ' .. math.floor(self.y * 10)/10, 10, 10)
    gfx.drawText('Velocity: ' .. math.floor(self.velx * 10)/10 .. ', ' .. math.floor(self.vely * 10)/10, 10, 30)
    gfx.drawText('Angle:    ' .. math.floor(self.angle * 10)/10, 10, 50)
    gfx.drawText('Onground: ' .. tostring(self.onground), 10, 70)
end

function Katamari:update()
    Katamari.super.update(self) -- To do: work out how to retain useful sprite functions (collisions, etc)
    
    -- Note: always rotateBy BEFORE moveBy !!
    
    self.velx += input_vector.dx
    self.vely -= input_vector.dy
    
    -- update rotation based on horizontal velocity (if required)
    self:rotateBy(self.velx/(2 * math.pi * self.width/2) * 360)
    --self:rotateBy(6)
    self:addGravity()
    
    self:updateGeometry()
    self:moveBy(self.velx, self.vely)
    self:draw()
    
end






