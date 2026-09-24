# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_cfefutures_binaryorderentry_boe3_v1_1_20_exchange import CboeCfefuturesBinaryorderentryBoe3V1120Exchange
from cboe_cfefutures_binaryorderentry_boe3_v1_1_20_firm import CboeCfefuturesBinaryorderentryBoe3V1120Firm


class CboeCfefuturesBinaryorderentryBoe3V1120ExchangeTests(unittest.TestCase):

    def test_clientheartbeatmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.BinaryOrderEntry.Boe3.v1.1.20/ClientHeartbeatMessage.pcap"):
            parsed = CboeCfefuturesBinaryorderentryBoe3V1120Firm.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quoteupdate(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.BinaryOrderEntry.Boe3.v1.1.20/QuoteUpdate.pcap"):
            parsed = CboeCfefuturesBinaryorderentryBoe3V1120Firm.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quoteupdateacknowledgement(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.BinaryOrderEntry.Boe3.v1.1.20/QuoteUpdateAcknowledgement.pcap"):
            parsed = CboeCfefuturesBinaryorderentryBoe3V1120Exchange.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_serverheartbeatmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.BinaryOrderEntry.Boe3.v1.1.20/ServerHeartbeatMessage.pcap"):
            parsed = CboeCfefuturesBinaryorderentryBoe3V1120Exchange.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
