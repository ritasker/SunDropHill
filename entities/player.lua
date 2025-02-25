-- player --
function iplr()
  plr={
    x=60,
    y=29,
    sp=12,
    ani_spd=1,
    ani_tmr=0
  }
end
   
function uplr()
  local lx=plr.x
  local ly=plr.y

  if btn(➡️) then
    plr.x += 1
  elseif btn(⬅️) then
    plr.x -= 1
  elseif btn(⬆️) then
    plr.y -= 1
  elseif btn(⬇️) then
    plr.y += 1
  end

  if collide() or off_screen() then
    plr.x=lx
    plr.y=ly
  end

  if btn(🅾️) then
    local ptx=flr((plr.x+4)/8)
    local pty=flr((plr.y+4)/8)
    
    if fget(mget(ptx, pty), 1) then
      plant(ptx, pty)
    end
  end

  if btn(❎) then
    local ptx=flr((plr.x+4)/8)
    local pty=flr((plr.y+4)/8)

    if fget(mget(ptx, pty), 2) then
      harvest(ptx, pty)
    elseif fget(mget(ptx, pty), 3) then
      if inv.gold>0 then
        inv.gold-=1
        inv.seeds+=1
      end
    elseif mget(ptx, pty)==2 then
      water(ptx,pty)
    end
  end

  if plr.ply_ani then
    ply_ani()
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