local pd <const> = playdate
local gfx <const> = pd.graphics
local geom = pd.geometry

local ground = 220

class('Item').extends(gfx.sprite)

function Item:init(x, y, width, height)
    local img = gfx.image.new(width, height)
    --self:moveTo(x, y)
    self:setImage(img)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.velx = math.random(-40, 40)/10
    self.vely = math.random(-5, 10)
    self.onground = false
    self.attached = false
    self.angle = 0
    self.geoms = {}
    self.geoms[1] = geom.polygon.new(
        -- make a rectangle by default - override in child class
        x - width/2, 
        y - height/2,
        x + width/2,
        y - height/2,
        x + width/2,
        y + height/2,
        x - width/2, 
        y + height/2,
        x - width/2, 
        y - height/2
    )
    self.transform = geom.affineTransform.new()
end

function Item:update()
    --Item.super.update(self)
    
    -- Note: always rotateBy BEFORE moveBy !!
    
    -- update rotation based on horizontal velocity (if required)
    self:rotateBy(self.velx/(2 * math.pi * self.width/2) * 360)
    --self:rotateBy(6)
    self:addGravity()
    
    self:updateGeometry()
    self:moveBy(self.velx, self.vely)
    self:draw()
    
end

function Item:addGravity()
    local vel = {x = 0, y = 0}
    
    if self.y + self.height/2 >= ground then
        self.onground = true
        
        --self:moveTo(self.x, ground - self.height/2)
        
        if self.vely > 0.5 then
            vel.y -= self.vely + 0.6 * self.vely
        else 
            vel.y = -self.vely
        end
        
        
        if self.velx > 0.5 and self.velx < 0.5 then
            vel.x -= self.velx
        else
            vel.x -= 0.1 * self.velx
        end
    else
        self.onground = false
    end
    
    if not self.onground then 
        vel.y += 0.5
    end
    
    self.velx += vel.x
    self.vely += vel.y

end

function Item:draw()
    for g = 1, #self.geoms do
        gfx.drawPolygon(self.geoms[g])
    end
end

function Item:updateGeometry()
    for g = 1, #self.geoms do
        self.geoms[g] = self.transform:transformedPolygon(self.geoms[g])
    end
    self.transform:reset()
end

function Item:rotateBy(degrees)
    self.angle += degrees
    if self.angle > 360 then 
        self.angle -= 360
    elseif self.angle < 0 then 
        self.angle += 360
    end
    self.transform:rotate(degrees, self.x, self.y)
end

function Item:moveBy(x, y)
    self.x += x
    self.y += y
    self.transform:translate(x, y)
end

function Item:moveTo(x, y)
    self.transform:translate(x - self.x, y - self.y)
end

function Item:scaleBy(percentage)
    -- move to origin (0, 0)
    self.transform:translate(-self.x, -self.y)
    self.transform:scale(1 + percentage)
    -- move back to position
    self.transform:translate(self.x, self.y)
end