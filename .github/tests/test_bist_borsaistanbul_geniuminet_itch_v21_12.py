# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from bist_borsaistanbul_geniuminet_itch_v21_12 import BistBorsaistanbulGeniuminetItchV2112


class BistBorsaistanbulGeniuminetItchV2112Tests(unittest.TestCase):

    def test_combinationorderbookleg(self):
        for payload in payloads.of("omi-data-packets/Bist/BorsaIstanbul.GeniumInet.Itch.v21.12/CombinationOrderBookLeg.pcap"):
            parsed = BistBorsaistanbulGeniuminetItchV2112.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderbookstatemessage(self):
        for payload in payloads.of("omi-data-packets/Bist/BorsaIstanbul.GeniumInet.Itch.v21.12/OrderBookStateMessage.pcap"):
            parsed = BistBorsaistanbulGeniuminetItchV2112.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
