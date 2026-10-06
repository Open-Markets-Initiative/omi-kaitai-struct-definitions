# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_gaprequestproxy_pitch_v1 import CboeGaprequestproxyPitchV1


class CboeGaprequestproxyPitchV1Tests(unittest.TestCase):

    def test_gaprequestmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/GapRequestProxy.Pitch.v1/GapRequestMessage.pcap"):
            parsed = CboeGaprequestproxyPitchV1.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_gapresponsemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/GapRequestProxy.Pitch.v1/GapResponseMessage.pcap"):
            parsed = CboeGaprequestproxyPitchV1.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/GapRequestProxy.Pitch.v1/LoginMessage.pcap"):
            parsed = CboeGaprequestproxyPitchV1.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginresponsemessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/GapRequestProxy.Pitch.v1/LoginResponseMessage.pcap"):
            parsed = CboeGaprequestproxyPitchV1.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
