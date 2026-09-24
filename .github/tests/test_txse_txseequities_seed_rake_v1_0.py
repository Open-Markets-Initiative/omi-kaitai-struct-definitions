# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from txse_txseequities_seed_rake_v1_0 import TxseTxseequitiesSeedRakeV10


class TxseTxseequitiesSeedRakeV10Tests(unittest.TestCase):

    def test_definesymbolmessage(self):
        for payload in payloads.of("omi-data-packets/Txse/TxseEquities.Seed.Rake.v1.0/DefineSymbolMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = TxseTxseequitiesSeedRakeV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_limitorderaccepted(self):
        for payload in payloads.of("omi-data-packets/Txse/TxseEquities.Seed.Rake.v1.0/LimitOrderAccepted.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = TxseTxseequitiesSeedRakeV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_limitordermessage(self):
        for payload in payloads.of("omi-data-packets/Txse/TxseEquities.Seed.Rake.v1.0/LimitOrderMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = TxseTxseequitiesSeedRakeV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logonrequestmessage(self):
        for payload in payloads.of("omi-data-packets/Txse/TxseEquities.Seed.Rake.v1.0/LogonRequestMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = TxseTxseequitiesSeedRakeV10.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
