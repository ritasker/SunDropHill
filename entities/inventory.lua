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
    rnd_carrots()
    rnd_seeds()
    rnd_gold()
end

function rnd_carrots()
    spr(17, 110, 2)
    print(inv.carrots, 120, 5, 7)
end

function rnd_seeds()
    spr(16, 93, 2)
    print(inv.seeds, 103, 5, 7)
end

function rnd_gold()
    spr(18, 75, 2)
    print(inv.gold, 85, 5, 7)
end