# Omi Kaitai Struct Definitions

Omi Kaitai Struct definitions provide declarative, cross language parsing of common binary exchange protocols.

[![Kaitai](https://github.com/Open-Markets-Initiative/Directory/blob/main/About/Images/Kaitai.png)](https://github.com/kaitai-io)

For more information on Kaitai Struct: [Kaitai Struct](https://kaitai.io/ "Kaitai Struct Website")
## Usage

Each .ksy file is a complete declarative description of one protocol version. Compile a definition into a parser for your language with the kaitai struct compiler:

```
kaitai-struct-compiler -t python Iex/IexEquities_Tops_IexTp_v1_6_6.ksy
```
Target languages include C++, C#, Java, JavaScript, Python, Ruby, Go, and more.

For compiler information: [Kaitai Struct Compiler](https://kaitai.io/#download "Kaitai Struct Compiler Download")
## Development

Updates are greatly appreciated; however, this entire repository is source generated...including the words you are reading right now. If you wish to suggest definition updates, the recommended process is to create an issue with changes and explanation.  Time permitting, we will update the models and regenerate.

| Protocol Count | Generated Lines |
| --- | --- |
| 238 | 593,407 |

## Testing

[![Build](https://github.com/Open-Markets-Initiative/omi-kaitai-struct-definitions/actions/workflows/build.yml/badge.svg)](https://github.com/Open-Markets-Initiative/omi-kaitai-struct-definitions/actions/workflows/build.yml)

Please report any parsing errors as an [issue](https://github.com/Open-Markets-Initiative/omi-kaitai-struct-definitions/issues "Omi Kaitai Struct Issues").  Include a small note on the protocol and version, and a minimal capture demonstrating the problem. Also consider including a link or pdf specification documenting the correct behavior.

Production packet captures are required for protocol verification.  If your organization has the rights to packet captures, and you wish to make the world a better place, please post captures to this project.

## Open Markets Initiative

[![Omi](https://github.com/Open-Markets-Initiative/Directory/blob/main/About/Images/Logo.png)](https://github.com/Open-Markets-Initiative/Directory)  The Open Markets Initiative (Omi) is a group of technologists dedicated to enhancing the stability of electronic financial markets using modern development methods.

For a list of Omi Hft projects: [Omi Projects](https://github.com/Open-Markets-Initiative/Directory/tree/main/Projects "Open Markets Initiative Projects")

For details of Omi rules and regulations: [Omi Directory](https://github.com/Open-Markets-Initiative/Directory "Open Markets Initiative Directory")
## Protocols

Definitions by Organization: [Cme][Cme.Directory], [Eurex][Eurex.Directory], [Iex][Iex.Directory], [Nasdaq][Nasdaq.Directory], [Nyse][Nyse.Directory]

Definitions by Exchange/Ats/Sip: [AmexEquities][AmexEquities.Directory], [AmexOptions][AmexOptions.Directory], [ArcaEquities][ArcaEquities.Directory], [ArcaOptions][ArcaOptions.Directory], [GemxOptions][GemxOptions.Directory], [IexEquities][IexEquities.Directory], [IexOptions][IexOptions.Directory], [IseOptions][IseOptions.Directory], [MrxOptions][MrxOptions.Directory], [NationalEquities][NationalEquities.Directory], [NomOptions][NomOptions.Directory], [NsmEquities][NsmEquities.Directory], [NtxEquities][NtxEquities.Directory], [NtxOptions][NtxOptions.Directory], [NyseEquities][NyseEquities.Directory], [NyseOptions][NyseOptions.Directory], [PhlxOptions][PhlxOptions.Directory], [PsxEquities][PsxEquities.Directory], [TexasEquities][TexasEquities.Directory], [Uqdf][Uqdf.Directory], [Utdf][Utdf.Directory], [Utp][Utp.Directory]

## Disclaimer

Any similarities between existing people, places and/or protocols is purely incidental.

Enjoy.

[Omi Projects]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Projects "Open Markets Initiative Projects"
[Omi Rules and Regulations]: https://github.com/Open-Markets-Initiative/Directory/tree/main/License "Open Markets Initiative Rules and Regulations"

[Omi.Glossary.Testing]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Glossary/Testing.md "Protocol Testing Status"
[Omi.Glossary.Testing.Verified]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Glossary/Testing.md "Testing Status: Protocol has been tested on live data"
[Omi.Glossary.Testing.Incomplete]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Glossary/Testing.md "Testing Status: Protocol has been tested on live data but contains known issues"
[Omi.Glossary.Testing.Beta]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Glossary/Testing.md "Testing Status: Protocol has not been tested and structure is speculative"
[Omi.Glossary.Testing.Untested]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Glossary/Testing.md "Testing Status: Protocol has not been tested on live data"
[Omi.Encoding.Definitions]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Protocols/ReadMe.md "Encoding Directory"

[Omi.Encoding.Sbe]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Protocols/Sbe.md "Sbe Encoding"
[Omi.Encoding.Fbe]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Protocols/Fbe.md "Fbe Encoding"
[Omi.Encoding.IexTp]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Protocols/IexTp.md "IexTp Encoding"
[Omi.Encoding.Itch]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Protocols/Itch.md "Itch Encoding"
[Omi.Encoding.Ouch]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Protocols/Ouch.md "Ouch Encoding"
[Omi.Encoding.Utp]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Protocols/Utp.md "Utp Encoding"
[Omi.Encoding.Pillar]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Protocols/Pillar.md "Pillar Encoding"
[Omi.Encoding.PillarStream]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Protocols/PillarStream.md "PillarStream Encoding"
[Omi.Encoding.Xdp]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Protocols/Xdp.md "Xdp Encoding"
[Omi.Encoding.Ultra]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Protocols/Ultra.md "Ultra Encoding"

[Cme.Globex.Mdp3]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Cme/Protocols/Globex/Mdp3.md "Market Data Platform 3"
[Cme.Globex.Streamlined]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Cme/Protocols/Globex/Streamlined.md "Streamlined Market Data"
[Cme.Globex.Settlements]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Cme/Protocols/Globex/Settlements.md "Settlements"
[Cme.Globex.Derived]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Cme/Protocols/Globex/Derived.md "Derived Market Data"
[Cme.Globex.EbsSpectrum]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Cme/Protocols/Globex/EbsSpectrum.md "Ebs Spectrum Market Data"
[Cme.Globex.BrokerTecUst]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Cme/Protocols/Globex/BrokerTecUst.md "BrokerTec Us Treasuries"
[Cme.Globex.iLink3]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Cme/Protocols/Globex/iLink3.md "iLink 3"
[Eurex.T7.Eobi]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Eurex/Protocols/T7/Eobi.md "Enhanced Order Book Interface"
[Eurex.T7.Eti]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Eurex/Protocols/T7/Eti.md "Enhanced Trading Interface"
[Eurex.T7.Xti]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Eurex/Protocols/T7/Xti.md "Cash Enhanced Trading Interface"
[Eurex.T7.Edci]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Eurex/Protocols/T7/Edci.md "Extended Derivatives Clearing Interface"
[Iex.IexEquities.Tops]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Iex/Protocols/IexEquities/Tops.md "Top Of Book"
[Iex.IexEquities.Deep]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Iex/Protocols/IexEquities/Deep.md "Depth Of Book"
[Iex.IexEquities.DeepPlus]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Iex/Protocols/IexEquities/DeepPlus.md "DeepPlus"
[Iex.IexOptions.MarketData]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Iex/Protocols/IexOptions/MarketData.md "Market Data"
[Iex.IexOptions.BinaryOrderEntry]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Iex/Protocols/IexOptions/BinaryOrderEntry.md "Binary Order Entry"
[Nasdaq.GemxOptions.DepthOfMarket]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/GemxOptions/DepthOfMarket.md "Depth Of Market"
[Nasdaq.GemxOptions.OrderFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/GemxOptions/OrderFeed.md "Order Feed"
[Nasdaq.GemxOptions.TopOfMarket]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/GemxOptions/TopOfMarket.md "Top Of Market"
[Nasdaq.GemxOptions.TradeFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/GemxOptions/TradeFeed.md "Trade Feed"
[Nasdaq.IseOptions.OrderComboFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/IseOptions/OrderComboFeed.md "Ise Order Combo Market Data Feed"
[Nasdaq.IseOptions.OrderFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/IseOptions/OrderFeed.md "Ise Order Feed Market Data"
[Nasdaq.IseOptions.TopComboQuoteFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/IseOptions/TopComboQuoteFeed.md "Ise Top Combo Quote Feed"
[Nasdaq.IseOptions.DepthOfMarket]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/IseOptions/DepthOfMarket.md "Depth Of Market"
[Nasdaq.IseOptions.SpreadDepthOfMarket]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/IseOptions/SpreadDepthOfMarket.md "Phlx Options Spread Depth"
[Nasdaq.IseOptions.SpreadOrders]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/IseOptions/SpreadOrders.md "Phlx Options Spread Orders"
[Nasdaq.IseOptions.SpreadTopOfMarket]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/IseOptions/SpreadTopOfMarket.md "Phlx Options Spread Top Of Market"
[Nasdaq.IseOptions.SpreadTradeFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/IseOptions/SpreadTradeFeed.md "Phlx Options Spread Trade Feed"
[Nasdaq.IseOptions.TopOfMarket]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/IseOptions/TopOfMarket.md "Top Of Market"
[Nasdaq.IseOptions.TradeFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/IseOptions/TradeFeed.md "Trade Feed"
[Nasdaq.MrxOptions.DepthOfMarket]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/MrxOptions/DepthOfMarket.md "Depth Of Market"
[Nasdaq.MrxOptions.OrderFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/MrxOptions/OrderFeed.md "Order Feed"
[Nasdaq.MrxOptions.SpreadDepthOfMarket]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/MrxOptions/SpreadDepthOfMarket.md "Phlx Options Spread Depth"
[Nasdaq.MrxOptions.SpreadOrders]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/MrxOptions/SpreadOrders.md "Phlx Options Spread Orders"
[Nasdaq.MrxOptions.SpreadTopOfMarket]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/MrxOptions/SpreadTopOfMarket.md "Phlx Options Spread Top Of Market"
[Nasdaq.MrxOptions.SpreadTradeFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/MrxOptions/SpreadTradeFeed.md "Phlx Options Spread Trade Feed"
[Nasdaq.MrxOptions.TopOfMarket]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/MrxOptions/TopOfMarket.md "Top Of Market"
[Nasdaq.MrxOptions.TradeFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/MrxOptions/TradeFeed.md "Trade Feed"
[Nasdaq.NomOptions.Bono]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/NomOptions/Bono.md "Nom Binary Order Entry"
[Nasdaq.NomOptions.Itto]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/NomOptions/Itto.md "Itch To Trade Options"
[Nasdaq.NtxEquities.TotalView]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/NtxEquities/TotalView.md "TX TotalView Itch"
[Nasdaq.NtxEquities.Orders]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/NtxEquities/Orders.md "BX Orders"
[Nasdaq.NtxOptions.TopOfMarket]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/NtxOptions/TopOfMarket.md "Top Of Market"
[Nasdaq.NtxOptions.TradeFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/NtxOptions/TradeFeed.md "Trade Feed"
[Nasdaq.NtxOptions.DepthOfMarket]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/NtxOptions/DepthOfMarket.md "Depth Of Market"
[Nasdaq.PhlxOptions.DepthOfMarket]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/PhlxOptions/DepthOfMarket.md "Depth Of Market"
[Nasdaq.PhlxOptions.Orders]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/PhlxOptions/Orders.md "PHLX Orders"
[Nasdaq.PhlxOptions.Topo]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/PhlxOptions/Topo.md "Phlx Top Order Market Data"
[Nasdaq.PhlxOptions.SpreadDepthOfMarket]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/PhlxOptions/SpreadDepthOfMarket.md "Spread Depth"
[Nasdaq.PhlxOptions.SpreadOrders]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/PhlxOptions/SpreadOrders.md "Spread Orders"
[Nasdaq.PhlxOptions.SpreadTopOfMarket]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/PhlxOptions/SpreadTopOfMarket.md "Spread Top Of Market"
[Nasdaq.PhlxOptions.SpreadTradeFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/PhlxOptions/SpreadTradeFeed.md "Spread Trade Feed"
[Nasdaq.PhlxOptions.TradeFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/PhlxOptions/TradeFeed.md "Trade Feed"
[Nasdaq.PsxEquities.LastSale]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/PsxEquities/LastSale.md "Last Sale"
[Nasdaq.PsxEquities.TotalView]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/PsxEquities/TotalView.md "TotalView Itch"
[Nasdaq.PsxEquities.Bbo]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/PsxEquities/Bbo.md "Best Bid And Offer"
[Nasdaq.PsxEquities.Orders]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/PsxEquities/Orders.md "Orders"
[Nasdaq.NsmEquities.Aggregated]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/NsmEquities/Aggregated.md "TotalView Aggregated"
[Nasdaq.NsmEquities.Level2]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/NsmEquities/Level2.md "Level 2"
[Nasdaq.NsmEquities.NlsPlus]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/NsmEquities/NlsPlus.md "Last Sale Plus"
[Nasdaq.NsmEquities.Nois]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/NsmEquities/Nois.md "Net Order Imbalance Snapshot"
[Nasdaq.NsmEquities.NoiView]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/NsmEquities/NoiView.md "Net Order Imbalance View"
[Nasdaq.NsmEquities.Orders]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/NsmEquities/Orders.md "Orders"
[Nasdaq.NsmEquities.TotalView]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/NsmEquities/TotalView.md "TotalView Itch"
[Nasdaq.Uqdf.Output]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/Uqdf/Output.md "Output"
[Nasdaq.Utdf.Output]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/Utdf/Output.md "Output"
[Nasdaq.Utp.Input]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/Utp/Input.md ""
[Nasdaq.Utp.Snapshot]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nasdaq/Protocols/Utp/Snapshot.md "Snapshot"
[Nyse.AmexEquities.Bbo]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/AmexEquities/Bbo.md "Best Bid And Offer"
[Nyse.AmexEquities.BinaryGateway]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/AmexEquities/BinaryGateway.md "Binary Gateway"
[Nyse.AmexEquities.Bqt]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/AmexEquities/Bqt.md "Best Quote And Trade"
[Nyse.AmexEquities.DepthFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/AmexEquities/DepthFeed.md "Depth Feed"
[Nyse.AmexEquities.ImbalancesFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/AmexEquities/ImbalancesFeed.md "Imbalances Feed"
[Nyse.AmexEquities.IntegratedFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/AmexEquities/IntegratedFeed.md "Integrated Feed"
[Nyse.AmexEquities.OpenBook.Aggregated]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/AmexEquities/OpenBook.Aggregated.md "Open Book Aggregated"
[Nyse.AmexEquities.OpenBook]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/AmexEquities/OpenBook.md "Open Book"
[Nyse.AmexEquities.Trades]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/AmexEquities/Trades.md "Trades"
[Nyse.AmexOptions.BinaryGateway]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/AmexOptions/BinaryGateway.md "Binary Gateway"
[Nyse.AmexOptions.ComplexFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/AmexOptions/ComplexFeed.md "Complex Feed"
[Nyse.AmexOptions.DeepFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/AmexOptions/DeepFeed.md "Deep Feed"
[Nyse.AmexOptions.TopFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/AmexOptions/TopFeed.md "Top Feed"
[Nyse.ArcaEquities.ArcaBook]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/ArcaEquities/ArcaBook.md "ArcaBook"
[Nyse.ArcaEquities.Bbo]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/ArcaEquities/Bbo.md "Best Bid And Offer"
[Nyse.ArcaEquities.BinaryGateway]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/ArcaEquities/BinaryGateway.md "Binary Gateway"
[Nyse.ArcaEquities.Bqt]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/ArcaEquities/Bqt.md "Best Quote And Trade"
[Nyse.ArcaEquities.DepthFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/ArcaEquities/DepthFeed.md "Depth Feed"
[Nyse.ArcaEquities.ImbalancesFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/ArcaEquities/ImbalancesFeed.md "Imbalances Feed"
[Nyse.ArcaEquities.IntegratedFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/ArcaEquities/IntegratedFeed.md "Integrated Feed"
[Nyse.ArcaEquities.Trades]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/ArcaEquities/Trades.md "Trades"
[Nyse.ArcaOptions.BinaryGateway]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/ArcaOptions/BinaryGateway.md "Binary Gateway"
[Nyse.ArcaOptions.ComplexFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/ArcaOptions/ComplexFeed.md "Complex Feed"
[Nyse.ArcaOptions.DeepFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/ArcaOptions/DeepFeed.md "Deep Feed"
[Nyse.ArcaOptions.TopFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/ArcaOptions/TopFeed.md "Top Feed"
[Nyse.NationalEquities.Bbo]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NationalEquities/Bbo.md "Best Bid And Offer"
[Nyse.NationalEquities.BinaryGateway]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NationalEquities/BinaryGateway.md "Binary Gateway"
[Nyse.NationalEquities.Bqt]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NationalEquities/Bqt.md "Best Quote And Trade"
[Nyse.NationalEquities.DepthFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NationalEquities/DepthFeed.md "Depth Feed"
[Nyse.NationalEquities.IntegratedFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NationalEquities/IntegratedFeed.md "Integrated Feed"
[Nyse.NationalEquities.Trades]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NationalEquities/Trades.md "Trades"
[Nyse.NyseConsolidated.Bqt]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NyseConsolidated/Bqt.md ""
[Nyse.NyseEquities.Bbo]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NyseEquities/Bbo.md "Best Bid And Offer"
[Nyse.NyseEquities.BinaryGateway]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NyseEquities/BinaryGateway.md "Binary Gateway"
[Nyse.NyseEquities.Bqt]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NyseEquities/Bqt.md "Best Quote And Trade"
[Nyse.NyseEquities.DepthFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NyseEquities/DepthFeed.md "Depth Feed"
[Nyse.NyseEquities.ImbalancesFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NyseEquities/ImbalancesFeed.md "Imbalances Feed"
[Nyse.NyseEquities.IntegratedFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NyseEquities/IntegratedFeed.md "Integrated Feed"
[Nyse.NyseEquities.OpenBook.Aggregated]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NyseEquities/OpenBook.Aggregated.md "Open Book Aggregated"
[Nyse.NyseEquities.OpenBook]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NyseEquities/OpenBook.md "Open Book"
[Nyse.NyseEquities.Trades]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NyseEquities/Trades.md "Trades"
[Nyse.NyseOptions.CommonClient]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/NyseOptions/CommonClient.md "Common Client"
[Nyse.Options.StreamProtocol]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/Options/StreamProtocol.md "Stream Protocol"
[Nyse.TexasEquities.Bbo]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/TexasEquities/Bbo.md "Best Bid And Offer"
[Nyse.TexasEquities.BinaryGateway]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/TexasEquities/BinaryGateway.md "Binary Gateway"
[Nyse.TexasEquities.Bqt]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/TexasEquities/Bqt.md "Best Quote And Trade"
[Nyse.TexasEquities.DepthFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/TexasEquities/DepthFeed.md "Depth Feed"
[Nyse.TexasEquities.ImbalancesFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/TexasEquities/ImbalancesFeed.md "Imbalances Feed"
[Nyse.TexasEquities.IntegratedFeed]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/TexasEquities/IntegratedFeed.md "Integrated Feed"
[Nyse.TexasEquities.Trades]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Nyse/Protocols/TexasEquities/Trades.md "Trades"

[Cme.Directory]: https://github.com/Open-Markets-Initiative/omi-kaitai-struct-definitions/tree/main/cme "CME Group"
[Eurex.Directory]: https://github.com/Open-Markets-Initiative/omi-kaitai-struct-definitions/tree/main/eurex "Eurex Exchange"
[Iex.Directory]: https://github.com/Open-Markets-Initiative/omi-kaitai-struct-definitions/tree/main/iex "Investors Exchange"
[Nasdaq.Directory]: https://github.com/Open-Markets-Initiative/omi-kaitai-struct-definitions/tree/main/nasdaq "National Association of Securities Dealers Automated Quotations (Nasdaq)"
[Nyse.Directory]: https://github.com/Open-Markets-Initiative/omi-kaitai-struct-definitions/tree/main/nyse "New York Stock Exchange"

[AmexEquities.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nyse/Protocols/AmexEquities "Nyse AmexEquities"
[AmexOptions.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nyse/Protocols/AmexOptions "Nyse AmexOptions"
[ArcaEquities.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nyse/Protocols/ArcaEquities "Nyse ArcaEquities"
[ArcaOptions.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nyse/Protocols/ArcaOptions "Nyse ArcaOptions"
[GemxOptions.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nasdaq/Protocols/GemxOptions "Nasdaq GemxOptions"
[IexEquities.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Iex/Protocols/IexEquities "Iex IexEquities"
[IexOptions.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Iex/Protocols/IexOptions "Iex IexOptions"
[IseOptions.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nasdaq/Protocols/IseOptions "Nasdaq IseOptions"
[MrxOptions.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nasdaq/Protocols/MrxOptions "Nasdaq MrxOptions"
[NationalEquities.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nyse/Protocols/NationalEquities "Nyse NationalEquities"
[NomOptions.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nasdaq/Protocols/NomOptions "Nasdaq NomOptions"
[NsmEquities.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nasdaq/Protocols/NsmEquities "Nasdaq NsmEquities"
[NtxEquities.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nasdaq/Protocols/NtxEquities "Nasdaq NtxEquities"
[NtxOptions.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nasdaq/Protocols/NtxOptions "Nasdaq NtxOptions"
[NyseEquities.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nyse/Protocols/NyseEquities "Nyse NyseEquities"
[NyseOptions.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nyse/Protocols/NyseOptions "Nyse NyseOptions"
[PhlxOptions.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nasdaq/Protocols/PhlxOptions "Nasdaq PhlxOptions"
[PsxEquities.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nasdaq/Protocols/PsxEquities "Nasdaq PsxEquities"
[TexasEquities.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nyse/Protocols/TexasEquities "Nyse TexasEquities"
[Uqdf.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nasdaq/Protocols/Uqdf "Nasdaq Uqdf"
[Utdf.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nasdaq/Protocols/Utdf "Nasdaq Utdf"
[Utp.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Nasdaq/Protocols/Utp "Nasdaq Utp"
