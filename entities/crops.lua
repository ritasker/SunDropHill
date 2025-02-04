function icrops()
  seeds={}
  crops={}
end

function ucrops()
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
        si=300+rnd(300),
        grown=false
      })
      del(seeds, s)
    end
  end
end

function grow_crops()
  for c in all(crops) do
    if c.grown==false then
      c.tig+=1

      if c.tig>c.si then
        mset(c.x,c.y,5)
        c.grown=true
      end
    end
  end
end