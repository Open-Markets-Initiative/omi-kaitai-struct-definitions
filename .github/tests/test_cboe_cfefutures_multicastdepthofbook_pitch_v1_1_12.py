# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from cboe_cfefutures_multicastdepthofbook_pitch_v1_1_12 import CboeCfefuturesMulticastdepthofbookPitchV1112


class CboeCfefuturesMulticastdepthofbookPitchV1112Tests(unittest.TestCase):

    def test_futureinstrumentdefinitionmessage(self):
        for payload in payloads.of("omi-data-packets/Cboe/CfeFutures.MulticastDepthOfBook.Pitch.v1.1.12/FutureInstrumentDefinitionMessage.pcap"):
            parsed = CboeCfefuturesMulticastdepthofbookPitchV1112.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
