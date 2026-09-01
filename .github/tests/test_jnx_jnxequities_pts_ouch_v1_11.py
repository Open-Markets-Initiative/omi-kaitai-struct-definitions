# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from jnx_jnxequities_pts_ouch_v1_11_client import JnxJnxequitiesPtsOuchV111Client
from jnx_jnxequities_pts_ouch_v1_11_server import JnxJnxequitiesPtsOuchV111Server


class JnxJnxequitiesPtsOuchV111ServerTests(unittest.TestCase):

    def test_enterordermessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Ouch.v1.11/EnterOrderMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = JnxJnxequitiesPtsOuchV111Client.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginacceptedpacket(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Ouch.v1.11/LoginAcceptedPacket.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = JnxJnxequitiesPtsOuchV111Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginrequestpacket(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Ouch.v1.11/LoginRequestPacket.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = JnxJnxequitiesPtsOuchV111Client.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderacceptedmessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Ouch.v1.11/OrderAcceptedMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = JnxJnxequitiesPtsOuchV111Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_replaceordermessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Ouch.v1.11/ReplaceOrderMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = JnxJnxequitiesPtsOuchV111Client.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_cancelordermessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Ouch.v1.12/CancelOrderMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = JnxJnxequitiesPtsOuchV111Client.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercanceledmessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Ouch.v1.12/OrderCanceledMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = JnxJnxequitiesPtsOuchV111Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Ouch.v1.12/OrderExecutedMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = JnxJnxequitiesPtsOuchV111Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderrejectedmessage(self):
        for payload in payloads.of("omi-data-packets/Jnx/JnxEquities.Pts.Ouch.v1.12/OrderRejectedMessage.pcap"):
            if payloads.partial(payload, 0, 2, "big", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = JnxJnxequitiesPtsOuchV111Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
