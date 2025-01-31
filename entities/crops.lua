function icrops()
  seeds={}
end

function ucrops()
  if btn(❎) then
    plant_seeds()
  end

  grow_seeds()
end

function grow_seeds()
  for s in all(seeds) do
    s.tig+=1

    if s.tig>300 then
      mset(s.x,s.y,4)
    end
  end
end

function plant_seeds()
  local ptx=flr((plr.x+4)/8)
  local pty=flr((plr.y+4)/8)
  local pt=mget(ptx,pty)

  if pt==0 or pt==1 or pt==2 then
   mset(ptx,pty,3)
   add(seeds,{
    x=ptx,
    y=pty,
    tig=0
  })
  end  
end