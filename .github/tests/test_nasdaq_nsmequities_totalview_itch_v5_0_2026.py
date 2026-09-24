# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_nsmequities_totalview_itch_v5_0_2026_udp import NasdaqNsmequitiesTotalviewItchV502026Udp


class NasdaqNsmequitiesTotalviewItchV502026UdpTests(unittest.TestCase):

    def test_addordernompid(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/AddOrderNoMPID.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_addorderwithmpid(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/AddOrderWithMPID.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_crosstrade(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/CrossTrade.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_luldauctioncollar(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/LULDAuctionCollar.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketparticipantposition(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/MarketParticipantPosition.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_netorderimbalanceindicator(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/NetOrderImbalanceIndicator.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_noncrosstrade(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/NonCrossTrade.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancel(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/OrderCancel.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdelete(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/OrderDelete.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecuted(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/OrderExecuted.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedwithprice(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/OrderExecutedWithPrice.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderreplace(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/OrderReplace.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_regshorestriction(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/RegSHORestriction.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_stockdirectory(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/StockDirectory.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_stocktradingaction(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/StockTradingAction.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemevent(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/SystemEvent.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
