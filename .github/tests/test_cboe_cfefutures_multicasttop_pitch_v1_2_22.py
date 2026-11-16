# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_cfefutures_multicasttop_pitch_v1_2_22 import CboeCfefuturesMulticasttopPitchV1222


class CboeCfefuturesMulticasttopPitchV1222Tests(unittest.TestCase):

    def test_marketsnapshotlongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.2.22/MarketSnapshotLongMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1222.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketsnapshotshortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.2.22/MarketSnapshotShortMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1222.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_pricelimitsmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.2.22/PriceLimitsMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1222.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_settlementmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.2.22/SettlementMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1222.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_singlesideupdatelongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.2.22/SingleSideUpdateLongMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1222.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_singlesideupdateshortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.2.22/SingleSideUpdateShortMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1222.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_timemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.2.22/TimeMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1222.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_timereferencemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.2.22/TimeReferenceMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1222.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_toptrademessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.2.22/TopTradeMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1222.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.2.22/TradingStatusMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1222.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_twosideupdatelongmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.2.22/TwoSideUpdateLongMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1222.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_twosideupdateshortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastTop.Pitch.v1.2.22/TwoSideUpdateShortMessage.pcap"):
            parsed = CboeCfefuturesMulticasttopPitchV1222.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
