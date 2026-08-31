# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from blueoceanats_blueequities_memoirlastsale_sbe_v1_3 import BlueoceanatsBlueequitiesMemoirlastsaleSbeV13


class BlueoceanatsBlueequitiesMemoirlastsaleSbeV13Tests(unittest.TestCase):

    def test_instrumentdirectorymessage(self):
        for payload in payloads.of("omi-data-packets/BlueOceanAts/BlueEquities.MemoirLastSale.Sbe.v1.3/InstrumentDirectoryMessage.pcap"):
            parsed = BlueoceanatsBlueequitiesMemoirlastsaleSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitytradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/BlueOceanAts/BlueEquities.MemoirLastSale.Sbe.v1.3/SecurityTradingStatusMessage.pcap"):
            parsed = BlueoceanatsBlueequitiesMemoirlastsaleSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradereportmessage(self):
        for payload in payloads.of("omi-data-packets/BlueOceanAts/BlueEquities.MemoirLastSale.Sbe.v1.3/TradeReportMessage.pcap"):
            parsed = BlueoceanatsBlueequitiesMemoirlastsaleSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingsessionstatusmessage(self):
        for payload in payloads.of("omi-data-packets/BlueOceanAts/BlueEquities.MemoirLastSale.Sbe.v1.3/TradingSessionStatusMessage.pcap"):
            parsed = BlueoceanatsBlueequitiesMemoirlastsaleSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
