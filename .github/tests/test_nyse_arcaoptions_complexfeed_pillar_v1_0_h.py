# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_arcaoptions_complexfeed_pillar_v1_0_h import NyseArcaoptionsComplexfeedPillarV10H


class NyseArcaoptionsComplexfeedPillarV10HTests(unittest.TestCase):

    def test_complexseriesindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.ComplexFeed.Pillar.v1.0.h/ComplexSeriesIndexMappingMessage.pcap"):
            parsed = NyseArcaoptionsComplexfeedPillarV10H.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionsquotemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.ComplexFeed.Pillar.v1.0.h/OptionsQuoteMessage.pcap"):
            parsed = NyseArcaoptionsComplexfeedPillarV10H.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionsstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.ComplexFeed.Pillar.v1.0.h/OptionsStatusMessage.pcap"):
            parsed = NyseArcaoptionsComplexfeedPillarV10H.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionstrademessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.ComplexFeed.Pillar.v1.0.h/OptionsTradeMessage.pcap"):
            parsed = NyseArcaoptionsComplexfeedPillarV10H.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sourcetimereferencemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.ComplexFeed.Pillar.v1.0.h/SourceTimeReferenceMessage.pcap"):
            parsed = NyseArcaoptionsComplexfeedPillarV10H.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolclearmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.ComplexFeed.Pillar.v1.0.h/SymbolClearMessage.pcap"):
            parsed = NyseArcaoptionsComplexfeedPillarV10H.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
