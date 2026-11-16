# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from moex_spectra_orderslogincremental_simba_v8_0_0 import MoexSpectraOrderslogincrementalSimbaV800


class MoexSpectraOrderslogincrementalSimbaV800Tests(unittest.TestCase):

    def test_bestpricesmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OrdersLogIncremental.Simba.v8.0.0/BestPricesMessage.pcap"):
            parsed = MoexSpectraOrderslogincrementalSimbaV800.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutionmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OrdersLogIncremental.Simba.v8.0.0/OrderExecutionMessage.pcap"):
            parsed = MoexSpectraOrderslogincrementalSimbaV800.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OrdersLogIncremental.Simba.v8.0.0/OrderUpdateMessage.pcap"):
            parsed = MoexSpectraOrderslogincrementalSimbaV800.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
