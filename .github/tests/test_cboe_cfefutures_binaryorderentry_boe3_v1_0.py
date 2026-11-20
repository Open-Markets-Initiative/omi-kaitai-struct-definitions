# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_cfefutures_binaryorderentry_boe3_v1_0_exchange import CboeCfefuturesBinaryorderentryBoe3V10Exchange
from cboe_cfefutures_binaryorderentry_boe3_v1_0_firm import CboeCfefuturesBinaryorderentryBoe3V10Firm


class CboeCfefuturesBinaryorderentryBoe3V10ExchangeTests(unittest.TestCase):

    def test_clientheartbeat(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.BinaryOrderEntry.Boe3.v1.0/ClientHeartbeat.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeCfefuturesBinaryorderentryBoe3V10Firm.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quoteupdate(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.BinaryOrderEntry.Boe3.v1.0/QuoteUpdate.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeCfefuturesBinaryorderentryBoe3V10Firm.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quoteupdateacknowledgement(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.BinaryOrderEntry.Boe3.v1.0/QuoteUpdateAcknowledgement.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeCfefuturesBinaryorderentryBoe3V10Exchange.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_serverheartbeat(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.BinaryOrderEntry.Boe3.v1.0/ServerHeartbeat.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeCfefuturesBinaryorderentryBoe3V10Exchange.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
