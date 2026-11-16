# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from moex_spectra_orderslogincremental_simba_v9_12_0 import MoexSpectraOrderslogincrementalSimbaV9120


class MoexSpectraOrderslogincrementalSimbaV9120Tests(unittest.TestCase):

    def test_bestpricesmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OrdersLogIncremental.Simba.v9.12.0/BestPricesMessage.pcap"):
            parsed = MoexSpectraOrderslogincrementalSimbaV9120.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_messagesequence(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OrdersLogIncremental.Simba.v9.12.0/MessageSequence.pcap"):
            parsed = MoexSpectraOrderslogincrementalSimbaV9120.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutionmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OrdersLogIncremental.Simba.v9.12.0/OrderExecutionMessage.pcap"):
            parsed = MoexSpectraOrderslogincrementalSimbaV9120.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OrdersLogIncremental.Simba.v9.12.0/OrderUpdateMessage.pcap"):
            parsed = MoexSpectraOrderslogincrementalSimbaV9120.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
