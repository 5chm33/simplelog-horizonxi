"""Offline regression fixtures for the HorizonXI 0x28 six-bit action header.

These fixtures intentionally exercise the documented wire-layout boundary without
starting Ashita, a game client, packet injection, or any external service.
"""
from pathlib import Path
import unittest

ROOT = Path(__file__).parents[1]
SOURCE = (ROOT / "simplelog/lib/actionhandlers.lua").read_text()


def put(bits, offset, width, value):
    for i in range(width):
        bits[offset + i] = (value >> (width - 1 - i)) & 1


def packet(target_count, result_count=3, size=64):
    bits = [0] * (size * 8)
    put(bits, 0, 8, 0x28)
    put(bits, 32, 8, size)
    put(bits, 40, 32, 0x12345678)
    put(bits, 72, 6, target_count)
    put(bits, 78, 4, result_count)
    put(bits, 82, 4, 1)
    put(bits, 86, 16, 0x55)
    put(bits, 118, 32, 0x1234)
    return bits


def read(bits, offset, width, total_bits=None):
    total_bits = len(bits) if total_bits is None else total_bits
    if offset < 0 or width < 1 or offset + width > total_bits:
        return None
    value = 0
    for bit in bits[offset : offset + width]:
        value = (value << 1) | bit
    return value


class ActionHeaderFixtures(unittest.TestCase):
    def test_six_bit_target_count_is_separate_from_four_bit_result_count(self):
        bits = packet(0x2A, result_count=0xB)
        self.assertEqual(read(bits, 72, 6), 0x2A)
        self.assertEqual(read(bits, 78, 4), 0xB)
        self.assertNotEqual(read(bits, 72, 10), 0x2A)

    def test_zero_targets_and_maximum_six_bit_count_are_representable(self):
        self.assertEqual(read(packet(0), 72, 6), 0)
        self.assertEqual(read(packet(0x3F), 72, 6), 0x3F)

    def test_truncated_header_and_target_record_fail_closed(self):
        bits = packet(1, size=19)  # 152 bits: header exists, target record does not.
        self.assertGreaterEqual(len(bits), 150)
        self.assertIsNone(read(bits, 150, 36))
        self.assertIsNone(read(bits, 151, 2))

    def test_lua_source_retains_bounds_and_field_width_guards(self):
        self.assertIn("read(72, 6)", SOURCE)
        self.assertIn("read(78, 4)", SOURCE)
        self.assertIn("if total_bits < 150 then", SOURCE)
        self.assertIn("if (offset + 36) > total_bits then", SOURCE)
        self.assertIn("if (offset + 87) > total_bits then", SOURCE)


if __name__ == "__main__":
    unittest.main()
