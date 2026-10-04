# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from iex_iexequities_deepplus_iextp_v1_01 import IexIexequitiesDeepplusIextpV101


class IexIexequitiesDeepplusIextpV101Tests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.01/AddOrderMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_operationalhaltstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.01/OperationalHaltStatusMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdeletemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.01/OrderDeleteMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.01/OrderExecutedMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordermodifymessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.01/OrderModifyMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_retailliquidityindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.01/RetailLiquidityIndicatorMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitydirectorymessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.01/SecurityDirectoryMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securityeventmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.01/SecurityEventMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_shortsalepriceteststatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.01/ShortSalePriceTestStatusMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.01/SystemEventMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradebreakmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.01/TradeBreakMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_trademessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.01/TradeMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.01/TradingStatusMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
