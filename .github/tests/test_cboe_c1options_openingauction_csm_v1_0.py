# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_c1options_openingauction_csm_v1_0 import CboeC1optionsOpeningauctionCsmV10


class CboeC1optionsOpeningauctionCsmV10Tests(unittest.TestCase):

    def test_currentmarketupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.OpeningAuction.Csm.v1.0/CurrentMarketUpdateMessage.pcap"):
            parsed = CboeC1optionsOpeningauctionCsmV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_expectedopeningpriceandsizemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.OpeningAuction.Csm.v1.0/ExpectedOpeningPriceAndSizeMessage.pcap"):
            parsed = CboeC1optionsOpeningauctionCsmV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeatmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.OpeningAuction.Csm.v1.0/HeartbeatMessage.pcap"):
            parsed = CboeC1optionsOpeningauctionCsmV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketdatarefreshmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.OpeningAuction.Csm.v1.0/MarketDataRefreshMessage.pcap"):
            parsed = CboeC1optionsOpeningauctionCsmV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitydefinitionmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.OpeningAuction.Csm.v1.0/SecurityDefinitionMessage.pcap"):
            parsed = CboeC1optionsOpeningauctionCsmV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
