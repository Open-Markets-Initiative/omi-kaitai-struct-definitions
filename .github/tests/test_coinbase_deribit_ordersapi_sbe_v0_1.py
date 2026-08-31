# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from coinbase_deribit_ordersapi_sbe_v0_1 import CoinbaseDeribitOrdersapiSbeV01


class CoinbaseDeribitOrdersapiSbeV01Tests(unittest.TestCase):

    def test_amendorderrejectmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.OrdersApi.Sbe.v0.1/AmendOrderRejectMessage.pcap"):
            parsed = CoinbaseDeribitOrdersapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_amendorderrequestmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.OrdersApi.Sbe.v0.1/AmendOrderRequestMessage.pcap"):
            parsed = CoinbaseDeribitOrdersapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_amendorderresponsemessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.OrdersApi.Sbe.v0.1/AmendOrderResponseMessage.pcap"):
            parsed = CoinbaseDeribitOrdersapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_cancelorderrequestmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.OrdersApi.Sbe.v0.1/CancelOrderRequestMessage.pcap"):
            parsed = CoinbaseDeribitOrdersapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_cancelorderresponsemessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.OrdersApi.Sbe.v0.1/CancelOrderResponseMessage.pcap"):
            parsed = CoinbaseDeribitOrdersapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_massquoterejectmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.OrdersApi.Sbe.v0.1/MassQuoteRejectMessage.pcap"):
            parsed = CoinbaseDeribitOrdersapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_massquoterequestmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.OrdersApi.Sbe.v0.1/MassQuoteRequestMessage.pcap"):
            parsed = CoinbaseDeribitOrdersapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_massquoteresponsemessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.OrdersApi.Sbe.v0.1/MassQuoteResponseMessage.pcap"):
            parsed = CoinbaseDeribitOrdersapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_neworderrejectmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.OrdersApi.Sbe.v0.1/NewOrderRejectMessage.pcap"):
            parsed = CoinbaseDeribitOrdersapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_neworderrequestmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.OrdersApi.Sbe.v0.1/NewOrderRequestMessage.pcap"):
            parsed = CoinbaseDeribitOrdersapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_neworderresponsemessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.OrdersApi.Sbe.v0.1/NewOrderResponseMessage.pcap"):
            parsed = CoinbaseDeribitOrdersapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderfilledmessage(self):
        for payload in payloads.of("omi-data-packets/Coinbase/Deribit.OrdersApi.Sbe.v0.1/OrderFilledMessage.pcap"):
            parsed = CoinbaseDeribitOrdersapiSbeV01.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
