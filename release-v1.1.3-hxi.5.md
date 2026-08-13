## SimpleLog v1.1.3-hxi.5 — Load-Safe GDI Renderer

This is a focused startup-crash correction for `v1.1.3-hxi.4`.

> **Important:** This is a HorizonXI compatibility distribution of [Spike2D's SimpleLog](https://github.com/Spike2D/SimpleLog), not an official upstream release. Original credits and licenses are preserved.

### Fixed

- Fixes the load-time error:
  ```text
  addons\libs\sugar\boolean.lua:133: Boolean type does not contain a definition for: getinfo
  ```
- The crash occurred because SimpleLog’s legacy constants set the global `debug` name to a boolean, while the bundled GDI renderer attempted to access the debug library during startup.
- The GDI renderer now resolves its own files through Ashita’s stable `addon.path`, avoiding that global-name conflict completely.
- Retains the styled cast alert, actor lookup retry, repaired combat log, and configuration-menu stability fixes from `v1.1.3-hxi.4`.

### Installation

1. Close HorizonXI.
2. Download and extract this release zip.
3. Replace `HorizonXI\Game\addons\simplelog\` with the included `simplelog` folder.
4. Start HorizonXI and run:
   ```text
   /addon load simplelog
   ```
