# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_arcaoptions_deepfeed_pillar_v1_2_m import NyseArcaoptionsDeepfeedPillarV12M


class NyseArcaoptionsDeepfeedPillarV12MTests(unittest.TestCase):

    def test_messagesequence(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.DeepFeed.Pillar.v1.2.m/MessageSequence.pcap"):
            parsed = NyseArcaoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionsaddordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.DeepFeed.Pillar.v1.2.m/OptionsAddOrderMessage.pcap"):
            parsed = NyseArcaoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionscrosstrademessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.DeepFeed.Pillar.v1.2.m/OptionsCrossTradeMessage.pcap"):
            parsed = NyseArcaoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionsdeleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.DeepFeed.Pillar.v1.2.m/OptionsDeleteOrderMessage.pcap"):
            parsed = NyseArcaoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionsimbalancemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.DeepFeed.Pillar.v1.2.m/OptionsImbalanceMessage.pcap"):
            parsed = NyseArcaoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionsmodifyordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.DeepFeed.Pillar.v1.2.m/OptionsModifyOrderMessage.pcap"):
            parsed = NyseArcaoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionsnondisplayedtrademessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.DeepFeed.Pillar.v1.2.m/OptionsNonDisplayedTradeMessage.pcap"):
            parsed = NyseArcaoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionsorderexecutionmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.DeepFeed.Pillar.v1.2.m/OptionsOrderExecutionMessage.pcap"):
            parsed = NyseArcaoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionsreplaceordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.DeepFeed.Pillar.v1.2.m/OptionsReplaceOrderMessage.pcap"):
            parsed = NyseArcaoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionsstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.DeepFeed.Pillar.v1.2.m/OptionsStatusMessage.pcap"):
            parsed = NyseArcaoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_outrightseriesindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.DeepFeed.Pillar.v1.2.m/OutrightSeriesIndexMappingMessage.pcap"):
            parsed = NyseArcaoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.DeepFeed.Pillar.v1.2.m/SecurityStatusMessage.pcap"):
            parsed = NyseArcaoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequencenumberresetmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.DeepFeed.Pillar.v1.2.m/SequenceNumberResetMessage.pcap"):
            parsed = NyseArcaoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sourcetimereferencemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.DeepFeed.Pillar.v1.2.m/SourceTimeReferenceMessage.pcap"):
            parsed = NyseArcaoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolclearmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.DeepFeed.Pillar.v1.2.m/SymbolClearMessage.pcap"):
            parsed = NyseArcaoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaOptions.DeepFeed.Pillar.v1.2.m/SymbolIndexMappingMessage.pcap"):
            parsed = NyseArcaoptionsDeepfeedPillarV12M.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
