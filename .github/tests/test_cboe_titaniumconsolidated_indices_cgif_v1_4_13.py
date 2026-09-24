# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_titaniumconsolidated_indices_cgif_v1_4_13 import CboeTitaniumconsolidatedIndicesCgifV1413


class CboeTitaniumconsolidatedIndicesCgifV1413Tests(unittest.TestCase):

    def test_contributorvaluemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/TitaniumConsolidated.Indices.Cgif.v1.4.13/ContributorValueMessage.pcap"):
            parsed = CboeTitaniumconsolidatedIndicesCgifV1413.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_heartbeatmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/TitaniumConsolidated.Indices.Cgif.v1.4.13/HeartbeatMessage.pcap"):
            parsed = CboeTitaniumconsolidatedIndicesCgifV1413.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_indexdefinitionmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/TitaniumConsolidated.Indices.Cgif.v1.4.13/IndexDefinitionMessage.pcap"):
            parsed = CboeTitaniumconsolidatedIndicesCgifV1413.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_indexvaluemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/TitaniumConsolidated.Indices.Cgif.v1.4.13/IndexValueMessage.pcap"):
            parsed = CboeTitaniumconsolidatedIndicesCgifV1413.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_indexvaluewithstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/TitaniumConsolidated.Indices.Cgif.v1.4.13/IndexValueWithStatusMessage.pcap"):
            parsed = CboeTitaniumconsolidatedIndicesCgifV1413.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
