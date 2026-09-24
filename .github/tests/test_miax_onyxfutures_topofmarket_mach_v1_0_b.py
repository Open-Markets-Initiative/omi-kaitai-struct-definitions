# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from miax_onyxfutures_topofmarket_mach_v1_0_b import MiaxOnyxfuturesTopofmarketMachV10B


class MiaxOnyxfuturesTopofmarketMachV10BTests(unittest.TestCase):

    def test_bestbidandoffermessage(self):
        for payload in payloads.of("omi-data-packets/Miax/OnyxFutures.TopOfMarket.Mach.v1.0.b/BestBidAndOfferMessage.pcap"):
            parsed = MiaxOnyxfuturesTopofmarketMachV10B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Miax/OnyxFutures.TopOfMarket.Mach.v1.0.b/Heartbeat.pcap"):
            parsed = MiaxOnyxfuturesTopofmarketMachV10B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_instrumenttradingstatusnotificationmessage(self):
        for payload in payloads.of("omi-data-packets/Miax/OnyxFutures.TopOfMarket.Mach.v1.0.b/InstrumentTradingStatusNotificationMessage.pcap"):
            parsed = MiaxOnyxfuturesTopofmarketMachV10B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemstatemessage(self):
        for payload in payloads.of("omi-data-packets/Miax/OnyxFutures.TopOfMarket.Mach.v1.0.b/SystemStateMessage.pcap"):
            parsed = MiaxOnyxfuturesTopofmarketMachV10B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
