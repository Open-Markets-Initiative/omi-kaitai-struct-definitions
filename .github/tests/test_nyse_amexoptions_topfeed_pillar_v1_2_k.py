# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_amexoptions_topfeed_pillar_v1_2_k import NyseAmexoptionsTopfeedPillarV12K


class NyseAmexoptionsTopfeedPillarV12KTests(unittest.TestCase):

    def test_optionsquotemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Pillar.v1.2.k/OptionsQuoteMessage.pcap"):
            parsed = NyseAmexoptionsTopfeedPillarV12K.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionsstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Pillar.v1.2.k/OptionsStatusMessage.pcap"):
            parsed = NyseAmexoptionsTopfeedPillarV12K.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_outrightseriesindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Pillar.v1.2.k/OutrightSeriesIndexMappingMessage.pcap"):
            parsed = NyseAmexoptionsTopfeedPillarV12K.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Pillar.v1.2.k/SecurityStatusMessage.pcap"):
            parsed = NyseAmexoptionsTopfeedPillarV12K.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequencenumberresetmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Pillar.v1.2.k/SequenceNumberResetMessage.pcap"):
            parsed = NyseAmexoptionsTopfeedPillarV12K.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sourcetimereferencemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Pillar.v1.2.k/SourceTimeReferenceMessage.pcap"):
            parsed = NyseAmexoptionsTopfeedPillarV12K.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolclearmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Pillar.v1.2.k/SymbolClearMessage.pcap"):
            parsed = NyseAmexoptionsTopfeedPillarV12K.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.TopFeed.Pillar.v1.2.k/SymbolIndexMappingMessage.pcap"):
            parsed = NyseAmexoptionsTopfeedPillarV12K.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
