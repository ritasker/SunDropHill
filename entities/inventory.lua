function iinv()
  inv={}

  add(inv,{
    name="Gold",
    qty=10,
    sp=18
  })

end

function uinv()
end

function dinv()
    rnd_hotbar()
end

function rnd_hotbar()
    rectfill(32,112,43,123,19)
    rect(32,112,43,123,5)
    rect(44,12,55,123,5)
    
    spr(18,34,114)
    print(10,34,106,13)
   -- rect(33,113,42,122,10)
    

    -- for i=1,#inv do
    --   if inv[i].ihb then
    --     spr(inv[i].sp,23+(i*8),116)
    --   end
    -- end
end