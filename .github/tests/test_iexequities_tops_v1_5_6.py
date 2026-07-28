# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from iexequities_tops_v1_5_6 import IexequitiesTopsV156


class IexequitiesTopsV156Tests(unittest.TestCase):

    def test_auctioninformationmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/Tops.IexTp.v1.5/AuctionInformationMessage.pcap"):
            parsed = IexequitiesTopsV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_officialpricemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/Tops.IexTp.v1.5/OfficialPriceMessage.pcap"):
            parsed = IexequitiesTopsV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_operationalhaltstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/Tops.IexTp.v1.5/OperationalHaltStatusMessage.pcap"):
            parsed = IexequitiesTopsV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quoteupdatemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/Tops.IexTp.v1.5/QuoteUpdateMessage.pcap"):
            parsed = IexequitiesTopsV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitydirectorymessage(self):
        for payload in payloads.of("omi-data-packets/Iex/Tops.IexTp.v1.5/SecurityDirectoryMessage.pcap"):
            parsed = IexequitiesTopsV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_shortsalepriceteststatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/Tops.IexTp.v1.5/ShortSalePriceTestStatusMessage.pcap"):
            parsed = IexequitiesTopsV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/Tops.IexTp.v1.5/SystemEventMessage.pcap"):
            parsed = IexequitiesTopsV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradereportmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/Tops.IexTp.v1.5/TradeReportMessage.pcap"):
            parsed = IexequitiesTopsV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/Tops.IexTp.v1.5/TradingStatusMessage.pcap"):
            parsed = IexequitiesTopsV156.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
