--[[
* SimpleLog - Native-style enemy cast alert overlay.
*
* This module intentionally renders its own no-box text instead of relying on
* the game client to recreate the historical action-message overlay.  The
* combat-log parser remains independent of this visual alert.
--]]

local fonts = require('fonts')

local castalert = {
    font_object = nil,
    expires_at = 0,
}

local ALERT_DURATION = 3.5

function castalert.initialize()
    if castalert.font_object ~= nil then
        castalert.font_object:destroy()
        castalert.font_object = nil
    end

    castalert.font_object = fonts.new({
        visible       = true,
        font_family   = 'Arial',
        font_height   = 34,
        bold          = true,
        color         = 0xFFFFFFFF,
        color_outline = 0xFF000000,
        position_x    = 760,
        position_y    = 335,
        background    = { visible = false },
    })
    castalert.font_object:SetText('')
    castalert.expires_at = 0
end

function castalert.show(actor_name, action_name)
    if castalert.font_object == nil or not actor_name or not action_name then
        return
    end

    castalert.font_object.color = 0xFFFFFFFF
    castalert.font_object:SetText(string.format('%s > %s', actor_name, action_name))
    castalert.expires_at = os.clock() + ALERT_DURATION
end

-- Resolve the action name directly from the resource manager.  This keeps the
-- visual alert independent from any downstream combat-log formatting failures.
function castalert.show_action(actor_name, category, action_id, language_index)
    if not actor_name or not action_id then
        return
    end

    local resource_manager = AshitaCore:GetResourceManager()
    if not resource_manager then
        return
    end

    local action_name = nil
    local resource = nil
    if category == 8 then
        resource = resource_manager:GetSpellById(action_id)
    else
        resource = resource_manager:GetAbilityById(action_id)
    end

    if resource and resource.Name then
        action_name = resource.Name[language_index] or resource.Name[2] or resource.Name[1]
    end

    -- Monster abilities do not always have a normal ability resource record.
    if (not action_name or action_name == '') and category == 7 then
        action_name = resource_manager:GetString('monsters.abilities', action_id, language_index)
    end

    if action_name and action_name ~= '' then
        castalert.show(actor_name, action_name)
    end
end

function castalert.tick()
    if castalert.font_object ~= nil and castalert.expires_at > 0 and os.clock() >= castalert.expires_at then
        castalert.font_object:SetText('')
        castalert.expires_at = 0
    end
end

function castalert.destroy()
    if castalert.font_object ~= nil then
        castalert.font_object:destroy()
        castalert.font_object = nil
    end
    castalert.expires_at = 0
end

return castalert
