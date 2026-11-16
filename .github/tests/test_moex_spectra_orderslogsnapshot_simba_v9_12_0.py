# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from moex_spectra_orderslogsnapshot_simba_v9_12_0 import MoexSpectraOrderslogsnapshotSimbaV9120


class MoexSpectraOrderslogsnapshotSimbaV9120Tests(unittest.TestCase):

    def test_messagesequence(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OrdersLogSnapshot.Simba.v9.12.0/MessageSequence.pcap"):
            parsed = MoexSpectraOrderslogsnapshotSimbaV9120.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderbooksnapshotmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OrdersLogSnapshot.Simba.v9.12.0/OrderBookSnapshotMessage.pcap"):
            parsed = MoexSpectraOrderslogsnapshotSimbaV9120.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequenceresetmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OrdersLogSnapshot.Simba.v9.12.0/SequenceResetMessage.pcap"):
            parsed = MoexSpectraOrderslogsnapshotSimbaV9120.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
