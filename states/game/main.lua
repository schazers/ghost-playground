--More timers
createEnemyTimerMax = 0.4
createEnemyTimer = createEnemyTimerMax

-- More images
enemyImg = nil -- Like other images we'll pull this in during out love.load function

-- More storage
enemies = {} -- array of current enemies on screen

-- set false on production
debug = true

player = { x = 200, y = 710, speed = 300, img = nil }

canShoot = true
canShootTimerMax = 0.14
canShootTimer = canShootTimerMax

-- Image Storage
bulletImg = nil

-- Entity Storage
bullets = {} -- array of current bullets being drawn and updated

function load()
  player.img = love.graphics.newImage('assets/plane.png')
  bulletImg = love.graphics.newImage('assets/bullet.png')
end

function love.update(dt)
  if love.keyboard.isDown('escape') then
      love.event.push('quit')
  end

  -- Time out how far apart our shots can be
  canShootTimer = canShootTimer - (1 * dt)
  if canShootTimer < 0 then
    canShoot = true
  end

  -- move the player
  if love.keyboard.isDown('left', 'a') then
    if player.x > 0 then
      player.x = player.x - (player.speed * dt)
    end
  elseif love.keyboard.isDown('right', 'd') then
    if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
      player.x = player.x + (player.speed * dt)
    end
  end

  -- Create some bullets
  if love.keyboard.isDown('space', 'rctrl', 'lctrl') and canShoot then
  	newBullet = { x = player.x + (player.img:getWidth()/2 - 5), y = player.y, img = bulletImg }
  	table.insert(bullets, newBullet)
  	canShoot = false
  	canShootTimer = canShootTimerMax
  end

  -- update the positions of bullets
  for i, bullet in ipairs(bullets) do
    bullet.y = bullet.y - (250 * dt)

    if bullet.y < 0 then --remove bullets when they leave screen
      table.remove(bullets, i)
    end
  end
end

function love.draw(dt)
  love.graphics.draw(player.img, player.x, player.y)

  for i, bullet in ipairs(bullets) do
    love.graphics.draw(bullet.img, bullet.x, bullet.y)
  end
end
