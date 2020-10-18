module(...,package.seeall)

defaultPath = "assets/sprites/"

images = {
  enemy = love.graphics.newImage(defaultPath .. "enemy.png"),
  wall_1 = love.graphics.newImage(defaultPath .. "wall_1.png"),
  wall_2 = love.graphics.newImage(defaultPath .. "wall_2.png"),
  floor_1 = love.graphics.newImage(defaultPath .. "floor_1.png"),
  stairs = love.graphics.newImage(defaultPath .. "stairs.png")
}
