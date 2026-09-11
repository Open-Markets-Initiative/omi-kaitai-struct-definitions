# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_nsmequities_nlsplus_itch_v3_0 import NasdaqNsmequitiesNlsplusItchV30


class NasdaqNsmequitiesNlsplusItchV30Tests(unittest.TestCase):

    def test_nlsplusregshoshortsalepricetestrestrictedindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.NlsPlus.Itch.v3.0/NlsPlus.RegShoShortSalePriceTestRestrictedIndicatorMessage.pcap"):
            parsed = NasdaqNsmequitiesNlsplusItchV30.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_nlsplusstocktradingactionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.NlsPlus.Itch.v3.0/NlsPlus.StockTradingActionMessage.pcap"):
            parsed = NasdaqNsmequitiesNlsplusItchV30.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_nlsplussystemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.NlsPlus.Itch.v3.0/NlsPlus.SystemEventMessage.pcap"):
            parsed = NasdaqNsmequitiesNlsplusItchV30.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_nlsplustradereportlongpricemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.NlsPlus.Itch.v3.0/NlsPlus.TradeReportLongPriceMessage.pcap"):
            parsed = NasdaqNsmequitiesNlsplusItchV30.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_nlsplustradereportmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.NlsPlus.Itch.v3.0/NlsPlus.TradeReportMessage.pcap"):
            parsed = NasdaqNsmequitiesNlsplusItchV30.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
