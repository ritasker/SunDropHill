function imenu()
    menu_visable=false
    store_menu={"buy","sell"}
end

function umenu()
    
end

function dmenu()
    rectfill(32,48,96,78,2)
    rect(33,49,95,77,13)
    print("WHAT DO YOU", 35, 50, 7)
    print("WANT TO DO?", 35, 57, 7)

    for i=1,#store_menu do
        print(store_menu[i],32+(10*(i-1)),65,7)
    end
end