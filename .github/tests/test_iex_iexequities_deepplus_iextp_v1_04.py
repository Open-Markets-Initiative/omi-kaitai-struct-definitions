# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from iex_iexequities_deepplus_iextp_v1_04 import IexIexequitiesDeepplusIextpV104


class IexIexequitiesDeepplusIextpV104Tests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.04/AddOrderMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV104.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_operationalhaltstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.04/OperationalHaltStatusMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV104.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdeletemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.04/OrderDeleteMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV104.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.04/OrderExecutedMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV104.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordermodifymessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.04/OrderModifyMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV104.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_retailliquidityindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.04/RetailLiquidityIndicatorMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV104.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securityeventmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.04/SecurityEventMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV104.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_shortsalepriceteststatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.04/ShortSalePriceTestStatusMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV104.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.04/SystemEventMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV104.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_trademessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.04/TradeMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV104.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.04/TradingStatusMessage.pcap"):
            parsed = IexIexequitiesDeepplusIextpV104.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
