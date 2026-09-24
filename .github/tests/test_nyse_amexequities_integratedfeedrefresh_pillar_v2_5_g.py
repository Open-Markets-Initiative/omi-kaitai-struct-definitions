# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_amexequities_integratedfeedrefresh_pillar_v2_5_g import NyseAmexequitiesIntegratedfeedrefreshPillarV25G


class NyseAmexequitiesIntegratedfeedrefreshPillarV25GTests(unittest.TestCase):

    def test_addorderrefreshmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.IntegratedFeedRefresh.Pillar.v2.5.g/AddOrderRefreshMessage.pcap"):
            parsed = NyseAmexequitiesIntegratedfeedrefreshPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_imbalancemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.IntegratedFeedRefresh.Pillar.v2.5.g/ImbalanceMessage.pcap"):
            parsed = NyseAmexequitiesIntegratedfeedrefreshPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_refreshheadermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.IntegratedFeedRefresh.Pillar.v2.5.g/RefreshHeaderMessage.pcap"):
            parsed = NyseAmexequitiesIntegratedfeedrefreshPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.IntegratedFeedRefresh.Pillar.v2.5.g/SecurityStatusMessage.pcap"):
            parsed = NyseAmexequitiesIntegratedfeedrefreshPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.IntegratedFeedRefresh.Pillar.v2.5.g/SymbolIndexMappingMessage.pcap"):
            parsed = NyseAmexequitiesIntegratedfeedrefreshPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
