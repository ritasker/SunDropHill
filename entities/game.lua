function init_game()
  crops = {}
  plr = {
    x = 60,
    y = 32,
    sp = 12
  }

  inv_sel=1
  inv = {}
  add(inv, {
    name = "gold",
    qty = 10,
    sp = 18
  })

  gen_map()
end

function update_game()
  local lx = plr.x
  local ly = plr.y

  update_crops()

  if btn(➡️) then plr.x += 1 end
  if btn(⬅️) then plr.x -= 1 end
  if btn(⬆️) then plr.y -= 1 end
  if btn(⬇️) then plr.y += 1 end

  if collide() or off_screen() then
    plr.x = lx
    plr.y = ly
  end

  if btnp(❎) then
    local ptx = flr((plr.x + 4) / 8)
    local pty = flr((plr.y + 6) / 8)

    if over_planted_seeds(ptx,pty) then
      print("over seeds", 64, 64,7)
      water(ptx, pty)
    end

    if over_farmable_land(ptx, pty) and seeds_selected() then
      print("over farmland", 64, 64,7)
      plant(ptx, pty)
    end    

    if over_fully_grown_crop(ptx, pty) then
      print("over carrots", 64, 64,7)
      harvest(ptx, pty)
    end
    
    if at_store(ptx, pty) then
      print("at store", 64, 64,7)
      init_menu()
      state="menu"
    end
  end

  if btnp(🅾️) and #inv > 0 then
    if inv_sel == #inv then
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
end

function gen_map()
  -- Random grass
  for x = 0, 16 do
    for y = 4, 16 do
      if rnd() < 0.15 then
        mset(x, y, 1)
      end
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

function collide()
  local px1 = (plr.x + 3) / 8
  local px2 = (plr.x + 4) / 8
  local py = (plr.y + 5) / 8

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

function seeds_selected()
  return inv[inv_sel].name == "seeds"
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

  for i = 1, #inv do
    spr(inv[i].sp, 23 + (8 * i) + (4 * i - 1), 114)
    print(inv[i].qty, 23 + (8 * i) + (4 * i - 1), 106, 7)
  end

  if #inv > 0 then
    rect(23 + (10 * inv_sel) + (2 * (inv_sel - 1)), 113, 32 + (10 * inv_sel) + (2 * (inv_sel - 1)), 122, 10)
  end
end

function plant(x, y)
  local seeds = get_inv_item_by_name(inv, "seeds")
  if seeds != nil and seeds.qty > 0 then
    plr.ply_ani = true
    add(crops, {
      x = x,
      y = y,
      wtd = false,
      sp = 2,
      tig = 0,
      si = 300 + rnd(300)
    })
    seeds.qty -= 1

    if seeds.qty == 0 then
      del(inv, seeds)
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
      local carrots = get_inv_item_by_name(inv, "carrots")
      if carrots == nil then
        add(inv, {
          name = "carrots",
          qty = 1,
          sp = 17
        })
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
