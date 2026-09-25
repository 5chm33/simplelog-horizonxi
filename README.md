# SimpleLog for HorizonXI

## Canonical source and packaging

The installable addon and **single canonical runtime source** are under [`simplelog/`](simplelog/). The repository root intentionally contains no second runtime tree: this prevents fixes from landing in an unshipped copy. Install by copying the complete `simplelog/` directory into Ashita's `addons` directory.

Run `python3 scripts/validate_package.py` to verify the expected package layout. Offline parser fixtures are in `tests/test_action_packet_parser.py` and run with `python3 -m unittest discover -s tests`.

This is a HorizonXI compatibility distribution, not an official upstream release. SimpleLog is based on Battlemod by Byrth, was ported to Ashita by Spiken, and includes subsequent work by Bee and Artoo; HorizonXI compatibility maintenance is by Schmeee. See [`simplelog/README.md`](simplelog/README.md) and [`REPACKAGING-NOTES.md`](REPACKAGING-NOTES.md) for attribution and licensing details.
