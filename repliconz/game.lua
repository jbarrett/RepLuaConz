local class = require "middleclass"
require "repliconz.player"
require "repliconz.baddie"

Game = class('Game')

local bump = require "bump"
local world = bump.newWorld()

math.randomseed( os.time() + ( os.clock() * 1000000 ) )

function Game:initialize()
    modes = love.window.getFullscreenModes()
    world.repliconz = {}
    world.repliconz.width = 640
    world.repliconz.height = 480
    love.window.setMode(
        world.repliconz.width,
        world.repliconz.height, {
        fullscreen = false,
        -- fullscreentype = "exclusive"
    })

    love.mouse.setCursor(
        love.mouse.newCursor('assets/images/crosshair2.png', 14, 14)
    )

    player = Player:new({
        name = "player",
        x = 10,
        y = 10,
        w = 20,
        h = 20,
        speed = 200,
        world = world,
    })
    print(world)
end

function Game:update(dt)
    player:move(dt)
end

function Game:draw()
    player:draw(255,0,0)
end


