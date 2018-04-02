require "repliconz.thing"
Bullet = Thing:subclass('Bullet')

function Bullet:filter(other)
    if other.class == self.class then return 'cross' end
    if other.class == self.shooter.class then return 'cross' end
    return 'touch'
end

function Bullet:initialize(opts)
    self.shooter = opts.shooter

    opts.x = self.shooter.x + ( opts.shooter.w / 2 )
    opts.y = self.shooter.y + ( opts.shooter.h / 2 )
    self.target = opts.target

    self.dx = self.target.x - opts.x
    self.dy = self.target.y - opts.y

    self.no_constrain = 1
    self.lives = 1

    self.speed = opts.speed or 500
    self.name = 'bullet'

    self.v = math.sqrt( self.dx^2 + self.dy^2 )
    if self.v == 0 then
        self.lives = 0
    end

    self.dx = self.dx / self.v;
    self.dy = self.dy / self.v;

    Thing.initialize(self, opts)
end

function Bullet:move(dt)
    if not self:alive() then return end

    if( self.x < 0 or self.x > 650 or self.y < 0 or self.y > 490 ) then
        self.lives = self.lives - 1
    end

    Thing.move(self, dt, self.dx, self.dy)
end

