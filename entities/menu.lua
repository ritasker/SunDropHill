function init_menu()
    m_sel = 1
    menu_state = "store"
    top_menu_item = { "buy", "sell" }
end

function update_menu()
    if menu_state == "store" then
        update_store_menu()
    elseif menu_state == "buy" then
        update_buy_menu()
    elseif menu_state == "sell" then
        update_sell_menu()
    end
end

function update_store_menu()
    if btnp(➡️) then
        if m_sel < #top_menu_item then
            m_sel += 1
        else
            m_sel = 1
        end
    elseif btnp(⬅️) then
        if m_sel > 1 then
            m_sel -= 1
        else
            m_sel = #top_menu_item
        end
    elseif btnp(❎) then
        if top_menu_item[m_sel] == "buy" then
            menu_state = "buy"
        elseif top_menu_item[m_sel] == "sell" then
            menu_state = "sell"
        end
    elseif btnp(🅾️) then
        state = "game"
    end
end

function update_buy_menu()
    if btnp(🅾️) then
        menu_state = "store"
    end
end

function update_sell_menu()
    if btnp(🅾️) then
        menu_state = "store"
    end
end

function draw_menu()
    if menu_state == "store" then
        draw_store_menu()
    elseif menu_state == "buy" then
        draw_buy_menu()
    elseif menu_state == "sell" then
        draw_sell_menu()
    end
end

function draw_store_menu()
    rectfill(32, 48, 96, 78, 2)
    rect(33, 49, 95, 77, 13)
    print("WHAT DO YOU", 35, 50, 7)
    print("WANT TO DO?", 35, 57, 7)

    for i = 1, #top_menu_item do
        print(top_menu_item[i], 40 + (20 * (i - 1)), 68, 7)
        print("▶", 35 + (20 * (m_sel - 1)), 68, 7)
    end
end

function draw_buy_menu()
    rectfill(32, 48, 96, 78, 2)
    rect(33, 49, 95, 77, 13)
    print("buy", 35, 50, 7)
end

function draw_sell_menu()
    rectfill(32, 48, 96, 78, 2)
    rect(33, 49, 95, 77, 13)
    print("sell", 35, 50, 7)
end
