function _init()
  add_paddle(
    55, 96, function(e)
      if btn(0) then
        e.vx = -1
      elseif btn(1) then
        e.vx = 1
      else
        e.vx = e.vx / 1.25
      end
      -- iterate over each sprite in the paddle
      for _, spritepos in pairs(e.sprites) do
        -- recalculate from the paddle's relative tile position to the world pixel position
        pos = { x = e.x + spritepos.x * 8, y = e.y + spritepos.y * 8, mapcollide = spritepos.mapcollide, worldboundscollide = e.worldboundscollide }
        collision = collide(pos)
        if collision.world or collision.map then
          e.vx = -e.vx * 3
          break
        end
      end
      e.x += e.vx
    end
  )

  add_ball(64, 64, 1, 1, 2, 3)
end

function _update60()
  update_paddles(scene)
end

function _draw()
  cls(12)
  map()
  draw_balls(scene)
  draw_paddle(scene)
end

scene = {}
w = 128
h = 128

draw_balls = system(
  { "ball", "r" }, function(e)
    circfill(e.x, e.y, e.r, e.color)
  end
)

draw_rects = system(
  { "rect", "w", "h" }, function(e)
    rectfill(e.x, e.y, e.x + e.w, e.y + e.h, e.color)
  end
)

draw_paddle = system(
  { "paddle", "sprites" }, function(e)
    for spritenum, spritepos in pairs(e.sprites) do
      spr(spritenum, e.x + spritepos.x * 8, e.y + spritepos.y * 8)
    end
  end
)

update_paddles = system(
  { "paddle" }, function(e)
    if e.updatefn then
      e.updatefn(e)
    end
  end
)

update_balls = system(
  { "ball" }, function(e)
    if e.updatefn then
      e.updatefn(e)
    else
      e.x += e.vx
      e.y += e.vy
    end
  end
)

update_rects = system(
  { "rect" }, function(e)
    if e.updatefn then
      e.updatefn(e)
    end
  end
)

function add_ball(x, y, vx, vy, r, color, updatefn)
  local ball = {
    ball = true,
    x = x,
    y = y,
    vx = vx,
    vy = vy,
    r = r,
    color = color,
    updatefn = updatefn
  }
  add(scene, ball)
end

function add_paddle(x, y, updatefn)
  local paddle = {
    paddle = true,
    x = x,
    y = y,
    vx = 0,
    vy = 0,
    color = color,
    worldboundscollide = true,
    mapcollide = true,
    sprites = {
      [1] = { x = 0, y = 0, mapcollide = true },
      [2] = { x = 1, y = 0, mapcollide = true }
    },
    updatefn = updatefn
  }
  add(scene, paddle)
end
