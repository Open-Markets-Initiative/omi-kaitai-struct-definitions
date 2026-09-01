# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cme_globex_mdp3_sbe_v1_12_clienttcp import CmeGlobexMdp3SbeV112Clienttcp
from cme_globex_mdp3_sbe_v1_12_servertcp import CmeGlobexMdp3SbeV112Servertcp


class CmeGlobexMdp3SbeV112UdpTests(unittest.TestCase):

    def test_marketdatarequesttcp(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/MarketDataRequest.Tcp.pcap"):
            parsed = CmeGlobexMdp3SbeV112Clienttcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_mdincrementalrefreshbooklongqty(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/MdIncrementalRefreshBookLongQty.pcap"):
            parsed = CmeGlobexMdp3SbeV112Servertcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_mdincrementalrefreshtradesummarylongqty(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/MdIncrementalRefreshTradeSummaryLongQty.pcap"):
            parsed = CmeGlobexMdp3SbeV112Servertcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_mdinstrumentdefinitionfxtcp(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/MdInstrumentDefinitionFx.Tcp.pcap"):
            parsed = CmeGlobexMdp3SbeV112Servertcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_requestacktcp(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/RequestAck.Tcp.pcap"):
            parsed = CmeGlobexMdp3SbeV112Servertcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitylistrequesttcp(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/SecurityListRequest.Tcp.pcap"):
            parsed = CmeGlobexMdp3SbeV112Clienttcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatustcp(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/SecurityStatus.Tcp.pcap"):
            parsed = CmeGlobexMdp3SbeV112Servertcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusrequesttcp(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/SecurityStatusRequest.Tcp.pcap"):
            parsed = CmeGlobexMdp3SbeV112Clienttcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_snapshotfullrefreshtcplongqtytcp(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/SnapshotFullRefreshTcpLongQty.Tcp.pcap"):
            parsed = CmeGlobexMdp3SbeV112Servertcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_subscriberheartbeattcp(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/SubscriberHeartbeat.Tcp.pcap"):
            parsed = CmeGlobexMdp3SbeV112Clienttcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
