# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nyseequities_imbalancesfeed_xdp_v2_2_a import NyseNyseequitiesImbalancesfeedXdpV22A


class NyseNyseequitiesImbalancesfeedXdpV22ATests(unittest.TestCase):

    def test_imbalancemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.ImbalancesFeed.Xdp.v2.2.a/ImbalanceMessage.pcap"):
            parsed = NyseNyseequitiesImbalancesfeedXdpV22A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.ImbalancesFeed.Xdp.v2.2.a/SecurityStatusMessage.pcap"):
            parsed = NyseNyseequitiesImbalancesfeedXdpV22A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.ImbalancesFeed.Xdp.v2.2.a/SymbolIndexMappingMessage.pcap"):
            parsed = NyseNyseequitiesImbalancesfeedXdpV22A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
