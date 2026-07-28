# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from iexequities_tops_v1_6_6 import IexequitiesTopsV166


class IexequitiesTopsV166Tests(unittest.TestCase):

    def test_quoteupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/Tops.IexTp.v1.6/QuoteUpdateMessage.pcap"):
            parsed = IexequitiesTopsV166.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
