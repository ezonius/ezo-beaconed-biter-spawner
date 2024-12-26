---@diagnostic disable: param-type-mismatch, assign-type-mismatch
local enableSpeed = settings.startup["cbs-enable-speed"].value
local enableProductivity = settings.startup["cbs-enable-productivity"].value
local enableQuality = settings.startup["cbs-enable-quality"].value
local enablePollution = settings.startup["cbs-enable-pollution"].value
local enableConsumption = settings.startup["cbs-enable-consumption"].value
local enableBeaconEffects = enableSpeed or enableProductivity or enableQuality or enableConsumption or enablePollution
local cbsModuleSlots = settings.startup["cbs-module-slots"].value

local function tableContains(tbl, element)
    for _, value in ipairs(tbl) do
        if value == element then
            return true
        end
    end
    return false
end

local cbs = data.raw["assembling-machine"]["captive-biter-spawner"]
local cbsRecipe = data.raw["recipe"]["biter-egg"]

if enableBeaconEffects then
    if not cbs.effect_receiver then
        cbs.effect_receiver = {}
    end
    cbs.effect_receiver.uses_beacon_effects = true
end

--- Make sure allowed_effects is defined as a table
if enableBeaconEffects or cbsModuleSlots > 0 then
    if type(cbs.allowed_effects) == "string" then
        local new_allowed_effect = {}
        table.insert(new_allowed_effect, cbs.allowed_effects)
        cbs.allowed_effects = new_allowed_effect
    elseif cbs.allowed_effects == nil then
        cbs.allowed_effects = {}
    end
end

--- Enable allowed effects on the cbs from beacons
if enableSpeed and not tableContains(cbs.allowed_effects, "speed") then
    table.insert(cbs.allowed_effects, "speed")
    cbsRecipe.allow_speed = true
end
if enableProductivity and not tableContains(cbs.allowed_effects, "productivity") then
    table.insert(cbs.allowed_effects, "productivity")
    cbsRecipe.allow_productivity = true
end
if enableQuality and not tableContains(cbs.allowed_effects, "quality") then
    table.insert(cbs.allowed_effects, "quality")
    cbsRecipe.allow_quality = true
end
if enablePollution and not tableContains(cbs.allowed_effects, "pollution") then
    table.insert(cbs.allowed_effects, "pollution")
    cbsRecipe.allow_pollution = true
end
if enableConsumption and not tableContains(cbs.allowed_effects, "consumption") then
    table.insert(cbs.allowed_effects, "consumption")
    cbsRecipe.allow_consumption = true
end

--- Add modules and enable module effects
if cbsModuleSlots > 0 then
    if cbs.module_slots == nil then
        cbs.module_slots = 0
    end
    cbs.module_slots = cbs.module_slots + cbsModuleSlots
    cbs.effect_receiver.uses_module_effects = true

    if enableBeaconEffects then
        if not cbs.allowed_module_categories then
            cbs.allowed_module_categories = {}
        end
    end
    if enableSpeed and not tableContains(cbs.allowed_module_categories, "speed") then
        table.insert(cbs.allowed_module_categories, "speed")
    end
    if enableProductivity and not tableContains(cbs.allowed_module_categories, "productivity") then
        table.insert(cbs.allowed_module_categories, "productivity")
    end
    if enableQuality and not tableContains(cbs.allowed_module_categories, "quality") then
        table.insert(cbs.allowed_module_categories, "quality")
    end
    if enablePollution or enableConsumption and not tableContains(cbs.allowed_module_categories, "efficiency") then
        table.insert(cbs.allowed_module_categories, "efficiency")
    end
end
