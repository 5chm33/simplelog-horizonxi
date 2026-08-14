--[[
* SimpleLog - HorizonXI compatibility build
* Original addon credits: Byrth, Spiken, Bee, Artoo, and Rags.
* Current compatibility maintenance: Schmeee.
* Licensed under GPLv3 or later.
--]]

addon.name      = 'simplelog';
addon.author    = 'Byrth, Spiken, Bee, Artoo, Rags; HorizonXI compatibility update by Schmeee';
addon.version   = '1.1.3-hxi.7';
addon.desc      = 'Combat log parser with restored reference cast warnings';
addon.link      = 'https://github.com/Spike2D/SimpleLog';

require('common');
require('lib\\constants');
chat                = require('chat');
UTF8toSJIS          = require('lib\\shift_jis');

res_actmsg          = require('lib\\res\\action_messages');
res_igramm          = require('lib\\res\\items_grammar');
res_skills          = require('lib\\res\\skills');

gDefaultSettings    = require('configuration');
gStatus             = require('lib\\profilehandler');
gFuncs              = require('lib\\functions');
gFileTools          = require('lib\\filetools');
gCommandHandlers    = require('lib\\commandhandlers');
gTextHandlers       = require('lib\\texthandlers');
gPacketHandlers     = require('lib\\packethandlers');
gActionHandlers     = require('lib\\actionhandlers');
gConfig             = require('lib\\ui');

gProfileSettings    = nil;
gProfileFilter      = nil;
gProfileColor       = nil;

gPriority           = require('configuration_priority');

-- This is the original GDI warning renderer used by the supplied working
-- SimpleLog reference.  Its loader has been made current-Ashita safe in
-- gdifonts/include.lua; no experimental renderer is used here.
local gdi            = require('gdifonts.include');
local settings       = require('settings');
local scaling        = require('scaling');

local screenCenter = {
    x = scaling.window.w / 2,
    y = scaling.window.h / 2,
};

local defaultWarningSettings = T{
    fade_after = 4,
    fade_duration = 1,
    font_spacing = 1.5,
    font_color_priority = 0xFFFFD700,
    font_color_priority_alt = 0xFF3F00FF,
    font_color_default = 0xFFFFFFFF,
    display_priority_only = false,
    use_alt_priority_font_color = false,
    font = {
        font_alignment = gdi.Alignment.Center,
        font_family = 'Consolas',
        font_flags = gdi.FontFlags.Bold,
        font_height = 36,
        outline_color = 0xFF000000,
        outline_width = 2,
    },
    x_offset = 0,
    y_offset = 50,
    hide_radar = false,
    hide_bg = false,
};

local loadedWarningSettings = nil;
local messages = {
    [1] = nil,
    [2] = nil,
    [3] = nil,
    [4] = nil,
    [5] = nil,
};

local function copy_table(source)
    local result = {};
    for key, value in pairs(source) do
        result[key] = value;
    end
    return result;
end

local function initialise_warnings()
    if not loadedWarningSettings then
        return;
    end

    for index = 1, 5 do
        local font = copy_table(loadedWarningSettings.font);
        font.position_x = screenCenter.x + loadedWarningSettings.x_offset;
        font.position_y = screenCenter.y - loadedWarningSettings.y_offset
            + (index - 1) * font.font_height * loadedWarningSettings.font_spacing;
        messages[index] = {
            fontobj = gdi:create_object(font),
            text = nil,
            expiry = nil,
        };
    end
end

local function update_warning_fade(message)
    if not message or not message.expiry or not loadedWarningSettings then
        return;
    end

    local elapsed = math.max(0, os.clock() - message.expiry);
    local alpha = math.max(0, 1 - (elapsed / loadedWarningSettings.fade_duration));
    message.fontobj:set_opacity(alpha);

    if alpha == 0 then
        message.expiry = nil;
        message.text = nil;
    end
end

-- Exposed for the packet/action handler.  Keeping this as a narrow accessor
-- prevents it from knowing anything about the renderer implementation.
function SimpleLogWarningQueue()
    return messages, loadedWarningSettings;
end

ashita.events.register('load', 'load_cb', function ()
    gStatus.Init();
    loadedWarningSettings = settings.load(defaultWarningSettings);
    initialise_warnings();
end);

ashita.events.register('unload', 'unload_cb', function ()
    gdi:destroy_interface();
    settings.save();
end);

ashita.events.register('text_in', 'text_in_cb', function (e)
    gTextHandlers.HandleIncomingText(e);
end);

ashita.events.register('packet_in', 'packet_in_cb', function (e)
    gPacketHandlers.HandleIncomingPacket(e, messages);
end);

ashita.events.register('packet_out', 'packet_out_cb', function (e)
    gPacketHandlers.HandleOutgoingPacket(e);
end);

ashita.events.register('command', 'command_cb', function (e)
    gCommandHandlers.HandleCommand(e);

    local args = e.command:lower():args();
    if (#args == 0 or args[1] ~= '/swarnings') then
        return;
    end

    e.blocked = true;

    if (#args == 4 and args[2]:any('pos')) then
        local x = tonumber(args[3]);
        local y = tonumber(args[4]);
        if x and y and loadedWarningSettings then
            loadedWarningSettings.x_offset = x;
            loadedWarningSettings.y_offset = y;
            for index = 1, 5 do
                local position_x = screenCenter.x + x;
                local position_y = screenCenter.y - y
                    + (index - 1) * loadedWarningSettings.font.font_height * loadedWarningSettings.font_spacing;
                messages[index].fontobj:set_position_x(position_x);
                messages[index].fontobj:set_position_y(position_y);
            end

            local expiry = os.clock() + loadedWarningSettings.fade_after;
            messages[1].fontobj:set_font_color(loadedWarningSettings.font_color_priority);
            messages[1].fontobj:set_text('Messages will be displayed here');
            messages[1].text = 'Messages will be displayed here';
            messages[1].expiry = expiry;
            messages[5].fontobj:set_font_color(loadedWarningSettings.font_color_priority);
            messages[5].fontobj:set_text('Have Fun!');
            messages[5].text = 'Have Fun!';
            messages[5].expiry = expiry;
            settings.save();
        end
        return;
    end

    if (#args == 2 and args[2]:any('font')) then
        loadedWarningSettings.use_alt_priority_font_color = not loadedWarningSettings.use_alt_priority_font_color;
        settings.save();
        print(chat.header('sWarnings') .. chat.message('Use Alternate Priority Font Colour: '
            .. tostring(loadedWarningSettings.use_alt_priority_font_color)));
        return;
    end

    if (#args == 2 and args[2]:any('prio')) then
        loadedWarningSettings.display_priority_only = not loadedWarningSettings.display_priority_only;
        settings.save();
        print(chat.header('sWarnings') .. chat.message('Display Priority Actions Only: '
            .. tostring(loadedWarningSettings.display_priority_only)));
        return;
    end

    print(chat.header('sWarnings') .. chat.message('/swarnings font - Toggle the alternate priority color'));
    print(chat.header('sWarnings') .. chat.message('/swarnings prio - Toggle priority-only display'));
    print(chat.header('sWarnings') .. chat.message('/swarnings pos [x_offset] [y_offset] - Reposition warning text'));
end);

ashita.events.register('d3d_present', 'd3d_present_callback1', function ()
    gConfig.render_config(gConfig.state.toggle_menu);
    gConfig.toggle_menu(0);

    for index = 1, 5 do
        update_warning_fade(messages[index]);
    end
end);

return {
    warning_queue = SimpleLogWarningQueue,
};
