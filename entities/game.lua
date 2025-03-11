function init_game()
  crops = {}
  trees = {}
  rocks = {}

  gen_map()

  for y = 4, 16 do
    for x = 0, 16 do
      if not collide(x, y) then
        plr = {
          x = 60,
          y = 32,
          sp = 12,
          gp = 10
        }
        break
      end
    end
  end

  inv_sel = 1
  plr_inv = {}
  add(plr_inv, {
    name = "axe",
    qty = 1,
    sp = 49
  })
end

function update_game()
  local lx = plr.x
  local ly = plr.y

  update_crops()

  if btn(➡️) then plr.x += 1 end
  if btn(⬅️) then plr.x -= 1 end
  if btn(⬆️) then plr.y -= 1 end
  if btn(⬇️) then plr.y += 1 end

  if collide(plr.x, plr.y) or off_screen() then
    plr.x = lx
    plr.y = ly
  end

  if btnp(❎) then
    local ptx = flr((plr.x + 4) / 8)
    local pty = flr((plr.y + 6) / 8)

    if next_to_rock(ptx, pty) and holding("pick") then
      damage_rock(ptx, pty)
    end

    if next_to_tree(ptx, pty) and holding("axe") then
      damage_tree(ptx, pty)
    end

    if over_planted_seeds(ptx, pty) then
      water(ptx, pty)
      sfx(2)
    end

    if over_farmable_land(ptx, pty) and holding("seeds") then
      plant(ptx, pty)
      sfx(0)
    end

    if over_fully_grown_crop(ptx, pty) then
      harvest(ptx, pty)
      sfx(1)
    end

    if at_store(ptx, pty) then
      init_menu()
      state = "menu"
    end
  end

  if btnp(🅾️) and #plr_inv > 0 then
    if inv_sel == #plr_inv then
      inv_sel = 1
    else
      inv_sel += 1
    end
  end
end

function draw_game()
  -- draw player
  spr(plr.sp, plr.x, plr.y)

  draw_hotbar()

  spr(18, 4, 4)
  print("X " .. plr.gp .. "gp", 15, 5, 7)
end

function gen_map()
  for y = 4, 15 do
    for x = 0, 15 do
      local map_tile = mget(x, y)
      if is_tree_tile(map_tile) then
        goto continue
      end

      -- grass
      if rnd() < 0.3 then
        mset(x, y, 1)
      end

      -- flowers
      if rnd() < 0.08 then
        flower_idx = flr(rnd(3))
        mset(x, y, 32 + flower_idx)
      end

      -- rocks
      if rnd() < 0.06 then
        mset(x, y, 6)
        add(rocks, {
          x = x,
          y = y,
          dmg = 0,
          sp = 6
        })
      end

      -- trees
      if rnd() < 0.03 then
        if not_on_tree(x, y) then
          map_tree(x, y, 19)
          add(trees, {
            x = x,
            y = y,
            dmg = 0,
            sp = 19
          })
        end
      end
      ::continue::
    end
  end

  -- fence
  for x = 0, 16 do
    if x < 6 or x > 9 then
      mset(x, 3, 11)
    end
  end

  -- fence post ends
  mset(6, 3, 27)
  mset(9, 3, 43)
end

function next_to_rock(x, y)
  for r in all(rocks) do
    if (r.x == x and r.y == y)
        or (r.x == x and r.y - 1 == y)
        or (r.x == x and r.y + 1 == y)
        or (r.x - 1 == x and r.y == y)
        or (r.x + 1 == x and r.y == y) then
      return true
    end
  end
  return false
end

function map_tree(x, y, sp)
  if sp == 0 then
    mset(x, y, 0)
    mset(x + 1, y, 0)
    mset(x, y + 1, 0)
    mset(x + 1, y + 1, 0)
  else
    mset(x, y, sp)
    mset(x + 1, y, sp + 1)
    mset(x, y + 1, sp + 16)
    mset(x + 1, y + 1, sp + 17)
  end
end

function next_to_tree(x, y)
  for t in all(trees) do
    if (t.x >= x - 1 and t.x <= x + 1)
        and (t.y >= y - 1 and t.y <= y + 1) then
      return true
    end
  end
  return false
end

function not_on_tree(x, y)
  local t1 = mget(x, y)
  local t2 = mget(x + 1, y)
  local t3 = mget(x, y + 1)
  local t4 = mget(x + 1, y + 1)

  return not is_tree_tile(t1)
      or not is_tree_tile(t2)
      or not is_tree_tile(t3)
      or not is_tree_tile(t4)
end

function is_tree_tile(tile)
  return tile == 19 or tile == 20 or tile == 35 or tile == 36
