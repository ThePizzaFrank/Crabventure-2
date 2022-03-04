module(...,package.seeall)

defaultPath = "assets/sprites/"
buttonPath = "assets/buttons/"

images = {
  enemy = love.graphics.newImage(defaultPath .. "enemy.png"),
  wall_1 = love.graphics.newImage(defaultPath .. "wall_1.png"),
  wall_2 = love.graphics.newImage(defaultPath .. "wall_2.png"),
  floor_1 = love.graphics.newImage(defaultPath .. "floor_1.png"),
  stairs = love.graphics.newImage(defaultPath .. "stairs.png"),
  crab = love.graphics.newImage(defaultPath .. "crab.png"),
  close_button = love.graphics.newImage(buttonPath .. "close_button.png"),
  close_button_hover = love.graphics.newImage(buttonPath .. "close_button_hover.png"),
  close_button_pressed = love.graphics.newImage(buttonPath .. "close_button_pressed.png")
}
