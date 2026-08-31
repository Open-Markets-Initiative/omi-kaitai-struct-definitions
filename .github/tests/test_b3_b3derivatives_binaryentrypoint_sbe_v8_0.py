# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from b3_b3derivatives_binaryentrypoint_sbe_v8_0 import B3B3derivativesBinaryentrypointSbeV80


class B3B3derivativesBinaryentrypointSbeV80Tests(unittest.TestCase):

    def test_establishackmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.0/EstablishAckMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV80.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_establishrejectmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.0/EstablishRejectMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV80.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_negotiaterejectmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.0/NegotiateRejectMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV80.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_retransmissionmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.0/RetransmissionMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV80.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_retransmitrejectmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.0/RetransmitRejectMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV80.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequencemessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.0/SequenceMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV80.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_terminatemessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.0/TerminateMessage.pcap"):
            if payloads.partial(payload, 0, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = B3B3derivativesBinaryentrypointSbeV80.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
