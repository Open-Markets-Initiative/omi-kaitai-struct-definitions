# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from miax_miaxoptions_complextopofmarket_mach_v1_1 import MiaxMiaxoptionsComplextopofmarketMachV11


class MiaxMiaxoptionsComplextopofmarketMachV11Tests(unittest.TestCase):

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Miax/MiaxOptions.ComplexTopOfMarket.Mach.v1.1/Heartbeat.pcap"):
            parsed = MiaxMiaxoptionsComplextopofmarketMachV11.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Miax/MiaxOptions.ComplexTopOfMarket.Mach.v1.1/SystemStatusMessage.pcap"):
            parsed = MiaxMiaxoptionsComplextopofmarketMachV11.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
