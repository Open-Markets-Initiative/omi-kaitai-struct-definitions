# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from jpx_osederivatives_geniuminet_itch_v5_0_6 import JpxOsederivativesGeniuminetItchV506


class JpxOsederivativesGeniuminetItchV506Tests(unittest.TestCase):

    def test_addordernompid(self):
        for payload in payloads.of("omi-data-packets/Jpx/OseDerivatives.GeniumInet.Itch.v5.0.6/AddOrderNoMpid.pcap"):
            parsed = JpxOsederivativesGeniuminetItchV506.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_equilibriumpriceupdate(self):
        for payload in payloads.of("omi-data-packets/Jpx/OseDerivatives.GeniumInet.Itch.v5.0.6/EquilibriumPriceUpdate.pcap"):
            parsed = JpxOsederivativesGeniuminetItchV506.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderbookstatemessage(self):
        for payload in payloads.of("omi-data-packets/Jpx/OseDerivatives.GeniumInet.Itch.v5.0.6/OrderBookStateMessage.pcap"):
            parsed = JpxOsederivativesGeniuminetItchV506.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdeletemessage(self):
        for payload in payloads.of("omi-data-packets/Jpx/OseDerivatives.GeniumInet.Itch.v5.0.6/OrderDeleteMessage.pcap"):
            parsed = JpxOsederivativesGeniuminetItchV506.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Jpx/OseDerivatives.GeniumInet.Itch.v5.0.6/OrderExecutedMessage.pcap"):
            parsed = JpxOsederivativesGeniuminetItchV506.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedwithpricemessage(self):
        for payload in payloads.of("omi-data-packets/Jpx/OseDerivatives.GeniumInet.Itch.v5.0.6/OrderExecutedWithPriceMessage.pcap"):
            parsed = JpxOsederivativesGeniuminetItchV506.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_secondsmessage(self):
        for payload in payloads.of("omi-data-packets/Jpx/OseDerivatives.GeniumInet.Itch.v5.0.6/SecondsMessage.pcap"):
            parsed = JpxOsederivativesGeniuminetItchV506.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
