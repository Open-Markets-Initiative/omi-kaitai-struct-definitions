# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from coinbase_coinbasederivatives_marketdataapi_sbe_v1_2 import CoinbaseCoinbasederivativesMarketdataapiSbeV12


class CoinbaseCoinbasederivativesMarketdataapiSbeV12Tests(unittest.TestCase):

    def test_orderdeletemessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.MarketDataApi.Sbe.v1.2/OrderDeleteMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesMarketdataapiSbeV12.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderputmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.MarketDataApi.Sbe.v1.2/OrderPutMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesMarketdataapiSbeV12.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordersnapshotmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.MarketDataApi.Sbe.v1.2/OrderSnapshotMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesMarketdataapiSbeV12.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_startofoutrightinstrumentsnapshotmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.MarketDataApi.Sbe.v1.2/StartOfOutrightInstrumentSnapshotMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesMarketdataapiSbeV12.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_startofspreadinstrumentsnapshotmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.MarketDataApi.Sbe.v1.2/StartOfSpreadInstrumentSnapshotMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesMarketdataapiSbeV12.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
