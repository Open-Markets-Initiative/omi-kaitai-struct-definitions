# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from b3_b3derivatives_binaryentrypoint_sbe_v8_3 import B3B3derivativesBinaryentrypointSbeV83


class B3B3derivativesBinaryentrypointSbeV83Tests(unittest.TestCase):

    def test_businessmessagerejectmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/BusinessMessageRejectMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_establishackmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/EstablishAckMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_establishmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/EstablishMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_establishrejectmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/EstablishRejectMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_executionreportcancelmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/ExecutionReportCancelMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_executionreportmodifymessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/ExecutionReportModifyMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_executionreportnewmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/ExecutionReportNewMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_executionreportrejectmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/ExecutionReportRejectMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_executionreporttrademessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/ExecutionReportTradeMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_negotiatemessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/NegotiateMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_negotiaterejectmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/NegotiateRejectMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_newordercrossmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/NewOrderCrossMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_newordersinglemessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/NewOrderSingleMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelreplacerequestmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/OrderCancelReplaceRequestMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelrequestmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/OrderCancelRequestMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordermassactionreportmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/OrderMassActionReportMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordermassactionrequestmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/OrderMassActionRequestMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_retransmissionmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/RetransmissionMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_retransmitrejectmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/RetransmitRejectMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_retransmitrequestmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/RetransmitRequestMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequencemessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/SequenceMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_simplemodifyordermessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/SimpleModifyOrderMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_simplenewordermessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/SimpleNewOrderMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_terminatemessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.3/TerminateMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV83.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
