# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from b3_b3derivatives_binaryumdf_sbe_v1_8 import B3B3derivativesBinaryumdfSbeV18


class B3B3derivativesBinaryumdfSbeV18Tests(unittest.TestCase):

    def test_securitydefinitionmessage(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryUmdf.v1.8/SecurityDefinitionMessage.pcap"):
            parsed = B3B3derivativesBinaryumdfSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_sequence(self):
        for payload in payloads.of("omi-data-packets/B3/B3Derivatives.BinaryUmdf.v1.8/Sequence.pcap"):
            parsed = B3B3derivativesBinaryumdfSbeV18.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
