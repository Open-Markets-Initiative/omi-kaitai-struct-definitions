# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from imperative_intelligentcross_depthofbook_aspen_v1_11 import ImperativeIntelligentcrossDepthofbookAspenV111


class ImperativeIntelligentcrossDepthofbookAspenV111Tests(unittest.TestCase):

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Imperative/IntelligentCross.DepthOfBook.Aspen.v1.11/OrderExecutedMessage.pcap"):
            parsed = ImperativeIntelligentcrossDepthofbookAspenV111.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_trademessage(self):
        for payload in payloads.of("omi-data-packets/Imperative/IntelligentCross.DepthOfBook.Aspen.v1.11/TradeMessage.pcap"):
            parsed = ImperativeIntelligentcrossDepthofbookAspenV111.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
