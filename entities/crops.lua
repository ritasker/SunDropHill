function icrops()
  seeds={}
  crops={}
end

function ucrops()
  if btn(❎) then
    plant_seeds()
  end

  grow_seeds()
  grow_crops()
end

function dcrops()
  
end

function grow_seeds()
  for s in all(seeds) do
    s.tig+=1

    if s.tig>s.si then
      mset(s.x,s.y,4)
      add(crops, {
        x=s.x,
        y=s.y,
        tig=0,
        si=300+rnd(300)
      })
      del(seeds, s)
    end
  end
end

function grow_crops()
  for c in all(crops) do
    c.tig+=1

    if c.tig>c.si then
      mset(c.x,c.y,5)
      del(crops, c)
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
    tig=0,
    si=300+rnd(300)
  })
  end  
end