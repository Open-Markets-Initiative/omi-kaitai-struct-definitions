# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nyse_nyseequities_binarygateway_pillarstream_v5_17 import NyseNyseequitiesBinarygatewayPillarstreamV517


class NyseNyseequitiesBinarygatewayPillarstreamV517Tests(unittest.TestCase):

    def test_newordersingleandcancelreplacerequestmessage(self):
        for payload in payloads.of("omi-data-packets/Nyse/NyseEquities.BinaryGateway.PillarStream.v5.17/NewOrderSingleAndCancelReplaceRequestMessage.pcap"):
            parsed = NyseNyseequitiesBinarygatewayPillarstreamV517.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
