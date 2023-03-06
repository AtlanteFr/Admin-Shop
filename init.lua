
-- Fonction pour acheter un article
local function acheter_article(player, nom_article, prix_article)
    local name = player:get_player_name()
    local inventory = player:get_inventory()

    -- Vérifier si le joueur a suffisamment gold ingot
    if inventory:contains_item("main", "default:gold_ingot "..prix_article) then
        -- Retirer les ingot de l'inventaire du joueur
        inventory:remove_item("main", "default:gold_ingot "..prix_article)

        -- Ajouter l'article à l'inventaire du joueur
        local itemstack = ItemStack(nom_article.." 1")
        local leftover = inventory:add_item("main", itemstack)

        -- Si l'inventaire est plein, déposer l'article au sol
        if not leftover:is_empty() then
            minetest.add_item(player:get_pos(), leftover)
        end
    else
        -- Afficher un message si le joueur n'a pas suffisamment de gold ingot
        minetest.chat_send_player(name, "[Shop] You do not have enough Gold Ingot to purchase this item.")
    end
end

-- Fonction pour gérer les clics sur les boutons d'image
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "interface_achat" then
        return
    end
    
    local articles = {
        stone = {"default:stone 25", 4},
        stone5 = {"default:stone 50", 9},
        stone20 = {"default:stone 99", 20},
        torch = {"default:torch 30", 2},
        torch5 = {"default:torch 60", 5},
        torch20 = {"default:torch 99", 9},
        apple = {"default:apple 20", 3},
        apple5 = {"default:apple 50", 7},
        apple20 = {"default:apple 99", 15},
        tree = {"default:tree 15", 3},
        tree5 = {"default:tree 50", 11},
        tree20 = {"default:tree 99", 20},
        paper = {"default:paper 25", 3},
        paper5 = {"default:paper 75", 10},
        paper20 = {"default:paper 99", 14},
        fence_wood = {"default:fence_wood 35", 4},
        fence_wood5 = {"default:fence_wood 70", 8},
        fence_wood20 = {"default:fence_wood 99", 11},
        bread = {"farming:bread 10", 3},
        bread5 = {"farming:bread 50", 18},
        bread20 = {"farming:bread 99", 36},
        woolwhite = {"wool:white 15", 4},
        woolwhite5 = {"wool:white 50", 7},
        woolwhite20 = {"wool:white 99", 15}
    }
    
    for field, article in pairs(articles) do
        if fields[field] then
            acheter_article(player, unpack(article))
            return
        end
    end
    
    if fields.close then
        minetest.close_formspec(player:get_player_name(), "interface_achat")
    end
end)

-- Fonction pour afficher l'interface d'achat
local function afficher_interface_achat(player)
    local name = player:get_player_name()

    local formspec = "size[8,5.5]" ..

        "label[0,0;Buy items : "..minetest.colorize("#ff8c00", "              1 = 1 gold ingot").."]"..
-----------------------Stone---------------------------------
        "item_image_button[0,1;1,1;default:stone 25;stone;"..
            "4]" ..
        "item_image_button[0,2;1,1;default:stone 50;stone5;"..
            "9]" ..
        "item_image_button[0,3;1,1;default:stone 99;stone20;"..
            "20]" ..
-----------------------Torch---------------------------------
        "item_image_button[1,1;1,1;default:torch 30;torch;"..
            "2]" ..
        "item_image_button[1,2;1,1;default:torch 60;torch5;"..
            "5]" ..
        "item_image_button[1,3;1,1;default:torch 99;torch20;"..
            "9]" ..
-----------------------tree---------------------------------
        "item_image_button[2,1;1,1;default:tree 15;tree;"..
            "3]" ..
        "item_image_button[2,2;1,1;default:tree 50;tree5;"..
            "11]" ..
        "item_image_button[2,3;1,1;default:tree 99;tree20;"..
            "20]" ..
-----------------------apple---------------------------------
        "item_image_button[3,1;1,1;default:apple 20;apple;"..
            "3]" ..
        "item_image_button[3,2;1,1;default:apple 50;apple5;"..
            "7]" ..
        "item_image_button[3,3;1,1;default:apple 99;apple20;"..
            "15]" ..
-----------------------paper---------------------------------
        "item_image_button[4,1;1,1;default:paper 25;paper;"..
            "3]" ..
        "item_image_button[4,2;1,1;default:paper 75;paper5;"..
            "10]" ..
        "item_image_button[4,3;1,1;default:paper 99;paper20;"..
            "14]" ..
-----------------------Fence Wood---------------------------------
        "item_image_button[5,1;1,1;default:fence_wood 35;fence_wood;"..
            "4]" ..
        "item_image_button[5,2;1,1;default:fence_wood 70;fence_wood5;"..
            "8]" ..
        "item_image_button[5,3;1,1;default:fence_wood 99;fence_wood20;"..
            "11]" ..
-----------------------Bread---------------------------------
        "item_image_button[6,1;1,1;farming:bread 10;bread;"..
            "3]" ..
        "item_image_button[6,2;1,1;farming:bread 50;bread5;"..
            "18]" ..
        "item_image_button[6,3;1,1;farming:bread 99;bread20;"..
            "36]" ..

-----------------------woolwhite---------------------------------
        "item_image_button[7,1;1,1;wool:white 15;woolwhite;"..
            "4]" ..
        "item_image_button[7,2;1,1;wool:white 50;woolwhite5;"..
            "7]" ..
        "item_image_button[7,3;1,1;wool:white 99;woolwhite20;"..
            "15]" ..

        "button[4,4.5;2,1;menu;Menu]"..
        "button[0,4.5;2,1;info;Info]"..
        "button[6,0;1,1;nexts;->]"..
        "button[5,0;1,1;precedent1;<-]"..
    "label[7.4,5.1;"..minetest.colorize("#ff8c00", "1/2").."]"..
        "button_exit[2,4.5;2,1;exit;Close]"

    minetest.show_formspec(name, "interface_achat", formspec)
