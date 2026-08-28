# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cme_globex_mdp3_sbe_v1_8_udp import CmeGlobexMdp3SbeV18Udp


class CmeGlobexMdp3SbeV18UdpTests(unittest.TestCase):

    def test_mdincrementalrefreshtradesummary(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.8/MdIncrementalRefreshTradeSummary.pcap"):
            parsed = CmeGlobexMdp3SbeV18Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
