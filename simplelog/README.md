# SimpleLog for HorizonXI

SimpleLog is an **Ashita v4 combat and message log parser**. It replaces selected system-combat messages with cleaner, configurable output and can display enemy cast-start notifications in the middle of the screen.

> **Platform:** Ashita v4 / HorizonXI. SimpleLog is an addon: load it with `/addon load simplelog`.

## Compatibility Update — v1.1.3-hxi.7

This release restores the **original five-line, centered, fading cast-warning display** from the supplied working SimpleLog reference. It does not use the experimental renderer from prior compatibility builds. The original GDI warning queue, colors, outline, fade behavior, priority list, and `/swarnings` controls are restored, while the corrected current-Horizon six-bit action-header parser remains in place.

| Area | Compatibility change |
|---|---|
| Cast warnings | Restores the reference five-slot centered fade display for monster spells and abilities. |
| Current Horizon packets | Keeps the current six-bit target-count action parser; the historical ten-bit parser is not restored. |
| TChat safety | Uses the same GDI rendering lifecycle as the supplied working reference, with only the loader-path change required to avoid the legacy `debug` boolean startup crash. |
| Configuration menu | Retains the corrected child-window and ImGui stack behavior and restores a **Disable UI Warnings** toggle. |
| Combat and message log | Keeps the repaired packet parsing, existing log suppression, and message formatting intact. |
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
| `/swarnings pos X Y` | Moves the centered warning stack by an X/Y offset and previews it. |
| `/swarnings prio` | Toggles priority-only warning display. |
| `/swarnings font` | Toggles the alternate priority warning color. |

## Credits

SimpleLog is based on **Battlemod** by Byrth, ported to Ashita by Spiken, with subsequent work by Bee and Artoo for HorizonXI. The compatibility update in this distribution is maintained by **Schmeee**. Action-message parsing originated with Farmboy0, and resource files were created using the Windower Team's ResourceExtractor.

The original source and license are retained. Upstream project: [Spike2D/SimpleLog](https://github.com/Spike2D/SimpleLog).
