# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cme_globex_ilink3_sbe_v8_5_client import CmeGlobexIlink3SbeV85Client


class CmeGlobexIlink3SbeV85ServerTests(unittest.TestCase):

    def test_executionreportstatus(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.iLink3.Sbe.v8.5/ExecutionReportStatus.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CmeGlobexIlink3SbeV85Client.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quotecancel(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.iLink3.Sbe.v8.5/QuoteCancel.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CmeGlobexIlink3SbeV85Client.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quotecancelack(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.iLink3.Sbe.v8.5/QuoteCancelAck.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CmeGlobexIlink3SbeV85Client.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequence(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.iLink3.Sbe.v8.5/Sequence.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CmeGlobexIlink3SbeV85Client.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
