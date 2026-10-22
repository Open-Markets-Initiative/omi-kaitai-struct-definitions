# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nysebonds_depthofbook_abp_v4_01_b_server import NyseNysebondsDepthofbookAbpV401BServer


class NyseNysebondsDepthofbookAbpV401BClientTests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseBonds.DepthOfBook.Abp.v4.01.b/AddOrderMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", 4):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NyseNysebondsDepthofbookAbpV401BServer.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_deleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseBonds.DepthOfBook.Abp.v4.01.b/DeleteOrderMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", 4):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NyseNysebondsDepthofbookAbpV401BServer.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
