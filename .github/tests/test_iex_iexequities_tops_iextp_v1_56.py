# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from iex_iexequities_tops_iextp_v1_56 import IexIexequitiesTopsIextpV156


class IexIexequitiesTopsIextpV156Tests(unittest.TestCase):

    def test_auctioninformationmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.v1.5/AuctionInformationMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_officialpricemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.v1.5/OfficialPriceMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_operationalhaltstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.v1.5/OperationalHaltStatusMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quoteupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.v1.5/QuoteUpdateMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitydirectorymessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.v1.5/SecurityDirectoryMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_shortsalepriceteststatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.v1.5/ShortSalePriceTestStatusMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.v1.5/SystemEventMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradereportmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.v1.5/TradeReportMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.v1.5/TradingStatusMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
