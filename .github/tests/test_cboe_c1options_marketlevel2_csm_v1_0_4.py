# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_c1options_marketlevel2_csm_v1_0_4 import CboeC1optionsMarketlevel2CsmV104


class CboeC1optionsMarketlevel2CsmV104Tests(unittest.TestCase):

    def test_heartbeatmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.MarketLevel2.Csm.v1.0.4/HeartbeatMessage.pcap"):
            parsed = CboeC1optionsMarketlevel2CsmV104.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_incrementalrefreshmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.MarketLevel2.Csm.v1.0.4/IncrementalRefreshMessage.pcap"):
            parsed = CboeC1optionsMarketlevel2CsmV104.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitydefinitionmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.MarketLevel2.Csm.v1.0.4/SecurityDefinitionMessage.pcap"):
            parsed = CboeC1optionsMarketlevel2CsmV104.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.MarketLevel2.Csm.v1.0.4/SecurityStatusMessage.pcap"):
            parsed = CboeC1optionsMarketlevel2CsmV104.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_snapshotfullrefreshmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.MarketLevel2.Csm.v1.0.4/SnapshotFullRefreshMessage.pcap"):
            parsed = CboeC1optionsMarketlevel2CsmV104.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
