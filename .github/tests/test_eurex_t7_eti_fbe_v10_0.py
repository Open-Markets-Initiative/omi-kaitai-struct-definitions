# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from eurex_t7_eti_fbe_v10_0_server import EurexT7EtiFbeV100Server


class EurexT7EtiFbeV100ServerTests(unittest.TestCase):

    def test_orderexecresponse(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eti.Fbe.v10.0/OrderExecResponse.pcap"):
            if payloads.partial(payload, 0, 4, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = EurexT7EtiFbeV100Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
