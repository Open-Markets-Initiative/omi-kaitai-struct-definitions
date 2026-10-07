# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_nsmequities_totalview_asciiitch_v3_0_udp import NasdaqNsmequitiesTotalviewAsciiitchV30Udp


class NasdaqNsmequitiesTotalviewAsciiitchV30UdpTests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v3.0/AddOrderMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_addorderwithmpidmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v3.0/AddOrderWithMpidMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_brokentrademessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v3.0/BrokenTradeMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_crosstrademessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v3.0/CrossTradeMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketparticipantpositionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v3.0/MarketParticipantPositionMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_millisecondsmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v3.0/MillisecondsMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_netorderimbalanceindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v3.0/NetOrderImbalanceIndicatorMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v3.0/OrderCancelMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdeletemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v3.0/OrderDeleteMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v3.0/OrderExecutedMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedwithpricemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v3.0/OrderExecutedWithPriceMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_secondsmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v3.0/SecondsMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_stockdirectorymessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v3.0/StockDirectoryMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_stocktradingactionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v3.0/StockTradingActionMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v3.0/SystemEventMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_trademessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v3.0/TradeMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV30Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
