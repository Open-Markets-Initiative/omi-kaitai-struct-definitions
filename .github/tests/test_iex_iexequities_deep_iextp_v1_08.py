# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from iex_iexequities_deep_iextp_v1_08 import IexIexequitiesDeepIextpV108


class IexIexequitiesDeepIextpV108Tests(unittest.TestCase):

    def test_auctioninformationmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.08/AuctionInformationMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV108.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_operationalhaltstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.08/OperationalHaltStatusMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV108.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_pricelevelbuyupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.08/PriceLevelBuyUpdateMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV108.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_pricelevelsellupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.08/PriceLevelSellUpdateMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV108.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_retailliquidityindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.08/RetailLiquidityIndicatorMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV108.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securityeventmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.08/SecurityEventMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV108.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_shortsalepriceteststatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.08/ShortSalePriceTestStatusMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV108.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.08/SystemEventMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV108.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradereportmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.08/TradeReportMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV108.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.08/TradingStatusMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV108.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
