# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_amexequities_openbookaggregated_xdp_v2_1_d import NyseAmexequitiesOpenbookaggregatedXdpV21D


class NyseAmexequitiesOpenbookaggregatedXdpV21DTests(unittest.TestCase):

    def test_orderbookdeltaupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.OpenBook.Aggregated.Xdp.v2.1.d/OrderbookDeltaUpdateMessage.pcap"):
            parsed = NyseAmexequitiesOpenbookaggregatedXdpV21D.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderbooksnapshotmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.OpenBook.Aggregated.Xdp.v2.1.d/OrderbookSnapshotMessage.pcap"):
            parsed = NyseAmexequitiesOpenbookaggregatedXdpV21D.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequencenumberresetmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.OpenBook.Aggregated.Xdp.v2.1.d/SequenceNumberResetMessage.pcap"):
            parsed = NyseAmexequitiesOpenbookaggregatedXdpV21D.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/AmexEquities.OpenBook.Aggregated.Xdp.v2.1.d/SymbolIndexMappingMessage.pcap"):
            parsed = NyseAmexequitiesOpenbookaggregatedXdpV21D.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
