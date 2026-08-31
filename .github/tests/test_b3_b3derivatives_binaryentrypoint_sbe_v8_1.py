# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from b3_b3derivatives_binaryentrypoint_sbe_v8_1 import B3B3derivativesBinaryentrypointSbeV81


class B3B3derivativesBinaryentrypointSbeV81Tests(unittest.TestCase):

    def test_establishmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/EstablishMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_executionreportcancelmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/ExecutionReportCancelMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_executionreportmodifymessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/ExecutionReportModifyMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_executionreportnewmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/ExecutionReportNewMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_executionreportrejectmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/ExecutionReportRejectMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_executionreporttrademessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/ExecutionReportTradeMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_negotiatemessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/NegotiateMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_newordercrossmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/NewOrderCrossMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_newordersinglemessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/NewOrderSingleMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelreplacerequestmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/OrderCancelReplaceRequestMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelrequestmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/OrderCancelRequestMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordermassactionreportmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/OrderMassActionReportMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordermassactionrequestmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/OrderMassActionRequestMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_retransmitrequestmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/RetransmitRequestMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_simplemodifyordermessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/SimpleModifyOrderMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_simplenewordermessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/SimpleNewOrderMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
