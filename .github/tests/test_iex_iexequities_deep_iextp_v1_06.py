# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from iex_iexequities_deep_iextp_v1_06 import IexIexequitiesDeepIextpV106


class IexIexequitiesDeepIextpV106Tests(unittest.TestCase):

    def test_auctioninformationmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.06/AuctionInformationMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV106.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.06/Heartbeat.pcap"):
            parsed = IexIexequitiesDeepIextpV106.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_officialpricemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.06/OfficialPriceMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV106.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_pricelevelbuyupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.06/PriceLevelBuyUpdateMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV106.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_pricelevelsellupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.06/PriceLevelSellUpdateMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV106.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securityeventmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.06/SecurityEventMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV106.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_shortsalepriceteststatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.06/ShortSalePriceTestStatusMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV106.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.06/SystemEventMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV106.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradereportmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.06/TradeReportMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV106.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Deep.IexTp.v1.06/TradingStatusMessage.pcap"):
            parsed = IexIexequitiesDeepIextpV106.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
