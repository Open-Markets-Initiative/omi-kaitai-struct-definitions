# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from iex_iexequities_tops_iextp_v1_64 import IexIexequitiesTopsIextpV164


class IexIexequitiesTopsIextpV164Tests(unittest.TestCase):

    def test_quoteupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.v1.64/QuoteUpdateMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV164.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
