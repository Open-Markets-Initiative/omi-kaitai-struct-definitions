# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_nsmequities_totalview_itch_v5_0_2023 import NasdaqNsmequitiesTotalviewItchV502023


class NasdaqNsmequitiesTotalviewItchV502023Tests(unittest.TestCase):

    def test_mpid(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/AddOrderNoMPID.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_mpid(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/AddOrderWithMPID.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_crosstrademessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/CrossTrade.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_luldauctioncollarmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/LULDAuctionCollar.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketparticipantpositionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/MarketParticipantPosition.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_netorderimbalanceindicatormessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/NetOrderImbalanceIndicator.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_noncrosstrademessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/NonCrossTrade.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancelmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/OrderCancel.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdeletemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/OrderDelete.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/OrderExecuted.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedwithpricemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/OrderExecutedWithPrice.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderreplacemessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/OrderReplace.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_message(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/RegSHORestriction.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_stocktradingactionmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/StockTradingAction.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemeventmessage(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/SystemEvent.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
