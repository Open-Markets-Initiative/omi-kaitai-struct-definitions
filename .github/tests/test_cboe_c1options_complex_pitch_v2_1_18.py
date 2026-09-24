# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_c1options_complex_pitch_v2_1_18 import CboeC1optionsComplexPitchV2118


class CboeC1optionsComplexPitchV2118Tests(unittest.TestCase):

    def test_auctioncancelmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.Complex.Pitch.v2.1.18/AuctionCancelMessage.pcap"):
            parsed = CboeC1optionsComplexPitchV2118.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_auctionnotificationmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.Complex.Pitch.v2.1.18/AuctionNotificationMessage.pcap"):
            parsed = CboeC1optionsComplexPitchV2118.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_auctionupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.Complex.Pitch.v2.1.18/AuctionUpdateMessage.pcap"):
            parsed = CboeC1optionsComplexPitchV2118.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_complexinstrumentdefinitionexpandedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.Complex.Pitch.v2.1.18/ComplexInstrumentDefinitionExpandedMessage.pcap"):
            parsed = CboeC1optionsComplexPitchV2118.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_deleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.Complex.Pitch.v2.1.18/DeleteOrderMessage.pcap"):
            parsed = CboeC1optionsComplexPitchV2118.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.Complex.Pitch.v2.1.18/Heartbeat.pcap"):
            parsed = CboeC1optionsComplexPitchV2118.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyordershortmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.Complex.Pitch.v2.1.18/ModifyOrderShortMessage.pcap"):
            parsed = CboeC1optionsComplexPitchV2118.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.Complex.Pitch.v2.1.18/OrderExecutedMessage.pcap"):
            parsed = CboeC1optionsComplexPitchV2118.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolmappingmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.Complex.Pitch.v2.1.18/SymbolMappingMessage.pcap"):
            parsed = CboeC1optionsComplexPitchV2118.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_timemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/C1Options.Complex.Pitch.v2.1.18/TimeMessage.pcap"):
            parsed = CboeC1optionsComplexPitchV2118.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
