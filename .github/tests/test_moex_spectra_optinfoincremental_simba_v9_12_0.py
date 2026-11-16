# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from moex_spectra_optinfoincremental_simba_v9_12_0 import MoexSpectraOptinfoincrementalSimbaV9120


class MoexSpectraOptinfoincrementalSimbaV9120Tests(unittest.TestCase):

    def test_heartbeatmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OptInfoIncremental.Simba.v9.12.0/HeartbeatMessage.pcap"):
            parsed = MoexSpectraOptinfoincrementalSimbaV9120.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_messagesequence(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OptInfoIncremental.Simba.v9.12.0/MessageSequence.pcap"):
            parsed = MoexSpectraOptinfoincrementalSimbaV9120.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitydefinitionupdatereportmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OptInfoIncremental.Simba.v9.12.0/SecurityDefinitionUpdateReportMessage.pcap"):
            parsed = MoexSpectraOptinfoincrementalSimbaV9120.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitygroupstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OptInfoIncremental.Simba.v9.12.0/SecurityGroupStatusMessage.pcap"):
            parsed = MoexSpectraOptinfoincrementalSimbaV9120.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_securitymassstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OptInfoIncremental.Simba.v9.12.0/SecurityMassStatusMessage.pcap"):
            parsed = MoexSpectraOptinfoincrementalSimbaV9120.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_tradingsessionstatusmessage(self):
        for payload in payloads.of("omi-data-packets/Moex/Spectra.OptInfoIncremental.Simba.v9.12.0/TradingSessionStatusMessage.pcap"):
            parsed = MoexSpectraOptinfoincrementalSimbaV9120.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
