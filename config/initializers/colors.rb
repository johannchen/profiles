module Sass::Script::Functions
  # given a color, returns a color that has the opposite lightness
  # (the specified color pushes its value to the opposite edge)
  def edgevalue(color, offset=0)
    unless lightness(color).value >= 50
      offset = 255 - offset.to_i
    end
    Sass::Script::Color.new(:red => offset, :green => offset, :blue => offset)
  end
end
