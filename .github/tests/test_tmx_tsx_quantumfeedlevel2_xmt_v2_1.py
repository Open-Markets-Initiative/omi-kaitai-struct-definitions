# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from tmx_tsx_quantumfeedlevel2_xmt_v2_1 import TmxTsxQuantumfeedlevel2XmtV21


class TmxTsxQuantumfeedlevel2XmtV21Tests(unittest.TestCase):

    def test_assigncopordersmessage(self):
        for payload in payloads.of("omi-data-packets/Tmx/Tsx.QuantumFeedLevel2.Xmt.v2.1/AssignCopOrdersMessage.pcap"):
            parsed = TmxTsxQuantumfeedlevel2XmtV21.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
