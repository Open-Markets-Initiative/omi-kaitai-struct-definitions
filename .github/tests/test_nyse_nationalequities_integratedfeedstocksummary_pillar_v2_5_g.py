# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nationalequities_integratedfeedstocksummary_pillar_v2_5_g import NyseNationalequitiesIntegratedfeedstocksummaryPillarV25G


class NyseNationalequitiesIntegratedfeedstocksummaryPillarV25GTests(unittest.TestCase):

    def test_stocksummarymessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.IntegratedFeedStockSummary.Pillar.v2.5.g/StockSummaryMessage.pcap"):
            parsed = NyseNationalequitiesIntegratedfeedstocksummaryPillarV25G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
