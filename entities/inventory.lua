function iinv()
    inv={
    carrots=0,
    seeds=9
    }
end

function uinv()
end

function dinv()
    rnd_carrots()
    rnd_seeds()
end

function rnd_carrots()
    spr(17, 105, 18)
    print(inv.carrots, 115, 20, 7)
end

function rnd_seeds()
    spr(16, 105, 6)
    print(inv.seeds, 115, 8, 7)
end