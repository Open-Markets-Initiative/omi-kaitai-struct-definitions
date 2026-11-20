# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_cfefutures_multicasttop_pitch_v1_0_15 import CboeCfefuturesMulticasttopPitchV1015


class CboeCfefuturesMulticasttopPitchV1015Tests(unittest.TestCase):

    def test_endofdaysummarymessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.0.15/EndOfDaySummaryMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1015.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_endofsessionmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.0.15/EndOfSessionMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1015.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_futuresinstrumentdefinitionmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.0.15/FuturesInstrumentDefinitionMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1015.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketsnapshotlongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.0.15/MarketSnapshotLongMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1015.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketsnapshotshortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.0.15/MarketSnapshotShortMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1015.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_pricelimitsmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.0.15/PriceLimitsMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1015.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_settlementmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.0.15/SettlementMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1015.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_singlesideupdatelongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.0.15/SingleSideUpdateLongMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1015.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_singlesideupdateshortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.0.15/SingleSideUpdateShortMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1015.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_timemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.0.15/TimeMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1015.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_timereferencemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.0.15/TimeReferenceMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1015.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_toptrademessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.0.15/TopTradeMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1015.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.0.15/TradingStatusMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1015.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_twosideupdatelongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.0.15/TwoSideUpdateLongMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1015.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_twosideupdateshortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.0.15/TwoSideUpdateShortMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1015.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
