-- player --
function iplr()
  plr={
    x=63,
    y=63,
    sp=12,
    ani_spd=1,
    ani_tmr=0
  }
end
   
function uplr()
  if btn(➡️) then
    plr.x += 1
  elseif btn(⬅️) then
    plr.x -= 1
  elseif btn(⬆️) then
    plr.y -= 1
  elseif btn(⬇️) then
    plr.y += 1
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