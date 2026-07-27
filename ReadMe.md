# Omi Kaitai Struct Definitions

Omi Kaitai Struct definitions provide declarative, cross language parsing of common binary exchange protocols.

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
| 31 | 76,831 |

## Testing

[![Build](https://github.com/Open-Markets-Initiative/omi-kaitai-struct-definitions/actions/workflows/build.yml/badge.svg)](https://github.com/Open-Markets-Initiative/omi-kaitai-struct-definitions/actions/workflows/build.yml)

Please report any parsing errors as an [issue](https://github.com/Open-Markets-Initiative/omi-kaitai-struct-definitions/issues "Omi Kaitai Struct Issues").  Include a small note on the protocol and version, and a minimal capture demonstrating the problem. Also consider including a link or pdf specification documenting the correct behavior.

Production packet captures are required for protocol verification.  If your organization has the rights to packet captures, and you wish to make the world a better place, please post captures to this project.

## Open Markets Initiative

[![Omi](https://github.com/Open-Markets-Initiative/Directory/blob/main/About/Images/Logo.png)](https://github.com/Open-Markets-Initiative/Directory)  The Open Markets Initiative (Omi) is a group of technologists dedicated to enhancing the stability of electronic financial markets using modern development methods.

For a list of Omi Hft projects: [Omi Projects](https://github.com/Open-Markets-Initiative/Directory/tree/main/Projects "Open Markets Initiative Projects")

For details of Omi rules and regulations: [Omi Directory](https://github.com/Open-Markets-Initiative/Directory "Open Markets Initiative Directory")
## Protocols

Definitions by Organization: [Cme][Cme.Directory], [Iex][Iex.Directory]

Definitions by Exchange/Ats/Sip: [CmeFutures][CmeFutures.Directory], [IexEquities][IexEquities.Directory], [IexOptions][IexOptions.Directory]

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
[Omi.Encoding.IexTp]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Protocols/IexTp.md "IexTp Encoding"

[Cme.CmeFutures.Mdp3]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Cme/Protocols/CmeFutures/Mdp3.md "Market Data Platform 3"
[Cme.CmeFutures.Streamlined]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Cme/Protocols/CmeFutures/Streamlined.md "Streamlined Market Data"
[Cme.CmeFutures.Settlements]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Cme/Protocols/CmeFutures/Settlements.md "Settlements"
[Cme.CmeFutures.Derived]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Cme/Protocols/CmeFutures/Derived.md "Derived Market Data"
[Cme.CmeFutures.EbsSpectrum]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Cme/Protocols/CmeFutures/EbsSpectrum.md "Ebs Spectrum Market Data"
[Cme.CmeFutures.BrokerTecUst]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Cme/Protocols/CmeFutures/BrokerTecUst.md "BrokerTec Us Treasuries"
[Cme.CmeFutures.iLink3]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Cme/Protocols/CmeFutures/iLink3.md "iLink 3"
[Iex.IexEquities.Tops]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Iex/Protocols/IexEquities/Tops.md "Top Of Book"
[Iex.IexEquities.Deep]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Iex/Protocols/IexEquities/Deep.md "Depth Of Book"
[Iex.IexEquities.DeepPlus]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Iex/Protocols/IexEquities/DeepPlus.md "DeepPlus"
[Iex.IexOptions.MarketData]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Iex/Protocols/IexOptions/MarketData.md "Market Data"
[Iex.IexOptions.BinaryOrderEntry]: https://github.com/Open-Markets-Initiative/Directory/blob/main/Organizations/Iex/Protocols/IexOptions/BinaryOrderEntry.md "Binary Order Entry"

[Cme.Directory]: https://github.com/Open-Markets-Initiative/omi-kaitai-struct-definitions/tree/main/cme "CME Group"
[Iex.Directory]: https://github.com/Open-Markets-Initiative/omi-kaitai-struct-definitions/tree/main/iex "Investors Exchange"

[CmeFutures.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Cme/Protocols/CmeFutures "Cme CmeFutures"
[IexEquities.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Iex/Protocols/IexEquities "Iex IexEquities"
[IexOptions.Directory]: https://github.com/Open-Markets-Initiative/Directory/tree/main/Organizations/Iex/Protocols/IexOptions "Iex IexOptions"
