# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nyseequities_depthfeed_pillar_v1_1 import NyseNyseequitiesDepthfeedPillarV11


class NyseNyseequitiesDepthfeedPillarV11Tests(unittest.TestCase):

    def test_deltamessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.DepthFeed.Pillar.v1.1/DeltaMessage.pcap"):
            parsed = NyseNyseequitiesDepthfeedPillarV11.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_imbalancemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.DepthFeed.Pillar.v1.1/ImbalanceMessage.pcap"):
            parsed = NyseNyseequitiesDepthfeedPillarV11.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.DepthFeed.Pillar.v1.1/SecurityStatusMessage.pcap"):
            parsed = NyseNyseequitiesDepthfeedPillarV11.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
