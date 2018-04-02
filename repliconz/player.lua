require "repliconz.thing"
require "repliconz.roles.canshoot"

Player = Thing:subclass('Player')
Player:include(CanShoot)

function Player:move(dt)
    local dx, dy = 0, 0
    self.total_dt = dt + ( self.total_dt or 0 )

    if love.keyboard.isDown('d') then
        dx = 1
    elseif love.keyboard.isDown('a') then
        dx = -1
    end

    if love.keyboard.isDown('s') then
        dy = 1
    elseif love.keyboard.isDown('w') then
        dy = -1
    end

    if love.mouse.isDown(1) then
        if self.total_dt >= self.cooldown then
            local x, y = love.mouse.getPosition()
            self:shoot({ x = x, y = y })
            self.total_dt = 0
        end
    end

    if love.keyboard.isDown('escape') then
        love.event.quit()
    end

    Thing.move(self, dt, dx, dy)
end

