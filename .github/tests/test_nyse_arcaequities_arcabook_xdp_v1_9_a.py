# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_arcaequities_arcabook_xdp_v1_9_a import NyseArcaequitiesArcabookXdpV19A


class NyseArcaequitiesArcabookXdpV19ATests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaEquities.ArcaBook.Xdp.v1.9.a/AddOrderMessage.pcap"):
            parsed = NyseArcaequitiesArcabookXdpV19A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_deleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaEquities.ArcaBook.Xdp.v1.9.a/DeleteOrderMessage.pcap"):
            parsed = NyseArcaequitiesArcabookXdpV19A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_executionmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaEquities.ArcaBook.Xdp.v1.9.a/ExecutionMessage.pcap"):
            parsed = NyseArcaequitiesArcabookXdpV19A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_imbalancemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaEquities.ArcaBook.Xdp.v1.9.a/ImbalanceMessage.pcap"):
            parsed = NyseArcaequitiesArcabookXdpV19A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_messagesequence(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaEquities.ArcaBook.Xdp.v1.9.a/MessageSequence.pcap"):
            parsed = NyseArcaequitiesArcabookXdpV19A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyordermessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaEquities.ArcaBook.Xdp.v1.9.a/ModifyOrderMessage.pcap"):
            parsed = NyseArcaequitiesArcabookXdpV19A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
