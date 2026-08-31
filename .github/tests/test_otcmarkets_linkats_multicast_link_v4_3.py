# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from otcmarkets_linkats_multicast_link_v4_3 import OtcmarketsLinkatsMulticastLinkV43


class OtcmarketsLinkatsMulticastLinkV43Tests(unittest.TestCase):

    def test_endofspin12(self):
        for payload in payloads.of("omi-data-packets/OtcMarkets/LinkAts.Multicast.Link.v4.3/EndOfSpin.12.pcap"):
            parsed = OtcmarketsLinkatsMulticastLinkV43.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/OtcMarkets/LinkAts.Multicast.Link.v4.3/Heartbeat.pcap"):
            parsed = OtcmarketsLinkatsMulticastLinkV43.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketclose14(self):
        for payload in payloads.of("omi-data-packets/OtcMarkets/LinkAts.Multicast.Link.v4.3/MarketClose.14.pcap"):
            parsed = OtcmarketsLinkatsMulticastLinkV43.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketopen13(self):
        for payload in payloads.of("omi-data-packets/OtcMarkets/LinkAts.Multicast.Link.v4.3/MarketOpen.13.pcap"):
            parsed = OtcmarketsLinkatsMulticastLinkV43.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quote1(self):
        for payload in payloads.of("omi-data-packets/OtcMarkets/LinkAts.Multicast.Link.v4.3/Quote.1.pcap"):
            parsed = OtcmarketsLinkatsMulticastLinkV43.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quoteupdate2(self):
        for payload in payloads.of("omi-data-packets/OtcMarkets/LinkAts.Multicast.Link.v4.3/QuoteUpdate.2.pcap"):
            parsed = OtcmarketsLinkatsMulticastLinkV43.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_security9(self):
        for payload in payloads.of("omi-data-packets/OtcMarkets/LinkAts.Multicast.Link.v4.3/Security.9.pcap"):
            parsed = OtcmarketsLinkatsMulticastLinkV43.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_startofspin11(self):
        for payload in payloads.of("omi-data-packets/OtcMarkets/LinkAts.Multicast.Link.v4.3/StartOfSpin.11.pcap"):
            parsed = OtcmarketsLinkatsMulticastLinkV43.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
