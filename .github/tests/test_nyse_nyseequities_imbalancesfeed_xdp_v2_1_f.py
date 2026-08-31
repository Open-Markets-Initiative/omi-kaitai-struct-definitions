# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nyseequities_imbalancesfeed_xdp_v2_1_f import NyseNyseequitiesImbalancesfeedXdpV21F


class NyseNyseequitiesImbalancesfeedXdpV21FTests(unittest.TestCase):

    def test_imbalancemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.ImbalancesFeed.Xdp.v2.1.f/ImbalanceMessage.pcap"):
            parsed = NyseNyseequitiesImbalancesfeedXdpV21F.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_message(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.ImbalancesFeed.Xdp.v2.1.f/SequenceResetMessage.pcap"):
            parsed = NyseNyseequitiesImbalancesfeedXdpV21F.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
