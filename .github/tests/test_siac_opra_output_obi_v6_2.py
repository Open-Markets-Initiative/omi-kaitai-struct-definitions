# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from siac_opra_output_obi_v6_2 import SiacOpraOutputObiV62


class SiacOpraOutputObiV62Tests(unittest.TestCase):

    def test_administrativemessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Opra.Output.Obi.v6.2/AdministrativeMessage.pcap"):
            parsed = SiacOpraOutputObiV62.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_controlmessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Opra.Output.Obi.v6.2/ControlMessage.pcap"):
            parsed = SiacOpraOutputObiV62.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_longequityandindexquotemessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Opra.Output.Obi.v6.2/LongEquityAndIndexQuoteMessage.pcap"):
            parsed = SiacOpraOutputObiV62.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_shortequityandindexquotemessage(self):
        for payload in payloads.of("omi-data-packets/Siac/Opra.Output.Obi.v6.2/ShortEquityAndIndexQuoteMessage.pcap"):
            parsed = SiacOpraOutputObiV62.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
