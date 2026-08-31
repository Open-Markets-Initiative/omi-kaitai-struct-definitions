# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nyseequities_integratedfeed_xdp_v2_3_a import NyseNyseequitiesIntegratedfeedXdpV23A


class NyseNyseequitiesIntegratedfeedXdpV23ATests(unittest.TestCase):

    def test_addorderrefreshmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.IntegratedFeed.Xdp.v2.3.a/AddOrderRefreshMessage.pcap"):
            parsed = NyseNyseequitiesIntegratedfeedXdpV23A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_refreshheadermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.IntegratedFeed.Xdp.v2.3.a/RefreshHeaderMessage.pcap"):
            parsed = NyseNyseequitiesIntegratedfeedXdpV23A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.IntegratedFeed.Xdp.v2.3.a/SecurityStatusMessage.pcap"):
            parsed = NyseNyseequitiesIntegratedfeedXdpV23A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.IntegratedFeed.Xdp.v2.3.a/SymbolIndexMappingMessage.pcap"):
            parsed = NyseNyseequitiesIntegratedfeedXdpV23A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
