# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from eurex_t7_eobi_fbe_v3_0 import EurexT7EobiFbeV30


class EurexT7EobiFbeV30Tests(unittest.TestCase):

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v3.0/Heartbeat.pcap"):
            parsed = EurexT7EobiFbeV30.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderadd(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v3.0/OrderAdd.pcap"):
            parsed = EurexT7EobiFbeV30.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_snapshotorder(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eobi.Fbe.v3.0/SnapshotOrder.pcap"):
            parsed = EurexT7EobiFbeV30.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
