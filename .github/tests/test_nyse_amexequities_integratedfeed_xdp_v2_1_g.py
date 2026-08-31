# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_amexequities_integratedfeed_xdp_v2_1_g import NyseAmexequitiesIntegratedfeedXdpV21G


class NyseAmexequitiesIntegratedfeedXdpV21GTests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.IntegratedFeed.Xdp.v2.1.g/AddOrderMessage.pcap"):
            parsed = NyseAmexequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_imbalancemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.IntegratedFeed.Xdp.v2.1.g/ImbalanceMessage.pcap"):
            parsed = NyseAmexequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutionmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.IntegratedFeed.Xdp.v2.1.g/OrderExecutionMessage.pcap"):
            parsed = NyseAmexequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_replaceordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.IntegratedFeed.Xdp.v2.1.g/ReplaceOrderMessage.pcap"):
            parsed = NyseAmexequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.IntegratedFeed.Xdp.v2.1.g/SecurityStatusMessage.pcap"):
            parsed = NyseAmexequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_message(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.IntegratedFeed.Xdp.v2.1.g/SequenceResetMessage.pcap"):
            parsed = NyseAmexequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sourcetimereferencemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.IntegratedFeed.Xdp.v2.1.g/SourceTimeReferenceMessage.pcap"):
            parsed = NyseAmexequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.IntegratedFeed.Xdp.v2.1.g/SymbolIndexMappingMessage.pcap"):
            parsed = NyseAmexequitiesIntegratedfeedXdpV21G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
