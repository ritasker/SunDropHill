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
  -- Random grass
  for x=0,16 do
    for y=4,16 do
      if rnd()<0.15 then
        mset(x,y,1)
      end
    end
  end

  for x=0,16 do
    if x<6 or x>9 then
      mset(x,3,11)
    end
  end
  
  -- fence post ends
  mset(6,3,27)
  mset(9,3,43)
end