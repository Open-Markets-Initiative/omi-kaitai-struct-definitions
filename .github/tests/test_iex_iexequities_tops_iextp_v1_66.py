# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from iex_iexequities_tops_iextp_v1_66 import IexIexequitiesTopsIextpV166


class IexIexequitiesTopsIextpV166Tests(unittest.TestCase):

    def test_auctioninformationmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.66/AuctionInformationMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV166.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quoteupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.66/QuoteUpdateMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV166.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_retailliquidityindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.66/RetailLiquidityIndicatorMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV166.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_shortsalepriceteststatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.66/ShortSalePriceTestStatusMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV166.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.66/SystemEventMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV166.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradereportmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.66/TradeReportMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV166.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.66/TradingStatusMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV166.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
