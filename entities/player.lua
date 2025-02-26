-- player --
function iplr()
  plr={
    x=60,
    y=32,
    sp=12,
    ani_spd=1,
    ani_tmr=0
  }
end
   
function uplr()
  local lx=plr.x
  local ly=plr.y

  if not menu_visable then
    if btn(➡️) then
      plr.x += 1
    elseif btn(⬅️) then
      plr.x -= 1
    elseif btn(⬆️) then
      plr.y -= 1
    elseif btn(⬇️) then
      plr.y += 1
    end
  end

  if collide() or off_screen() then
    plr.x=lx
    plr.y=ly
  end

  if btnp(❎) then
    local ptx=flr((plr.x+4)/8)
    local pty=flr((plr.y+4)/8)

    if over_farmable_land(ptx, pty) and seeds_selected() then
      plant(ptx, pty)
    elseif over_fully_grown_crop(ptx, pty) then
      harvest(ptx, pty)
    elseif at_store(ptx, pty) then
      if not menu_visable then
      m_sel=1
      show_top_menu=true
      -- gold=get_inv_item_by_name(inv, "gold")
      -- if gold != nil then
      --   if gold.qty>0 then
      --     gold.qty-=1
          
      --     if gold.qty == 0 then
      --       del(inv,gold)
      --     end

      --     seeds=get_inv_item_by_name(inv, "seeds")
      --     if seeds==nil then
      --       add(inv, {
      --         name="seeds",
      --         qty=1,
      --         sp=16
      --       })
      --     else
      --       seeds.qty+=1
      --     end
      --   end
      -- end
      end
    elseif over_planted_seeds then
      water(ptx,pty)
    end
  end

  if plr.ply_ani then
    ply_ani()
  end
end

function over_planted_seeds(x, y)
  if mget(ptx, pty)==2 then
    return true
  else
    return false
  end
end

function over_farmable_land(x, y)
  if fget(mget(x, y), 1) then
    return true
  else
    return false
  end
end

function over_fully_grown_crop(x, y)
  if fget(mget(x, y), 2) then
    return true
  else
    return false
  end
end


function at_store(x, y)
  if fget(mget(x, y), 3) then
    return true
  else
    return false
  end
end

function seeds_selected()
  if inv[sel].name=="seeds" then
    return true
  else
    return false
  end
end

function dplr()
  spr(plr.sp,plr.x,plr.y)
end

function off_screen()
  local px1=(plr.x+1)/8
  local px2=(plr.x+7)/8
  local py1=(plr.y+1)/8
  local py2=(plr.y+8)/8

  if px1 < 0 or px2 > 16 or py1 < 0 or py2 > 16 then 
    return true
  else
    return false
  end
end

function collide()
  local px1=(plr.x+3)/8
  local px2=(plr.x+4)/8
  local py=(plr.y+5)/8

  if fget(mget(px1,py),0) or fget(mget(px2,py),0) then
    return true
  else 
    return false
  end
end

function plant(ptx, pty)
  local seeds = get_inv_item_by_name(inv, "seeds")
  if seeds != nil then
    if seeds.qty>0 then
      plr.ply_ani=true
      add(crops,{
        x=ptx,
        y=pty,
        wtd=false,
        sp=2,
        tig=0,
        si=300+rnd(300)
      })
      seeds.qty-=1

      if seeds.qty == 0 then
        del(inv, seeds)
        sel=1
      end
    end
  end
end

function water(ptx, pty)
  for c in all(crops) do
    if c.x==ptx and c.y==pty then
      c.wtd=true
      c.sp=3
    end
  end
end

function harvest(ptx, pty)
    plr.ply_ani=true

    for c in all(crops) do
      if c.x==ptx and c.y==pty then
        c.sp=0
        local carrots = get_inv_item_by_name(inv, "carrots")
        if carrots == nil then
          add(inv, {
            name="carrots",
            qty=1,
            sp=17
          })
        else
          carrots.qty+=1
        end
      end
    end
  end

function ply_ani()
  if plr.ani_tmr<plr.ani_spd then
    plr.ani_tmr+=1
  else
    if plr.sp==12 then
      plr.sp=13
    else
      plr.sp=12
      plr.ply_ani=false
    end
    plr.ani_tmr=0
  end
end