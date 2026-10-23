# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from tmx_mx_solamulticast_hsvf_v1_14_1 import TmxMxSolamulticastHsvfV1141


class TmxMxSolamulticastHsvfV1141Tests(unittest.TestCase):

    def test_optionmarketdepthmessage(self):
        for payload in payloads.of("omi-data-packets/Tmx/Mx.SolaMulticast.Hsvf.v1.14.1/OptionMarketDepthMessage.pcap"):
            parsed = TmxMxSolamulticastHsvfV1141.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optiontrademessage(self):
        for payload in payloads.of("omi-data-packets/Tmx/Mx.SolaMulticast.Hsvf.v1.14.1/OptionTradeMessage.pcap"):
            parsed = TmxMxSolamulticastHsvfV1141.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_strategyauctionbeginningmessage(self):
        for payload in payloads.of("omi-data-packets/Tmx/Mx.SolaMulticast.Hsvf.v1.14.1/StrategyAuctionBeginningMessage.pcap"):
            parsed = TmxMxSolamulticastHsvfV1141.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_strategyinstrumentkeysmessage(self):
        for payload in payloads.of("omi-data-packets/Tmx/Mx.SolaMulticast.Hsvf.v1.14.1/StrategyInstrumentKeysMessage.pcap"):
            parsed = TmxMxSolamulticastHsvfV1141.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_strategymarketdepthmessage(self):
        for payload in payloads.of("omi-data-packets/Tmx/Mx.SolaMulticast.Hsvf.v1.14.1/StrategyMarketDepthMessage.pcap"):
            parsed = TmxMxSolamulticastHsvfV1141.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_strategytrademessage(self):
        for payload in payloads.of("omi-data-packets/Tmx/Mx.SolaMulticast.Hsvf.v1.14.1/StrategyTradeMessage.pcap"):
            parsed = TmxMxSolamulticastHsvfV1141.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
