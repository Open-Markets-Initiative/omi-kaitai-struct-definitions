# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_arcaoptions_topfeed_pillar_v1_2_c import NyseArcaoptionsTopfeedPillarV12C


class NyseArcaoptionsTopfeedPillarV12CTests(unittest.TestCase):

    def test_message(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.TopFeed.Pillar.v1.2.c/HeartBeat.pcap"):
            parsed = NyseArcaoptionsTopfeedPillarV12C.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionsquotemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.TopFeed.Pillar.v1.2.c/OptionsQuoteMessage.pcap"):
            parsed = NyseArcaoptionsTopfeedPillarV12C.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequencenumberresetmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.TopFeed.Pillar.v1.2.c/SequenceNumberResetMessage.pcap"):
            parsed = NyseArcaoptionsTopfeedPillarV12C.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
