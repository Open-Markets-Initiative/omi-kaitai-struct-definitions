# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_byxequities_multicastdepthofbook_pitch_v2_41_29 import CboeByxequitiesMulticastdepthofbookPitchV24129


class CboeByxequitiesMulticastdepthofbookPitchV24129Tests(unittest.TestCase):

    def test_addorderlongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/ByxEquities.MulticastDepthOfBook.Pitch.v2.41.29/AddOrderLongMessage.pcap"):
            parsed = CboeByxequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_addordershortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/ByxEquities.MulticastDepthOfBook.Pitch.v2.41.29/AddOrderShortMessage.pcap"):
            parsed = CboeByxequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_auctionsummarymessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/ByxEquities.MulticastDepthOfBook.Pitch.v2.41.29/AuctionSummaryMessage.pcap"):
            parsed = CboeByxequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_auctionupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/ByxEquities.MulticastDepthOfBook.Pitch.v2.41.29/AuctionUpdateMessage.pcap"):
            parsed = CboeByxequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_deleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/ByxEquities.MulticastDepthOfBook.Pitch.v2.41.29/DeleteOrderMessage.pcap"):
            parsed = CboeByxequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyorderlongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/ByxEquities.MulticastDepthOfBook.Pitch.v2.41.29/ModifyOrderLongMessage.pcap"):
            parsed = CboeByxequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyordershortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/ByxEquities.MulticastDepthOfBook.Pitch.v2.41.29/ModifyOrderShortMessage.pcap"):
            parsed = CboeByxequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedatpricesizemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/ByxEquities.MulticastDepthOfBook.Pitch.v2.41.29/OrderExecutedAtPriceSizeMessage.pcap"):
            parsed = CboeByxequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/ByxEquities.MulticastDepthOfBook.Pitch.v2.41.29/OrderExecutedMessage.pcap"):
            parsed = CboeByxequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_reducesizeshortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/ByxEquities.MulticastDepthOfBook.Pitch.v2.41.29/ReduceSizeShortMessage.pcap"):
            parsed = CboeByxequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_retailpriceimprovementmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/ByxEquities.MulticastDepthOfBook.Pitch.v2.41.29/RetailPriceImprovementMessage.pcap"):
            parsed = CboeByxequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradelongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/ByxEquities.MulticastDepthOfBook.Pitch.v2.41.29/TradeLongMessage.pcap"):
            parsed = CboeByxequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradeshortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/ByxEquities.MulticastDepthOfBook.Pitch.v2.41.29/TradeShortMessage.pcap"):
            parsed = CboeByxequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/ByxEquities.MulticastDepthOfBook.Pitch.v2.41.29/TradingStatusMessage.pcap"):
            parsed = CboeByxequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
