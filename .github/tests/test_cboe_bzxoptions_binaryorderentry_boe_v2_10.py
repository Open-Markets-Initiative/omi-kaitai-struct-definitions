# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_bzxoptions_binaryorderentry_boe_v2_10 import CboeBzxoptionsBinaryorderentryBoeV210


class CboeBzxoptionsBinaryorderentryBoeV210Tests(unittest.TestCase):

    def test_cancelordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/CancelOrderMessage.pcap"):
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_clientheartbeatmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/ClientHeartbeatMessage.pcap"):
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginrequestmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/LoginRequestMessage.pcap"):
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginresponsemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/LoginResponseMessage.pcap"):
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/ModifyOrderMessage.pcap"):
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_newordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/NewOrderMessage.pcap"):
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderacknowledgementmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/OrderAcknowledgementMessage.pcap"):
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelledmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/OrderCancelledMessage.pcap"):
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutionmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/OrderExecutionMessage.pcap"):
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordermodifiedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/OrderModifiedMessage.pcap"):
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderrejectedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/OrderRejectedMessage.pcap"):
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_replaycompletemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/ReplayCompleteMessage.pcap"):
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_serverheartbeatmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/ServerHeartbeatMessage.pcap"):
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
