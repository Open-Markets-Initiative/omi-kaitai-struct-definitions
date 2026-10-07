# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_cfefutures_multicastdepthofbook_pitch_v1_1_6 import CboeCfefuturesMulticastdepthofbookPitchV116


class CboeCfefuturesMulticastdepthofbookPitchV116Tests(unittest.TestCase):

    def test_addordershortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastDepthOfBook.Pitch.v1.1.6/AddOrderShortMessage.pcap"):
            parsed = CboeCfefuturesMulticastdepthofbookPitchV116.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_deleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastDepthOfBook.Pitch.v1.1.6/DeleteOrderMessage.pcap"):
            parsed = CboeCfefuturesMulticastdepthofbookPitchV116.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_futuresinstrumentdefinitionmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastDepthOfBook.Pitch.v1.1.6/FuturesInstrumentDefinitionMessage.pcap"):
            parsed = CboeCfefuturesMulticastdepthofbookPitchV116.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastDepthOfBook.Pitch.v1.1.6/Heartbeat.pcap"):
            parsed = CboeCfefuturesMulticastdepthofbookPitchV116.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyordershortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastDepthOfBook.Pitch.v1.1.6/ModifyOrderShortMessage.pcap"):
            parsed = CboeCfefuturesMulticastdepthofbookPitchV116.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_timemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastDepthOfBook.Pitch.v1.1.6/TimeMessage.pcap"):
            parsed = CboeCfefuturesMulticastdepthofbookPitchV116.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastDepthOfBook.Pitch.v1.1.6/TradingStatusMessage.pcap"):
            parsed = CboeCfefuturesMulticastdepthofbookPitchV116.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
