function imap()
    crops={}
    gen_map()
end

function umap()
  for c in all(crops) do
    if rnd()>=0.6 and c.sp<5 then
      c.tig+=1
      if c.tig >= c.si then
        c.tig=0
        c.sp+=1
      end
    end
    mset(c.x,c.y,c.sp)
  end
end

function dmap()
    cls(11)
    map()
end

function gen_map()
    for x=0,128 do
        for y=0,128 do
            if rnd()<0.1 then
                mset(x,y,1)
            end
        end
    end
end

function harvest()
    local ptx=flr((plr.x+4)/8)
    local pty=flr((plr.y+4)/8)

    plr.ply_ani=true

    if fget(mget(ptx, pty), 2) then
      for c in all(crops) do
        if c.x==ptx and c.y==pty then
          c.sp=2
          inv.carrots+=1
          inv.seeds+=2
        end
      end
    end
  end

  function plant()
    local ptx=flr((plr.x+4)/8)
    local pty=flr((plr.y+4)/8)
    
    plr.ply_ani=true
  
    if fget(mget(ptx, pty), 1) then
      add(crops,{
        x=ptx,
        y=pty,
        sp=3,
        tig=0,
        si=300+rnd(300)
      })
      inv.seeds-=1
    end
  end