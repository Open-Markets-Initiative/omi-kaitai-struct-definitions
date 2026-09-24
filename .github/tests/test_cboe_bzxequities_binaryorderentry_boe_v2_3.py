# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_bzxequities_binaryorderentry_boe_v2_3 import CboeBzxequitiesBinaryorderentryBoeV23


class CboeBzxequitiesBinaryorderentryBoeV23Tests(unittest.TestCase):

    def test_cancelordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/CancelOrderMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_cancelrejectedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/CancelRejectedMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_clientheartbeatmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/ClientHeartbeatMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginrequestmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/LoginRequestMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginresponsemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/LoginResponseMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logoutmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/LogoutMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_logoutrequestmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/LogoutRequestMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_masscancelacknowledgementmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/MassCancelAcknowledgementMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_minimalorderacknowledgementmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/MinimalOrderAcknowledgementMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/ModifyOrderMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_newordermessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/NewOrderMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderacknowledgementmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/OrderAcknowledgementMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelledmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/OrderCancelledMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutionmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/OrderExecutionMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordermodifiedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/OrderModifiedMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderrejectedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/OrderRejectedMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderrestatedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/OrderRestatedMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_purgeordersmessage_riskgroupid(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/PurgeOrdersMessage_RiskGroupID.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_purgeordersmessage_symbol(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/PurgeOrdersMessage_Symbol.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_purgerejectedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/PurgeRejectedMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_replaycompletemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/ReplayCompleteMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_serverheartbeatmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/ServerHeartbeatMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradecancelorcorrectmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/TradeCancelOrCorrectMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_usermodifyrejectedmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/BzxEquities.BinaryOrderEntry.Boe.v2.3/UserModifyRejectedMessage.pcap"):
            parsed = CboeBzxequitiesBinaryorderentryBoeV23.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
