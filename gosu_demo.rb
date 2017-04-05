require 'gosu'

class BadassGame2000 < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Tutorial Game"
    @ship = Starship.new
    @pews = []
  end

  def update
    @ship.update
    @ship.move
    
    @pews.each do |pew|
      pew.update
    end

    if Gosu.button_down?(Gosu::KB_SPACE)
      @pews << PewPewPew.new(@ship.x + 3, @ship.y + 3, @ship.angle)
      Gosu::Sample.new("assets/pew.wav").play
    end
  end

  def draw
    @ship.draw
    @pews.each do |pew|
      pew.draw

    end
    #..
  end
end



class PewPewPew
  def initialize(x,y, angle)
    @image = Gosu::Image.new("assets/pew.png")
    @x = x
    @y = y
    @angle = angle
  end

  def update
    @x += Gosu.offset_x(@angle, 10)
    @y += Gosu.offset_y(@angle, 10)
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end

class Starship
  attr_accessor :x, :y, :angle
  def initialize
    @image = Gosu::Image.new("assets/ships.gif", :rect => [0,0,65,65])
    
    @angle = 0.0
    @x = 320
    @y = 240
    @vel_x = 0.0 
    @vel_y = 0.0
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu.offset_x(@angle, 0.15)
    @vel_y += Gosu.offset_y(@angle, 0.15)
  end

  def backup
    @vel_x -= Gosu.offset_x(@angle, 0.15)
    @vel_y -= Gosu.offset_y(@angle, 0.15)
  end

  def update
    if Gosu.button_down?(Gosu::KB_LEFT)
      turn_left
    end

    if Gosu.button_down?(Gosu::KB_RIGHT)
      turn_right
    end

    if Gosu.button_down?(Gosu::KB_UP)
      accelerate
    end

    if Gosu.button_down?(Gosu::KB_DOWN)
      backup
    end

    move
  end



  # def warp(x, y)
  #   @x, @y = x, y
  # end
  
  # def turn_left
  #   @angle -= 4.5
  # end
  
  # def turn_right
  #   @angle += 4.5
  # end
  
  # def accelerate
  #   @vel_x += Gosu.offset_x(@angle, 0.5)
  #   @vel_y += Gosu.offset_y(@angle, 0.5)
  # end
  
  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480
    
    @vel_x *= 0.97
    @vel_y *= 0.97
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end


# Initialize
BadassGame2000.new.show