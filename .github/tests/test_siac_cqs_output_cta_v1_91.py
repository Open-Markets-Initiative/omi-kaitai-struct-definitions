# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from siac_cqs_output_cta_v1_91 import SiacCqsOutputCtaV191


class SiacCqsOutputCtaV191Tests(unittest.TestCase):

    def test_longquotemessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v1.91/LongQuoteMessage.pcap"):
            parsed = SiacCqsOutputCtaV191.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
