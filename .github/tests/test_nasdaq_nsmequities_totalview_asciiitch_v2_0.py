# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_nsmequities_totalview_asciiitch_v2_0_udp import NasdaqNsmequitiesTotalviewAsciiitchV20Udp


class NasdaqNsmequitiesTotalviewAsciiitchV20UdpTests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v2.0/AddOrderMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV20Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v2.0/OrderCancelMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV20Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v2.0/OrderExecutedMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV20Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v2.0/SystemEventMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV20Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_trademessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.AsciiItch.v2.0/TradeMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewAsciiitchV20Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
