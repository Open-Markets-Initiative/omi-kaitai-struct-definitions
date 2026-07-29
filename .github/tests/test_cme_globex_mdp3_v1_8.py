# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cme_globex_mdp3_v1_8 import CmeGlobexMdp3V18


class CmeGlobexMdp3V18Tests(unittest.TestCase):

    def test_mdincrementalrefreshtradesummary(self):
        for payload in payloads.of("omi-data-packets/Cme/Mdp3.Sbe.v1.8/MdIncrementalRefreshTradeSummary.pcap"):
            parsed = CmeGlobexMdp3V18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
