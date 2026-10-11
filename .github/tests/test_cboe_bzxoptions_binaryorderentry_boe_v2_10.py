# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_bzxoptions_binaryorderentry_boe_v2_10 import CboeBzxoptionsBinaryorderentryBoeV210


class CboeBzxoptionsBinaryorderentryBoeV210Tests(unittest.TestCase):

    def test_cancelordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/CancelOrderMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_clientheartbeatmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/ClientHeartbeatMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginrequestmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/LoginRequestMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginresponsemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/LoginResponseMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/ModifyOrderMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_newordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/NewOrderMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderacknowledgmentmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/OrderAcknowledgmentMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelledmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/OrderCancelledMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutionmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/OrderExecutionMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordermodifiedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/OrderModifiedMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderrejectedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/OrderRejectedMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_replaycompletemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/ReplayCompleteMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_serverheartbeatmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxOptions.BinaryOrderEntry.Boe.v2.10/ServerHeartbeatMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxoptionsBinaryorderentryBoeV210.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
