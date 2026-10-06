# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nationalequities_trades_pillar_v2_6 import NyseNationalequitiesTradesPillarV26


class NyseNationalequitiesTradesPillarV26Tests(unittest.TestCase):

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.Trades.Pillar.v2.6/SecurityStatusMessage.pcap"):
            parsed = NyseNationalequitiesTradesPillarV26.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_trademessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NationalEquities.Trades.Pillar.v2.6/TradeMessage.pcap"):
            parsed = NyseNationalequitiesTradesPillarV26.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
