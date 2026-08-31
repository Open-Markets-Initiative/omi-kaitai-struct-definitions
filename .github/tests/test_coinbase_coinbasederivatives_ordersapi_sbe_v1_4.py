# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from coinbase_coinbasederivatives_ordersapi_sbe_v1_4 import CoinbaseCoinbasederivativesOrdersapiSbeV14


class CoinbaseCoinbasederivativesOrdersapiSbeV14Tests(unittest.TestCase):

    def test_instrumentinfomessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/InstrumentInfoMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_instrumentinforequestmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/InstrumentInfoRequestMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loggedoutmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/LoggedOutMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logonconfmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/LogonConfMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logonmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/LogonMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_masscancelorderackmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/MassCancelOrderAckMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_masscancelordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/MassCancelOrderMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_newordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/NewOrderMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderfilledmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/OrderFilledMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderreplacedmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/OrderReplacedMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_replaceordermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/ReplaceOrderMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_setaccountmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/SetAccountMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_setackmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/SetAckMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_settradermessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/CoinbaseDerivatives.OrdersApi.Sbe.v1.4/SetTraderMessage.pcap"):
            if payloads.partial(payload, 3, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CoinbaseCoinbasederivativesOrdersapiSbeV14.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
