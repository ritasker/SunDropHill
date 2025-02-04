-- player --
function iplr()
  plr={
    x=63,
    y=63,
    carrots=0,
    sp=12,
    ani_spd=1,
    ani_tmr=0
  }
end
   
function uplr() -- add new sprits for movement directions
  if btn(➡️) then
    plr.x+=1
  elseif btn(⬅️) then
    plr.x-=1
  elseif btn(⬆️) then
    plr.y-=1
  elseif btn(⬇️) then
    plr.y+=1
  end

  if btn(❎) then
    plant_seed()
  end

  if btn(🅾️) then
    harvest()
  end

  if plr.ply_ani then
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
end

function dplr()
  spr(plr.sp,plr.x,plr.y)
  spr(18, 105, 6)
  print(plr.carrots, 115, 8, 7)
end

function plant_seed()
  local ptx=flr((plr.x+4)/8)
  local pty=flr((plr.y+4)/8)
  
  plr.ply_ani=true

  if fget(mget(ptx, pty), 1) then
    mset(ptx,pty,3)
    add(seeds,{
      x=ptx,
      y=pty,
      tig=0,
      si=300+rnd(300)
    })
  end
end

function harvest()
  local ptx=flr((plr.x+4)/8)
  local pty=flr((plr.y+4)/8)
  
  plr.ply_ani=true

  if fget(mget(ptx, pty), 2) then
    mset(ptx,pty,2)
    
    for c in all(crops) do
      if c.x==ptx and c.y==pty then
        del(crops, c)
        plr.carrots+=1
      end
    end
  end
end