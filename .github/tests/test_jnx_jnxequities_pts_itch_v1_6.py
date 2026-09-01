# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from jnx_jnxequities_pts_itch_v1_6 import JnxJnxequitiesPtsItchV16


class JnxJnxequitiesPtsItchV16Tests(unittest.TestCase):

    def test_orderdeletedmessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Itch.v1.6/OrderDeletedMessage.pcap"):
            parsed = JnxJnxequitiesPtsItchV16.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Itch.v1.6/OrderExecutedMessage.pcap"):
            parsed = JnxJnxequitiesPtsItchV16.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderreplacedmessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Itch.v1.6/OrderReplacedMessage.pcap"):
            parsed = JnxJnxequitiesPtsItchV16.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_shortsellingpricerestrictionstatemessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Itch.v1.6/ShortSellingPriceRestrictionStateMessage.pcap"):
            parsed = JnxJnxequitiesPtsItchV16.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_timestampsecondsmessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Itch.v1.6/TimestampSecondsMessage.pcap"):
            parsed = JnxJnxequitiesPtsItchV16.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
