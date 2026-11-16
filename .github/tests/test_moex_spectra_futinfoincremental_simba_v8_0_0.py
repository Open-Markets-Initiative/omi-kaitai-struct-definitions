# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from moex_spectra_futinfoincremental_simba_v8_0_0 import MoexSpectraFutinfoincrementalSimbaV800


class MoexSpectraFutinfoincrementalSimbaV800Tests(unittest.TestCase):

    def test_heartbeatmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.FutInfoIncremental.Simba.v8.0.0/HeartbeatMessage.pcap"):
            parsed = MoexSpectraFutinfoincrementalSimbaV800.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitygroupstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.FutInfoIncremental.Simba.v8.0.0/SecurityGroupStatusMessage.pcap"):
            parsed = MoexSpectraFutinfoincrementalSimbaV800.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitymassstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.FutInfoIncremental.Simba.v8.0.0/SecurityMassStatusMessage.pcap"):
            parsed = MoexSpectraFutinfoincrementalSimbaV800.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingsessionstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.FutInfoIncremental.Simba.v8.0.0/TradingSessionStatusMessage.pcap"):
            parsed = MoexSpectraFutinfoincrementalSimbaV800.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
