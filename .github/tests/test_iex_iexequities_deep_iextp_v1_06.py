# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from iex_iexequities_deep_iextp_v1_06 import IexIexequitiesDeepIextpV106


class IexIexequitiesDeepIextpV106Tests(unittest.TestCase):

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.v1.0/Heartbeat.pcap"):
            parsed = IexIexequitiesDeepIextpV106.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_pricelevelbuyupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.v1.0/PriceLevelBuyUpdateMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV106.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_pricelevelsellupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.v1.0/PriceLevelSellUpdateMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV106.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
