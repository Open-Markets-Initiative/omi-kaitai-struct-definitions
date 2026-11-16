# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from moex_spectra_orderslogsnapshot_simba_v8_0_0 import MoexSpectraOrderslogsnapshotSimbaV800


class MoexSpectraOrderslogsnapshotSimbaV800Tests(unittest.TestCase):

    def test_orderbooksnapshotmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OrdersLogSnapshot.Simba.v8.0.0/OrderBookSnapshotMessage.pcap"):
            parsed = MoexSpectraOrderslogsnapshotSimbaV800.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequenceresetmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OrdersLogSnapshot.Simba.v8.0.0/SequenceResetMessage.pcap"):
            parsed = MoexSpectraOrderslogsnapshotSimbaV800.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
