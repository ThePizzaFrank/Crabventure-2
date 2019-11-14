module(...,package.seeall)

defaultPath = "assets/sprites/"

images = {
<<<<<<< HEAD
  enemy = love.graphics.newImage("assets/sprites/enemy.png"),
  wall_1 = love.graphics.newImage("assets/sprites/stoneWall.png"),
  floor_1 = love.graphics.newImage("assets/sprites/stoneGround.png")
=======
  enemy = love.graphics.newImage(defaultPath .. "/enemy.png"),
  wall_1 = love.graphics.newImage(defaultPath.. "/wall_1.png")
>>>>>>> 8ecb81f790f990fe2a2b9a448996cf8787ef6dcc
}
