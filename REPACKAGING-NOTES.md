# Repackaging Notes

This repository is a **HorizonXI compatibility distribution** of the [Spike2D/SimpleLog](https://github.com/Spike2D/SimpleLog) Ashita v4 addon.

It is **not an official upstream repository** and does not claim to replace SimpleLog or its original authors. The purpose of this repository is to provide a documented, shareable compatibility build for HorizonXI players after the ToAU client update.

## Changes in This Distribution

The v1.1.3-hxi.1 update corrects the `0x28` action-packet header parsing, removes unnecessary packet rewriting during observation, and prevents unresolved entity data from being silently discarded by the filter layer. These changes restore mob cast-start notifications and normal action-log formatting.

## Credits and License

SimpleLog is based on Battlemod by Byrth and was ported to Ashita by Spiken, with subsequent updates by Bee and Artoo for HorizonXI. The HorizonXI compatibility maintenance update is by **Schmeee**.

The original GPLv3 license is retained in `LICENSE`. The included `gdifonts` component retains its own license in `gdifonts/LICENSE`. General feature requests and upstream bugs should be directed to the original [SimpleLog project](https://github.com/Spike2D/SimpleLog).
