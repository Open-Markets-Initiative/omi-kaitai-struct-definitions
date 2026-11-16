# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nyseequities_openbookaggregated_xdp_v2_1_d import NyseNyseequitiesOpenbookaggregatedXdpV21D


class NyseNyseequitiesOpenbookaggregatedXdpV21DTests(unittest.TestCase):

    def test_orderbookdeltaupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.OpenBook.Aggregated.Xdp.v2.1.d/OrderbookDeltaUpdateMessage.pcap"):
            parsed = NyseNyseequitiesOpenbookaggregatedXdpV21D.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderbooksnapshotmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.OpenBook.Aggregated.Xdp.v2.1.d/OrderbookSnapshotMessage.pcap"):
            parsed = NyseNyseequitiesOpenbookaggregatedXdpV21D.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequencenumberresetmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.OpenBook.Aggregated.Xdp.v2.1.d/SequenceNumberResetMessage.pcap"):
            parsed = NyseNyseequitiesOpenbookaggregatedXdpV21D.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.OpenBook.Aggregated.Xdp.v2.1.d/SymbolIndexMappingMessage.pcap"):
            parsed = NyseNyseequitiesOpenbookaggregatedXdpV21D.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
