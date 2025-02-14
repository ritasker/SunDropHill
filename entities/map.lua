function imap()
    crops={}
    gen_map()
end

function umap()
  for c in all(crops) do
    if c.wtd and rnd()>=0.6 and c.sp>2 and c.sp<5 then
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

function plant(ptx, pty)
  plr.ply_ani=true

  if inv.seeds>0 then
    add(crops,{
      x=ptx,
      y=pty,
      wtd=false,
      sp=2,
      tig=0,
      si=300+rnd(300)
    })
    inv.seeds-=1
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
        inv.carrots+=1
        inv.seeds+=2
      end
    end
  end

