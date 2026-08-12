# Changelog

## v1.1.3-hxi.2 — Native Cast Alert Restoration

This follow-up restores the separate **native center-screen enemy cast alert** while retaining the repaired SimpleLog combat log.

| Component | Change |
|---|---|
| Native cast display | Preserves action messages `3`, `327`, and `716` in the reconstructed `0x28` packet so HorizonXI can draw its center-screen casting alert. |
| Combat log | Retains the corrected 6-bit target-count parser and existing SimpleLog formatting / suppression behavior. |
| Casting filter | Applies the existing **Casting** filter consistently to message `716` as well. |

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
