# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_bzxequities_binaryorderentry_boe_v2_4_55 import CboeBzxequitiesBinaryorderentryBoeV2455


class CboeBzxequitiesBinaryorderentryBoeV2455Tests(unittest.TestCase):

    def test_cancelordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/CancelOrderMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_cancelrejectedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/CancelRejectedMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_clientheartbeatmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/ClientHeartbeatMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginrequestmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/LoginRequestMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginresponsemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/LoginResponseMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logoutmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/LogoutMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logoutrequestmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/LogoutRequestMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_masscancelacknowledgmentmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/MassCancelAcknowledgmentMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_minimalorderacknowledgementmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/MinimalOrderAcknowledgementMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/ModifyOrderMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_newordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/NewOrderMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderacknowledgmentmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/OrderAcknowledgmentMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelledmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/OrderCancelledMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutionmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/OrderExecutionMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordermodifiedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/OrderModifiedMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderrejectedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/OrderRejectedMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderrestatedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/OrderRestatedMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_purgeordersmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/PurgeOrdersMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_purgerejectedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/PurgeRejectedMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_replaycompletemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/ReplayCompleteMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_serverheartbeatmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/ServerHeartbeatMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradecancelorcorrectmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/TradeCancelOrCorrectMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_usermodifyrejectedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.4.55/UserModifyRejectedMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", 2):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CboeBzxequitiesBinaryorderentryBoeV2455.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
