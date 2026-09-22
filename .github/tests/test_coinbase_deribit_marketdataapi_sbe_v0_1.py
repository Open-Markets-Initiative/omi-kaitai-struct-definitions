# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from coinbase_deribit_marketdataapi_sbe_v0_1 import CoinbaseDeribitMarketdataapiSbeV01


class CoinbaseDeribitMarketdataapiSbeV01Tests(unittest.TestCase):

    def test_askdeletemessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.MarketDataApi.Sbe.v0.1/AskDeleteMessage.pcap"):
            parsed = CoinbaseDeribitMarketdataapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_askputmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.MarketDataApi.Sbe.v0.1/AskPutMessage.pcap"):
            parsed = CoinbaseDeribitMarketdataapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_askqtyreducedmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.MarketDataApi.Sbe.v0.1/AskQtyReducedMessage.pcap"):
            parsed = CoinbaseDeribitMarketdataapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_biddeletemessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.MarketDataApi.Sbe.v0.1/BidDeleteMessage.pcap"):
            parsed = CoinbaseDeribitMarketdataapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_bidputmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.MarketDataApi.Sbe.v0.1/BidPutMessage.pcap"):
            parsed = CoinbaseDeribitMarketdataapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_bidqtyreducedmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.MarketDataApi.Sbe.v0.1/BidQtyReducedMessage.pcap"):
            parsed = CoinbaseDeribitMarketdataapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_endofcyclemessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.MarketDataApi.Sbe.v0.1/EndOfCycleMessage.pcap"):
            parsed = CoinbaseDeribitMarketdataapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_instrumentmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.MarketDataApi.Sbe.v0.1/InstrumentMessage.pcap"):
            parsed = CoinbaseDeribitMarketdataapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_snapshottrailermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.MarketDataApi.Sbe.v0.1/SnapshotTrailerMessage.pcap"):
            parsed = CoinbaseDeribitMarketdataapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
