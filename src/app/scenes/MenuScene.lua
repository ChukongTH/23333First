
local AdBar = import("..views.AdBar")
local BubbleButton = import("..views.BubbleButton")

local MenuScene = class("MenuScene", function()
    return display.newScene("MenuScene")
end)

function MenuScene:ctor()
    self.bg = display.newSprite("bj1.png", display.cx, display.cy)
    self:addChild(self.bg)

        local title = display.newSprite("#Title.png", display.cx, display.top - 100)
    self:addChild(title)


    self.moreGamesButton = BubbleButton.new({
            image = "b1.jpg",
            sound = GAME_SFX.tapButton,
            prepare = function()
                audio.playSound(GAME_SFX.tapButton)
                self.moreGamesButton:setButtonEnabled(false)
            end,
            listener = function()
                app:enterMoreGamesScene()
            end,
        })
        :align(display.CENTER, display.left + 150, display.bottom + 300)
        :addTo(self)

    self.startButton = BubbleButton.new({
            image = "b2.jpg",
            sound = GAME_SFX.tapButton,
            prepare = function()
                audio.playSound(GAME_SFX.tapButton)
                self.startButton:setButtonEnabled(false)
            end,
            listener = function()
                app:enterChooseLevelScene()
            end,
        })
        :align(display.CENTER, display.right - 150, display.bottom + 300)
        :addTo(self)

end

function MenuScene:onEnter()
end

return MenuScene
