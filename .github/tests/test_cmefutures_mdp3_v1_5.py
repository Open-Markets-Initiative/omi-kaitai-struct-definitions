# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cmefutures_mdp3_v1_5 import CmefuturesMdp3V15


class CmefuturesMdp3V15Tests(unittest.TestCase):

    def test_mdincrementalrefreshbook(self):
        for payload in payloads.of("omi-data-packets/Cme/Mdp3.Sbe.v1.5/MdIncrementalRefreshBook.pcap"):
            parsed = CmefuturesMdp3V15.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_mdincrementalrefreshsessionstatistics(self):
        for payload in payloads.of("omi-data-packets/Cme/Mdp3.Sbe.v1.5/MdIncrementalRefreshSessionStatistics.pcap"):
            parsed = CmefuturesMdp3V15.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_mdincrementalrefreshtradesummary(self):
        for payload in payloads.of("omi-data-packets/Cme/Mdp3.Sbe.v1.5/MdIncrementalRefreshTradeSummary.pcap"):
            parsed = CmefuturesMdp3V15.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_mdincrementalrefreshvolume(self):
        for payload in payloads.of("omi-data-packets/Cme/Mdp3.Sbe.v1.5/MdIncrementalRefreshVolume.pcap"):
            parsed = CmefuturesMdp3V15.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
