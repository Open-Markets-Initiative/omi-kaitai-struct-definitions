# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from box_boxoptions_solamulticast_hsvf_v1_8 import BoxBoxoptionsSolamulticastHsvfV18


class BoxBoxoptionsSolamulticastHsvfV18Tests(unittest.TestCase):

    def test_optionquotemessage(self):
        for payload in payloads.of("omi-data-packets/Box/BoxOptions.SolaMulticast.Hsvf.v1.8/OptionQuoteMessage.pcap"):
            parsed = BoxBoxoptionsSolamulticastHsvfV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
