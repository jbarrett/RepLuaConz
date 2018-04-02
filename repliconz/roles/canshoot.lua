require "middleclass"
require "repliconz.bullet"

CanShoot = {
    can_shoot = true,
    cooldown = cooldown or .1,
    bullets = {},

    shoot = function(self, target)
        table.insert(self.bullets, Bullet:new({
            shooter = self,
            target  = target,
            world   = self.world,
        }))
    end,

    move_bullets = function(self, dt)
        for i, bullet in ipairs(self.bullets) do
            if not bullet:alive() then
                table.remove(self.bullets, i)
            else
                bullet:move(dt)
            end
        end
    end,

    draw_bullets = function(self)
        for i, bullet in ipairs(self.bullets) do
            if bullet.alive then
                bullet:draw(255,255,255)
            end
        end
    end
}
