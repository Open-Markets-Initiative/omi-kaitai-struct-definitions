# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from coinbase_coinbasederivatives_ordersapi_sbe_v1_4 import CoinbaseCoinbasederivativesOrdersapiSbeV14


class CoinbaseCoinbasederivativesOrdersapiSbeV14Tests(unittest.TestCase):

    def test_cancelordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/CancelOrderMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_cancelorderrejectmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/CancelOrderRejectMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_instrumentinfomessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/InstrumentInfoMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_instrumentinforequestmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/InstrumentInfoRequestMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_lastexecidmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/LastExecIdMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_lastexecidrequestmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/LastExecIdRequestMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loggedoutmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/LoggedOutMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logonconfmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/LogonConfMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logonmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/LogonMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logoutmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/LogoutMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_masscancelorderackmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/MassCancelOrderAckMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_masscancelordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/MassCancelOrderMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_masscancelorderrejectmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/MassCancelOrderRejectMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_newordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/NewOrderMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercanceledmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/OrderCanceledMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderenteredmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/OrderEnteredMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderfilledmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/OrderFilledMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderrejectmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/OrderRejectMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderreplacedmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/OrderReplacedMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_pingmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/PingMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_pongmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/PongMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_replaceordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/ReplaceOrderMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_setaccountmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/SetAccountMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_setackmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/SetAckMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_settradermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/SetTraderMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_streamordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/StreamOrderMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_unlocktradingackmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/UnlockTradingAckMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_unlocktradingmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/UnlockTradingMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 0):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
