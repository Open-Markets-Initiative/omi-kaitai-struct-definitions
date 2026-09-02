# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from siac_cts_output_cta_v2_9 import SiacCtsOutputCtaV29


class SiacCtsOutputCtaV29Tests(unittest.TestCase):

    def test_lineintegritymessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.9/LineIntegrityMessage.pcap"):
            parsed = SiacCtsOutputCtaV29.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_longtrademessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.9/LongTradeMessage.pcap"):
            parsed = SiacCtsOutputCtaV29.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.9/TradingStatusMessage.pcap"):
            parsed = SiacCtsOutputCtaV29.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
