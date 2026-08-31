# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from memx_memxequities_memoirdepthfeed_sbe_v1_3 import MemxMemxequitiesMemoirdepthfeedSbeV13


class MemxMemxequitiesMemoirdepthfeedSbeV13Tests(unittest.TestCase):

    def test_orderaddedmessage(self):
        for payload in payloads.of("omi-data-packets/Memx/MemxEquities.MemoirDepthFeed.Sbe.v1.3/OrderAddedMessage.pcap"):
            parsed = MemxMemxequitiesMemoirdepthfeedSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdeletedmessage(self):
        for payload in payloads.of("omi-data-packets/Memx/MemxEquities.MemoirDepthFeed.Sbe.v1.3/OrderDeletedMessage.pcap"):
            parsed = MemxMemxequitiesMemoirdepthfeedSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Memx/MemxEquities.MemoirDepthFeed.Sbe.v1.3/OrderExecutedMessage.pcap"):
            parsed = MemxMemxequitiesMemoirdepthfeedSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderreducedmessage(self):
        for payload in payloads.of("omi-data-packets/Memx/MemxEquities.MemoirDepthFeed.Sbe.v1.3/OrderReducedMessage.pcap"):
            parsed = MemxMemxequitiesMemoirdepthfeedSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_regshorestrictionmessage(self):
        for payload in payloads.of("omi-data-packets/Memx/MemxEquities.MemoirDepthFeed.Sbe.v1.3/RegShowRestrictionMessage.pcap"):
            parsed = MemxMemxequitiesMemoirdepthfeedSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitytradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Memx/MemxEquities.MemoirDepthFeed.Sbe.v1.3/SecurityTradingStatusMessage.pcap"):
            parsed = MemxMemxequitiesMemoirdepthfeedSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingsessionstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Memx/MemxEquities.MemoirDepthFeed.Sbe.v1.3/TradingSessionStatusMessage.pcap"):
            parsed = MemxMemxequitiesMemoirdepthfeedSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_multiplemessages(self):
        for payload in payloads.of("omi-data-packets/Memx/MemxEquities.MemoirDepthFeed.Sbe.v1.3/MultipleMessages.pcap"):
            parsed = MemxMemxequitiesMemoirdepthfeedSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
