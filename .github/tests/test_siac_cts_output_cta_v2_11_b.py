# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from siac_cts_output_cta_v2_11_b import SiacCtsOutputCtaV211B


class SiacCtsOutputCtaV211BTests(unittest.TestCase):

    def test_consolidatedstartofdaysummarymessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/ConsolidatedStartOfDaySummaryMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_endofdaymessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/EndOfDayMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_endofendofdaysummarymessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/EndOfEndOfDaySummaryMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_endofstartofdaysummarymessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/EndOfStartOfDaySummaryMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_fractionalapproximateadjustedvolumemarketcentermessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/FractionalApproximateAdjustedVolumeMarketCenterMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_fractionalconsolidatedendofdaysummarymessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/FractionalConsolidatedEndOfDaySummaryMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_fractionallongtrademessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/FractionalLongTradeMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_fractionalparticipantendofdaysummarymessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/FractionalParticipantEndOfDaySummaryMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_fractionalpriordaytradecancelerrormessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/FractionalPriorDayTradeCancelErrorMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_fractionalpriordaytrademessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/FractionalPriorDayTradeMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_fractionaltradecancelerrormessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/FractionalTradeCancelErrorMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_lineintegritymessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/LineIntegrityMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketwidecircuitbreakerdeclinelevelstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/MarketWideCircuitBreakerDeclineLevelStatusMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_participantstartofdaysummarymessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/ParticipantStartOfDaySummaryMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_startofdaymessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/StartOfDayMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_startofendofdaysummarymessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/StartOfEndOfDaySummaryMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_startofstartofdaysummarymessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/StartOfStartOfDaySummaryMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolreferencedatamessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/SymbolReferenceDataMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Cts.Output.Cta.v2.11.b/TradingStatusMessage.pcap"):
            parsed = SiacCtsOutputCtaV211B.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
