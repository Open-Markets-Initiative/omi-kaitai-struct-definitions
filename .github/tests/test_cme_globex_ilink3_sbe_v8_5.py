# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cme_globex_ilink3_sbe_v8_5_server import CmeGlobexIlink3SbeV85Server


class CmeGlobexIlink3SbeV85ServerTests(unittest.TestCase):

    def test_executionreportstatus(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.iLink3.Sbe.v8.5/ExecutionReportStatus.pcap"):
            parsed = CmeGlobexIlink3SbeV85Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quotecancel(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.iLink3.Sbe.v8.5/QuoteCancel.pcap"):
            parsed = CmeGlobexIlink3SbeV85Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quotecancelack(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.iLink3.Sbe.v8.5/QuoteCancelAck.pcap"):
            parsed = CmeGlobexIlink3SbeV85Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequence(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.iLink3.Sbe.v8.5/Sequence.pcap"):
            parsed = CmeGlobexIlink3SbeV85Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
