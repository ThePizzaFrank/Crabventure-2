module(...,package.seeall)

defaultPath = "assets/sprites/"

images = {
  enemy = love.graphics.newImage(defaultPath .. "/enemy.png"),
  wall_1 = love.graphics.newImage(defaultPath.. "/stoneWall.png")
}
