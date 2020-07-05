# frozen_string_literal: true

$LOAD_PATH.concat(
  [
    File.join(File.dirname(__FILE__), 'modules'),
    File.join(File.dirname(__FILE__), 'classes')
  ]
)

%w[gosu globals player].each(&method(:require))

# entry point for the game
class Game < Gosu::Window
  def initialize
    super(Globals::HORIZONTAL_RESOLUTION, Globals::VERTICAL_RESOLUTION)
    self.caption = 'Gosuvania'

    @background_image = Gosu::Image.new('assets/sprites/placeholder.png')

    @player = Player.new
    @player.warp(512, 384)
  end

  def update
    @player.move_left if
      Gosu.button_down?(Gosu::KB_LEFT) || Gosu.button_down?(Gosu::KB_A)
    @player.move_right if
      Gosu.button_down?(Gosu::KB_RIGHT) || Gosu.button_down?(Gosu::KB_D)
    @player.move_up if
      Gosu.button_down?(Gosu::KB_UP) || Gosu.button_down?(Gosu::KB_W)
    @player.move_down if
      Gosu.button_down?(Gosu::KB_DOWN) || Gosu.button_down?(Gosu::KB_S)

    @player.move
  end

  def draw
    @background_image.draw(0, 0, 0)
    @player.draw
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end

Game.new.show
