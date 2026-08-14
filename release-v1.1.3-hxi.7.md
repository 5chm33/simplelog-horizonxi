# SimpleLog v1.1.3-hxi.7 — Reference-Based Warning Restoration

This release restores the original graceful cast-warning display from the supplied working SimpleLog reference build while preserving the current HorizonXI ToAU action-packet compatibility fix.

## Restored behavior

The addon again uses the original five-slot centered GDI warning queue. Monster spells and abilities appear in the established bold, outlined, fading format with the original priority colors, de-duplication behavior, fade timing, and `/swarnings` commands.

## Compatibility safeguards

The current six-bit ToAU action-header parser remains in use; the obsolete historical ten-bit parser was not restored. The renderer is the same implementation used by the working reference, except its loader resolves files through `addon.path` so it cannot crash after legacy SimpleLog sets the global `debug` value to a Boolean. The prior experimental direct-renderer module remains absent.

The general settings menu includes a **Disable UI Warnings** toggle and retains the previously corrected child-window and ImGui stack behavior.

## Installation

Close HorizonXI, replace `HorizonXI\Game\addons\simplelog\` with the `simplelog` directory from the archive, then run:

```text
/addon load simplelog
```

Use `/slog` to open the menu. Use `/swarnings pos X Y` to reposition the warning stack, `/swarnings prio` for priority-only output, and `/swarnings font` to toggle the alternate priority color.
