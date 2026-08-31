# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_iseoptions_topcomboquotefeed_itch_v1_0 import NasdaqIseoptionsTopcomboquotefeedItchV10


class NasdaqIseoptionsTopcomboquotefeedItchV10Tests(unittest.TestCase):

    def test_complexstrategydirectorymessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/IseOptions.TopComboQuoteFeed.Itch.v1.0/ComplexStrategyDirectoryMessage.pcap"):
            parsed = NasdaqIseoptionsTopcomboquotefeedItchV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_complexstrategytickermessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/IseOptions.TopComboQuoteFeed.Itch.v1.0/ComplexStrategyTickerMessage.pcap"):
            parsed = NasdaqIseoptionsTopcomboquotefeedItchV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/IseOptions.TopComboQuoteFeed.Itch.v1.0/Heartbeat.pcap"):
            parsed = NasdaqIseoptionsTopcomboquotefeedItchV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_strategybestaskupdate(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/IseOptions.TopComboQuoteFeed.Itch.v1.0/StrategyBestAskUpdate.pcap"):
            parsed = NasdaqIseoptionsTopcomboquotefeedItchV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_strategybestbidandaskupdate(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/IseOptions.TopComboQuoteFeed.Itch.v1.0/StrategyBestBidAndAskUpdate.pcap"):
            parsed = NasdaqIseoptionsTopcomboquotefeedItchV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_strategybestbidupdate(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/IseOptions.TopComboQuoteFeed.Itch.v1.0/StrategyBestBidUpdate.pcap"):
            parsed = NasdaqIseoptionsTopcomboquotefeedItchV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_strategyopenclosedmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/IseOptions.TopComboQuoteFeed.Itch.v1.0/StrategyOpenClosedMessage.pcap"):
            parsed = NasdaqIseoptionsTopcomboquotefeedItchV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_strategytradingactionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/IseOptions.TopComboQuoteFeed.Itch.v1.0/StrategyTradingActionMessage.pcap"):
            parsed = NasdaqIseoptionsTopcomboquotefeedItchV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
