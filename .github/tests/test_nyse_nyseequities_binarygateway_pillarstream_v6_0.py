# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nyseequities_binarygateway_pillarstream_v6_0_clientpillarmessage import NyseNyseequitiesBinarygatewayPillarstreamV60Clientpillarmessage
from nyse_nyseequities_binarygateway_pillarstream_v6_0_serverpillarmessage import NyseNyseequitiesBinarygatewayPillarstreamV60Serverpillarmessage


class NyseNyseequitiesBinarygatewayPillarstreamV60ServerpillarmessageTests(unittest.TestCase):

    def test_closeresponse(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.BinaryGateway.PillarStream.v6.0/CloseResponse.pcap"):
            if payloads.partial(payload, 2, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NyseNyseequitiesBinarygatewayPillarstreamV60Serverpillarmessage.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_equitiessymbolreferencedatamessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.BinaryGateway.PillarStream.v6.0/EquitiesSymbolReferenceDataMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NyseNyseequitiesBinarygatewayPillarstreamV60Serverpillarmessage.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_executionreportmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.BinaryGateway.PillarStream.v6.0/ExecutionReportMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NyseNyseequitiesBinarygatewayPillarstreamV60Serverpillarmessage.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.BinaryGateway.PillarStream.v6.0/Heartbeat.pcap"):
            if payloads.partial(payload, 2, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NyseNyseequitiesBinarygatewayPillarstreamV60Serverpillarmessage.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.BinaryGateway.PillarStream.v6.0/LoginMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NyseNyseequitiesBinarygatewayPillarstreamV60Clientpillarmessage.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginresponse(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.BinaryGateway.PillarStream.v6.0/LoginResponse.pcap"):
            if payloads.partial(payload, 2, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NyseNyseequitiesBinarygatewayPillarstreamV60Serverpillarmessage.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_newordersingleandcancelreplacerequestmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.BinaryGateway.PillarStream.v6.0/NewOrderSingleAndCancelReplaceRequestMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NyseNyseequitiesBinarygatewayPillarstreamV60Clientpillarmessage.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_open(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.BinaryGateway.PillarStream.v6.0/Open.pcap"):
            if payloads.partial(payload, 2, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NyseNyseequitiesBinarygatewayPillarstreamV60Clientpillarmessage.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_openresponse(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.BinaryGateway.PillarStream.v6.0/OpenResponse.pcap"):
            if payloads.partial(payload, 2, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NyseNyseequitiesBinarygatewayPillarstreamV60Serverpillarmessage.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderandcancelreplaceacknowledgementmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.BinaryGateway.PillarStream.v6.0/OrderAndCancelReplaceAcknowledgementMessage.pcap"):
            if payloads.partial(payload, 2, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NyseNyseequitiesBinarygatewayPillarstreamV60Serverpillarmessage.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_streamavail(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.BinaryGateway.PillarStream.v6.0/StreamAvail.pcap"):
            if payloads.partial(payload, 2, 2, "little", True):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = NyseNyseequitiesBinarygatewayPillarstreamV60Serverpillarmessage.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
