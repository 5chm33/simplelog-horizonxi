#!/usr/bin/env python3
"""Validate that the checked-in Ashita distribution has one canonical runtime tree."""
from pathlib import Path
import hashlib
import sys

ROOT = Path(__file__).resolve().parents[1]
PACKAGE = ROOT / "simplelog"
REQUIRED = ["simplelog.lua", "lib/actionhandlers.lua", "lib/packethandlers.lua", "README.md"]

missing = [name for name in REQUIRED if not (PACKAGE / name).is_file()]
if missing:
    print("missing canonical package files:", ", ".join(missing), file=sys.stderr)
    raise SystemExit(1)

# Runtime files must only exist below the installable package directory.
for path in ROOT.iterdir():
    if path.name in {".git", "simplelog", "scripts", "tests"} or path.name.endswith(".md") or path.name in {"LICENSE"}:
        continue
    if path.is_file() or path.is_dir():
        print(f"unexpected root runtime copy: {path.relative_to(ROOT)}", file=sys.stderr)
        raise SystemExit(1)

print("canonical package: simplelog/")
for name in REQUIRED:
    digest = hashlib.sha256((PACKAGE / name).read_bytes()).hexdigest()[:12]
    print(f"{name}: {digest}")
