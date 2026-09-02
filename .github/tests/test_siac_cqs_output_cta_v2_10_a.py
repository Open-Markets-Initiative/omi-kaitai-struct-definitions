# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from siac_cqs_output_cta_v2_10_a import SiacCqsOutputCtaV210A


class SiacCqsOutputCtaV210ATests(unittest.TestCase):

    def test_a_s_symbol_reference_data(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v2.10.a/A_S_Symbol_Reference_Data.pcap"):
            parsed = SiacCqsOutputCtaV210A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_c_a_start_of_day(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v2.10.a/C_A_Start_of_Day.pcap"):
            parsed = SiacCqsOutputCtaV210A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_c_c_finra_close(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v2.10.a/C_C_FINRA_Close.pcap"):
            parsed = SiacCqsOutputCtaV210A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_c_o_finra_open(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v2.10.a/C_O_FINRA_Open.pcap"):
            parsed = SiacCqsOutputCtaV210A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_c_t_line_integrity(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v2.10.a/C_T_Line_Integrity.pcap"):
            parsed = SiacCqsOutputCtaV210A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_c_z_end_of_day(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v2.10.a/C_Z_End_of_Day.pcap"):
            parsed = SiacCqsOutputCtaV210A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_m_k_mwcb_decline_level_status(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v2.10.a/M_K_MWCB_Decline_Level_Status.pcap"):
            parsed = SiacCqsOutputCtaV210A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_q_l_long_quote(self):
        for payload in payloads.of("omi-data-packets/Siac/Cqs.Output.Cta.v2.10.a/Q_L_Long_Quote.pcap"):
            parsed = SiacCqsOutputCtaV210A.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
