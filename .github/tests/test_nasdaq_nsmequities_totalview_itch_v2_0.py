# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_nsmequities_totalview_itch_v2_0_udp import NasdaqNsmequitiesTotalviewItchV20Udp


class NasdaqNsmequitiesTotalviewItchV20UdpTests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v2.0/AddOrderMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV20Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v2.0/OrderCancelMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV20Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v2.0/OrderExecutedMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV20Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v2.0/SystemEventMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV20Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_trademessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v2.0/TradeMessage.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV20Udp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
