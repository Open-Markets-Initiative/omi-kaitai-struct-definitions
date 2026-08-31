# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_iseoptions_ordercombofeed_itch_v1_1 import NasdaqIseoptionsOrdercombofeedItchV11


class NasdaqIseoptionsOrdercombofeedItchV11Tests(unittest.TestCase):

    def test_complexstrategyauctionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/IseOptions.OrderComboFeed.Itch.v1.1/ComplexStrategyAuctionMessage.pcap"):
            parsed = NasdaqIseoptionsOrdercombofeedItchV11.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_complexstrategydirectorymessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/IseOptions.OrderComboFeed.Itch.v1.1/ComplexStrategyDirectoryMessage.pcap"):
            parsed = NasdaqIseoptionsOrdercombofeedItchV11.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_complexstrategyorderonbookmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/IseOptions.OrderComboFeed.Itch.v1.1/ComplexStrategyOrderOnBookMessage.pcap"):
            parsed = NasdaqIseoptionsOrdercombofeedItchV11.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/IseOptions.OrderComboFeed.Itch.v1.1/Heartbeat.pcap"):
            parsed = NasdaqIseoptionsOrdercombofeedItchV11.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_strategyopenclosedmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/IseOptions.OrderComboFeed.Itch.v1.1/StrategyOpenClosedMessage.pcap"):
            parsed = NasdaqIseoptionsOrdercombofeedItchV11.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_strategytradingactionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/IseOptions.OrderComboFeed.Itch.v1.1/StrategyTradingActionMessage.pcap"):
            parsed = NasdaqIseoptionsOrdercombofeedItchV11.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
