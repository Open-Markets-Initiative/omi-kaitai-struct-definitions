# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_nsmequities_orders_ouch_v5_0_server import NasdaqNsmequitiesOrdersOuchV50Server


class NasdaqNsmequitiesOrdersOuchV50ServerTests(unittest.TestCase):

    def test_canceledmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.Orders.Ouch.v5.0/CanceledMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NasdaqNsmequitiesOrdersOuchV50Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_cancelordermessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.Orders.Ouch.v5.0/CancelOrderMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NasdaqNsmequitiesOrdersOuchV50Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_clientheartbeatpacket(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.Orders.Ouch.v5.0/ClientHeartbeatPacket.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NasdaqNsmequitiesOrdersOuchV50Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_enterordermessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.Orders.Ouch.v5.0/EnterOrderMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NasdaqNsmequitiesOrdersOuchV50Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderacceptedmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.Orders.Ouch.v5.0/OrderAcceptedMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NasdaqNsmequitiesOrdersOuchV50Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_serverheartbeatpacket(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.Orders.Ouch.v5.0/ServerHeartbeatPacket.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NasdaqNsmequitiesOrdersOuchV50Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
