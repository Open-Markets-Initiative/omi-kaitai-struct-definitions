# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from ice_icefutures_mdf_impact_v1_1_24 import IceIcefuturesMdfImpactV1124


class IceIcefuturesMdfImpactV1124Tests(unittest.TestCase):

    def test_addormodifyordermessage(self):
        for payload in payloads.of("omi-data-packets/Ice/IceFutures.Mdf.iMpact.v1.1.24/AddOrModifyOrderMessage.pcap"):
            parsed = IceIcefuturesMdfImpactV1124.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketstatechangemessage(self):
        for payload in payloads.of("omi-data-packets/Ice/IceFutures.Mdf.iMpact.v1.1.24/MarketStateChangeMessage.pcap"):
            parsed = IceIcefuturesMdfImpactV1124.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_newoptionsstrategydefinitionmessage(self):
        for payload in payloads.of("omi-data-packets/Ice/IceFutures.Mdf.iMpact.v1.1.24/NewOptionsStrategyDefinitionMessage.pcap"):
            parsed = IceIcefuturesMdfImpactV1124.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_openpricemessage(self):
        for payload in payloads.of("omi-data-packets/Ice/IceFutures.Mdf.iMpact.v1.1.24/OpenPriceMessage.pcap"):
            parsed = IceIcefuturesMdfImpactV1124.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_preopenpriceindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Ice/IceFutures.Mdf.iMpact.v1.1.24/PreOpenPriceIndicatorMessage.pcap"):
            parsed = IceIcefuturesMdfImpactV1124.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
