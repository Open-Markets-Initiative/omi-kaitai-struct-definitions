# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from b3_b3derivatives_binaryentrypoint_sbe_v8_1 import B3B3derivativesBinaryentrypointSbeV81


class B3B3derivativesBinaryentrypointSbeV81Tests(unittest.TestCase):

    def test_establishmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/EstablishMessage.pcap"):
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_executionreportnewmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/ExecutionReportNewMessage.pcap"):
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_executionreporttrademessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/ExecutionReportTradeMessage.pcap"):
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_negotiatemessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/NegotiateMessage.pcap"):
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_simplemodifyordermessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/SimpleModifyOrderMessage.pcap"):
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_simplenewordermessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.Sbe.v8.1/SimpleNewOrderMessage.pcap"):
            parsed = B3B3derivativesBinaryentrypointSbeV81.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
