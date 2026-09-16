# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from iex_iexequities_tops_iextp_v1_56 import IexIexequitiesTopsIextpV156


class IexIexequitiesTopsIextpV156Tests(unittest.TestCase):

    def test_quoteupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.56/QuoteUpdateMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradereportmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.56/TradeReportMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
