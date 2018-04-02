require "repliconz.thing"

Baddie = Thing:subclass('Baddie')
Baddie:include(CanShoot)

function Baddie:filter(other)
    if other.class == self.class then return 'slide' end
    return 'touch'
end

function Baddie:move(dt, player)
    dx = player.x - self.x
    dy = player.y - self.y

    Thing.move(self, dt, dx, dy)
end

