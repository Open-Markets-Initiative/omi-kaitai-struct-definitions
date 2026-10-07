# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_nsmequities_nlsplus_itch_v3_0 import NasdaqNsmequitiesNlsplusItchV30


class NasdaqNsmequitiesNlsplusItchV30Tests(unittest.TestCase):

    def test_longformtradereportmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.NlsPlus.Itch.v3.0/LongFormTradeReportMessage.pcap"):
            parsed = NasdaqNsmequitiesNlsplusItchV30.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_regshoshortsalepricetestrestrictedindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.NlsPlus.Itch.v3.0/RegShoShortSalePriceTestRestrictedIndicatorMessage.pcap"):
            parsed = NasdaqNsmequitiesNlsplusItchV30.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_stocktradingactionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.NlsPlus.Itch.v3.0/StockTradingActionMessage.pcap"):
            parsed = NasdaqNsmequitiesNlsplusItchV30.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.NlsPlus.Itch.v3.0/SystemEventMessage.pcap"):
            parsed = NasdaqNsmequitiesNlsplusItchV30.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradereportmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.NlsPlus.Itch.v3.0/TradeReportMessage.pcap"):
            parsed = NasdaqNsmequitiesNlsplusItchV30.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
