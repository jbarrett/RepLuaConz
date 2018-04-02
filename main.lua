require "repliconz.game"

local game = Game:new()

function love.load()
end

function love.update(dt)
    Game:update(dt)
end

function love.draw()
    Game:draw()
end

