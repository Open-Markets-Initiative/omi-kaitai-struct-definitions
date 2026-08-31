# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from coinbase_coinbasederivatives_ordersapi_sbe_v1_8 import CoinbaseCoinbasederivativesOrdersapiSbeV18


class CoinbaseCoinbasederivativesOrdersapiSbeV18Tests(unittest.TestCase):

    def test_cancelordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/CancelOrderMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_cancelorderrejectmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/CancelOrderRejectMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_lastexecidmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/LastExecIdMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_lastexecidrequestmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/LastExecIdRequestMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loggedoutmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/LoggedOutMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logonconfmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/LogonConfMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logonmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/LogonMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logoutmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/LogoutMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_masscancelorderackmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/MassCancelOrderAckMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_masscancelordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/MassCancelOrderMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_masscancelorderrejectmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/MassCancelOrderRejectMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_newordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/NewOrderMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercanceledmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/OrderCanceledMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderenteredmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/OrderEnteredMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderfilledmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/OrderFilledMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderrejectmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/OrderRejectMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderreplacedmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/OrderReplacedMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_pingmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/PingMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_pongmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/PongMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_replaceordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/ReplaceOrderMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_setaccountmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/SetAccountMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_setackmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/SetAckMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_settradermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/SetTraderMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_unlocktradingackmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/UnlockTradingAckMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_unlocktradingmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.8/UnlockTradingMessage.pcap"):
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
