# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_amexoptions_topfeed_xdp_v1_3_a import NyseAmexoptionsTopfeedXdpV13A


class NyseAmexoptionsTopfeedXdpV13ATests(unittest.TestCase):

    def test_messagesequence(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Xdp.v1.3.a/MessageSequence.pcap"):
            parsed = NyseAmexoptionsTopfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_outrightboldrfqmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Xdp.v1.3.a/OutrightBoldRfqMessage.pcap"):
            parsed = NyseAmexoptionsTopfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_outrightcrossingrfqmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Xdp.v1.3.a/OutrightCrossingRfqMessage.pcap"):
            parsed = NyseAmexoptionsTopfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_outrightquotemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Xdp.v1.3.a/OutrightQuoteMessage.pcap"):
            parsed = NyseAmexoptionsTopfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_outrightseriesstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Xdp.v1.3.a/OutrightSeriesStatusMessage.pcap"):
            parsed = NyseAmexoptionsTopfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_outrighttrademessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Xdp.v1.3.a/OutrightTradeMessage.pcap"):
            parsed = NyseAmexoptionsTopfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_refreshoutrightquotemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Xdp.v1.3.a/RefreshOutrightQuoteMessage.pcap"):
            parsed = NyseAmexoptionsTopfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_refreshoutrighttrademessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Xdp.v1.3.a/RefreshOutrightTradeMessage.pcap"):
            parsed = NyseAmexoptionsTopfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_streamidmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Xdp.v1.3.a/StreamIdMessage.pcap"):
            parsed = NyseAmexoptionsTopfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
