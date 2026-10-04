# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from siac_cqs_output_cta_v2_10_a import SiacCqsOutputCtaV210A


class SiacCqsOutputCtaV210ATests(unittest.TestCase):

    def test_endofdaymessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v2.10.a/EndOfDayMessage.pcap"):
            parsed = SiacCqsOutputCtaV210A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_finraclosemessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v2.10.a/FinraCloseMessage.pcap"):
            parsed = SiacCqsOutputCtaV210A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_finraopenmessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v2.10.a/FinraOpenMessage.pcap"):
            parsed = SiacCqsOutputCtaV210A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_lineintegritymessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v2.10.a/LineIntegrityMessage.pcap"):
            parsed = SiacCqsOutputCtaV210A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_longquotemessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v2.10.a/LongQuoteMessage.pcap"):
            parsed = SiacCqsOutputCtaV210A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketwidecircuitbreakerdeclinelevelstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v2.10.a/MarketWideCircuitBreakerDeclineLevelStatusMessage.pcap"):
            parsed = SiacCqsOutputCtaV210A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_startofdaymessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v2.10.a/StartOfDayMessage.pcap"):
            parsed = SiacCqsOutputCtaV210A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolreferencedatamessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v2.10.a/SymbolReferenceDataMessage.pcap"):
            parsed = SiacCqsOutputCtaV210A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
