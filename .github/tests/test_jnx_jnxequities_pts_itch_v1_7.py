# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from jnx_jnxequities_pts_itch_v1_7_moldudp64 import JnxJnxequitiesPtsItchV17Moldudp64


class JnxJnxequitiesPtsItchV17Moldudp64Tests(unittest.TestCase):

    def test_orderaddedwithoutattributesmessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Itch.v1.7/OrderAddedWithoutAttributesMessage.pcap"):
            parsed = JnxJnxequitiesPtsItchV17Moldudp64.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdeletedmessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Itch.v1.7/OrderDeletedMessage.pcap"):
            parsed = JnxJnxequitiesPtsItchV17Moldudp64.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Itch.v1.7/OrderExecutedMessage.pcap"):
            parsed = JnxJnxequitiesPtsItchV17Moldudp64.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderreplacedmessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Itch.v1.7/OrderReplacedMessage.pcap"):
            parsed = JnxJnxequitiesPtsItchV17Moldudp64.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_secondsmessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Itch.v1.7/SecondsMessage.pcap"):
            parsed = JnxJnxequitiesPtsItchV17Moldudp64.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_shortsellingpricerestrictionstatemessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Itch.v1.7/ShortSellingPriceRestrictionStateMessage.pcap"):
            parsed = JnxJnxequitiesPtsItchV17Moldudp64.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Itch.v1.7/SystemEventMessage.pcap"):
            parsed = JnxJnxequitiesPtsItchV17Moldudp64.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatemessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Itch.v1.7/TradingStateMessage.pcap"):
            parsed = JnxJnxequitiesPtsItchV17Moldudp64.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
