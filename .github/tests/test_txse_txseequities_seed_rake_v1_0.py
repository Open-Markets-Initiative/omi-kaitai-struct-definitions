# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from txse_txseequities_seed_rake_v1_0_client import TxseTxseequitiesSeedRakeV10Client
from txse_txseequities_seed_rake_v1_0_server import TxseTxseequitiesSeedRakeV10Server


class TxseTxseequitiesSeedRakeV10ServerTests(unittest.TestCase):

    def test_limitorderacceptedmessage(self):
        for payload in payloads.of("omi-data-packets/Txse/TxseEquities.Seed.Rake.v1.0/LimitOrderAcceptedMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = TxseTxseequitiesSeedRakeV10Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_limitordermessage(self):
        for payload in payloads.of("omi-data-packets/Txse/TxseEquities.Seed.Rake.v1.0/LimitOrderMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = TxseTxseequitiesSeedRakeV10Client.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logonrequestpacket(self):
        for payload in payloads.of("omi-data-packets/Txse/TxseEquities.Seed.Rake.v1.0/LogonRequestPacket.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = TxseTxseequitiesSeedRakeV10Client.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logonresponsemessage(self):
        for payload in payloads.of("omi-data-packets/Txse/TxseEquities.Seed.Rake.v1.0/LogonResponseMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = TxseTxseequitiesSeedRakeV10Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
