# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nationalequities_bbo_pillar_v2_5_d import NyseNationalequitiesBboPillarV25D


class NyseNationalequitiesBboPillarV25DTests(unittest.TestCase):

    def test_messagesequence(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.Bbo.Pillar.v2.5.d/MessageSequence.pcap"):
            parsed = NyseNationalequitiesBboPillarV25D.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quotemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.Bbo.Pillar.v2.5.d/QuoteMessage.pcap"):
            parsed = NyseNationalequitiesBboPillarV25D.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.Bbo.Pillar.v2.5.d/SecurityStatusMessage.pcap"):
            parsed = NyseNationalequitiesBboPillarV25D.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sourcetimereferencemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.Bbo.Pillar.v2.5.d/SourceTimeReferenceMessage.pcap"):
            parsed = NyseNationalequitiesBboPillarV25D.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
