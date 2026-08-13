--[[
* SimpleLog - HorizonXI enemy cast alert.
*
* Renders a styled, no-box alert through SimpleLog's bundled GDI font system.
* Actor names are resolved from Ashita entity memory and unresolved actions are
* retried briefly instead of displaying an incorrect {Unknown:<id>} placeholder.
--]]

local bitreader = require('bitreader')
local gdifonts  = require('gdifonts\\include')

local castalert = {
    font_object = nil,
    expires_at = 0,
    pending = nil,
}

local ALERT_DURATION = 3.5
local RETRY_DURATION = 1.5

local function get_screen_center()
    local x, y = 640, 350
    local ok, imgui = pcall(require, 'imgui')
    if ok and imgui and imgui.GetIO then
        local success, io = pcall(imgui.GetIO)
        if success and io and io.DisplaySize and io.DisplaySize.x and io.DisplaySize.y then
            x = io.DisplaySize.x * 0.5
            y = io.DisplaySize.y * 0.36
        end
    end
    return x, y
end

local function find_actor_name(server_id)
    local entity = AshitaCore:GetMemoryManager():GetEntity()
    if not entity then return nil end

    for index = 0, 2303 do
        if entity:GetServerId(index) == server_id then
            local name = entity:GetName(index)
            if name and name ~= '' then return name end
        end
    end
    return nil
end

local function find_action_name(category, action_id)
    local resources = AshitaCore:GetResourceManager()
    if not resources then return nil end

    local id = bit.band(action_id, 0xFFFF)
    local resource = nil
    if category == 8 then
        resource = resources:GetSpellById(id)
    elseif category == 10 then
        resource = resources:GetAbilityById(id)
    end

    if resource and resource.Name then
        return resource.Name[2] or resource.Name[1]
    end

    if category == 7 then
        return resources:GetString('monsters.abilities', id, 2)
    end
    return nil
end

local function display_action(server_id, category, action_id)
    local actor_name = find_actor_name(server_id)
    local action_name = find_action_name(category, action_id)
    if not actor_name or not action_name or action_name == '' then
        return false
    end

    if castalert.font_object == nil then return false end
    local x, y = get_screen_center()
    castalert.font_object:set_position_x(x)
    castalert.font_object:set_position_y(y)
    castalert.font_object:set_text(string.format('%s  >  %s', actor_name, action_name))
    castalert.expires_at = os.clock() + ALERT_DURATION
    castalert.pending = nil
    return true
end

function castalert.initialize()
    if castalert.font_object ~= nil then
        gdifonts:destroy_object(castalert.font_object)
        castalert.font_object = nil
    end

    local x, y = get_screen_center()
    castalert.font_object = gdifonts:create_object({
        visible         = true,
        font_family     = 'Arial',
        font_height     = 30,
        font_flags      = gdifonts.FontFlags.Bold,
        font_alignment  = gdifonts.Alignment.Center,
        font_color      = 0xFFE5F7FF,
        gradient_color  = 0xFF4B9DCC,
        gradient_style  = gdifonts.Gradient.TopToBottom,
        outline_color   = 0xFF07131C,
        outline_width   = 3,
        position_x      = x,
        position_y      = y,
        text            = '',
        z_order         = 100,
    })
    castalert.expires_at = 0
    castalert.pending = nil
end

function castalert.observe_action_packet(packet)
    if not packet or string.byte(packet) ~= 0x28 then return end

    local ok, actor_id, category, action_id = pcall(function()
        local reader = bitreader:new()
        reader:set_data(packet)
        reader:set_pos(5)
        local id = reader:read(32)
        reader:read(6)  -- target count
        reader:read(4)  -- result count
        local cat = reader:read(4)
        local arg = reader:read(32)
        return id, cat, arg
    end)

    if not ok or not actor_id or (category ~= 7 and category ~= 8 and category ~= 10) then
        return
    end

    if not display_action(actor_id, category, action_id) then
        castalert.pending = {
            actor_id = actor_id,
            category = category,
            action_id = action_id,
            expires_at = os.clock() + RETRY_DURATION,
        }
    end
end

function castalert.tick()
    if castalert.pending then
        if os.clock() >= castalert.pending.expires_at then
            castalert.pending = nil
        else
            display_action(castalert.pending.actor_id, castalert.pending.category, castalert.pending.action_id)
        end
    end

    if castalert.font_object ~= nil and castalert.expires_at > 0 and os.clock() >= castalert.expires_at then
        castalert.font_object:set_text('')
        castalert.expires_at = 0
    end
end

function castalert.destroy()
    if castalert.font_object ~= nil then
        gdifonts:destroy_object(castalert.font_object)
        castalert.font_object = nil
    end
    castalert.pending = nil
    castalert.expires_at = 0
end

return castalert
