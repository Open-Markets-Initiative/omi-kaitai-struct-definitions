# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nyseequities_bbo_xdp_v2_4_g import NyseNyseequitiesBboXdpV24G


class NyseNyseequitiesBboXdpV24GTests(unittest.TestCase):

    def test_quotemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.Bbo.Xdp.v2.4.g/QuoteMessage.pcap"):
            parsed = NyseNyseequitiesBboXdpV24G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.Bbo.Xdp.v2.4.g/SecurityStatusMessage.pcap"):
            parsed = NyseNyseequitiesBboXdpV24G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequencenumberresetmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.Bbo.Xdp.v2.4.g/SequenceNumberResetMessage.pcap"):
            parsed = NyseNyseequitiesBboXdpV24G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolindexmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.Bbo.Xdp.v2.4.g/SymbolIndexMappingMessage.pcap"):
            parsed = NyseNyseequitiesBboXdpV24G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingsessionchangemessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.Bbo.Xdp.v2.4.g/TradingSessionChangeMessage.pcap"):
            parsed = NyseNyseequitiesBboXdpV24G.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
