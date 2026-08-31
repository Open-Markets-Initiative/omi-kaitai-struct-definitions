# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from blueoceanats_blueequities_memoirdepthfeed_sbe_v1_3 import BlueoceanatsBlueequitiesMemoirdepthfeedSbeV13


class BlueoceanatsBlueequitiesMemoirdepthfeedSbeV13Tests(unittest.TestCase):

    def test_orderaddedmessage(self):
        for payload in payloads.of("omi-data-packets/BlueOceanAts/BlueEquities.MemoirDepthFeed.Sbe.v1.3/OrderAddedMessage.pcap"):
            parsed = BlueoceanatsBlueequitiesMemoirdepthfeedSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdeletedmessage(self):
        for payload in payloads.of("omi-data-packets/BlueOceanAts/BlueEquities.MemoirDepthFeed.Sbe.v1.3/OrderDeletedMessage.pcap"):
            parsed = BlueoceanatsBlueequitiesMemoirdepthfeedSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/BlueOceanAts/BlueEquities.MemoirDepthFeed.Sbe.v1.3/OrderExecutedMessage.pcap"):
            parsed = BlueoceanatsBlueequitiesMemoirdepthfeedSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderreducedmessage(self):
        for payload in payloads.of("omi-data-packets/BlueOceanAts/BlueEquities.MemoirDepthFeed.Sbe.v1.3/OrderReducedMessage.pcap"):
            parsed = BlueoceanatsBlueequitiesMemoirdepthfeedSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
