# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_arcaequities_bbo_xdp_v2_4_c import NyseArcaequitiesBboXdpV24C


class NyseArcaequitiesBboXdpV24CTests(unittest.TestCase):

    def test_quotemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaEquities.Bbo.Xdp.v2.4.c/QuoteMessage.pcap"):
            parsed = NyseArcaequitiesBboXdpV24C.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequencenumberresetmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaEquities.Bbo.Xdp.v2.4.c/SequenceNumberResetMessage.pcap"):
            parsed = NyseArcaequitiesBboXdpV24C.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/ArcaEquities.Bbo.Xdp.v2.4.c/SymbolIndexMappingMessage.pcap"):
            parsed = NyseArcaequitiesBboXdpV24C.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
