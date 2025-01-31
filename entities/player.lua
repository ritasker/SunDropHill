-- player --
function iplr()
  plr={
    x=63,
    y=63  
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
end

function dplr()
  spr(12,plr.x,plr.y)
end