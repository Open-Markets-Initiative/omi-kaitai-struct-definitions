# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_amexoptions_deepfeed_pillar_v1_2_m import NyseAmexoptionsDeepfeedPillarV12M


class NyseAmexoptionsDeepfeedPillarV12MTests(unittest.TestCase):

    def test_optionsaddordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.DeepFeed.Pillar.v1.2.m/OptionsAddOrderMessage.pcap"):
            parsed = NyseAmexoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionsdeleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.DeepFeed.Pillar.v1.2.m/OptionsDeleteOrderMessage.pcap"):
            parsed = NyseAmexoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionsimbalancemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.DeepFeed.Pillar.v1.2.m/OptionsImbalanceMessage.pcap"):
            parsed = NyseAmexoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionsstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.DeepFeed.Pillar.v1.2.m/OptionsStatusMessage.pcap"):
            parsed = NyseAmexoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_outrightseriesindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.DeepFeed.Pillar.v1.2.m/OutrightSeriesIndexMappingMessage.pcap"):
            parsed = NyseAmexoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.DeepFeed.Pillar.v1.2.m/SecurityStatusMessage.pcap"):
            parsed = NyseAmexoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequencenumberresetmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.DeepFeed.Pillar.v1.2.m/SequenceNumberResetMessage.pcap"):
            parsed = NyseAmexoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sourcetimereferencemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.DeepFeed.Pillar.v1.2.m/SourceTimeReferenceMessage.pcap"):
            parsed = NyseAmexoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolclearmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.DeepFeed.Pillar.v1.2.m/SymbolClearMessage.pcap"):
            parsed = NyseAmexoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexOptions.DeepFeed.Pillar.v1.2.m/SymbolIndexMappingMessage.pcap"):
            parsed = NyseAmexoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
