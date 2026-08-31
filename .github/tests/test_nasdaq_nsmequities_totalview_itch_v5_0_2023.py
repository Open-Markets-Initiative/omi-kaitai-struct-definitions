# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from nasdaq_nsmequities_totalview_itch_v5_0_2023 import NasdaqNsmequitiesTotalviewItchV502023


class NasdaqNsmequitiesTotalviewItchV502023Tests(unittest.TestCase):

    def test_addordernompid(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/AddOrderNoMPID.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_addorderwithmpid(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/AddOrderWithMPID.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_crosstrade(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/CrossTrade.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_luldauctioncollar(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/LULDAuctionCollar.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_marketparticipantposition(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/MarketParticipantPosition.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_netorderimbalanceindicator(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/NetOrderImbalanceIndicator.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_noncrosstrade(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/NonCrossTrade.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_ordercancel(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/OrderCancel.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderdelete(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/OrderDelete.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecuted(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/OrderExecuted.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderexecutedwithprice(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/OrderExecutedWithPrice.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderreplace(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/OrderReplace.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_regshorestriction(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/RegSHORestriction.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_stocktradingaction(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/StockTradingAction.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemevent(self):
        for payload in payloads.of("omi-data-packets/Nasdaq/NsmEquities.TotalView.Itch.v5.0.2023/SystemEvent.pcap"):
            parsed = NasdaqNsmequitiesTotalviewItchV502023.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
