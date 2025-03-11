function init_menu()
    m_sel = 1
    menu_state = "store"
    store_menu_items = { "buy", "sell" }

    store_inv = {}
    add(
        store_inv, {
            name = "seeds",
            gp = 1,
            sp = 16
        }
    )
    add(
        store_inv, {
            name = "axe",
            gp = 100,
            sp = 49
        }
    )
    add(
        store_inv, {
            name = "pick",
            gp = 500,
            sp = 48
        }
    )
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
        if m_sel < #store_menu_items then
            m_sel += 1
        else
            m_sel = 1
        end
    elseif btnp(⬅️) then
        if m_sel > 1 then
            m_sel -= 1
        else
            m_sel = #store_menu_items
        end
    elseif btnp(❎) then
        if store_menu_items[m_sel] == "buy" then
            menu_state = "buy"
            m_sel = 1
        elseif store_menu_items[m_sel] == "sell" then
            menu_state = "sell"
            m_sel = 1
        end
    elseif btnp(🅾️) then
        state = "game"
    end
end

function update_buy_menu()
    if btnp(⬇️) then
        if m_sel < #store_inv then
            m_sel += 1
        else
            m_sel = 1
        end
    elseif btnp(⬆️) then
        if m_sel > 1 then
            m_sel -= 1
        else
            m_sel = #store_inv
        end
    end

    if btnp(❎) then
        local store_item = store_inv[m_sel]
        local plr_item = get_inv_item_by_name(plr_inv, store_item.name)
        if plr.gp > 0 and plr.gp >= store_item.gp then
            if plr_item != nil then
                plr_item.qty += 1
            else
                add(
                    plr_inv, {
                        name = store_item.name,
                        qty = 1,
                        sp = store_item.sp
                    }
                )
            end
            plr.gp -= store_item.gp
            sfx(3)
        end
    end

    if btnp(🅾️) then
        menu_state = "store"
    end
end

function update_sell_menu()
    if btnp(❎) then
        local carrots = get_inv_item_by_name(plr_inv, "carrots")
        if carrots != nil and carrots.qty > 0 then
            plr.gp += carrots.gp
            carrots.qty -= 1

            if carrots.qty == 0 then
                del(plr_inv, carrots)
            end
        end
    end

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

    for i = 1, #store_menu_items do
        print(store_menu_items[i], 40 + (20 * (i - 1)), 68, 7)
    end

    print("▶", 35 + (20 * (m_sel - 1)), 68, 7)
end

function draw_buy_menu()
    spr(18, 32, 39)
    print("X " .. plr.gp .. "gp", 42, 40, 7)

    rectfill(30, 48, 104, 52 + (10 * #store_inv), 2)
    rect(31, 49, 103, 51 + (10 * #store_inv), 13)

    for i = 1, #store_inv do
        local si = store_inv[i]
        if plr.gp >= si.gp then
            txt_col = 7
        else
            txt_col = 8
        end
        spr(si.sp, 38, 41 + (10 * i))
        print(si.name, 48, 43 + (10 * i), txt_col)
        print(si.gp .. "gp", 80, 43 + (10 * i), txt_col)
    end

    print("▶", 34, 43 + (10 * m_sel), 7)
end

function draw_sell_menu()
    spr(18, 32, 39)
    print("X " .. plr.gp .. "gp", 42, 40, 7)

    rectfill(32, 48, 96, 62, 2)
    rect(33, 49, 95, 61, 13)

    local carrots = get_inv_item_by_name(plr_inv, "carrots")
    if carrots != nil then
        spr(carrots.sp, 40, 51)
        print(carrots.name, 50, 53, 7)
        print(carrots.gp .. "gp", 82, 53, 7)

        print("▶", 36, 53, 7)
    end
end
