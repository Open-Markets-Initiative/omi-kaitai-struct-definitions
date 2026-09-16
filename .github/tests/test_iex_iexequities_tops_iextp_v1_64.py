# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from iex_iexequities_tops_iextp_v1_64 import IexIexequitiesTopsIextpV164


class IexIexequitiesTopsIextpV164Tests(unittest.TestCase):

    def test_auctioninformationmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.64/AuctionInformationMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV164.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_officialpricemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.64/OfficialPriceMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV164.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_operationalhaltstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.64/OperationalHaltStatusMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV164.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quoteupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.64/QuoteUpdateMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV164.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitydirectorymessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.64/SecurityDirectoryMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV164.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_shortsalepriceteststatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.64/ShortSalePriceTestStatusMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV164.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.64/SystemEventMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV164.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradereportmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.64/TradeReportMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV164.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.Tops.IexTp.v1.64/TradingStatusMessage.pcap"):
            parsed = IexIexequitiesTopsIextpV164.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
