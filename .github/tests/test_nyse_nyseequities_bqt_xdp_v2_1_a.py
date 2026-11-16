# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nyseequities_bqt_xdp_v2_1_a import NyseNyseequitiesBqtXdpV21A


class NyseNyseequitiesBqtXdpV21ATests(unittest.TestCase):

    def test_consolidatedstocksummarymessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.Bqt.Xdp.v2.1.a/ConsolidatedStockSummaryMessage.pcap"):
            parsed = NyseNyseequitiesBqtXdpV21A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequencenumberresetmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.Bqt.Xdp.v2.1.a/SequenceNumberResetMessage.pcap"):
            parsed = NyseNyseequitiesBqtXdpV21A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
