# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nyseequities_integratedfeed_xdp_v2_1_g import NyseNyseequitiesIntegratedfeedXdpV21G


class NyseNyseequitiesIntegratedfeedXdpV21GTests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.IntegratedFeed.Xdp.v2.1.g/AddOrderMessage.pcap"):
            parsed = NyseNyseequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_crosstrademessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.IntegratedFeed.Xdp.v2.1.g/CrossTradeMessage.pcap"):
            parsed = NyseNyseequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_deleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.IntegratedFeed.Xdp.v2.1.g/DeleteOrderMessage.pcap"):
            parsed = NyseNyseequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_imbalancemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.IntegratedFeed.Xdp.v2.1.g/ImbalanceMessage.pcap"):
            parsed = NyseNyseequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.IntegratedFeed.Xdp.v2.1.g/ModifyOrderMessage.pcap"):
            parsed = NyseNyseequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_nondisplayedtrademessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.IntegratedFeed.Xdp.v2.1.g/NonDisplayedTradeMessage.pcap"):
            parsed = NyseNyseequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutionmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.IntegratedFeed.Xdp.v2.1.g/OrderExecutionMessage.pcap"):
            parsed = NyseNyseequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_replaceordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.IntegratedFeed.Xdp.v2.1.g/ReplaceOrderMessage.pcap"):
            parsed = NyseNyseequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.IntegratedFeed.Xdp.v2.1.g/SecurityStatusMessage.pcap"):
            parsed = NyseNyseequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequencenumberresetmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.IntegratedFeed.Xdp.v2.1.g/SequenceNumberResetMessage.pcap"):
            parsed = NyseNyseequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sourcetimereferencemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.IntegratedFeed.Xdp.v2.1.g/SourceTimeReferenceMessage.pcap"):
            parsed = NyseNyseequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.IntegratedFeed.Xdp.v2.1.g/SymbolIndexMappingMessage.pcap"):
            parsed = NyseNyseequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
