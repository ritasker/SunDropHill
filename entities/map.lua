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

function plant(ptx, pty)
  local seeds = get_inv_item_by_name(inv, "Seeds")
  if seeds != nil then
    if seeds.qty>0 then
      plr.ply_ani=true
      add(crops,{
        x=ptx,
        y=pty,
        wtd=false,
        sp=2,
        tig=0,
        si=300+rnd(300)
      })
      seeds.qty-=1

      if seeds.qty == 0 then
        del(inv, seeds)
      end
    end
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
        local carrots = get_inv_item_by_name(inv, "Carrots")
        if carrots == nil then
          add(inv, {
            name="Carrots",
            qty=1,
            sp=17
          })
        else
          carrots.qty+=1
        end
      end
    end
  end

