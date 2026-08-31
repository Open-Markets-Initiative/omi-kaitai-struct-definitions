# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_nsmequities_nlsplus_itch_v4_0 import NasdaqNsmequitiesNlsplusItchV40


class NasdaqNsmequitiesNlsplusItchV40Tests(unittest.TestCase):

    def test_regshoshortsalepricetestrestrictedindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.NlsPlus.Itch.v4.0/NlsPlus.RegShoShortSalePriceTestRestrictedIndicatorMessage.pcap"):
            parsed = NasdaqNsmequitiesNlsplusItchV40.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_stocktradingactionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.NlsPlus.Itch.v4.0/NlsPlus.StockTradingActionMessage.pcap"):
            parsed = NasdaqNsmequitiesNlsplusItchV40.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.NlsPlus.Itch.v4.0/NlsPlus.SystemEventMessage.pcap"):
            parsed = NasdaqNsmequitiesNlsplusItchV40.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_message(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.NlsPlus.Itch.v4.0/NlsPlus.TradeReportLongPriceMessage.pcap"):
            parsed = NasdaqNsmequitiesNlsplusItchV40.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradereportmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.NlsPlus.Itch.v4.0/NlsPlus.TradeReportMessage.pcap"):
            parsed = NasdaqNsmequitiesNlsplusItchV40.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
