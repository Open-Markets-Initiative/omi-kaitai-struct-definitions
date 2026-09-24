# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_byxequities_multicastdepthofbook_pitch_v2_41_29 import CboeByxequitiesMulticastdepthofbookPitchV24129


class CboeByxequitiesMulticastdepthofbookPitchV24129Tests(unittest.TestCase):

    def test_addordershortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/ByxEquities.MulticastDepthOfBook.Pitch.v2.41.29/AddOrderShortMessage.pcap"):
            parsed = CboeByxequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyordershortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/ByxEquities.MulticastDepthOfBook.Pitch.v2.41.29/ModifyOrderShortMessage.pcap"):
            parsed = CboeByxequitiesMulticastdepthofbookPitchV24129.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
