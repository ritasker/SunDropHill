function iinv()
  inv={
    carrots=0,
    seeds=0,
    gold=5
  }
end

function uinv()
end

function dinv()
    rnd_hotbar()
end

function rnd_hotbar()
    rectfill(30,115,100,124,13)
    spr(16, 31, 116)
    rect(30,115,39,124,7)
    spr(17, 40, 116)
    rect(39,115,48,124,7)
    spr(18, 49, 116)
    rect(48,115,57,124,7)
end