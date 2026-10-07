# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_nsmequities_totalview_itch_v5_0_2026_udp import NasdaqNsmequitiesTotalviewItchV502026Udp


class NasdaqNsmequitiesTotalviewItchV502026UdpTests(unittest.TestCase):

    def test_addordernompidattributionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/AddOrderNoMpidAttributionMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_addorderwithmpidattributionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/AddOrderWithMpidAttributionMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_crosstrademessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/CrossTradeMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_luldauctioncollarmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/LuldAuctionCollarMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketparticipantpositionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/MarketParticipantPositionMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_netorderimbalanceindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/NetOrderImbalanceIndicatorMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_noncrosstrademessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/NonCrossTradeMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/OrderCancelMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdeletemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/OrderDeleteMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/OrderExecutedMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedwithpricemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/OrderExecutedWithPriceMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderreplacemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/OrderReplaceMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_regshoshortsalepricetestrestrictedindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/RegShoShortSalePriceTestRestrictedIndicatorMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_stockdirectorymessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/StockDirectoryMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_stocktradingactionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/StockTradingActionMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2026/SystemEventMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502026Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
