local class = require "middleclass"
Thing = class('Thing')

function Thing:initialize(opts)
    self.x = opts.x
    self.y = opts.y
    self.w = opts.w or 5
    self.h = opts.h or 5
    self.speed = opts.speed or 300
    self.name = opts.name
    self.lives = opts.lives or 1
    self:add_to_world(opts.world)
end

function Thing:add_to_world(world)
    self.world = world
    world:add( self, self.x, self.y, self.w, self.h )
end

function Thing:filter(other)
    return 'cross'
end

function Thing:alive()
    if self.lives < 1 then return false end
    return true
end

function Thing:move(dt, dx, dy)
    if not self:alive() then return end

    if not self.no_constrain then
        if dx > 0 then dx = 1 end
        if dx < 0 then dx = -1 end
        if dy > 0 then dy = 1 end
        if dy < 0 then dy = -1 end
    end

    local vx = self.speed * dx * dt
    local vy = self.speed * dy * dt

    if not self.no_constrain then
        if ( vx ~= 0 and vy ~= 0 ) then
            vx = vx * 0.707
            vy = vy * 0.707
        end
    end

    self.x, self.y, cols, cols_len = self.world:move(
        self, self.x + vx, self.y + vy, self.filter
    )

    if self.can_shoot then
        self:move_bullets(dt)
    end
end

function Thing:draw(r,g,b)
    if not self:alive() then return end

    love.graphics.setColor(r,g,b,70)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    love.graphics.setColor(r,g,b)
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)

    if self.can_shoot then
        self:draw_bullets(dt)
    end
end

