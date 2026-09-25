# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_nsmequities_totalview_itch_v3_0_udp import NasdaqNsmequitiesTotalviewItchV30Udp


class NasdaqNsmequitiesTotalviewItchV30UdpTests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v3.0/AddOrderMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_addorderwithmpidmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v3.0/AddOrderWithMpidMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_brokentrademessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v3.0/BrokenTradeMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_crosstrademessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v3.0/CrossTradeMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketparticipantpositionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v3.0/MarketParticipantPositionMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_millisecondsmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v3.0/MillisecondsMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_netorderimbalanceindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v3.0/NetOrderImbalanceIndicatorMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v3.0/OrderCancelMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdeletemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v3.0/OrderDeleteMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v3.0/OrderExecutedMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedwithpricemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v3.0/OrderExecutedWithPriceMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_secondsmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v3.0/SecondsMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_stockdirectorymessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v3.0/StockDirectoryMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_stocktradingactionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v3.0/StockTradingActionMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v3.0/SystemEventMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_trademessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v3.0/TradeMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
