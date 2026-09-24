# Generated Kaitai Struct definition tests: captures from omi-data-packets

import sys
import unittest

sys.path.insert(0, "generated/python")

import payloads

from miax_pearlequities_expressorders_meo_v2_6 import MiaxPearlequitiesExpressordersMeoV26


class MiaxPearlequitiesExpressordersMeoV26Tests(unittest.TestCase):

    def test_cancelorderrequest(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.ExpressOrders.Meo.v2.6/CancelOrderRequest.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = MiaxPearlequitiesExpressordersMeoV26.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_cancelorderresponse(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.ExpressOrders.Meo.v2.6/CancelOrderResponse.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = MiaxPearlequitiesExpressordersMeoV26.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_cancelorreducesizeordernotification(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.ExpressOrders.Meo.v2.6/CancelOrReduceSizeOrderNotification.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = MiaxPearlequitiesExpressordersMeoV26.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_clientheartbeat(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.ExpressOrders.Meo.v2.6/ClientHeartbeat.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = MiaxPearlequitiesExpressordersMeoV26.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginrequest(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.ExpressOrders.Meo.v2.6/LoginRequest.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = MiaxPearlequitiesExpressordersMeoV26.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_loginresponse(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.ExpressOrders.Meo.v2.6/LoginResponse.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = MiaxPearlequitiesExpressordersMeoV26.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_newordernotification(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.ExpressOrders.Meo.v2.6/NewOrderNotification.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = MiaxPearlequitiesExpressordersMeoV26.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_neworderrequest(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.ExpressOrders.Meo.v2.6/NewOrderRequest.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = MiaxPearlequitiesExpressordersMeoV26.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_orderpriceupdatenotification(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.ExpressOrders.Meo.v2.6/OrderPriceUpdateNotification.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = MiaxPearlequitiesExpressordersMeoV26.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_serverheartbeat(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.ExpressOrders.Meo.v2.6/ServerHeartbeat.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = MiaxPearlequitiesExpressordersMeoV26.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_symbolupdate(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.ExpressOrders.Meo.v2.6/SymbolUpdate.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = MiaxPearlequitiesExpressordersMeoV26.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())

    def test_systemstatenotification(self):
        for payload in payloads.of("omi-data-packets/Miax/PearlEquities.ExpressOrders.Meo.v2.6/SystemStateNotification.pcap"):
            if payloads.partial(payload, 0, 2, "little", False):
                self.skipTest("capture ends mid message; tcp reassembly required")
            parsed = MiaxPearlequitiesExpressordersMeoV26.from_bytes(payload)
            self.assertTrue(parsed._io.is_eof())


if __name__ == "__main__":
    unittest.main()
