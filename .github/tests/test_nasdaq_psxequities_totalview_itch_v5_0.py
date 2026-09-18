# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_psxequities_totalview_itch_v5_0 import NasdaqPsxequitiesTotalviewItchV50


class NasdaqPsxequitiesTotalviewItchV50Tests(unittest.TestCase):

    def test_addordernompidattributionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/PsxEquities.TotalView.Itch.v5.0/AddOrderNoMpidAttributionMessage.pcap"):
            parsed = NasdaqPsxequitiesTotalviewItchV50.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_addorderwithmpidattributionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/PsxEquities.TotalView.Itch.v5.0/AddOrderWithMpidAttributionMessage.pcap"):
            parsed = NasdaqPsxequitiesTotalviewItchV50.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/PsxEquities.TotalView.Itch.v5.0/OrderCancelMessage.pcap"):
            parsed = NasdaqPsxequitiesTotalviewItchV50.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdeletemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/PsxEquities.TotalView.Itch.v5.0/OrderDeleteMessage.pcap"):
            parsed = NasdaqPsxequitiesTotalviewItchV50.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/PsxEquities.TotalView.Itch.v5.0/OrderExecutedMessage.pcap"):
            parsed = NasdaqPsxequitiesTotalviewItchV50.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedwithpricemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/PsxEquities.TotalView.Itch.v5.0/OrderExecutedWithPriceMessage.pcap"):
            parsed = NasdaqPsxequitiesTotalviewItchV50.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderreplacemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/PsxEquities.TotalView.Itch.v5.0/OrderReplaceMessage.pcap"):
            parsed = NasdaqPsxequitiesTotalviewItchV50.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_regshoshortsalepricetestrestrictedindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/PsxEquities.TotalView.Itch.v5.0/RegShoShortSalePriceTestRestrictedIndicatorMessage.pcap"):
            parsed = NasdaqPsxequitiesTotalviewItchV50.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_stocktradingactionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/PsxEquities.TotalView.Itch.v5.0/StockTradingActionMessage.pcap"):
            parsed = NasdaqPsxequitiesTotalviewItchV50.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/PsxEquities.TotalView.Itch.v5.0/SystemEventMessage.pcap"):
            parsed = NasdaqPsxequitiesTotalviewItchV50.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_trademessagenoncross(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/PsxEquities.TotalView.Itch.v5.0/TradeMessageNon-cross.pcap"):
            parsed = NasdaqPsxequitiesTotalviewItchV50.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
