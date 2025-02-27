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
        local gold = get_inv_item_by_name(plr_inv, "gold")
        if gold != nil and gold.qty > 0 then
            local seeds = get_inv_item_by_name(plr_inv, "seeds")
            if seeds != nil then
                seeds.qty += 1
            else
                add(
                    plr_inv, {
                        name = "seeds",
                        qty = 1,
                        sp = 16
                    }
                )
            end
            gold.qty -= 1
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
            local gold = get_inv_item_by_name(plr_inv, "gold")
            if gold != nil then
                gold.qty += carrots.gp
            else
                add(
                    plr_inv, {
                        name = "gold",
                        qty = carrots.gp,
                        sp = 18
                    }
                )
            end
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
    local gold = get_inv_item_by_name(plr_inv, "gold")
    spr(gold.sp, 32, 39)
    print("X " .. gold.qty .. "gp", 42, 40, 7)

    rectfill(32, 48, 96, 52 + (10 * #store_inv), 2)
    rect(33, 49, 95, 51 + (10 * #store_inv), 13)

    for i = 1, #store_inv do
        local si = store_inv[i]
        spr(si.sp, 40, 41 + (10 * i))
        print(si.name, 50, 43 + (10 * i), 7)
        print(si.gp .. "gp", 82, 43 + (10 * i), 7)
    end

    print("▶", 36, 43 + (10 * m_sel), 7)
end

function draw_sell_menu()
    local gold = get_inv_item_by_name(plr_inv, "gold")
    spr(gold.sp, 32, 39)
    print("X " .. gold.qty .. "gp", 42, 40, 7)

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
