BurgerTable = {
    cheese = {"boiguh_che","boiguh_pat"},
    bigmac = {"boiguh_let","boiguh_pat","boiguh_bot","boiguh_che","boiguh_pat"},
    cheeseandlettuce = {"boiguh_let","boiguh_che","boiguh_pat"},
    doublecheese = {"boiguh_pat","boiguh_che","boiguh_pat"},
    lettuce = {"boiguh_let","boiguh_pat"},
    bacon = {"boiguh_bac","boiguh_pat"},
    baconcheese = {"boiguh_tom","boiguh_bac","boiguh_che","boiguh_pat"},
    complicatedcheese = {"boiguh_tom","boiguh_let","boiguh_che","boiguh_pat"},
    deluxebacon = {"boiguh_let","boiguh_bac","boiguh_pat","boiguh_bac"},
    vegan = {"boiguh_tom","boiguh_let","boiguh_let"},
}
function GM:GetBurgers()
    return BurgerTable
end

function GM:GetBurger(name)
    return BurgerTable[name] or false
end
