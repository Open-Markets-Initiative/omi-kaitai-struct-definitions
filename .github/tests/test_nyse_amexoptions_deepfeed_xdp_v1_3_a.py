# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_amexoptions_deepfeed_xdp_v1_3_a import NyseAmexoptionsDeepfeedXdpV13A


class NyseAmexoptionsDeepfeedXdpV13ATests(unittest.TestCase):

    def test_outrightmarketdepthbuymessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.DeepFeed.Xdp.v1.3.a/OutrightMarketDepthBuyMessage.pcap"):
            parsed = NyseAmexoptionsDeepfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_outrightmarketdepthsellmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.DeepFeed.Xdp.v1.3.a/OutrightMarketDepthSellMessage.pcap"):
            parsed = NyseAmexoptionsDeepfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_refreshoutrightmarketdepthbuymessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.DeepFeed.Xdp.v1.3.a/RefreshOutrightMarketDepthBuyMessage.pcap"):
            parsed = NyseAmexoptionsDeepfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_refreshoutrightmarketdepthsellmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.DeepFeed.Xdp.v1.3.a/RefreshOutrightMarketDepthSellMessage.pcap"):
            parsed = NyseAmexoptionsDeepfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_streamidmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.DeepFeed.Xdp.v1.3.a/StreamIdMessage.pcap"):
            parsed = NyseAmexoptionsDeepfeedXdpV13A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
