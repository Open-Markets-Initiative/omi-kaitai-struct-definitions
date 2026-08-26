# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from b3_b3derivatives_binaryentrypoint_sbe_v8_0 import B3B3derivativesBinaryentrypointSbeV80


class B3B3derivativesBinaryentrypointSbeV80Tests(unittest.TestCase):

    def test_negotiaterejectmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.v8.0/NegotiateRejectMessage.pcap"):
            parsed = B3B3derivativesBinaryentrypointSbeV80.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_terminatemessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryEntryPoint.v8.0/TerminateMessage.pcap"):
            parsed = B3B3derivativesBinaryentrypointSbeV80.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
