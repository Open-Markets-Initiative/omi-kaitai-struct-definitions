# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cixats_cixaspen_marketdatafeed_aspen_v1_4 import CixatsCixaspenMarketdatafeedAspenV14


class CixatsCixaspenMarketdatafeedAspenV14Tests(unittest.TestCase):

    def test_marketeventmessage(self):
        for payload in payloads.of("omi-data-packets/CixAts/CixAspen.MarketDataFeed.Aspen.v1.4/MarketEventMessage.pcap"):
            parsed = CixatsCixaspenMarketdatafeedAspenV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_neworderaddmessage(self):
        for payload in payloads.of("omi-data-packets/CixAts/CixAspen.MarketDataFeed.Aspen.v1.4/NewOrderAddMessage.pcap"):
            parsed = CixatsCixaspenMarketdatafeedAspenV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelallmessage(self):
        for payload in payloads.of("omi-data-packets/CixAts/CixAspen.MarketDataFeed.Aspen.v1.4/OrderCancelAllMessage.pcap"):
            parsed = CixatsCixaspenMarketdatafeedAspenV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/CixAts/CixAspen.MarketDataFeed.Aspen.v1.4/OrderExecutedMessage.pcap"):
            parsed = CixatsCixaspenMarketdatafeedAspenV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderpartialcancelmessage(self):
        for payload in payloads.of("omi-data-packets/CixAts/CixAspen.MarketDataFeed.Aspen.v1.4/OrderPartialCancelMessage.pcap"):
            parsed = CixatsCixaspenMarketdatafeedAspenV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolinformationmessage(self):
        for payload in payloads.of("omi-data-packets/CixAts/CixAspen.MarketDataFeed.Aspen.v1.4/SymbolInformationMessage.pcap"):
            parsed = CixatsCixaspenMarketdatafeedAspenV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolstatemessage(self):
        for payload in payloads.of("omi-data-packets/CixAts/CixAspen.MarketDataFeed.Aspen.v1.4/SymbolStateMessage.pcap"):
            parsed = CixatsCixaspenMarketdatafeedAspenV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_trademessage(self):
        for payload in payloads.of("omi-data-packets/CixAts/CixAspen.MarketDataFeed.Aspen.v1.4/TradeMessage.pcap"):
            parsed = CixatsCixaspenMarketdatafeedAspenV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_multiplemessages(self):
        for payload in payloads.of("omi-data-packets/CixAts/CixAspen.MarketDataFeed.Aspen.v1.4/MultipleMessages.pcap"):
            parsed = CixatsCixaspenMarketdatafeedAspenV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
