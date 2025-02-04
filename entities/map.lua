function imap()
    for x=0,128 do
        for y=0,128 do
            if rnd()<0.1 then
                mset(x,y,1)
            end
        end
    end
end

function dmap()
    cls(11)
    map()
end