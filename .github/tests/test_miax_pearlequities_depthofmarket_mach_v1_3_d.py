# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from miax_pearlequities_depthofmarket_mach_v1_3_d_udp import MiaxPearlequitiesDepthofmarketMachV13DUdp


class MiaxPearlequitiesDepthofmarketMachV13DUdpTests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.DepthOfMarket.Mach.v1.3.d/AddOrderMessage.pcap"):
            parsed = MiaxPearlequitiesDepthofmarketMachV13DUdp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_deleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.DepthOfMarket.Mach.v1.3.d/DeleteOrderMessage.pcap"):
            parsed = MiaxPearlequitiesDepthofmarketMachV13DUdp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyordermessage(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.DepthOfMarket.Mach.v1.3.d/ModifyOrderMessage.pcap"):
            parsed = MiaxPearlequitiesDepthofmarketMachV13DUdp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutionmessage(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.DepthOfMarket.Mach.v1.3.d/OrderExecutionMessage.pcap"):
            parsed = MiaxPearlequitiesDepthofmarketMachV13DUdp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitytradingstatusnotificationmessage(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.DepthOfMarket.Mach.v1.3.d/SecurityTradingStatusNotificationMessage.pcap"):
            parsed = MiaxPearlequitiesDepthofmarketMachV13DUdp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemtimemessage(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.DepthOfMarket.Mach.v1.3.d/SystemTimeMessage.pcap"):
            parsed = MiaxPearlequitiesDepthofmarketMachV13DUdp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_trademessage(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.DepthOfMarket.Mach.v1.3.d/TradeMessage.pcap"):
            parsed = MiaxPearlequitiesDepthofmarketMachV13DUdp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
