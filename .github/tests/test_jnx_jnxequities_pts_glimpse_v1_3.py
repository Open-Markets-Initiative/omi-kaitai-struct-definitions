# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from jnx_jnxequities_pts_glimpse_v1_3_client import JnxJnxequitiesPtsGlimpseV13Client
from jnx_jnxequities_pts_glimpse_v1_3_server import JnxJnxequitiesPtsGlimpseV13Server


class JnxJnxequitiesPtsGlimpseV13ServerTests(unittest.TestCase):

    def test_loginacceptedpacket(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Glimpse.v1.3/LoginAcceptedPacket.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = JnxJnxequitiesPtsGlimpseV13Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginrequestpacket(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Glimpse.v1.3/LoginRequestPacket.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = JnxJnxequitiesPtsGlimpseV13Client.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderbookdirectorymessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Glimpse.v1.3/OrderbookDirectoryMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = JnxJnxequitiesPtsGlimpseV13Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_priceticksizemessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Glimpse.v1.3/PriceTickSizeMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = JnxJnxequitiesPtsGlimpseV13Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_secondsmessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Glimpse.v1.3/SecondsMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = JnxJnxequitiesPtsGlimpseV13Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Glimpse.v1.3/SystemEventMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = JnxJnxequitiesPtsGlimpseV13Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
