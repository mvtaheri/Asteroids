local love = require "love"

function Text(text,x,y,font_size,fade_in,fade_out,wrap_width,align,opacity)
    font_size= font_size or "p"
    fade_in=fade_in or false
    fade_out = fade_out or false
    wrap_width = wrap_width or love.graphics.getWidth()
    align= align or "left"
    opacity = opacity or 1

    local TEXT_FADE_DUR = 5

    local fonts = {
        h1 = love.graphics.newFont(60),
        h2 = love.graphics.newFont(50),
        h3 = love.graphics.newFont(40),
        h4 = love.graphics.newFont(30),
        h5 = love.graphics.newFont(20),
        h6 = love.graphics.newFont(10),
        p = love.graphics.newFont(16)
    }
    if fade_in then 
        opacity = 0.1
    end
    return{
        text= text,
        x=x,
        y=y,
        opacity = opacity,
        color={
            r=1,
            g=1,
            b=1
        },
        setColor = function (self,red,green,blue)
                self.color.r=red
                self.color.blue=blue
                self.color.green = green
        end,
        draw = function (self,tb1_text,index)
                if self.opacity >0 then 
                  if fade_in then
                    if self.opacity<1 then
                        self.opacity = self.opacity+(1/TEXT_FADE_DUR / love.timer.getFPS())
                    else
                        fade_in =false
                    end
                  elseif fade_out then
                      self.opacity = self.opacity - (1/TEXT_FADE_DUR / love.timer.getFPS())
                  end
                  love.graphics.setColor(self.color.r,self.color.g,self.color.b,self.opacity)
                  love.graphics.setFont(fonts[font_size])
                  love.graphics.printf(self.text,self.x,self.y,wrap_width,align)
                  love.graphics.setFont(fonts["p"])
                else
                    table.remove(tb1_text,index)
                    return false
                end
                return true 
        end
    }
end

return Text