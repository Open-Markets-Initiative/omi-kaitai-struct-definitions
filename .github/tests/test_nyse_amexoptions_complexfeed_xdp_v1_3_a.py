# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_amexoptions_complexfeed_xdp_v1_3_a import NyseAmexoptionsComplexfeedXdpV13A


class NyseAmexoptionsComplexfeedXdpV13ATests(unittest.TestCase):

    def test_complexcrossingrfqmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.ComplexFeed.Xdp.v1.3.a/ComplexCrossingRfqMessage.pcap"):
            parsed = NyseAmexoptionsComplexfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_complexquotemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.ComplexFeed.Xdp.v1.3.a/ComplexQuoteMessage.pcap"):
            parsed = NyseAmexoptionsComplexfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_complexstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.ComplexFeed.Xdp.v1.3.a/ComplexStatusMessage.pcap"):
            parsed = NyseAmexoptionsComplexfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_complexsymboldefinitionmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.ComplexFeed.Xdp.v1.3.a/ComplexSymbolDefinitionMessage.pcap"):
            parsed = NyseAmexoptionsComplexfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_complextrademessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.ComplexFeed.Xdp.v1.3.a/ComplexTradeMessage.pcap"):
            parsed = NyseAmexoptionsComplexfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_refreshcomplexquotemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.ComplexFeed.Xdp.v1.3.a/RefreshComplexQuoteMessage.pcap"):
            parsed = NyseAmexoptionsComplexfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_refreshcomplextrademessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.ComplexFeed.Xdp.v1.3.a/RefreshComplexTradeMessage.pcap"):
            parsed = NyseAmexoptionsComplexfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_streamidmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.ComplexFeed.Xdp.v1.3.a/StreamIdMessage.pcap"):
            parsed = NyseAmexoptionsComplexfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
