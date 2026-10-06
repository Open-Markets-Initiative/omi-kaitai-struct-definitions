# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_bzxequities_multicastdepthofbook_pitch_v2_20_4 import CboeBzxequitiesMulticastdepthofbookPitchV2204


class CboeBzxequitiesMulticastdepthofbookPitchV2204Tests(unittest.TestCase):

    def test_addorderlongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Pitch.v2.20.4/AddOrderLongMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookPitchV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_addordershortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Pitch.v2.20.4/AddOrderShortMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookPitchV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_deleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Pitch.v2.20.4/DeleteOrderMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookPitchV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyorderlongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Pitch.v2.20.4/ModifyOrderLongMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookPitchV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyordershortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Pitch.v2.20.4/ModifyOrderShortMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookPitchV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Pitch.v2.20.4/OrderExecutedMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookPitchV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_reducesizeshortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Pitch.v2.20.4/ReduceSizeShortMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookPitchV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_timemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Pitch.v2.20.4/TimeMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookPitchV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradelongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Pitch.v2.20.4/TradeLongMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookPitchV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradeshortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Pitch.v2.20.4/TradeShortMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookPitchV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
