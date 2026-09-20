# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from iex_iexequities_deepplus_iextp_v1_05 import IexIexequitiesDeepplusIextpV105


class IexIexequitiesDeepplusIextpV105Tests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.05/AddOrderMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_operationalhaltstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.05/OperationalHaltStatusMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdeletemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.05/OrderDeleteMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.05/OrderExecutedMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordermodifymessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.05/OrderModifyMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_retailliquidityindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.05/RetailLiquidityIndicatorMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securityeventmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.05/SecurityEventMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_shortsalepriceteststatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.05/ShortSalePriceTestStatusMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.05/SystemEventMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_trademessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.05/TradeMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.05/TradingStatusMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
