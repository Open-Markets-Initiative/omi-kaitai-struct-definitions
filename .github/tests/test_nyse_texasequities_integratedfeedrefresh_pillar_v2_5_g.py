# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_texasequities_integratedfeedrefresh_pillar_v2_5_g import NyseTexasequitiesIntegratedfeedrefreshPillarV25G


class NyseTexasequitiesIntegratedfeedrefreshPillarV25GTests(unittest.TestCase):

    def test_addorderrefreshmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/TexasEquities.IntegratedFeedRefresh.Pillar.v2.5.g/AddOrderRefreshMessage.pcap"):
            parsed = NyseTexasequitiesIntegratedfeedrefreshPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_refreshheadermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/TexasEquities.IntegratedFeedRefresh.Pillar.v2.5.g/RefreshHeaderMessage.pcap"):
            parsed = NyseTexasequitiesIntegratedfeedrefreshPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/TexasEquities.IntegratedFeedRefresh.Pillar.v2.5.g/SecurityStatusMessage.pcap"):
            parsed = NyseTexasequitiesIntegratedfeedrefreshPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/TexasEquities.IntegratedFeedRefresh.Pillar.v2.5.g/SymbolIndexMappingMessage.pcap"):
            parsed = NyseTexasequitiesIntegratedfeedrefreshPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
