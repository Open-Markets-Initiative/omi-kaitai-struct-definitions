# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_c1options_multicastdepthofbook_pitch_v2_39_4 import CboeC1optionsMulticastdepthofbookPitchV2394


class CboeC1optionsMulticastdepthofbookPitchV2394Tests(unittest.TestCase):

    def test_addorderlongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.MulticastDepthOfBook.Pitch.v2.39.4/AddOrderLongMessage.pcap"):
            parsed = CboeC1optionsMulticastdepthofbookPitchV2394.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_deleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.MulticastDepthOfBook.Pitch.v2.39.4/DeleteOrderMessage.pcap"):
            parsed = CboeC1optionsMulticastdepthofbookPitchV2394.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.MulticastDepthOfBook.Pitch.v2.39.4/Heartbeat.pcap"):
            parsed = CboeC1optionsMulticastdepthofbookPitchV2394.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyorderlongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.MulticastDepthOfBook.Pitch.v2.39.4/ModifyOrderLongMessage.pcap"):
            parsed = CboeC1optionsMulticastdepthofbookPitchV2394.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
