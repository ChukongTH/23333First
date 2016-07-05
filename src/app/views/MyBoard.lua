
local Levels = import("..data.MyLevels")
local Coin   = import("..views.MyCoin")

local Board = class("Board", function()
    return display.newNode()
end)

local NODE_PADDING   = 100 
local NODE_ZORDER    = 0

local COIN_ZORDER    = 1000

function Board:ctor(levelData)
    cc.GameObject.extend(self):addComponent("components.behavior.EventProtocol"):exportMethods()

    -- self.batch = display.newBatchNode(GAME_TEXTURE_IMAGE_FILENAME)
    self.batch = display.newNode()
    self.batch:setPosition(display.cx, display.cy)
    self:addChild(self.batch)

    self.grid = clone(levelData.grid)
    self.rows = levelData.rows
    self.cols = levelData.cols
    self.coins = {}
    self.flipAnimationCount = 0

    local offsetX = -math.floor(NODE_PADDING * self.cols / 2) - NODE_PADDING / 2
    local offsetY = -math.floor(NODE_PADDING * self.rows / 2) - NODE_PADDING / 2
    -- GAME_CELL_EIGHT_ADD_SCALE = 8.0 / self.cols
    -- NODE_PADDING = 100 * GAME_CELL_STAND_SCALE * GAME_CELL_EIGHT_ADD_SCALE

    if self.cols >= 8 then -- create board, place all coins
     self.batch:setScale(640/self.cols/NODE_PADDING)
	    for row = 1, self.rows do
	        local y = row * NODE_PADDING + offsetY 
	        for col = 1, self.cols do
	            local x = col * NODE_PADDING + offsetX
	            local nodeSprite = display.newSprite("#BoardNode.png", x, y)
	           -- nodeSprite.setScale(GAME_CELL_STAND_SCALE * GAME_CELL_EIGHT_ADD_SCALE)
	            self.batch:addChild(nodeSprite, NODE_ZORDER)

	            local node = self.grid[row][col]
	            if node ~= Levels.NODE_IS_EMPTY then
	                local coin = Coin.new(node)
	                coin:setPosition(x, y)
	                -- coin.setScale(GAME_CELL_STAND_SCALE * GAME_CELL_EIGHT_ADD_SCALE)
	                coin.row = row
	                coin.col = col
	                self.grid[row][col] = coin
	                self.coins[#self.coins + 1] = coin
	                self.batch:addChild(coin, COIN_ZORDER)
	            end
	        end
	    end
	    -- GAME_CELL_EIGHT_ADD_SCALE = 1.0
	    --    NODE_PADDING = 100 * GAME_CELL_STAND_SCALE
    else
    	-- GAME_CELL_EIGHT_ADD_SCALE = 1.0
    	-- local offsetX = -math.floor(NODE_PADDING * self.cols / 2) - NODE_PADDING / 2
     --    local offsetY = -math.floor(NODE_PADDING * self.rows / 2) - NODE_PADDING / 2
     --    NODE_PADDING = 100 * GAME_CELL_STAND_SCALE
    	for row = 1, self.rows do
	        local y = row * NODE_PADDING + offsetY
	        for col = 1, self.cols do
	            local x = col * NODE_PADDING + offsetX
	            local nodeSprite = display.newSprite("#BoardNode.png", x, y)
	            --nodeSprite:setScale(GAME_CELL_STAND_SCALE)
	            self.batch:addChild(nodeSprite, NODE_ZORDER)

	            local node = self.grid[row][col]
	            if node ~= Levels.NODE_IS_EMPTY then
	                local coin = Coin.new(node)
	                coin:setPosition(x, y)
	                coin.row = row
	                coin.col = col
	                self.grid[row][col] = coin
	                self.coins[#self.coins + 1] = coin
	                self.batch:addChild(coin, COIN_ZORDER)
	            end
	        end
	    end
	end    

    self:setNodeEventEnabled(true)
    self:setTouchEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        return self:onTouch(event.name, event.x, event.y)
    end)

    self:checkAll2()

end

function Board:checkLevelCompleted()
    local count = 0
    for _, coin in ipairs(self.coins) do
        if coin.isWhite then count = count + 1 end
    end
    if count == #self.coins then
        -- completed
        self:setTouchEnabled(false)
        self:dispatchEvent({name = "LEVEL_COMPLETED"})
    end
end

function Board:getCoin(row, col)
    if self.grid[row] then
        return self.grid[row][col]
    end
end

function Board:flipCoin(coin, includeNeighbour)
    if not coin or coin == Levels.NODE_IS_EMPTY then return end

    self.flipAnimationCount = self.flipAnimationCount + 1
    coin:flip(function()
        self.flipAnimationCount = self.flipAnimationCount - 1
        self.batch:reorderChild(coin, COIN_ZORDER)
        if self.flipAnimationCount == 0 then
            self:checkLevelCompleted()
        end
    end)
    if includeNeighbour then
        audio.playSound(GAME_SFX.flipCoin)
        self.batch:reorderChild(coin, COIN_ZORDER + 1)
        self:performWithDelay(function()
            self:flipCoin(self:getCoin(coin.row - 1, coin.col))
            self:flipCoin(self:getCoin(coin.row + 1, coin.col))
            self:flipCoin(self:getCoin(coin.row, coin.col - 1))
            self:flipCoin(self:getCoin(coin.row, coin.col + 1))
        end, 0.25)
    end
end

function Board:onTouch(event, x, y)
    if event ~= "began" or self.flipAnimationCount > 0 then return end

    local padding = NODE_PADDING / 2
    for _, coin in ipairs(self.coins) do
        local cx, cy = coin:getPosition()
        cx = cx + display.cx
        cy = cy + display.cy
        if x >= cx - padding
            and x <= cx + padding
            and y >= cy - padding
            and y <= cy + padding then
            --self:flipCoin(coin, true)
            break
        end
    end
end

	-- function Board:checkAll( ... )
	-- 	for i = 1,self.rows do
	-- 		for j = 1self.cols do
	-- 			print(self.grid[i][j].nodeType)
	-- 			if i + 1 <= self.rows  then
	-- 			    if self.grid[i][j].nodeType == self.grid[i + 1][j]  then
	-- 				    if i + 2 <= self.rows  then
	-- 					    if self.grid[i][j].nodeType == self.grid[i + 2][j]then
	-- 					        print("hava same")
	-- 				        end
	-- 				    end
	-- 		         end
	-- 		    end

 --                if j + 1 <= self.cols  then
	-- 		        if self.grid[i][j].nodeType == self.grid[i][j+ 1]  then
	-- 				    if j + 2 <= self.cols  then
	-- 					    if self.grid[i][j].nodeType == self.grid[i][j+ 2]then
	-- 					        print("hava same")
	-- 				        end
	-- 				    end
	-- 		        end
	-- 		    end
	-- 		end 
	-- 	end
	-- end

	function Board:checkAll2( ... )
		local i = 1
	    local waitRemove = {}
		while i <= self.rows do
              local j = 1
              while j <= self.cols do
              	   local standType = self.grid[i][j].nodeType
              	   local sum = 1
              	   j = j + 1
              	   waitRemove = {}
              	   while self.grid[i][j] and  standType == self.grid[i][j].nodeType do
              	   	    sum = sum + 1
              	   	    j = j + 1
              	   end
              	   if sum >= 3 then
              	   	    for i,v in pairs(waitRemove) do
                             v.isNeedClean = true
              	   	    end
              	    end
               end
            i = i + 1
        end

  --       local a = 1
		-- while a <= self.cols do
  --             local b = 1
  --             while b <= self.cols do
  --             	   local standType = self.grid[a][b].nodeType
  --             	   local sum = 1
  --             	   a = a + 1
  --             	   while self.grid[a][b] and  standType == self.grid[a][b].nodeType do
  --             	   	    sum = sum + 1
  --             	   	    a = a + 1
  --             	   end
  --             	   if sum >= 3 then
  --             	   	   -- print("h",a,b - 1)
  --             	   	   for i,v in pairs(waitRemove) do
  --                            v.isNeedClean = true
  --             	   end
  --             end
  --           b = b + 1
  --       end
	end

-- function Borad:chenkRow( x,y )
-- 	local sameCell = {}

-- 		if self.grid[x][y].nodeType ==  self.grid[x + 1][y].nodeType then
-- 			table.insert(sameCell,self.grid[x + 1][y])
-- 				if x ~= self.cols  then
-- 					self:chenkRow(self.grid[x + 1][y].getLocation())
-- 				end
			
-- 		end

-- 		-- if self.grid[x][y].nodeType ==  self.grid[x - 1][y].nodeType then
-- 		-- 	table.insert(sameCell,self.grid[x - 1][y])
-- 		-- 		if x ~= 1 || y ~= 1 || (x ~= 1 && y ~= 1) then
-- 		-- 			self:chenkRow(self.grid[x - 1][y].getLocation())
-- 		-- 		end
-- 		-- end
-- end

-- function Borad:chenkCol( x,y )
-- 	local sameCell = {}

-- 		if self.grid[x][y].nodeType ==  self.grid[x][y + 1].nodeType then
-- 			table.insert(sameCell,self.grid[x][y + 1])
-- 				if x ~= 1 || y ~= 1 || (x ~= 1 && y ~= 1) then
-- 					self:chenkCol(self.grid[x][y + 1].getLocation())
-- 				end
-- 		end

-- 		if self.grid[x][y].nodeType ==  self.grid[x][y - 1].nodeType then
-- 			table.insert(sameCell,self.grid[x][y - 1])
-- 				if x ~= 1 || y ~= 1 || (x ~= 1 && y ~= 1) then
-- 					self:chenkCol(self.grid[x][y - 1].getLocation())
-- 				end
-- 		end
-- end


function Board:onEnter()
    self:setTouchEnabled(true)
end

function Board:changeSingedCell()
    local sum = 0
    for i,v in pairs(self.cells) do
        if v.isNeedClean then
            sum = sum +1
            print("x",v.row,"y",v.col,"type",v.nodeType)
            print("find it!!!!!!",sum )
        end
    end
end

function Board:onExit()
    self:removeAllEventListeners()
end

return Board


-- void GameScene::getSameStar(Star * star)
-- {
-- 	if (star->Y>0)//不在最左边一列，判断点击的那个左边的星星
-- 	{
-- 		auto s = stars->at(star->getTag() - 1);
-- 		if (s->getReal() == true)
-- 		{
-- 			int i = 0;
-- 			for (; i < selectStars->size(); i++)
-- 			{
-- 				auto ss = selectStars->at(i);
-- 				if (ss->getTag() == s->getTag())
-- 				{
-- 					break;
-- 				}
-- 			}
-- 			if (i == selectStars->size() && s->kind == star->kind)
-- 			{
-- 				s->setOpacity(100);
-- 				selectStars->pushBack(s);
-- 			}
-- 		}
-- 	}
-- 	if (star->Y < 9)  //不在最右边一列，判断点击的那个右边的星星
-- 	{
-- 		auto s = stars->at(star->getTag() + 1);
-- 		if (s->getReal() == true)
-- 		{
-- 			int i = 0;
-- 			for (; i < selectStars->size(); i++)
-- 			{
-- 				auto ss = selectStars->at(i);
-- 				if (ss->getTag() == s->getTag())
-- 				{
-- 					break;
-- 				}
-- 			}
-- 			if (i == selectStars->size() && s->kind == star->kind)
-- 			{
-- 				s->setOpacity(100);
-- 				selectStars->pushBack(s);
-- 			}
-- 		}
-- 	}
-- 	if (star->X>0)//不在最上边一列，判断点击的那个上边的星星
-- 	{
-- 		auto s = stars->at(star->getTag() - 10);
-- 		if (s->getReal() == true)
-- 		{
-- 			int i = 0;
-- 			for (; i < selectStars->size(); i++)
-- 			{
-- 				auto ss = selectStars->at(i);
-- 				if (ss->getTag() == s->getTag())
-- 				{
-- 					break;
-- 				}
-- 			}
-- 			if (i == selectStars->size() && s->kind == star->kind)
-- 			{
-- 				s->setOpacity(100);
-- 				selectStars->pushBack(s);
-- 			}
-- 		}
-- 	}
-- 	if (star->X < 9)//不在最下边一行，判断点击的那个下边的星星
-- 	{
-- 		auto s = stars->at(star->getTag() + 10);
-- 		if (s->getReal() == true)
-- 		{
-- 			int i = 0;
-- 			for (; i < selectStars->size(); i++)
-- 			{
-- 				auto ss = selectStars->at(i);
-- 				if (ss->getTag() == s->getTag())
-- 				{
-- 					break;
-- 				}
-- 			}
-- 			if (i == selectStars->size() && s->kind == star->kind)
-- 			{
-- 				s->setOpacity(100);
-- 				selectStars->pushBack(s);
-- 			}
-- 		}
-- 	}
-- }
