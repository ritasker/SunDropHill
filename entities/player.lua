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

  if btn(❎) then
    plant()
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
end