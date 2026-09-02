# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from siac_cts_output_cta_v1_91 import SiacCtsOutputCtaV191


class SiacCtsOutputCtaV191Tests(unittest.TestCase):

    def test_indexmessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v1.91/IndexMessage.pcap"):
            parsed = SiacCtsOutputCtaV191.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_lineintegritymessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v1.91/LineIntegrityMessage.pcap"):
            parsed = SiacCtsOutputCtaV191.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_longtrademessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v1.91/LongTradeMessage.pcap"):
            parsed = SiacCtsOutputCtaV191.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_shorttrademessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v1.91/ShortTradeMessage.pcap"):
            parsed = SiacCtsOutputCtaV191.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v1.91/TradingStatusMessage.pcap"):
            parsed = SiacCtsOutputCtaV191.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
