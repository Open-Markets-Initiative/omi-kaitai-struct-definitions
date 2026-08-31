# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from asx_asxderivatives_ntp_itch_v1_05 import AsxAsxderivativesNtpItchV105


class AsxAsxderivativesNtpItchV105Tests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/AddOrderMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_anomalousorderthresholdpublishmessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/AnomalousOrderThresholdPublishMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_auctionorderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/AuctionOrderExecutedMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_combinationorderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/CombinationOrderExecutedMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_combinationsymboldirectorymessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/CombinationSymbolDirectoryMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_combinationtradeexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/CombinationTradeExecutedMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_equilibriumpricemessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/EquilibriumPriceMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_futuresymboldirectorymessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/FutureSymbolDirectoryMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/Heartbeat.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_impliedorderaddedmessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/ImpliedOrderAddedMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_impliedorderdeletedmessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/ImpliedOrderDeletedMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_impliedorderreplacedmessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/ImpliedOrderReplacedMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_openhighlowlasttradeadjustmentmessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/OpenHighLowLastTradeAdjustmentMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_optionssymboldirectorymessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/OptionsSymbolDirectoryMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderbookstatemessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/OrderBookStateMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdeletedmessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/OrderDeletedMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/OrderExecutedMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordervolumecancelledmessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/OrderVolumeCancelledMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_seconds(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/Seconds.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_textmessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/TextMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradeexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Asx/AsxDerivatives.Ntp.Itch.v1.05/TradeExecutedMessage.pcap"):
            parsed = AsxAsxderivativesNtpItchV105.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
