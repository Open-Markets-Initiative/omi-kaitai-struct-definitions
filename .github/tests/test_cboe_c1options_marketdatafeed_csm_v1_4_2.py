# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_c1options_marketdatafeed_csm_v1_4_2 import CboeC1optionsMarketdatafeedCsmV142


class CboeC1optionsMarketdatafeedCsmV142Tests(unittest.TestCase):

    def test_currentmarketrefreshmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.MarketDataFeed.Csm.v1.4.2/CurrentMarketRefreshMessage.pcap"):
            parsed = CboeC1optionsMarketdatafeedCsmV142.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_currentmarketupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.MarketDataFeed.Csm.v1.4.2/CurrentMarketUpdateMessage.pcap"):
            parsed = CboeC1optionsMarketdatafeedCsmV142.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.MarketDataFeed.Csm.v1.4.2/Heartbeat.pcap"):
            parsed = CboeC1optionsMarketdatafeedCsmV142.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketdatarefreshmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.MarketDataFeed.Csm.v1.4.2/MarketDataRefreshMessage.pcap"):
            parsed = CboeC1optionsMarketdatafeedCsmV142.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_recapupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.MarketDataFeed.Csm.v1.4.2/RecapUpdateMessage.pcap"):
            parsed = CboeC1optionsMarketdatafeedCsmV142.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitydefinitionmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.MarketDataFeed.Csm.v1.4.2/SecurityDefinitionMessage.pcap"):
            parsed = CboeC1optionsMarketdatafeedCsmV142.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tickermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.MarketDataFeed.Csm.v1.4.2/TickerMessage.pcap"):
            parsed = CboeC1optionsMarketdatafeedCsmV142.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
