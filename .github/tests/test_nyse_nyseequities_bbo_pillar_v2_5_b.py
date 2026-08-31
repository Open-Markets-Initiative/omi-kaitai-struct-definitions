# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nyseequities_bbo_pillar_v2_5_b import NyseNyseequitiesBboPillarV25B


class NyseNyseequitiesBboPillarV25BTests(unittest.TestCase):

    def test_quotemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.Bbo.Pillar.v2.5.b/QuoteMessage.pcap"):
            parsed = NyseNyseequitiesBboPillarV25B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_refreshheadermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.Bbo.Pillar.v2.5.b/RefreshHeaderMessage.pcap"):
            parsed = NyseNyseequitiesBboPillarV25B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.Bbo.Pillar.v2.5.b/SecurityStatusMessage.pcap"):
            parsed = NyseNyseequitiesBboPillarV25B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sourcetimereferencemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.Bbo.Pillar.v2.5.b/SourceTimeReferenceMessage.pcap"):
            parsed = NyseNyseequitiesBboPillarV25B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
