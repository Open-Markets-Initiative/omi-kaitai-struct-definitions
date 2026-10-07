# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_nsmequities_totalview_itch_v5_0_2023_udp import NasdaqNsmequitiesTotalviewItchV502023Udp


class NasdaqNsmequitiesTotalviewItchV502023UdpTests(unittest.TestCase):

    def test_addordernompidattributionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/AddOrderNoMpidAttributionMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_addorderwithmpidattributionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/AddOrderWithMpidAttributionMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_crosstrademessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/CrossTradeMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_luldauctioncollarmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/LuldAuctionCollarMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketparticipantpositionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/MarketParticipantPositionMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_netorderimbalanceindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/NetOrderImbalanceIndicatorMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_noncrosstrademessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/NonCrossTradeMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/OrderCancelMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdeletemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/OrderDeleteMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/OrderExecutedMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedwithpricemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/OrderExecutedWithPriceMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderreplacemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/OrderReplaceMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_regshoshortsalepricetestrestrictedindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/RegShoShortSalePriceTestRestrictedIndicatorMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_stocktradingactionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/StockTradingActionMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/SystemEventMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
