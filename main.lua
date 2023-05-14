import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

import "item"

local pd <const> = playdate
local gfx <const> = playdate.graphics

pd.display.setInverted(true)

local objects = {}

local function initialize()
    for i = 1, 20 do
        objects[#objects+1] = Item(math.random(50, 350), 0, 20, 20)
    end
    --katamari = Katamari(20, 200)
end

initialize()

function pd.update()
    gfx.clear() -- To do: use dirty rects for partial screen updates
    for o = 1, #objects do
        objects[o]:update()
    end
    gfx.fillRect(0, 220, 400, 20)
end
