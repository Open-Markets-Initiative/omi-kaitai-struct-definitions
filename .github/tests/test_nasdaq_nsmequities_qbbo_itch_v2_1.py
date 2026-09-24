# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_nsmequities_qbbo_itch_v2_1 import NasdaqNsmequitiesQbboItchV21


class NasdaqNsmequitiesQbboItchV21Tests(unittest.TestCase):

    def test_bbobboquotationmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.Qbbo.Itch.v2.1/Bbo.BboQuotationMessage.pcap"):
            parsed = NasdaqNsmequitiesQbboItchV21.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_bboregshorestrictionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.Qbbo.Itch.v2.1/Bbo.RegShoRestrictionMessage.pcap"):
            parsed = NasdaqNsmequitiesQbboItchV21.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_bbostocktradingactionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.Qbbo.Itch.v2.1/Bbo.StockTradingActionMessage.pcap"):
            parsed = NasdaqNsmequitiesQbboItchV21.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_bbosystemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.Qbbo.Itch.v2.1/Bbo.SystemEventMessage.pcap"):
            parsed = NasdaqNsmequitiesQbboItchV21.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
