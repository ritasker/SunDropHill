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
    rectfill(32,112,91,123,19)
    
    rect(32,112,43,123,5)
    rect(44,112,55,123,5)
    rect(56,112,67,123,5)
    rect(68,112,79,123,5)
    rect(80,112,91,123,5)

    for i=1,#inv do
      spr(inv[i].sp,23+(8*i)+(4*i-1),114)
      if inv[i].qty > 1 then
        print(inv[i].qty,23+(8*i)+(4*i-1),106,7)
      end
    end
    
   -- rect(33,113,42,122,10)
    

    
end

function get_inv_item_by_name(t, name)
  for i = 1, #t do
    if t[i].name == name then
      return t[i]
    end
  end
end