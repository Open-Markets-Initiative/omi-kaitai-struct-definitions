# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_texasequities_integratedfeed_pillar_v2_5_g import NyseTexasequitiesIntegratedfeedPillarV25G


class NyseTexasequitiesIntegratedfeedPillarV25GTests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/TexasEquities.IntegratedFeed.Pillar.v2.5.g/AddOrderMessage.pcap"):
            parsed = NyseTexasequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_deleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/TexasEquities.IntegratedFeed.Pillar.v2.5.g/DeleteOrderMessage.pcap"):
            parsed = NyseTexasequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/TexasEquities.IntegratedFeed.Pillar.v2.5.g/ModifyOrderMessage.pcap"):
            parsed = NyseTexasequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_nondisplayedtrademessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/TexasEquities.IntegratedFeed.Pillar.v2.5.g/NonDisplayedTradeMessage.pcap"):
            parsed = NyseTexasequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutionmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/TexasEquities.IntegratedFeed.Pillar.v2.5.g/OrderExecutionMessage.pcap"):
            parsed = NyseTexasequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_replaceordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/TexasEquities.IntegratedFeed.Pillar.v2.5.g/ReplaceOrderMessage.pcap"):
            parsed = NyseTexasequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/TexasEquities.IntegratedFeed.Pillar.v2.5.g/SecurityStatusMessage.pcap"):
            parsed = NyseTexasequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sourcetimereferencemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/TexasEquities.IntegratedFeed.Pillar.v2.5.g/SourceTimeReferenceMessage.pcap"):
            parsed = NyseTexasequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
