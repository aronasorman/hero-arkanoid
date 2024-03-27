function _has(e, ks)
  for n in all(ks) do
    if not e[n] then
      return false
    end
  end
  return true
end

function system(ks, f)
  return function(es)
    for e in all(es) do
      if _has(e, ks) then
        f(e)
      end
    end
  end
end

-- collide returns a table with two fields, map and world, which are true if the object is colliding with the map or world bounds, respectively.
-- object o should have o.mapcollide and o.worldboundscollide defined
-- mapcollide is whether the object collides with map tiles
-- worldboundscollide is whether the object collides with the world bounds
-- w or h should be defined as the world bounds
function collide(o)
  local ct = false
  local cb = false

  -- if colliding with map tiles
  if o.mapcollide then
    local x1 = o.x / 8
    local y1 = o.y / 8
    local x2 = (o.x + 7) / 8
    local y2 = (o.y + 7) / 8
    local a = fget(mget(x1, y1), 0)
    local b = fget(mget(x1, y2), 0)
    local c = fget(mget(x2, y2), 0)
    local d = fget(mget(x2, y1), 0)
    ct = a or b or c or d
  end
  -- if colliding world bounds
  if o.worldboundscollide then
    cb = o.x < 0 or o.x + 8 > w
        or o.y < 0 or o.y + 8 > h
  end

  return {
    map = ct,
    world = cb
  }
end
