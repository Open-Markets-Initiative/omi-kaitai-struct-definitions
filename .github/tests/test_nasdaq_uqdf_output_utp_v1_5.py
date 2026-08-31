# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_uqdf_output_utp_v1_5 import NasdaqUqdfOutputUtpV15


class NasdaqUqdfOutputUtpV15Tests(unittest.TestCase):

    def test_limituplimitdownpricebandmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/Uqdf.Output.Utp.v1.5/LimitUpLimitDownPriceBandMessage.pcap"):
            parsed = NasdaqUqdfOutputUtpV15.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quotelongformmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/Uqdf.Output.Utp.v1.5/QuoteLongFormMessage.pcap"):
            parsed = NasdaqUqdfOutputUtpV15.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_quoteshortformmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/Uqdf.Output.Utp.v1.5/QuoteShortFormMessage.pcap"):
            parsed = NasdaqUqdfOutputUtpV15.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
