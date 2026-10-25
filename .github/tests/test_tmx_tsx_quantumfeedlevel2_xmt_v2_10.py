# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from tmx_tsx_quantumfeedlevel2_xmt_v2_10 import TmxTsxQuantumfeedlevel2XmtV210


class TmxTsxQuantumfeedlevel2XmtV210Tests(unittest.TestCase):

    def test_assigncopordersmessage(self):
        for payload in payloads.of("omi-data-packets/Tmx/Tsx.QuantumFeedLevel2.Xmt.v2.10/AssignCopOrdersMessage.pcap"):
            parsed = TmxTsxQuantumfeedlevel2XmtV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderbookedmessage(self):
        for payload in payloads.of("omi-data-packets/Tmx/Tsx.QuantumFeedLevel2.Xmt.v2.10/OrderBookedMessage.pcap"):
            parsed = TmxTsxQuantumfeedlevel2XmtV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelledmessage(self):
        for payload in payloads.of("omi-data-packets/Tmx/Tsx.QuantumFeedLevel2.Xmt.v2.10/OrderCancelledMessage.pcap"):
            parsed = TmxTsxQuantumfeedlevel2XmtV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradereportmessage(self):
        for payload in payloads.of("omi-data-packets/Tmx/Tsx.QuantumFeedLevel2.Xmt.v2.10/TradeReportMessage.pcap"):
            parsed = TmxTsxQuantumfeedlevel2XmtV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
