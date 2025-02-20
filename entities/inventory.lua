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
    spr(17, 110, 2)
    print(inv.carrots, 120, 5, 7)
end

function rnd_seeds()
    spr(16, 90, 2)
    print(inv.seeds, 100, 5, 7)
end