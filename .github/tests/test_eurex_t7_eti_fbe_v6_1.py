# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from eurex_t7_eti_fbe_v6_1_server import EurexT7EtiFbeV61Server


class EurexT7EtiFbeV61ServerTests(unittest.TestCase):

    def test_heartbeat(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eti.Fbe.v6.1/Heartbeat.pcap"):
            parsed = EurexT7EtiFbeV61Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_retransmitmemessagerequest(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eti.Fbe.v6.1/RetransmitMeMessageRequest.pcap"):
            parsed = EurexT7EtiFbeV61Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_userloginresponse(self):
        for payload in payloads.of("omi-data-packets/Eurex/T7.Eti.Fbe.v6.1/UserLoginResponse.pcap"):
            parsed = EurexT7EtiFbeV61Server.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
