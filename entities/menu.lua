function imenu()
    menu_visable=false
    show_buy_menu=false
    show_sell_menu=false
    show_top_menu=false

    m_sel=1
    store_menu={"buy","sell"}
end

function umenu()
    if btnp(➡️) then
        if m_sel < #store_menu then
            m_sel+=1
        else
            m_sel=1
        end
    elseif btnp(⬅️) then
        if m_sel > 1 then
            m_sel-=1
        else
            m_sel=#store_menu
        end
    elseif btnp(❎) then
        if store_menu[m_sel] == "buy" then
            show_buy_menu=true
        elseif store_menu[m_sel] == "sell" then
            show_sell_menu=true
        end
    elseif btnp(🅾️) then
        if show_buy_menu or show_sell_menu then
            show_buy_menu=false
            show_sell_menu=false
        else
            show_top_menu=false
        end
    end
    menu_visable=show_buy_menu or show_sell_menu or show_top_menu
end

function dmenu()
    if show_top_menu then
        rectfill(32,48,96,78,2)
        rect(33,49,95,77,13)
        print("WHAT DO YOU", 35, 50, 7)
        print("WANT TO DO?", 35, 57, 7)

        for i=1,#store_menu do
            print(store_menu[i],40+(20*(i-1)),68,7)
            print("▶", 35+(20*(m_sel-1)),68,7)
        end
    elseif show_buy_menu then
        rectfill(32,48,96,78,2)
        rect(33,49,95,77,13)
        print("buy", 35, 50, 7)
    elseif show_sell_menu then
        rectfill(32,48,96,78,2)
        rect(33,49,95,77,13)
        print("sell", 35, 50, 7)
    end
end