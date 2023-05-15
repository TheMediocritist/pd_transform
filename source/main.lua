import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "item"
import "katamari"
import "triangle"
import "circle"

local pd <const> = playdate
local gfx <const> = playdate.graphics
local geom <const> = playdate.geometry

input_vector = geom.vector2D.new(0, 0)
ground = 220

pd.display.setInverted(true)

local t = nil
local objects = {}

local function initialize()
    
    -- make a timer that randomly spits out 5 new shapes every second
    t = playdate.timer.new(2)
    t.repeats = true
    t.timerEndedCallback = function()
        local shape = {}
        shape[1] = Circle(math.random(300, 400), 40, 15, 15)
        shape[2] = Triangle(math.random(0, 100), 10, 10, 20)
        shape[3] = Item(math.random(150, 250), 0, 20, 20)
        
        objects[#objects+1] = shape[math.random(1, 3)]
    end  
    
    -- make the katamari
    katamari = Katamari(20, 60, 30, 30)
end

initialize()

function pd.update()
    gfx.clear() -- To do: use dirty rects for partial screen updates
        
    if pd.buttonJustPressed('b') then
        katamari:scaleBy(0.1)
    end
    for o = 1, #objects do
        objects[o]:update()
    end
    katamari:update()
    pd.timer.updateTimers()
    gfx.fillRect(0, 220, 400, 20)
    gfx.drawTextAligned('Objects: ' .. #objects, 390, 10, kTextAlignment.right)
    pd.drawFPS(196, 10)
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