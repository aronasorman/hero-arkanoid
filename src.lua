function _init()
  add_paddle(
    55, 96, function(e)
      if btn(0) then
        e.time_btn_pressed = t()
        e.vx = -1
      elseif btn(1) then
        e.time_btn_pressed = t()
        e.vx = 1
      else
        e.vx = e.vx / 1.25
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
  cls()
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
    for i = 1, #e.sprites do
      spr(e.sprites[i], e.x + (i - 1) * 8, e.y)
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
    sprites = { 2, 3 },
    updatefn = updatefn
  }
  add(scene, paddle)
end
