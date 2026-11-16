# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nationalequities_integratedfeed_pillar_v2_5_g import NyseNationalequitiesIntegratedfeedPillarV25G


class NyseNationalequitiesIntegratedfeedPillarV25GTests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.IntegratedFeed.Pillar.v2.5.g/AddOrderMessage.pcap"):
            parsed = NyseNationalequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_crosstrademessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.IntegratedFeed.Pillar.v2.5.g/CrossTradeMessage.pcap"):
            parsed = NyseNationalequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_deleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.IntegratedFeed.Pillar.v2.5.g/DeleteOrderMessage.pcap"):
            parsed = NyseNationalequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_imbalancemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.IntegratedFeed.Pillar.v2.5.g/ImbalanceMessage.pcap"):
            parsed = NyseNationalequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_messagesequence(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.IntegratedFeed.Pillar.v2.5.g/MessageSequence.pcap"):
            parsed = NyseNationalequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.IntegratedFeed.Pillar.v2.5.g/ModifyOrderMessage.pcap"):
            parsed = NyseNationalequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_nondisplayedtrademessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.IntegratedFeed.Pillar.v2.5.g/NonDisplayedTradeMessage.pcap"):
            parsed = NyseNationalequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutionmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.IntegratedFeed.Pillar.v2.5.g/OrderExecutionMessage.pcap"):
            parsed = NyseNationalequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_replaceordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.IntegratedFeed.Pillar.v2.5.g/ReplaceOrderMessage.pcap"):
            parsed = NyseNationalequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.IntegratedFeed.Pillar.v2.5.g/SecurityStatusMessage.pcap"):
            parsed = NyseNationalequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sourcetimereferencemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.IntegratedFeed.Pillar.v2.5.g/SourceTimeReferenceMessage.pcap"):
            parsed = NyseNationalequitiesIntegratedfeedPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
