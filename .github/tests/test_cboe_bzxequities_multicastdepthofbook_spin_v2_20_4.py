# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_bzxequities_multicastdepthofbook_spin_v2_20_4 import CboeBzxequitiesMulticastdepthofbookSpinV2204


class CboeBzxequitiesMulticastdepthofbookSpinV2204Tests(unittest.TestCase):

    def test_loginmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Spin.v2.20.4/LoginMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookSpinV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginresponsemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Spin.v2.20.4/LoginResponseMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookSpinV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_spinfinishedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Spin.v2.20.4/SpinFinishedMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookSpinV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_spinimageavailablemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Spin.v2.20.4/SpinImageAvailableMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookSpinV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_spinrequestmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Spin.v2.20.4/SpinRequestMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookSpinV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_spinresponsemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Spin.v2.20.4/SpinResponseMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookSpinV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_timemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.MulticastDepthOfBook.Spin.v2.20.4/TimeMessage.pcap"):
            parsed = CboeBzxequitiesMulticastdepthofbookSpinV2204.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
