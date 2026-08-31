# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from iex_iexequities_deepplus_iextp_v1_01 import IexIexequitiesDeepplusIextpV101


class IexIexequitiesDeepplusIextpV101Tests(unittest.TestCase):

    def test_tradebreakmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.0.2/B_TradeBreak.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitydirectorymessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.0.2/D_SecurityDirectory.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securityevent(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.0.2/E_SecurityEvent.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatus(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.0.2/H_TradingStatus.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_retailliquidityindicator(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.0.2/I_RetailLiquidityIndicator.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.0.2/L_OrderExecuted.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordermodifymessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.0.2/M_OrderModify.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_operationalhaltstatus(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.0.2/O_OperationalHaltStatus.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_shortsalepriceteststatus(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.0.2/P_ShortSalePriceTestStatus.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdeletemessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.0.2/R_OrderDelete.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemevent(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.0.2/S_SystemEvent.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_trademessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.0.2/T_Trade.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Iex/IexEquities.DeepPlus.IexTp.v1.0.2/a_AddOrder.pcap"):
            parsed = IexIexequitiesDeepplusIextpV101.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