end

-- Fonction pour afficher l'interface d'information
local function afficher_interface_info(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..
        "button[0,4.5;2,1;retour;Return]"..

    "label[0,0;"..minetest.colorize("#ff8c00", "Information about the Shop").."]"..
    "label[0,0.7;Welcome to the Shop!Here's how it works:\nFirst of all there are items in boxes, there is also a number\nin the middle of this box which indicates the cost in gold ingot\n.I also assume that you must have seen that there was\nanother number at the bottom right? Well it indicates\nthe quantity.\nI hope you like this /shop :D\nSigned Atlante]"..
        "button_exit[2,4.5;2,1;exit;Close]"

    minetest.show_formspec(name, "interface_info", formspec)
end

-- Fonction pour afficher l'interface d'information
local function afficher_interface_infof(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..

        "button[0,4.5;2,1;retour;Return]"..
    "label[0,0;"..minetest.colorize("#ff8c00", "Information about the Shop").."]"..
    "label[0,0.7;Welcome to the Shop!Here's how it works:\nFirst of all there are items in boxes, there is also a number\nin the middle of this box which indicates the cost in gold ingot\n.I also assume that you must have seen that there was\nanother number at the bottom right? Well it indicates\nthe quantity.\nI hope you like this /shop :D\nSigned Atlante]"..
        "button_exit[2,4.5;2,1;exit;Close]"

    minetest.show_formspec(name, "interface_infof", formspec)
end

-- Fonction pour afficher l'interface d'information
local function afficher_interface_infofar(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..

        "button[0,4.5;2,1;retour;Return]"..
    "label[0,0;"..minetest.colorize("#ff8c00", "Information about the Shop").."]"..
    "label[0,0.7;Welcome to the Shop!Here's how it works:\nFirst of all there are items in boxes, there is also a number\nin the middle of this box which indicates the cost in gold ingot\n.I also assume that you must have seen that there was\nanother number at the bottom right? Well it indicates\nthe quantity.\nI hope you like this /shop :D\nSigned Atlante]"..
        "button_exit[2,4.5;2,1;exit;Close]"

    minetest.show_formspec(name, "interface_infofar", formspec)
end


-- Fonction pour afficher l'interface d'information
local function afficher_interface_infofna(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..

        "button[0,4.5;2,1;retour;Return]"..
    "label[0,0;"..minetest.colorize("#ff8c00", "Information about the Shop").."]"..
    "label[0,0.7;Welcome to the Shop!Here's how it works:\nFirst of all there are items in boxes, there is also a number\nin the middle of this box which indicates the cost in gold ingot\n.I also assume that you must have seen that there was\nanother number at the bottom right? Well it indicates\nthe quantity.\nI hope you like this /shop :D\nSigned Atlante]"..
        "button_exit[2,4.5;2,1;exit;Close]"

    minetest.show_formspec(name, "interface_infofna", formspec)
end

-- Fonction pour afficher l'interface d'information
local function afficher_interface_info2(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..

        "button[0,4.5;2,1;retour;Return]"..
    "label[0,0;"..minetest.colorize("#ff8c00", "Information about the Shop").."]"..
    "label[0,0.7;Welcome to the Shop!Here's how it works:\nFirst of all there are items in boxes, there is also a number\nin the middle of this box which indicates the cost in gold ingot\n.I also assume that you must have seen that there was\nanother number at the bottom right? Well it indicates\nthe quantity.\nI hope you like this /shop :D\nSigned Atlante]"..
        "button_exit[2,4.5;2,1;exit;Close]"

    minetest.show_formspec(name, "interface_info2", formspec)
end

-- Fonction pour afficher l'interface d'information
local function afficher_interface_info7(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..

        "button[0,4.5;2,1;retour;Return]"..
    "label[0,0;"..minetest.colorize("#ff8c00", "Information about the Shop").."]"..
    "label[0,0.7;Welcome to the Shop!Here's how it works:\nFirst of all there are items in boxes, there is also a number\nin the middle of this box which indicates the cost in gold ingot\n.I also assume that you must have seen that there was\nanother number at the bottom right? Well it indicates\nthe quantity.\nI hope you like this /shop :D\nSigned Atlante]"..
        "button_exit[2,4.5;2,1;exit;Close]"

    minetest.show_formspec(name, "interface_info7", formspec)
end

-- Fonction pour afficher l'interface d'information
local function afficher_interface_info6(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..

        "button[0,4.5;2,1;retour;Return]"..
    "label[0,0;"..minetest.colorize("#ff8c00", "Information about the Shop").."]"..
    "label[0,0.7;Welcome to the Shop!Here's how it works:\nFirst of all there are items in boxes, there is also a number\nin the middle of this box which indicates the cost in gold ingot\n.I also assume that you must have seen that there was\nanother number at the bottom right? Well it indicates\nthe quantity.\nI hope you like this /shop :D\nSigned Atlante]"..
        "button_exit[2,4.5;2,1;exit;Close]"

    minetest.show_formspec(name, "interface_info6", formspec)
end

-- Fonction pour afficher l'interface d'information
local function afficher_interface_info5(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..

        "button[0,4.5;2,1;retour;Return]"..
    "label[0,0;"..minetest.colorize("#ff8c00", "Information about the Shop").."]"..
    "label[0,0.7;Welcome to the Shop!Here's how it works:\nFirst of all there are items in boxes, there is also a number\nin the middle of this box which indicates the cost in gold ingot\n.I also assume that you must have seen that there was\nanother number at the bottom right? Well it indicates\nthe quantity.\nI hope you like this /shop :D\nSigned Atlante]"..
        "button_exit[2,4.5;2,1;exit;Close]"

    minetest.show_formspec(name, "interface_info5", formspec)
end

-- Fonction pour afficher l'interface d'information
local function afficher_interface_info4(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..

        "button[0,4.5;2,1;retour;Return]"..
    "label[0,0;"..minetest.colorize("#ff8c00", "Information about the Shop").."]"..
    "label[0,0.7;Welcome to the Shop!Here's how it works:\nFirst of all there are items in boxes, there is also a number\nin the middle of this box which indicates the cost in gold ingot\n.I also assume that you must have seen that there was\nanother number at the bottom right? Well it indicates\nthe quantity.\nI hope you like this /shop :D\nSigned Atlante]"..
        "button_exit[2,4.5;2,1;exit;Close]"

    minetest.show_formspec(name, "interface_info4", formspec)
end

-- Fonction pour afficher l'interface d'information
local function afficher_interface_info3(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..

        "button[0,4.5;2,1;retour2;Return]"..
    "label[0,0;"..minetest.colorize("#ff8c00", "Information about the Shop").."]"..
    "label[0,0.7;Welcome to the Shop!Here's how it works:\nFirst of all there are items in boxes, there is also a number\nin the middle of this box which indicates the cost in gold ingot\n.I also assume that you must have seen that there was\nanother number at the bottom right? Well it indicates\nthe quantity.\nI hope you like this /shop :D\nSigned Atlante]"..
        "button_exit[2,4.5;2,1;exit;Close]"

    minetest.show_formspec(name, "interface_info3", formspec)
end

-- Fonction pour afficher l'interface d'information
local function afficher_interface_infoa(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..

        "button[0,4.5;2,1;retour;Return]"..
    "label[0,0;"..minetest.colorize("#ff8c00", "Information about the Shop").."]"..
    "label[0,0.7;Welcome to the Shop!Here's how it works:\nFirst of all there are items in boxes, there is also a number\nin the middle of this box which indicates the cost in gold ingot\n.I also assume that you must have seen that there was\nanother number at the bottom right? Well it indicates\nthe quantity.\nI hope you like this /shop :D\nSigned Atlante]"..
        "button_exit[2,4.5;2,1;exit;Close]"

    minetest.show_formspec(name, "interface_infoa", formspec)
end

-- Fonction pour afficher l'interface du menu
local function afficher_interface_menu(player)
    local name = player:get_player_name()

    local formspec = "size[8,5.5]" ..

        "button[0,4.5;2,1;retour;Return]"..
        "label[0,0; "..minetest.colorize("#ff8c00", "Menu of selection :").."]"..
        "button[4,4.5;2,1;info6;Info]"..

        "button[0.1,0.5;2,1;diver;Diver]"..
        "item_image_button[0.6,1.5;1,1;default:torch;diver;]"..

        "button[2,0.5;2,1;tools;Tools]"..
        "item_image_button[2.5,1.5;1,1;default:sword_diamond;tools;]"..

        "button[3.9,0.5;2,1;blocks;Blocks]"..
        "item_image_button[4.4,1.5;1,1;default:stone_block;blocks;]"..

        "button[5.8,0.5;2,1;minerals;Minerals]"..
        "item_image_button[6.3,1.5;1,1;default:diamond;minerals;]"..

        "button[0.1,2.5;2,1;armor;Armor]"..
        "item_image_button[0.6,3.5;1,1;3d_armor:chestplate_diamond;armor;]"..

        "button[2,2.5;2,1;food;Food]"..
        "item_image_button[2.5,3.5;1,1;default:apple;food;]"..

        "button[3.9,2.5;2,1;farming;Farming]"..
        "item_image_button[4.4,3.5;1,1;farming:wheat;farming;]"..

        "button[5.8,2.5;2,1;natural;Natural]"..
        "item_image_button[6.3,3.5;1,1;default:dirt_with_grass;natural;]"..

        "button_exit[2,4.5;2,1;exit;Close]"

    minetest.show_formspec(name, "interface_menu", formspec)
end



-- Fonction pour afficher l'interface du Diver
local function afficher_interface_diver(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..

        "label[0,0;  "..minetest.colorize("#ff8c00", "Section Diver:").."]"..
        "button_exit[2,4.5;2,1;exit;Close]"..
        "label[0,0;"..minetest.colorize("#ff8c00", "                                               Buy items : ").."]"..
      "button[4,4.5;2,1;info2;Info]"..
        "button[0,4.5;2,1;retour;Return]"
    minetest.show_formspec(name, "interface_diver", formspec)
end

-- Fonction pour gérer les clics sur les boutons d'image
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "interface_tools" then
        return
    end
    
    local articles = {
        sword_diamond = {"default:sword_diamond", 10},
        pickaxe_diamond = {"default:pick_diamond", 15},
        shovel_diamond = {"default:shovel_diamond", 5},
        shovel_diamond = {"default:axe_diamond", 15},

        sword_mese = {"default:sword_mese", 4},
        pickaxe_mese = {"default:pick_mese", 6},
        shovel_mese = {"default:shovel_mese", 2},
        shovel_mese = {"default:axe_mese", 6},

        sword_bronze = {"default:sword_bronze", 1},
        pickaxe_bronze = {"default:pick_bronze", 2},
        shovel_bronze = {"default:shovel_bronze", 1},
        shovel_bronze = {"default:axe_bronze", 2},

        sword_steel = {"default:sword_steel", 1},
        pickaxe_steel = {"default:pick_steel", 2},
        shovel_steel = {"default:shovel_steel", 1},
        shovel_steel = {"default:axe_steel", 2},

        sword_stone = {"default:sword_stone", 0},
        pickaxe_stone = {"default:pick_stone", 0},
        shovel_stone = {"default:shovel_stone", 0},
        shovel_stone = {"default:axe_stone", 0},

        sword_wood = {"default:sword_wood ", 0},
        pick_wood = {"default:pick_wood", 0},
        shovel_wood= {"default:shovel_wood", 0},
        axe_wood = {"default:axe_wood", 0},

        hoe_wood = {"farming:hoe_wood ", 0},
        hoe_stone = {"farming:hoe_stone", 0},
        hoe_steel= {"farming:hoe_steel", 1},
    }
    
    for field, article in pairs(articles) do
        if fields[field] then
            acheter_article(player, unpack(article))
            return
        end
    end
    
    if fields.close then
        minetest.close_formspec(player:get_player_name(), "interface_minerals")
    end
end)

-- Fonction pour afficher l'interface du tools
local function afficher_interface_tools(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..
        "label[0,0;  "..minetest.colorize("#ff8c00", "Section Tools:").."]"..
        "item_image_button[0,1;1,1;default:sword_diamond;sword_diamond;"..
            "10]" ..
        "item_image_button[0,2;1,1;default:pick_diamond;pick_diamond;"..
            "15]" ..
        "item_image_button[0,3;1,1;default:shovel_diamond;shovel_diamond;"..
            "5]" ..
        "item_image_button[1,1;1,1;default:axe_diamond;axe_diamond;"..
            "15]" ..

        "item_image_button[1,2;1,1;default:sword_mese;sword_mese;"..
            "4]" ..
        "item_image_button[1,3;1,1;default:pick_mese;pick_mese;"..
            "6]" ..
        "item_image_button[2,1;1,1;default:shovel_mese;shovel_mese;"..
            "2]" ..
        "item_image_button[2,2;1,1;default:axe_mese;axe_mese;"..
            "4]" ..

        "item_image_button[2,3;1,1;default:sword_bronze;sword_bronze;"..
            "1]" ..
        "item_image_button[3,1;1,1;default:pick_bronze;pick_bronze;"..
            "2]" ..
        "item_image_button[3,2;1,1;default:shovel_bronze;shovel_bronze;"..
            "1]" ..
        "item_image_button[3,3;1,1;default:axe_bronze;axe_bronze;"..
            "2]" ..

        "item_image_button[4,1;1,1;default:sword_steel;sword_steel;"..
            "1]" ..
        "item_image_button[4,2;1,1;default:pick_steel;pick_steel;"..
            "2]" ..
        "item_image_button[4,3;1,1;default:shovel_steel;shovel_steel;"..
            "1]" ..
        "item_image_button[5,1;1,1;default:axe_steel;axe_steel;"..
            "2]" ..

        "item_image_button[5,2;1,1;default:sword_wood;sword_wood;"..
            "0]" ..
        "item_image_button[5,3;1,1;default:pick_wood;pick_wood;"..
            "0]" ..
        "item_image_button[6,1;1,1;default:shovel_wood;shovel_wood;"..
            "0]" ..
        "item_image_button[6,2;1,1;default:axe_wood;axe_wood;"..
            "0]" ..

        "item_image_button[6,3;1,1;farming:hoe_wood;hoe_wood;"..
            "0]" ..
        "item_image_button[7,1;1,1;farming:hoe_stone;hoe_stone;"..
            "0]" ..
        "item_image_button[7,2;1,1;farming:hoe_steel;hoe_steel;"..
            "1]" ..

        "button_exit[2,4.5;2,1;exit;Close]"..
        "label[0,0;"..minetest.colorize("#ff8c00", "                                               Buy items : ").."]"..
      "button[4,4.5;2,1;info3;Info]"..
        "button[0,4.5;2,1;retour;Return]"
    minetest.show_formspec(name, "interface_tools", formspec)
end

-- Fonction pour gérer les clics sur les boutons d'image
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "interface_minerals" then
        return
    end
    
    local articles = {
        steel_ingot = {"default:steel_ingot 5", 1},
        steel_ingot5 = {"default:steel_ingot 25", 5},
        steel_ingot20 = {"default:steel_ingot 50", 10},

        bronze_ingot = {"default:bronze_ingot 5", 2},
        bronze_ingot5 = {"default:bronze_ingot 25", 10},
        bronze_ingot20 = {"default:bronze_ingot 50", 20},

        tin_ingot = {"default:tin_ingot 10", 1},
        tin_ingot5 = {"default:tin_ingot 25", 3},
        tin_ingot20 = {"default:tin_ingot 50", 6},

        copper_ingot = {"default:copper_ingot 10", 1},
        copper_ingot5 = {"default:copper_ingot 25", 3},
        copper_ingot20 = {"default:copper_ingot 50", 6},

        mese_crystal = {"default:mese_crystal 1", 2},
        mese_crystal5 = {"default:mese_crystal 15", 30},
        mese_crystal20 = {"default:mese_crystal 50", 99},

        diamond = {"default:diamond 1", 5},
        diamond5 = {"default:diamond 15", 75},
        diamond20 = {"default:diamond 25", 125},

        coal_lump = {"default:coal_lump 20", 1},
        coal_lump5 = {"default:coal_lump 50", 3},
        coal_lump20 = {"default:coal_lump 99", 6},

        gold_ingot = {"default:gold_ingot 1", 1},
        gold_ingot5 = {"default:gold_ingot 10", 10},
        gold_ingot20 = {"default:gold_ingot 25", 25}
    }
    
    for field, article in pairs(articles) do
        if fields[field] then
            acheter_article(player, unpack(article))
            return
        end
    end
    
    if fields.close then
        minetest.close_formspec(player:get_player_name(), "interface_minerals")
    end
end)
-- Fonction pour afficher l'interface du minerals
local function afficher_interface_minerals(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..
        "label[0,0;  "..minetest.colorize("#ff8c00", "Section Minerals:").."]"..
        "item_image_button[0,1;1,1;default:steel_ingot 5;steel_ingot;"..
            "1]" ..
        "item_image_button[0,2;1,1;default:steel_ingot 25;steel_ingot5;"..
            "5]" ..
        "item_image_button[0,3;1,1;default:steel_ingot 50;steel_ingot20;"..
            "10]" ..

        "item_image_button[1,1;1,1;default:gold_ingot 1;gold_ingot;"..
            "1]" ..
        "item_image_button[1,2;1,1;default:gold_ingot 10;gold_ingot5;"..
            "10]" ..
        "item_image_button[1,3;1,1;default:gold_ingot 25;gold_ingot20;"..
            "25]" ..

        "item_image_button[2,1;1,1;default:tin_ingot 10;tin_ingot;"..
            "1]" ..
        "item_image_button[2,2;1,1;default:tin_ingot 25;tin_ingot5;"..
            "3]" ..
        "item_image_button[2,3;1,1;default:tin_ingot 50;tin_ingot20;"..
            "6]" ..

        "item_image_button[3,1;1,1;default:bronze_ingot 5;bronze_ingot;"..
            "2]" ..
        "item_image_button[3,2;1,1;default:bronze_ingot 25;bronze_ingot5;"..
            "10]" ..
        "item_image_button[3,3;1,1;default:bronze_ingot 50;bronze_ingot20;"..
            "20]" ..

        "item_image_button[4,1;1,1;default:copper_ingot 10;copper_ingot;"..
            "1]" ..
        "item_image_button[4,2;1,1;default:copper_ingot 25;copper_ingot5;"..
            "3]" ..
        "item_image_button[4,3;1,1;default:copper_ingot 50;copper_ingot20;"..
            "6]" ..

        "item_image_button[5,1;1,1;default:mese_crystal 1;mese_crystal;"..
            "2]" ..
        "item_image_button[5,2;1,1;default:mese_crystal 15;mese_crystal5;"..
            "30]" ..
        "item_image_button[5,3;1,1;default:mese_crystal 50;mese_crystal20;"..
            "99]" ..

        "item_image_button[6,1;1,1;default:diamond 1;diamond;"..
            "5]" ..
        "item_image_button[6,2;1,1;default:diamond 15;diamond5;"..
            "75]" ..
        "item_image_button[6,3;1,1;default:diamond 25;diamond20;"..
            "125]" ..

        "item_image_button[7,1;1,1;default:coal_lump 20;coal_lump;"..
            "1]" ..
        "item_image_button[7,2;1,1;default:coal_lump 50;coal_lump5;"..
            "3]" ..
        "item_image_button[7,3;1,1;default:coal_lump 99;coal_lump20;"..
            "6]" ..

        "button_exit[2,4.5;2,1;exit;Close]"..
        "label[0,0;"..minetest.colorize("#ff8c00", "                                               Buy items : ").."]"..
      "button[4,4.5;2,1;info5;Info]"..
        "button[0,4.5;2,1;retour;Return]"
    minetest.show_formspec(name, "interface_minerals", formspec)
end
-- Fonction pour gérer les clics sur les boutons d'image
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "interface_blocks" then
        return
    end
    
    local articles = {
        pine_tree = {"default:pine_tree 99", 1},
        aspen_tree = {"default:aspen_tree 99", 1},
        acacia_tree = {"default:acacia_tree 99", 1},

        tree = {"default:tree 99", 1},
        jungletree = {"default:jungletree 99", 1},
        brick = {"default:brick 99", 1},

        bookshelf = {"default:bookshelf 99", 1},
        coral_skeleton = {"default:coral_skeleton 99", 1},
        desert_stone = {"default:desert_stone 99", 1},

        cobble = {"default:cobble 99", 1},
        silver_sandstone = {"default:silver_sandstone 99", 1},
        sandstone = {"default:sandstone 99", 1},

        woolwhite = {"wool:white 99", 1},
        obsidian = {"default:obsidian 99", 1},

        leaves = {"default:leaves 99", 1},

    }
    
    for field, article in pairs(articles) do
        if fields[field] then
            acheter_article(player, unpack(article))
            return
        end
    end
    
    if fields.close then
        minetest.close_formspec(player:get_player_name(), "interface_blocks")
    end
end)
-- Fonction pour afficher l'interface du blocks
local function afficher_interface_blocks(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..
        "label[0,0;  "..minetest.colorize("#ff8c00", "Section Blocks:").."]"..
        "button_exit[2,4.5;2,1;exit;Close]"..
       "item_image_button[0,1;1,1;default:pine_tree 99;pine_tree;"..
            "1]" ..
        "item_image_button[0,2;1,1;default:aspen_tree 99;aspen_tree;"..
            "5]" ..
        "item_image_button[0,3;1,1;default:acacia_tree 98;acacia_tree;"..
            "10]" ..

        "item_image_button[1,1;1,1;default:tree 99;tree;"..
            "1]" ..
        "item_image_button[1,2;1,1;default:jungletree 99;jungletree;"..
            "10]" ..
        "item_image_button[1,3;1,1;default:brick 99;brick;"..
            "25]" ..

        "item_image_button[2,1;1,1;default:bookshelf 99;bookshelf;"..
            "1]" ..
        "item_image_button[2,2;1,1;default:coral_skeleton 99;coral_skeleton;"..
            "3]" ..
        "item_image_button[2,3;1,1;default:desert_stone 99;desert_stone;"..
            "6]" ..

        "item_image_button[3,1;1,1;default:cobble 99;cobble;"..
            "2]" ..
        "item_image_button[3,2;1,1;default:silver_sandstone 99;silver_sandstone;"..
            "10]" ..


        "item_image_button[4,1;1,1;default:sandstone 99;sandstone;"..
            "1]" ..
        "item_image_button[4,2;1,1;wool:white 25;woolwhite;"..
            "3]" ..
        "item_image_button[4,3;1,1;default:obsidian 99;obsidian;"..
            "6]" ..

        "item_image_button[5,1;1,1;default:leaves 99;leaves;"..
            "2]" ..
        "label[0,0;"..minetest.colorize("#ff8c00", "                                               Buy items : ").."]"..
      "button[4,4.5;2,1;info4;Info]"..
        "button[0,4.5;2,1;retour;Return]"
    minetest.show_formspec(name, "interface_blocks", formspec)
end

-- Fonction pour afficher l'interface du armor
local function afficher_interface_armor(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..

        "label[0,0;  "..minetest.colorize("#ff8c00", "Section Armor:").."]"..
        "button_exit[2,4.5;2,1;exit;Close]"..
        "label[0,0;"..minetest.colorize("#ff8c00", "                                               Buy items : ").."]"..
      "button[4,4.5;2,1;infoa;Info]"..
        "button[0,4.5;2,1;retour;Return]"
    minetest.show_formspec(name, "interface_armor", formspec)
end

-- Fonction pour gérer les clics sur les boutons d'image
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "interface_food" then
        return
    end
    
    local articles = {
        apple = {"default:apple 5", 1},
        apple5 = {"default:apple 25", 5},
        apple20 = {"default:apple 50", 10},

        bread = {"farming:bread 5", 6},
        bread5 = {"default:apple 25", 30},
        bread20 = {"default:apple 50", 60},

        mushroom_brown = {"flowers:mushroom_brown 5", 2},
        mushroom_brown5 = {"flowers:mushroom_brown 10", 4},
        mushroom_brown20 = {"flowers:mushroom_brown 30", 12},

        mushroom_red = {"flowers:mushroom_red 5", 5},
        mushroom_red5 = {"flowers:mushroom_red 25", 25},
        mushroom_red20 = {"flowers:mushroom_red 50", 50},

        blueberries = {"default:blueberries 20", 5},
        blueberries5 = {"default:blueberries 50", 15},
        blueberries20 = {"default:blueberries 99", 30},

    }
    
    for field, article in pairs(articles) do
        if fields[field] then
            acheter_article(player, unpack(article))
            return
        end
    end
    
    if fields.close then
        minetest.close_formspec(player:get_player_name(), "interface_food")
    end
end)

-- Fonction pour afficher l'interface du food
local function afficher_interface_food(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..
        "label[0,0;  "..minetest.colorize("#ff8c00", "Section Food:").."]"..
        "item_image_button[0,1;1,1;default:apple 20;apple;"..
            "3]" ..
        "item_image_button[0,2;1,1;default:apple 50;apple5;"..
            "7]" ..
        "item_image_button[0,3;1,1;default:apple 99;apple20;"..
            "15]" ..

        "item_image_button[1,1;1,1;farming:bread 5;bread;"..
            "6]" ..
        "item_image_button[1,2;1,1;farming:bread 25;bread5;"..
            "30]" ..
        "item_image_button[1,3;1,1;farming:bread 50;bread20;"..
            "60]" ..

        "item_image_button[2,1;1,1;flowers:mushroom_brown 5;mushroom_brown;"..
            "2]" ..
        "item_image_button[2,2;1,1;flowers:mushroom_brown 10;mushroom_brown5;"..
            "4]" ..
        "item_image_button[2,3;1,1;flowers:mushroom_brown 30;mushroom_brown20;"..
            "12]" ..

        "item_image_button[3,1;1,1;flowers:mushroom_red 5;mushroom_red;"..
            "4]" ..
        "item_image_button[3,2;1,1;flowers:mushroom_red 25;mushroom_red5;"..
            "20]" ..
        "item_image_button[3,3;1,1;flowers:mushroom_red 50;mushroom_red20;"..
            "40]" ..

        "item_image_button[4,1;1,1;default:blueberries 20;blueberries;"..
            "5]" ..
        "item_image_button[4,2;1,1;default:blueberries 50;blueberries5;"..
            "15]" ..
        "item_image_button[4,3;1,1;default:blueberries 99;blueberries20;"..
            "30]" ..


        "button_exit[2,4.5;2,1;exit;Close]"..
        "label[0,0;"..minetest.colorize("#ff8c00", "                                               Buy items : ").."]"..
      "button[4,4.5;2,1;infof;Info]"..
        "button[0,4.5;2,1;retour;Return]"
    minetest.show_formspec(name, "interface_food", formspec)
end

-- Fonction pour gérer les clics sur les boutons d'image
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "interface_farming" then
        return
    end
    
    local articles = {
        seed_cotton = {"farming:seed_cotton 20", 3},
        seed_cotton5 = {"farming:seed_cotton 50", 6},
        seed_cotton20 = {"farming:seed_cotton 99", 12},

        seed_wheat = {"farming:seed_wheat 20", 2},
        seed_wheat5 = {"farming:seed_wheat 50", 5},
        seed_wheat20 = {"farming:seed_wheat 99", 10},

        flour = {"farming:flour 10", 7},
        flour5 = {"farming:flour 20", 15},
        flour20 = {"farming:flour 50", 37},

         wheat = {"farming:wheat 20", 5},
        wheat5 = {"farming:wheat 50", 10},
        wheat20 = {"farming:wheat 99", 20},

         cotton = {"farming:cotton 20", 6},
        cotton5 = {"farming:cotton 50", 12},
        cotton20 = {"farming:cotton 99", 24},

         large_cactus_seedling = {"default:large_cactus_seedling 5", 2},
        large_cactus_seedling5 = {"default:large_cactus_seedling 25", 10},
        large_cactus_seedling20 = {"default:large_cactus_seedling 50", 20},

         cactus = {"default:cactus 10", 3},
        cactus5 = {"default:cactus 50", 12},
        cactus20 = {"default:cactus 99", 24},

         cactus = {"default:papyrus 10", 3},
        cactus5 = {"default:papyrus 30", 9},
        cactus20 = {"default:papyrus 60", 18},
    }
    
    for field, article in pairs(articles) do
        if fields[field] then
            acheter_article(player, unpack(article))
            return
        end
    end
    
    if fields.close then
        minetest.close_formspec(player:get_player_name(), "interface_farming")
    end
end)

-- Fonction pour afficher l'interface du farming
local function afficher_interface_farming(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..
        "label[0,0;  "..minetest.colorize("#ff8c00", "Section Farming:").."]"..

        "item_image_button[0,1;1,1;farming:seed_cotton 20;seed_cotton;"..
            "3]" ..
        "item_image_button[0,2;1,1;farming:seed_cotton 50;seed_cotton5;"..
            "6]" ..
        "item_image_button[0,3;1,1;farming:seed_cotton 99;seed_cotton20;"..
            "12]" ..

        "item_image_button[1,1;1,1;farming:cotton 20;cotton;"..
            "6]" ..
        "item_image_button[1,2;1,1;farming:cotton 50;cotton5;"..
            "12]" ..
        "item_image_button[1,3;1,1;farming:cotton 99;cotton20;"..
            "24]" ..

        "item_image_button[2,1;1,1;farming:seed_wheat 20;seed_wheat;"..
            "2]" ..
        "item_image_button[2,2;1,1;farming:seed_wheat 50;seed_wheat5;"..
            "5]" ..
        "item_image_button[2,3;1,1;farming:seed_wheat 99;seed_wheat20;"..
            "10]" ..

        "item_image_button[3,1;1,1;farming:wheat 20;wheat;"..
            "5]" ..
        "item_image_button[3,2;1,1;farming:wheat 50;wheat5;"..
            "10]" ..
        "item_image_button[3,3;1,1;farming:wheat 99;wheat20;"..
            "20]" ..

        "item_image_button[4,1;1,1;farming:flour 10;wheat;"..
            "7]" ..
        "item_image_button[4,2;1,1;farming:flour 20;wheat5;"..
            "15]" ..
        "item_image_button[4,3;1,1;farming:flour 50;wheat20;"..
            "37]" ..

        "item_image_button[5,1;1,1;default:large_cactus_seedling 5;large_cactus_seedling;"..
            "2]" ..
        "item_image_button[5,2;1,1;default:large_cactus_seedling 25;large_cactus_seedling5;"..
            "10]" ..
        "item_image_button[5,3;1,1;default:large_cactus_seedling 50;large_cactus_seedling20;"..
            "20]" ..

        "item_image_button[6,1;1,1;default:cactus 10;cactus;"..
            "3]" ..
        "item_image_button[6,2;1,1;default:cactus 50;cactus5;"..
            "12]" ..
        "item_image_button[6,3;1,1;default:cactus 99;cactus20;"..
            "24]" ..

        "item_image_button[7,1;1,1;default:papyrus 10;paper;"..
            "3]" ..
        "item_image_button[7,2;1,1;default:papyrus 30;paper5;"..
            "9]" ..
        "item_image_button[7,3;1,1;default:papyrus 60;paper20;"..
            "18]" ..

        "button[6,0;1,1;nextsfar;->]"..
        "button[5,0;1,1;precedentfar;<-]"..
        "button_exit[2,4.5;2,1;exit;Close]"..
    "label[7.4,5.1;"..minetest.colorize("#ff8c00", "1/2").."]"..
        "label[0,0;"..minetest.colorize("#ff8c00", "                                               Buy items : ").."]"..
      "button[4,4.5;2,1;infofar;Info]"..
        "button[0,4.5;2,1;retour;Return]"
    minetest.show_formspec(name, "interface_farming", formspec)
end

-- Fonction pour afficher l'interface du armor
local function afficher_interface_natural(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..
        "label[0,0;  "..minetest.colorize("#ff8c00", "Section Natural:").."]"..
        "button_exit[2,4.5;2,1;exit;Close]"..
        "label[0,0;"..minetest.colorize("#ff8c00", "                                               Buy items : ").."]"..
      "button[4,4.5;2,1;infofna;Info]"..

        "button[0,4.5;2,1;retour;Return]"
    minetest.show_formspec(name, "interface_natural", formspec)
end

-- Fonction pour gérer les clics sur les boutons d'image
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "interface_farming_2" then
        return
    end
    
    local articles = {
        paper = {"default:paper 25", 3},
        paper5 = {"default:paper 75", 10},
        paper20 = {"default:paper 99", 14},
    }
    
    for field, article in pairs(articles) do
        if fields[field] then
            acheter_article(player, unpack(article))
            return
        end
    end
    
    if fields.close then
        minetest.close_formspec(player:get_player_name(), "interface_farming_2")
    end
end)

-- Fonction pour afficher l'interface farming 2
local function afficher_interface_farming_2(player)
local name = player:get_player_name()
local formspec = "size[8,5.5]" ..
        "label[0,0;  "..minetest.colorize("#ff8c00", "Section Farming (2):").."]"..
        "item_image_button[0,1;1,1;default:paper 25;paper;"..
            "3]" ..
        "item_image_button[0,2;1,1;default:paper 75;paper5;"..
            "10]" ..
        "item_image_button[0,3;1,1;default:paper 99;paper20;"..
            "14]" ..
        "button[4,4.5;2,1;menu;Menu]"..
        "button[6,0;1,1;nextsfar;->]"..
        "button[5,0;1,1;precedentfar;<-]"..
        "button[0,4.5;2,1;info2;Info]"..

    "label[7.4,5.1;"..minetest.colorize("#ff8c00", "2/2").."]"..
        "button_exit[2,4.5;2,1;exit;Close]"
    minetest.show_formspec(name, "interface_farming_2", formspec)

end


-- Fonction pour afficher l'interface d'achat 2
local function afficher_interface_achat_2(player)
local name = player:get_player_name()
local formspec = "size[8,5.5]" ..
        "button[4,4.5;2,1;menu;Menu]"..
        "button[6,0;1,1;nexts;->]"..
        "button[5,0;1,1;precedent;<-]"..

        "button[0,4.5;2,1;info2;Info]"..
    "label[0,0;"..minetest.colorize("#ff8c00", "Future functionality").."]"..
    "label[7.4,5.1;"..minetest.colorize("#ff8c00", "2/2").."]"..
        "button_exit[2,4.5;2,1;exit;Close]"
    minetest.show_formspec(name, "interface_achat_2", formspec)

end

-- Enregistrement de la fonction pour le bouton "<- (precedent page)"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_achat_2" and fields.precedent then
afficher_interface_achat(player)
    end
end)




-- Enregistrement de la fonction pour le bouton "-> (next page)"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_achat" and fields.nexts then
afficher_interface_achat_2(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_info" and fields.retour then
afficher_interface_achat(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "nextfar"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_farming" and fields.nextsfar then
afficher_interface_farming_2(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "nextfar"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_farming_2" and fields.precedentfar then
afficher_interface_farming(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_info2" and fields.retour then
afficher_interface_diver(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_infoa" and fields.retour then
afficher_interface_armor(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_infof" and fields.retour then
afficher_interface_food(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_infofar" and fields.retour then
afficher_interface_farming(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_infofna" and fields.retour then
afficher_interface_natural(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "menu"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_achat_2" and fields.menu then
afficher_interface_menu(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_info3" and fields.retour then
afficher_interface_tools(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_info4" and fields.retour then
afficher_interface_blocks(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_info5" and fields.retour then
afficher_interface_minerals(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_info6" and fields.retour then
afficher_interface_menu(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_info7" and fields.retour2 then
afficher_interface_menu(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_armor" and fields.retour then
afficher_interface_menu(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_food" and fields.retour then
afficher_interface_menu(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_farming" and fields.retour then
afficher_interface_menu(player)
    end
end)


-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_natural" and fields.retour then
afficher_interface_menu(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_tools" and fields.retour then
afficher_interface_menu(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_blocks" and fields.retour then
afficher_interface_menu(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_minerals" and fields.retour then
afficher_interface_menu(player)
    end
end)
-- Enregistrement de la fonction pour le bouton "info"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_achat" and fields.info then
afficher_interface_info(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "info"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_diver" and fields.info2 then
afficher_interface_info2(player)
    end
end)



-- Enregistrement de la fonction pour le bouton "info"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_food" and fields.infof then
afficher_interface_infof(player)
    end
end)
-- Enregistrement de la fonction pour le bouton "info"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_farming" and fields.infofar then
afficher_interface_infofar(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "info"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_natural" and fields.infofna then
afficher_interface_infofna(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "info"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_armor" and fields.infoa then
afficher_interface_infoa(player)
    end
end)



-- Enregistrement de la fonction pour le bouton "info"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_tools" and fields.info3 then
afficher_interface_info3(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "info"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_blocks" and fields.info4 then
afficher_interface_info4(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "info"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_minerals" and fields.info5 then
afficher_interface_info5(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "info"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_menu" and fields.info6 then
afficher_interface_info6(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "info"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_achat_2" and fields.info7 then
afficher_interface_info7(player)
    end
end)


-- Enregistrement de la fonction pour le bouton "info"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_tools" and fields.info3 then
afficher_interface_info3(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "info"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_blocks" and fields.info4 then
afficher_interface_info4(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "info"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_minerals" and fields.info5 then
afficher_interface_info5(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "info"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_menu" and fields.info then
afficher_interface_info6(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "diver"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_menu" and fields.diver then
afficher_interface_diver(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "armor"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_menu" and fields.armor then
afficher_interface_armor(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "food"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_menu" and fields.food then
afficher_interface_food(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "farming"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_menu" and fields.farming then
afficher_interface_farming(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "natural"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_menu" and fields.natural then
afficher_interface_natural(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "tools"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_menu" and fields.tools then
afficher_interface_tools(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "blocks"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_menu" and fields.blocks then
afficher_interface_blocks(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "minerals"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_achat_2" and fields.menu then
afficher_interface_menu(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "minerals"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_menu" and fields.minerals then
afficher_interface_minerals(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_menu" and fields.retour then
afficher_interface_achat(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_diver" and fields.retour then
afficher_interface_menu(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_info7" and fields.retour then
afficher_interface_achat_2(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "menu"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_achat" and fields.menu then
afficher_interface_menu(player)
    end
end)

-- Enregistrer la commande pour afficher l'interface
minetest.register_chatcommand("shop", {
    description = "Open The Admin Shop",
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        afficher_interface_achat(player)
    end,
})