end

function update_crops()
  for c in all(crops) do
    if c.wtd and rnd() >= 0.6 and c.sp > 2 and c.sp < 5 then
      c.tig += 1
      if c.tig >= c.si then
        c.tig = 0
        c.sp += 1
      end
    end

    mset(c.x, c.y, c.sp)
  end
end

function off_screen()
  local px1 = (plr.x + 1) / 8
  local px2 = (plr.x + 7) / 8
  local py1 = (plr.y + 1) / 8
  local py2 = (plr.y + 8) / 8

  if px1 < 0 or px2 > 16 or py1 < 0 or py2 > 16 then
    return true
  else
    return false
  end
end

function collide(plrx, plry)
  local px1 = (plrx + 3) / 8
  local px2 = (plrx + 4) / 8
  local py = (plry + 5) / 8

  if fget(mget(px1, py), 0) or fget(mget(px2, py), 0) then
    return true
  else
    return false
  end
end

function over_planted_seeds(x, y)
  return mget(x, y) == 2
end

function over_farmable_land(x, y)
  return fget(mget(x, y), 1)
end

function over_fully_grown_crop(x, y)
  return fget(mget(x, y), 2)
end

function at_store(x, y)
  return fget(mget(x, y), 3)
end

function holding(name)
  return plr_inv[inv_sel].name == name
end

function get_inv_item_by_name(t, name)
  for i = 1, #t do
    if t[i].name == name then
      return t[i]
    end
  end
end

function draw_hotbar()
  rectfill(32, 112, 91, 123, 19)

  rect(32, 112, 43, 123, 5)
  rect(44, 112, 55, 123, 5)
  rect(56, 112, 67, 123, 5)
  rect(68, 112, 79, 123, 5)
  rect(80, 112, 91, 123, 5)

  for i = 1, #plr_inv do
    spr(plr_inv[i].sp, 23 + (8 * i) + (4 * i - 1), 114)
    print(plr_inv[i].qty, 23 + (8 * i) + (4 * i - 1), 106, 7)
  end

  if #plr_inv > 0 then
    rect(23 + (10 * inv_sel) + (2 * (inv_sel - 1)), 113, 32 + (10 * inv_sel) + (2 * (inv_sel - 1)), 122, 10)
  end
end

function damage_rock(x, y)
  for r in all(rocks) do
    if (r.x == x and r.y == y)
        or (r.x == x and r.y - 1 == y)
        or (r.x == x and r.y + 1 == y)
        or (r.x - 1 == x and r.y == y)
        or (r.x + 1 == x and r.y == y) then
      if r.dmg < 3 then
        r.dmg += 1
        r.sp += 1
        mset(r.x, r.y, r.sp)
      end

      if r.dmg >= 3 then
        mset(r.x, r.y, 0)
        del(rocks, r)
      end
    end
  end
end

function damage_tree(x, y)
  for t in all(trees) do
    if (t.x >= x - 1 and t.x <= x + 1)
        and (t.y >= y - 1 and t.y <= y + 1) then
      if t.dmg < 3 then
        t.dmg += 1
        t.sp += 2
        map_tree(t.x, t.y, t.sp)
      end

      if t.dmg >= 3 then
        map_tree(t.x, t.y, 0)
        del(trees, t)
      end
    end
  end
end

function plant(x, y)
  local seeds = get_inv_item_by_name(plr_inv, "seeds")
  if seeds != nil and seeds.qty > 0 then
    plr.ply_ani = true
    add(
      crops, {
        x = x,
        y = y,
        wtd = false,
        sp = 2,
        tig = 0,
        si = 200 + rnd(200)
      }
    )
    seeds.qty -= 1

    if seeds.qty == 0 then
      del(plr_inv, seeds)
      inv_sel = 1
    end
  end
end

function water(x, y)
  for c in all(crops) do
    if c.x == x and c.y == y then
      c.wtd = true
      c.sp = 3
    end
  end
end

function harvest(x, y)
  plr.ply_ani = true

  for c in all(crops) do
    if c.x == x and c.y == y then
      c.sp = 0
      local carrots = get_inv_item_by_name(plr_inv, "carrots")
      if carrots == nil then
        add(
          plr_inv, {
            name = "carrots",
            qty = 1,
            gp = 5,
            sp = 17
          }
        )
      else
        carrots.qty += 1
      end
    end
  end
end

function ply_ani()
  if plr.ani_tmr < plr.ani_spd then
    plr.ani_tmr += 1
  else
    if plr.sp == 12 then
      plr.sp = 13
    else
      plr.sp = 12
      plr.ply_ani = false
    end
    plr.ani_tmr = 0
  end
end
