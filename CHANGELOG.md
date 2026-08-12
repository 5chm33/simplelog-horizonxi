# Changelog

## v1.1.3-hxi.1 — HorizonXI ToAU Compatibility

This maintenance update restores action-driven output that could disappear after the current HorizonXI/Ashita client update.

| Component | Change |
|---|---|
| `0x28` action parser | Corrected the action header: the target count is a 6-bit value, followed by a separate 4-bit header field. |
| Mob cast notifications | Cast-start actions now parse with the correct target boundary and can reach SimpleLog's normal message formatter. |
| Combat log output | Removed unnecessary action-packet rewriting; SimpleLog now observes the packet locally instead of writing a rebuilt packet back to Ashita. |
| Safe parsing | Added bounds checks for target and result sections, so incomplete data is ignored safely. |
| Entity fallback | Restored a classified monster fallback while entity data is still loading, preventing the filter layer from silently dropping the message. |

## Credits

SimpleLog remains the work of its original authors: Byrth, Spiken, Bee, and Artoo. This HorizonXI compatibility maintenance update was prepared by Schmeee.
