# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from otcmarkets_linkats_multicast_link_v4_3 import OtcmarketsLinkatsMulticastLinkV43


class OtcmarketsLinkatsMulticastLinkV43Tests(unittest.TestCase):

    def test_endofspinmessage(self):
        for payload in payloads.of("omi-data-packets/OtcMarkets/LinkAts.Multicast.Link.v4.3/EndOfSpinMessage.pcap"):
            parsed = OtcmarketsLinkatsMulticastLinkV43.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/OtcMarkets/LinkAts.Multicast.Link.v4.3/Heartbeat.pcap"):
            parsed = OtcmarketsLinkatsMulticastLinkV43.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketclosemessage(self):
        for payload in payloads.of("omi-data-packets/OtcMarkets/LinkAts.Multicast.Link.v4.3/MarketCloseMessage.pcap"):
            parsed = OtcmarketsLinkatsMulticastLinkV43.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketopenmessage(self):
        for payload in payloads.of("omi-data-packets/OtcMarkets/LinkAts.Multicast.Link.v4.3/MarketOpenMessage.pcap"):
            parsed = OtcmarketsLinkatsMulticastLinkV43.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quotemessage(self):
        for payload in payloads.of("omi-data-packets/OtcMarkets/LinkAts.Multicast.Link.v4.3/QuoteMessage.pcap"):
            parsed = OtcmarketsLinkatsMulticastLinkV43.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quoteupdatemessage(self):
        for payload in payloads.of("omi-data-packets/OtcMarkets/LinkAts.Multicast.Link.v4.3/QuoteUpdateMessage.pcap"):
            parsed = OtcmarketsLinkatsMulticastLinkV43.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitymessage(self):
        for payload in payloads.of("omi-data-packets/OtcMarkets/LinkAts.Multicast.Link.v4.3/SecurityMessage.pcap"):
            parsed = OtcmarketsLinkatsMulticastLinkV43.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_startofspinmessage(self):
        for payload in payloads.of("omi-data-packets/OtcMarkets/LinkAts.Multicast.Link.v4.3/StartOfSpinMessage.pcap"):
            parsed = OtcmarketsLinkatsMulticastLinkV43.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
