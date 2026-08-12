# SimpleLog for HorizonXI

SimpleLog is an **Ashita v4 combat and message log parser**. It replaces selected system-combat messages with cleaner, configurable output and can display enemy cast-start notifications in the middle of the screen.

> **Platform:** Ashita v4 / HorizonXI. SimpleLog is an addon: load it with `/addon load simplelog`.

## Compatibility Update — v1.1.3-hxi.3

This release repairs the incoming `0x28` action-packet parser for the current Ashita/HorizonXI packet layout and restores the visual enemy-cast alert through a direct Ashita font overlay. The alert is rendered by SimpleLog itself, so it no longer relies on the native client display behavior that changed after the HorizonXI update.

| Area | Compatibility change |
|---|---|
| Mob casting alerts | Renders a direct, no-box center-screen alert for enemy spell and ability starts; it no longer depends on the changed native client overlay path. |
| Combat and message log | Rebuilds action packets only after safe parsing, keeping SimpleLog’s existing log suppression and formatting behavior intact. |
| Unknown entities | Uses a safe monster fallback while an entity is still loading, rather than silently filtering the message. |
| Truncated packets | Fails closed instead of attempting to read outside packet data. |

## Features

- Configurable combat-log messages, filters, and colors.
- Damage and target condensation.
- Enemy spell and ability cast-start display.
- Crafting result preview.
- In-game configuration menu.

## Installation

1. Close HorizonXI.
2. Copy the `simplelog` folder into `HorizonXI\Game\addons\`.
3. Start HorizonXI and run:
   ```text
   /addon load simplelog
   ```
4. Run `/slog` or `/simplelog` to open the configuration menu.

## Commands

| Command | Result |
|---|---|
| `/slog` | Opens or closes the configuration menu. |
| `/simplelog` | Opens or closes the configuration menu. |

## Credits

SimpleLog is based on **Battlemod** by Byrth, ported to Ashita by Spiken, with subsequent work by Bee and Artoo for HorizonXI. The compatibility update in this distribution is maintained by **Schmeee**. Action-message parsing originated with Farmboy0, and resource files were created using the Windower Team's ResourceExtractor.

The original source and license are retained. Upstream project: [Spike2D/SimpleLog](https://github.com/Spike2D/SimpleLog).
