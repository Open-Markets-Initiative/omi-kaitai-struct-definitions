# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_ntxequities_totalview_itch_v5_0 import NasdaqNtxequitiesTotalviewItchV50


class NasdaqNtxequitiesTotalviewItchV50Tests(unittest.TestCase):

    def test_addordernompidattributionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NtxEquities.TotalView.Itch.v5.0/AddOrderNoMpidAttributionMessage.pcap"):
            parsed = NasdaqNtxequitiesTotalviewItchV50.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdeletemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NtxEquities.TotalView.Itch.v5.0/OrderDeleteMessage.pcap"):
            parsed = NasdaqNtxequitiesTotalviewItchV50.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderreplacemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NtxEquities.TotalView.Itch.v5.0/OrderReplaceMessage.pcap"):
            parsed = NasdaqNtxequitiesTotalviewItchV50.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
