# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from siac_cts_output_cta_v2_10 import SiacCtsOutputCtaV210


class SiacCtsOutputCtaV210Tests(unittest.TestCase):

    def test_tradecorrectionmessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.10/TradeCorrectionMessage.pcap"):
            parsed = SiacCtsOutputCtaV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
