# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cme_globex_mdp3_sbe_v1_12_clienttcp import CmeGlobexMdp3SbeV112Clienttcp
from cme_globex_mdp3_sbe_v1_12_servertcp import CmeGlobexMdp3SbeV112Servertcp


class CmeGlobexMdp3SbeV112UdpTests(unittest.TestCase):

    def test_marketdatarequest(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/MarketDataRequest.pcap"):
            if payloads.partial(payload, 14, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CmeGlobexMdp3SbeV112Clienttcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_mdincrementalrefreshbooklongqty(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/MdIncrementalRefreshBookLongQty.pcap"):
            if payloads.partial(payload, 14, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CmeGlobexMdp3SbeV112Servertcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_mdincrementalrefreshtradesummarylongqty(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/MdIncrementalRefreshTradeSummaryLongQty.pcap"):
            if payloads.partial(payload, 14, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CmeGlobexMdp3SbeV112Servertcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_mdinstrumentdefinitionfx(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/MdInstrumentDefinitionFx.pcap"):
            if payloads.partial(payload, 14, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CmeGlobexMdp3SbeV112Servertcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_requestack(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/RequestAck.pcap"):
            if payloads.partial(payload, 14, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CmeGlobexMdp3SbeV112Servertcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitylistrequest(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/SecurityListRequest.pcap"):
            if payloads.partial(payload, 14, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CmeGlobexMdp3SbeV112Clienttcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatus(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/SecurityStatus.pcap"):
            if payloads.partial(payload, 14, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CmeGlobexMdp3SbeV112Servertcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusrequest(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/SecurityStatusRequest.pcap"):
            if payloads.partial(payload, 14, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CmeGlobexMdp3SbeV112Clienttcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_snapshotfullrefreshtcplongqty(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/SnapshotFullRefreshTcpLongQty.pcap"):
            if payloads.partial(payload, 14, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CmeGlobexMdp3SbeV112Servertcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_subscriberheartbeat(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/SubscriberHeartbeat.pcap"):
            if payloads.partial(payload, 14, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = CmeGlobexMdp3SbeV112Clienttcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
