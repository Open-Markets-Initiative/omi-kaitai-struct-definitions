# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from hkex_hkexderivatives_fulltick_omd_v1_49 import HkexHkexderivativesFulltickOmdV149


class HkexHkexderivativesFulltickOmdV149Tests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Hkex/HkexDerivatives.FullTick.Omd.v1.49/AddOrderMessage.pcap"):
            parsed = HkexHkexderivativesFulltickOmdV149.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_calculatedopeningpricemessage(self):
        for payload in payloads.of("omi-data-packets/Hkex/HkexDerivatives.FullTick.Omd.v1.49/CalculatedOpeningPriceMessage.pcap"):
            parsed = HkexHkexderivativesFulltickOmdV149.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_combinationdefinitionmessage(self):
        for payload in payloads.of("omi-data-packets/Hkex/HkexDerivatives.FullTick.Omd.v1.49/CombinationDefinitionMessage.pcap"):
            parsed = HkexHkexderivativesFulltickOmdV149.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_deleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Hkex/HkexDerivatives.FullTick.Omd.v1.49/DeleteOrderMessage.pcap"):
            parsed = HkexHkexderivativesFulltickOmdV149.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Hkex/HkexDerivatives.FullTick.Omd.v1.49/MarketStatusMessage.pcap"):
            parsed = HkexHkexderivativesFulltickOmdV149.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quoterequest(self):
        for payload in payloads.of("omi-data-packets/Hkex/HkexDerivatives.FullTick.Omd.v1.49/QuoteRequest.pcap"):
            parsed = HkexHkexderivativesFulltickOmdV149.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_refreshcomplete(self):
        for payload in payloads.of("omi-data-packets/Hkex/HkexDerivatives.FullTick.Omd.v1.49/RefreshComplete.pcap"):
            parsed = HkexHkexderivativesFulltickOmdV149.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_seriesdefinitionbasemessage(self):
        for payload in payloads.of("omi-data-packets/Hkex/HkexDerivatives.FullTick.Omd.v1.49/SeriesDefinitionBaseMessage.pcap"):
            parsed = HkexHkexderivativesFulltickOmdV149.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_seriesdefinitionextendedmessage(self):
        for payload in payloads.of("omi-data-packets/Hkex/HkexDerivatives.FullTick.Omd.v1.49/SeriesDefinitionExtendedMessage.pcap"):
            parsed = HkexHkexderivativesFulltickOmdV149.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_trademessage(self):
        for payload in payloads.of("omi-data-packets/Hkex/HkexDerivatives.FullTick.Omd.v1.49/TradeMessage.pcap"):
            parsed = HkexHkexderivativesFulltickOmdV149.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
