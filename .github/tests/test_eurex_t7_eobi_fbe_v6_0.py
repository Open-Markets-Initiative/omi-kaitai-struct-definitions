# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from eurex_t7_eobi_fbe_v6_0 import EurexT7EobiFbeV60


class EurexT7EobiFbeV60Tests(unittest.TestCase):

    def test_executionsummary(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v6.0/ExecutionSummary.pcap"):
            parsed = EurexT7EobiFbeV60.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_fullorderexecution(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v6.0/FullOrderExecution.pcap"):
            parsed = EurexT7EobiFbeV60.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v6.0/Heartbeat.pcap"):
            parsed = EurexT7EobiFbeV60.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_instrumentsummary(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v6.0/InstrumentSummary.pcap"):
            parsed = EurexT7EobiFbeV60.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderadd(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v6.0/OrderAdd.pcap"):
            parsed = EurexT7EobiFbeV60.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordermodify(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v6.0/OrderModify.pcap"):
            parsed = EurexT7EobiFbeV60.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_partialorderexecution(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v6.0/PartialOrderExecution.pcap"):
            parsed = EurexT7EobiFbeV60.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_productsummary(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v6.0/ProductSummary.pcap"):
            parsed = EurexT7EobiFbeV60.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_snapshotorder(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v6.0/SnapshotOrder.pcap"):
            parsed = EurexT7EobiFbeV60.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
