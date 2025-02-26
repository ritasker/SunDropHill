function iinv()
  sel=1
  inv={}

  add(inv,{
    name="gold",
    qty=10,
    sp=18
  })
  

end

function uinv()
  if btnp(🅾️) and #inv > 0 then
    if sel == #inv then
      sel=1
    else
      sel+=1
    end
  end
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
    
    if #inv > 0 then
      rect(23+(10*sel)+(2*(sel-1)),113,32+(10*sel)+(2*(sel-1)),122,10)
    end
end

function get_inv_item_by_name(t, name)
  for i = 1, #t do
    if t[i].name == name then
      return t[i]
    end
  end
end