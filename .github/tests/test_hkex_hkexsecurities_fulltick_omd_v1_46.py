# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from hkex_hkexsecurities_fulltick_omd_v1_46 import HkexHkexsecuritiesFulltickOmdV146


class HkexHkexsecuritiesFulltickOmdV146Tests(unittest.TestCase):

    def test_addordermessage(self):
        for payload in payloads.of("omi-data-packets/Hkex/HkexSecurities.FullTick.Omd.v1.46/AddOrderMessage.pcap"):
            parsed = HkexHkexsecuritiesFulltickOmdV146.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_deleteordermessage(self):
        for payload in payloads.of("omi-data-packets/Hkex/HkexSecurities.FullTick.Omd.v1.46/DeleteOrderMessage.pcap"):
            parsed = HkexHkexsecuritiesFulltickOmdV146.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_messagesequence(self):
        for payload in payloads.of("omi-data-packets/Hkex/HkexSecurities.FullTick.Omd.v1.46/MessageSequence.pcap"):
            parsed = HkexHkexsecuritiesFulltickOmdV146.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_modifyordermessage(self):
        for payload in payloads.of("omi-data-packets/Hkex/HkexSecurities.FullTick.Omd.v1.46/ModifyOrderMessage.pcap"):
            parsed = HkexHkexsecuritiesFulltickOmdV146.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_trademessage(self):
        for payload in payloads.of("omi-data-packets/Hkex/HkexSecurities.FullTick.Omd.v1.46/TradeMessage.pcap"):
            parsed = HkexHkexsecuritiesFulltickOmdV146.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingsessionstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Hkex/HkexSecurities.FullTick.Omd.v1.46/TradingSessionStatusMessage.pcap"):
            parsed = HkexHkexsecuritiesFulltickOmdV146.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
