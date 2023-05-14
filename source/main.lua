import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

import "item"
import "katamari"
import "triangle"
import "circle"

local pd <const> = playdate
local gfx <const> = playdate.graphics
local geom <const> = playdate.geometry

input_vector = geom.vector2D.new(0, 0)

pd.display.setInverted(true)

local objects = {}

local function initialize()
    for i = 1, 20 do
        objects[#objects+1] = Triangle(math.random(0, 100), 10, 10, 20)
    end
    for i = 1, 20 do
        objects[#objects+1] = Item(math.random(150, 250), 0, 20, 20)
    end
    for i = 1, 20 do
        objects[#objects+1] = Circle(math.random(300, 400), 10, 10, 20)
    end
    
    katamari = Katamari(20, 60, 30, 30)
end

initialize()

function pd.update()
    gfx.clear() -- To do: use dirty rects for partial screen updates
    for o = 1, #objects do
        objects[o]:update()
    end
    katamari:update()
    gfx.fillRect(0, 220, 400, 20)
end

-- input callbacks
function playdate.leftButtonDown() input_vector.dx = -1 end
function playdate.leftButtonUp() input_vector.dx = 0 end
function playdate.rightButtonDown() input_vector.dx = 1 end
function playdate.rightButtonUp() input_vector.dx = 0 end
function playdate.upButtonDown() input_vector.dy = 1 end
function playdate.upButtonUp() input_vector.dy = 0 end
function playdate.downButtonDown() input_vector.dy = -1 end
function playdate.downButtonUp() input_vector.dy = 0 end
function playdate.AButtonDown() aDown = true end
function playdate.AButtonHeld() aHeld = true end
function playdate.AButtonUp() aDown = false aHeld = false end
function playdate.BButtonDown() bDown = true end
function playdate.BButtonHeld() bHeld = true end
function playdate.BButtonUp() bDown = false bHeld = false end