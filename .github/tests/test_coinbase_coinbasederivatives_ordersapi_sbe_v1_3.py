# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from coinbase_coinbasederivatives_ordersapi_sbe_v1_3 import CoinbaseCoinbasederivativesOrdersapiSbeV13


class CoinbaseCoinbasederivativesOrdersapiSbeV13Tests(unittest.TestCase):

    def test_cancelordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/CancelOrderMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_cancelorderrejectmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/CancelOrderRejectMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_lastexecidmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/LastExecIdMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_lastexecidrequestmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/LastExecIdRequestMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loggedoutmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/LoggedOutMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logonconfmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/LogonConfMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logonmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/LogonMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logoutmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/LogoutMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_masscancelorderackmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/MassCancelOrderAckMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_masscancelordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/MassCancelOrderMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_masscancelorderrejectmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/MassCancelOrderRejectMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_newordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/NewOrderMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercanceledmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/OrderCanceledMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderenteredmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/OrderEnteredMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderfilledmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/OrderFilledMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderrejectmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/OrderRejectMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderreplacedmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/OrderReplacedMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_pingmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/PingMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_pongmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/PongMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_replaceordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/ReplaceOrderMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_setaccountmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/SetAccountMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_setackmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/SetAckMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_settradermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/SetTraderMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_streamordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/StreamOrderMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_unlocktradingackmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/UnlockTradingAckMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_unlocktradingmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.3/UnlockTradingMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV13.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
