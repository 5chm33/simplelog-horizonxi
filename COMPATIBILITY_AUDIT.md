# SimpleLog HorizonXI ToAU Compatibility Audit

## Scope

The supplied SimpleLog build is a Horizon-oriented fork of Spike2D/SimpleLog. Its primary combat output path is the incoming `0x28` action packet handler, which feeds formatted cast-start and cast-completion messages to the chat log.

## Root Cause

The supplied parser reads the `0x28` header field at bit offset 72 as a single 10-bit `target_count`. Current Ashita's maintained `actionparse` parser identifies this header as two separate fields: a **6-bit target count** followed by a **4-bit result/header field**. Treating both fields as a target count causes the parser to iterate past the packet's actual targets whenever the high four bits are non-zero. It then produces invalid action records, which prevents normal message rendering and can suppress mob cast-start messages.

## Related Hardening Fixes

The fork also has two fragile behaviors that can hide output instead of producing a usable fallback.

| Area | Existing behavior | Fix |
|---|---|---|
| Action packet callback | Rebuilds and writes `e.data_modified` even though SimpleLog is only observing the action packet. | Parse locally without modifying the packet seen by the game or other addons. |
| Unknown actor/target lookup | Returns an actor object without `filter` metadata. `CheckFilter` then silently rejects the message. | Restore the upstream fallback actor classification so visible output is retained while entity data is still loading. |
| Action parsing | No header/target bounds validation. | Validate packet header data and stop safely on malformed or truncated action records. |

## Verification Basis

The corrected header layout follows the current Ashita v4 `actionparse/parser.lua` implementation: bit 72 contains `trg_sum` for 6 bits and bit 78 contains the next 4-bit header value. The base action payload begins after bit 150, as in both the maintained parser and SimpleLog.

