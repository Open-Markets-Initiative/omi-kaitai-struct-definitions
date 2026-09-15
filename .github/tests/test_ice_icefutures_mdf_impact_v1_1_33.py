# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from ice_icefutures_mdf_impact_v1_1_33 import IceIcefuturesMdfImpactV1133


class IceIcefuturesMdfImpactV1133Tests(unittest.TestCase):

    def test_addormodifymessage(self):
        for payload in payloads.of("omi-data-packets/Ice/IceFutures.Mdf.iMpact.v1.1.33/AddOrModifyMessage.pcap"):
            parsed = IceIcefuturesMdfImpactV1133.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_deleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Ice/IceFutures.Mdf.iMpact.v1.1.33/DeleteOrderMessage.pcap"):
            parsed = IceIcefuturesMdfImpactV1133.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Ice/IceFutures.Mdf.iMpact.v1.1.33/Heartbeat.pcap"):
            parsed = IceIcefuturesMdfImpactV1133.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketsnapshotmessage(self):
        for payload in payloads.of("omi-data-packets/Ice/IceFutures.Mdf.iMpact.v1.1.33/MarketSnapShotMessage.pcap"):
            parsed = IceIcefuturesMdfImpactV1133.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketsnapshotordermessage(self):
        for payload in payloads.of("omi-data-packets/Ice/IceFutures.Mdf.iMpact.v1.1.33/MarketSnapshotOrderMessage.pcap"):
            parsed = IceIcefuturesMdfImpactV1133.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketstatisticsmessage(self):
        for payload in payloads.of("omi-data-packets/Ice/IceFutures.Mdf.iMpact.v1.1.33/MarketStatisticsMessage.pcap"):
            parsed = IceIcefuturesMdfImpactV1133.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_messagebundlemarker(self):
        for payload in payloads.of("omi-data-packets/Ice/IceFutures.Mdf.iMpact.v1.1.33/MessageBundleMarker.pcap"):
            parsed = IceIcefuturesMdfImpactV1133.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_newoptionsstrategydefinintionmessage(self):
        for payload in payloads.of("omi-data-packets/Ice/IceFutures.Mdf.iMpact.v1.1.33/NewOptionsStrategyDefinintionMessage.pcap"):
            parsed = IceIcefuturesMdfImpactV1133.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_specialfieldmessage(self):
        for payload in payloads.of("omi-data-packets/Ice/IceFutures.Mdf.iMpact.v1.1.33/SpecialFieldMessage.pcap"):
            parsed = IceIcefuturesMdfImpactV1133.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_trademessage(self):
        for payload in payloads.of("omi-data-packets/Ice/IceFutures.Mdf.iMpact.v1.1.33/TradeMessage.pcap"):
            parsed = IceIcefuturesMdfImpactV1133.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
