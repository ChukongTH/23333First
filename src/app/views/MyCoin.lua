--
-- Author: shuaigeT
-- Date: 2016-07-01 17:49:33
--

local Levels = import("..data.MyLevels")

local starCell = 
{
	"x1.png","x2.png","x3.png","x4.png","x5.png",
}

local Coin = class("Coin", function(nodeType)
    local index = math.random(#starCell) --#starCell表示starCell的长度
    if nodeType == Levels.NODE_IS_BLACK then
        index = 8
    end

    local sprite = display.newSprite(starCell[index])
    sprite.isWhite = index == 1
    sprite.nodeType = index
    return sprite
end)

-- function Coin:flip(onComplete)
--     local frames = display.newFrames("x%d.png", 1, 8, not self.isWhite)
--     local animation = display.newAnimation(frames, 0.3 / 8)
--     self:playAnimationOnce(animation, false, onComplete)

--     self:runAction(transition.sequence({
--         cc.ScaleTo:create(0.15, 1.5),
--         cc.ScaleTo:create(0.1, 1.0),
--         cc.CallFunc:create(function()
--             local actions = {}
--             local scale = 1.1
--             local time = 0.04
--             for i = 1, 5 do
--                 actions[#actions + 1] = cc.ScaleTo:create(time, scale, 1.0)
--                 actions[#actions + 1] = cc.ScaleTo:create(time, 1.0, scale)
--                 scale = scale * 0.95
--                 time = time * 0.8
--             end
--             actions[#actions + 1] = cc.ScaleTo:create(0, 1.0, 1.0)
--             self:runAction(transition.sequence(actions))
--         end)
--     }))

--     self.isWhite = not self.isWhite
-- end

return Coin
