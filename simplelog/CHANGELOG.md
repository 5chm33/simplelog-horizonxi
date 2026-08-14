# Changelog

## v1.1.3-hxi.6 — TChat-Safe Stability Rollback

This corrective release removes the experimental direct GDI cast renderer because it could clear TChat content when the chat window was maximized or minimized.

| Component | Change |
|---|---|
| TChat safety | Detaches the experimental GDI renderer from SimpleLog’s load, packet, frame, and unload callbacks. SimpleLog no longer creates or renders its own Direct3D sprite resources. |
| Combat log | Retains the repaired current-client packet parser and normal SimpleLog log behavior. |
| Configuration menu | Retains the configuration-window stack and child-window stability corrections. |
| Enemy cast overlay | Deliberately disabled in this stable release while a TChat-safe implementation is researched; this avoids corrupting or clearing the chat window. |

## v1.1.3-hxi.5 — Load-Safe GDI Renderer

This corrective update fixes the startup crash introduced by v1.1.3-hxi.4.

| Component | Change |
|---|---|
| Startup safety | Stops the bundled GDI font loader from calling `debug.getinfo` after legacy SimpleLog code reuses the global name `debug` as a boolean setting. |
| GDI path resolution | Uses the stable Ashita `addon.path` to resolve the bundled `gdifonts` files and native renderer DLL. |
| Alert behavior | Retains the styled cast alert, actor-name retry, repaired packet parser, and configuration-menu stability fixes from v1.1.3-hxi.4. |

## v1.1.3-hxi.4 — Styled Cast Alert and Menu Stability

This corrective update replaces the experimental plain white fallback from v1.1.3-hxi.3 with a styled SimpleLog alert and repairs the configuration window’s ImGui stack handling.

| Component | Change |
|---|---|
| Alert style | Uses the bundled GDI renderer: centered alignment, blue gradient, dark outline, bold text, and no background box. |
| Actor resolution | Parses the untouched action packet with the current Ashita bitreader and resolves names through entity memory; briefly retries for loading entities instead of showing `{Unknown:<id>}`. |
| Action resolution | Reads the action-start command argument directly, avoiding the legacy parser’s unreliable per-target value. |
| Configuration menu | Removes unbalanced text-wrap/tree stack operations, balances window styling on collapsed frames, and uses the current `BeginChild` signature. |

## v1.1.3-hxi.3 — Direct Enemy Cast Overlay

This corrective update stops relying on the native HorizonXI cast display entirely. SimpleLog now draws its own **no-box center-screen alert** with Ashita’s fonts API when an enemy begins a spell or ability.

| Component | Change |
|---|---|
| On-screen alert | Added a direct no-box font overlay: `Mob Name > Spell or Ability`. |
| Trigger source | Uses parsed enemy action-start categories for monster abilities, magic, and job abilities. |
| Log behavior | Keeps the repaired SimpleLog chat log and existing packet suppression unchanged. |
| Lifetime | Each alert remains visible for 3.5 seconds, then clears automatically. |

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

## v1.1.3-hxi.7 — Reference-Based Warning Restoration

- Restored the original five-slot GDI warning queue from the supplied working Rags/SimpleLog reference build.
- Restored the original centered layout, bold outlined font, fade timing, priority colors, queue de-duplication, and `/swarnings` commands.
- Preserved the current HorizonXI six-bit action packet header parser instead of restoring the obsolete historical ten-bit parser.
- Restored the `is_monster` actor classification used by the original warning eligibility gate.
- Restored the **Disable UI Warnings** checkbox using the current menu's stack-safe ImGui structure.
- Retained the GDI loader's `addon.path` resolution to avoid the legacy `debug` boolean startup crash.
- Removed all dependencies on the experimental direct cast-alert module from earlier compatibility builds.
