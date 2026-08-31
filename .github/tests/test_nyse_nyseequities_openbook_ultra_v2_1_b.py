# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nyseequities_openbook_ultra_v2_1_b import NyseNyseequitiesOpenbookUltraV21B


class NyseNyseequitiesOpenbookUltraV21BTests(unittest.TestCase):

    def test_deltaupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.OpenBook.Ultra.v2.1.b/DeltaUpdateMessage.pcap"):
            parsed = NyseNyseequitiesOpenbookUltraV21B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_fullupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.OpenBook.Ultra.v2.1.b/FullUpdateMessage.pcap"):
            parsed = NyseNyseequitiesOpenbookUltraV21B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeatmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.OpenBook.Ultra.v2.1.b/HeartbeatMessage.pcap"):
            parsed = NyseNyseequitiesOpenbookUltraV21B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequencenumberresetmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.OpenBook.Ultra.v2.1.b/SequenceNumberResetMessage.pcap"):
            parsed = NyseNyseequitiesOpenbookUltraV21B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
