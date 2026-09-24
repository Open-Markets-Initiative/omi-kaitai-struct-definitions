# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_edgaequities_multicastdepthofbook_pitch_v2_41_29 import CboeEdgaequitiesMulticastdepthofbookPitchV24129


class CboeEdgaequitiesMulticastdepthofbookPitchV24129Tests(unittest.TestCase):

    def test_addorderlongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/EdgaEquities.MulticastDepthOfBook.Pitch.v2.41.29/AddOrderLongMessage.pcap"):
            parsed = CboeEdgaequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_addordershortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/EdgaEquities.MulticastDepthOfBook.Pitch.v2.41.29/AddOrderShortMessage.pcap"):
            parsed = CboeEdgaequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_deleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/EdgaEquities.MulticastDepthOfBook.Pitch.v2.41.29/DeleteOrderMessage.pcap"):
            parsed = CboeEdgaequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyorderlongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/EdgaEquities.MulticastDepthOfBook.Pitch.v2.41.29/ModifyOrderLongMessage.pcap"):
            parsed = CboeEdgaequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyordershortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/EdgaEquities.MulticastDepthOfBook.Pitch.v2.41.29/ModifyOrderShortMessage.pcap"):
            parsed = CboeEdgaequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedatpricesizemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/EdgaEquities.MulticastDepthOfBook.Pitch.v2.41.29/OrderExecutedAtPriceSizeMessage.pcap"):
            parsed = CboeEdgaequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/EdgaEquities.MulticastDepthOfBook.Pitch.v2.41.29/OrderExecutedMessage.pcap"):
            parsed = CboeEdgaequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_reducesizeshortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/EdgaEquities.MulticastDepthOfBook.Pitch.v2.41.29/ReduceSizeShortMessage.pcap"):
            parsed = CboeEdgaequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_timemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/EdgaEquities.MulticastDepthOfBook.Pitch.v2.41.29/TimeMessage.pcap"):
            parsed = CboeEdgaequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradelongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/EdgaEquities.MulticastDepthOfBook.Pitch.v2.41.29/TradeLongMessage.pcap"):
            parsed = CboeEdgaequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradeshortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/EdgaEquities.MulticastDepthOfBook.Pitch.v2.41.29/TradeShortMessage.pcap"):
            parsed = CboeEdgaequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/EdgaEquities.MulticastDepthOfBook.Pitch.v2.41.29/TradingStatusMessage.pcap"):
            parsed = CboeEdgaequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
