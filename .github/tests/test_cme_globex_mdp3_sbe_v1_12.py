# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cme_globex_mdp3_sbe_v1_12_tcp import CmeGlobexMdp3SbeV112Tcp


class CmeGlobexMdp3SbeV112UdpTests(unittest.TestCase):

    def test_mdincrementalrefreshbooklongqty(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/MdIncrementalRefreshBookLongQty.pcap"):
            parsed = CmeGlobexMdp3SbeV112Tcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_mdincrementalrefreshtradesummarylongqty(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/MdIncrementalRefreshTradeSummaryLongQty.pcap"):
            parsed = CmeGlobexMdp3SbeV112Tcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketdatarequest(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/MarketDataRequest.Tcp.pcap"):
            parsed = CmeGlobexMdp3SbeV112Tcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_requestack(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/RequestAck.Tcp.pcap"):
            parsed = CmeGlobexMdp3SbeV112Tcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitylistrequest(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/SecurityListRequest.Tcp.pcap"):
            parsed = CmeGlobexMdp3SbeV112Tcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatusrequest(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/SecurityStatusRequest.Tcp.pcap"):
            parsed = CmeGlobexMdp3SbeV112Tcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitystatus(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/SecurityStatus.Tcp.pcap"):
            parsed = CmeGlobexMdp3SbeV112Tcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_snapshotfullrefreshtcplongqty(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/SnapshotFullRefreshTcpLongQty.Tcp.pcap"):
            parsed = CmeGlobexMdp3SbeV112Tcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_subscriberheartbeat(self):
        for payload in payloads.of("omi-data-packets/Cme/Globex.Mdp3.Sbe.v1.12/SubscriberHeartbeat.Tcp.pcap"):
            parsed = CmeGlobexMdp3SbeV112Tcp.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
