# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from eurex_t7_eobi_fbe_v13_0 import EurexT7EobiFbeV130


class EurexT7EobiFbeV130Tests(unittest.TestCase):

    def test_addcomplexinstrument(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/AddComplexInstrument.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_crossrequest(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/CrossRequest.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_executionsummary(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/ExecutionSummary.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_fullorderexecution(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/FullOrderExecution.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/Heartbeat.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_instrumentstatechange(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/InstrumentStateChange.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_instrumentsummary(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/InstrumentSummary.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_massinstrumentstatechange(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/MassInstrumentStateChange.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderadd(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/OrderAdd.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdelete(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/OrderDelete.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordermodify(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/OrderModify.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordermodifysameprio(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/OrderModifySamePrio.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_partialorderexecution(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/PartialOrderExecution.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_productstatechange(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/ProductStateChange.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_productsummary(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/ProductSummary.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quoterequest(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/QuoteRequest.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_snapshotorder(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/SnapshotOrder.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_testradereport(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/TesTradeReport.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradereport(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v13.0/TradeReport.pcap"):
            parsed = EurexT7EobiFbeV130.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
