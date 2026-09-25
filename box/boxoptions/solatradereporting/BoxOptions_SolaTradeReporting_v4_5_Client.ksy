# ---------------------------------------------------------------------
# Kaitai struct definition for: Box BoxOptions SolaTradeReporting Atr v4.5
#
# Protocol:
#   Organization: Box Options Market
#   Protocol: Sola Trade Reporting
#   Encoding: Automated Trade Reporting
#   Version: 4.5
#   Date: 11/05/2024
#   Specification: ATR-BX-001E-BOX-SOLA-ATR-Specifications-v4.5.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: Public/GPLv3
#   Authors: Omi Developers
#
# Copyright (c) 2026 Scaled Sources LLC.  https://www.scaledsources.com
#
# This kaitai struct definition is contributed to The Open Markets Initiative under
# the license noted above.
#
# The protocol compiler technologies used to produce this file
# are the subject of patents owned by Scaled Sources LLC.  Those patent
# rights are retained and are not transferred by this contribution:
#   https://patents.google.com/patent/US20240129382A1/en
#   https://patents.google.com/patent/US20240419416A1/en
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: box_boxoptions_solatradereporting_atr_v4_5_client
  title: Box BoxOptions SolaTradeReporting Atr v4.5
  license: GPL-3.0
  endian: be

doc: 'Box Options Market BOX Options Exchange Sola Trade Reporting Atr v4.5'

seq:
  - id: message_header
    type: message_header_struct
    doc: 'Atr message header, twenty eight bytes opening every message either way'
  - id: client_message
    type:
      switch-on: message_header.message_type
      cases:
        '"04"': restart_request
        '"09"': client_signon
        '"42"': new_allocation
        '"43"': modify_allocation
        '"44"': delete_allocation
        '"52"': new_give_up
        '"53"': modify_give_up
        '"54"': delete_give_up
  - id: end_of_text
    type: u1
    doc: 'End of text, an ascii character of 0x03, closing every Atr message'

types:
  message_header_struct:
    seq:
      - id: source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the mnemonic of the message source'
      - id: destination
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the mnemonic of the message destination, Box for Box or the firm''s clearing number'
      - id: message_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'The two digits naming which message follows the header'
      - id: message_flag
        type: u1
        enum: message_flag
        doc: 'Whether the message is a retransmission or a duplicate, blank for a normal message'
      - id: control_byte
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unused, always blank'
      - id: sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'If the sequence number is higher than any message number known to the ATR Server, the Participant will receive the next message from the last sequence number which was sent by the ATR Server. In the [1,99999999] range, right justified, zero padded'
      - id: acknowledgement_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Original outbound number of the message being acknowledged, right justified and zero padded'
  restart_request:
    seq:
      - id: sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'If the sequence number is higher than any message number known to the ATR Server, the Participant will receive the next message from the last sequence number which was sent by the ATR Server. In the [1,99999999] range, right justified, zero padded'
  client_signon:
    seq:
      - id: member_number
        type: str
        size: 4
        encoding: ASCII
        doc: 'In the [0001,9999] range Right justified, zero padded'
      - id: initial_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'The ATR Server will begin at this specific sequence number In the [1,99999999] range Right justified, zero padded'
      - id: protocol_version
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Protocol versions supported: A2, A3'
      - id: time
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time at which the Client Signon is sent (HHMMSS)'
      - id: username
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the User for a connection. The Username must be configured by BOX MOC (Please contact BOX MOC for details)'
      - id: password_md_5_encryption
        type: str
        size: 8
        encoding: ASCII
        doc: 'Used when establishing an ATR Logical connection See Section 7 for details on how to encode password. (Please contact BOX MOC for details about new password procedure or password reset)'
  new_allocation:
    seq:
      - id: reference_transaction_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'For Message Type 42 – New Allocation Identifies the Unique Transaction ID of the parent Trade under which the Allocation is to be created. For Message Type 43 – Modify Allocation Identifies the Unique Transaction ID of the original Allocation which is to be modified. For Message Type 52 – New Give-Up Identifies the Unique Transaction ID of the parent Trade under which the Give-Up is to be created. For Message Type 53 – Modify Give-Up Identifies the Unique Transaction ID of the original Give- Up which is to be modified'
      - id: reference_trade_number
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the Trade received from the Message Type 30 - Trade This refers to the Trade Number under which a New Allocation (or Give-Up) is to be created or under which an existing Allocation (or Give-Up) is to be modified'
      - id: give_up_firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the Give-Up Firm Applies only for Message Type 52 (New Give-Up) or Message Type 53 (Modify Give-Up), otherwise leave blank. The guide states no data type for this field; read as alphabetic, as every other firm field of this width is'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Volume of the trade Right justified, Zero padded'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'Account type of the Executing Broker of the trade 6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer V: Floor Broker Customer W: Broker Dealer cleared as Customer X: Away Market Maker Y: Floor Broker Dealer Z: Floor Market Maker FLEX Symbology: Symbol is prefixed by one of the following: ‘1’ (American FLEX Option, Physical-Settled) ‘2’ (European FLEX Option, Physical-Settled) ‘3’ (American FLEX Option, Cash-Settled) ‘4’ (European FLEX Option, Cash-Settled)'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Position of the trade O: Open C: Close'
      - id: client_account_number
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, right blank filled Used with Client Order ID and Client Memo for Order Identification'
      - id: subtrader_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'For Allocation (40) and Allocation Cancel (41) messages, the ''Sub-trader ID'' field contains the Market Maker OCC sub-account. For Trade (30) and Trade Cancel (31) messages, the ‘Sub-trader ID’ field contains the last 2 digits of the Trader ID'
      - id: cmta_broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Contains the numeric portion of the Firm ID who will receive the trade in a CMTA'
      - id: client_memo
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, right blank filled Used with Client Account Number and Client Order ID for Order Identification'
      - id: additional_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Contains the numeric portion of the BOX Participant ID (FirmID) to which this message is to be drop-copied In the [0001,9999] range Right justified, zero padded'
      - id: additional_client_memo
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, right blank filled Free text field'
  modify_allocation:
    seq:
      - id: reference_transaction_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'For Message Type 42 – New Allocation Identifies the Unique Transaction ID of the parent Trade under which the Allocation is to be created. For Message Type 43 – Modify Allocation Identifies the Unique Transaction ID of the original Allocation which is to be modified. For Message Type 52 – New Give-Up Identifies the Unique Transaction ID of the parent Trade under which the Give-Up is to be created. For Message Type 53 – Modify Give-Up Identifies the Unique Transaction ID of the original Give- Up which is to be modified'
      - id: reference_trade_number
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the Trade received from the Message Type 30 - Trade This refers to the Trade Number under which a New Allocation (or Give-Up) is to be created or under which an existing Allocation (or Give-Up) is to be modified'
      - id: give_up_firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the Give-Up Firm Applies only for Message Type 52 (New Give-Up) or Message Type 53 (Modify Give-Up), otherwise leave blank. The guide states no data type for this field; read as alphabetic, as every other firm field of this width is'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Volume of the trade Right justified, Zero padded'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'Account type of the Executing Broker of the trade 6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer V: Floor Broker Customer W: Broker Dealer cleared as Customer X: Away Market Maker Y: Floor Broker Dealer Z: Floor Market Maker FLEX Symbology: Symbol is prefixed by one of the following: ‘1’ (American FLEX Option, Physical-Settled) ‘2’ (European FLEX Option, Physical-Settled) ‘3’ (American FLEX Option, Cash-Settled) ‘4’ (European FLEX Option, Cash-Settled)'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Position of the trade O: Open C: Close'
      - id: client_account_number
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, right blank filled Used with Client Order ID and Client Memo for Order Identification'
      - id: subtrader_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'For Allocation (40) and Allocation Cancel (41) messages, the ''Sub-trader ID'' field contains the Market Maker OCC sub-account. For Trade (30) and Trade Cancel (31) messages, the ‘Sub-trader ID’ field contains the last 2 digits of the Trader ID'
      - id: cmta_broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Contains the numeric portion of the Firm ID who will receive the trade in a CMTA'
      - id: client_memo
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, right blank filled Used with Client Account Number and Client Order ID for Order Identification'
      - id: additional_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Contains the numeric portion of the BOX Participant ID (FirmID) to which this message is to be drop-copied In the [0001,9999] range Right justified, zero padded'
      - id: additional_client_memo
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, right blank filled Free text field'
  delete_allocation:
    seq:
      - id: reference_transaction_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'For Message Type 42 – New Allocation Identifies the Unique Transaction ID of the parent Trade under which the Allocation is to be created. For Message Type 43 – Modify Allocation Identifies the Unique Transaction ID of the original Allocation which is to be modified. For Message Type 52 – New Give-Up Identifies the Unique Transaction ID of the parent Trade under which the Give-Up is to be created. For Message Type 53 – Modify Give-Up Identifies the Unique Transaction ID of the original Give- Up which is to be modified'
      - id: reference_trade_number
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the Trade received from the Message Type 30 - Trade This refers to the Trade Number under which a New Allocation (or Give-Up) is to be created or under which an existing Allocation (or Give-Up) is to be modified'
  new_give_up:
    seq:
      - id: reference_transaction_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'For Message Type 42 – New Allocation Identifies the Unique Transaction ID of the parent Trade under which the Allocation is to be created. For Message Type 43 – Modify Allocation Identifies the Unique Transaction ID of the original Allocation which is to be modified. For Message Type 52 – New Give-Up Identifies the Unique Transaction ID of the parent Trade under which the Give-Up is to be created. For Message Type 53 – Modify Give-Up Identifies the Unique Transaction ID of the original Give- Up which is to be modified'
      - id: reference_trade_number
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the Trade received from the Message Type 30 - Trade This refers to the Trade Number under which a New Allocation (or Give-Up) is to be created or under which an existing Allocation (or Give-Up) is to be modified'
      - id: give_up_firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the Give-Up Firm Applies only for Message Type 52 (New Give-Up) or Message Type 53 (Modify Give-Up), otherwise leave blank. The guide states no data type for this field; read as alphabetic, as every other firm field of this width is'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Volume of the trade Right justified, Zero padded'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'Account type of the Executing Broker of the trade 6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer V: Floor Broker Customer W: Broker Dealer cleared as Customer X: Away Market Maker Y: Floor Broker Dealer Z: Floor Market Maker FLEX Symbology: Symbol is prefixed by one of the following: ‘1’ (American FLEX Option, Physical-Settled) ‘2’ (European FLEX Option, Physical-Settled) ‘3’ (American FLEX Option, Cash-Settled) ‘4’ (European FLEX Option, Cash-Settled)'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Position of the trade O: Open C: Close'
      - id: client_account_number
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, right blank filled Used with Client Order ID and Client Memo for Order Identification'
      - id: subtrader_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'For Allocation (40) and Allocation Cancel (41) messages, the ''Sub-trader ID'' field contains the Market Maker OCC sub-account. For Trade (30) and Trade Cancel (31) messages, the ‘Sub-trader ID’ field contains the last 2 digits of the Trader ID'
      - id: cmta_broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Contains the numeric portion of the Firm ID who will receive the trade in a CMTA'
      - id: client_memo
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, right blank filled Used with Client Account Number and Client Order ID for Order Identification'
      - id: additional_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Contains the numeric portion of the BOX Participant ID (FirmID) to which this message is to be drop-copied In the [0001,9999] range Right justified, zero padded'
      - id: additional_client_memo
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, right blank filled Free text field'
  modify_give_up:
    seq:
      - id: reference_transaction_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'For Message Type 42 – New Allocation Identifies the Unique Transaction ID of the parent Trade under which the Allocation is to be created. For Message Type 43 – Modify Allocation Identifies the Unique Transaction ID of the original Allocation which is to be modified. For Message Type 52 – New Give-Up Identifies the Unique Transaction ID of the parent Trade under which the Give-Up is to be created. For Message Type 53 – Modify Give-Up Identifies the Unique Transaction ID of the original Give- Up which is to be modified'
      - id: reference_trade_number
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the Trade received from the Message Type 30 - Trade This refers to the Trade Number under which a New Allocation (or Give-Up) is to be created or under which an existing Allocation (or Give-Up) is to be modified'
      - id: give_up_firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the Give-Up Firm Applies only for Message Type 52 (New Give-Up) or Message Type 53 (Modify Give-Up), otherwise leave blank. The guide states no data type for this field; read as alphabetic, as every other firm field of this width is'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Volume of the trade Right justified, Zero padded'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'Account type of the Executing Broker of the trade 6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer V: Floor Broker Customer W: Broker Dealer cleared as Customer X: Away Market Maker Y: Floor Broker Dealer Z: Floor Market Maker FLEX Symbology: Symbol is prefixed by one of the following: ‘1’ (American FLEX Option, Physical-Settled) ‘2’ (European FLEX Option, Physical-Settled) ‘3’ (American FLEX Option, Cash-Settled) ‘4’ (European FLEX Option, Cash-Settled)'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Position of the trade O: Open C: Close'
      - id: client_account_number
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, right blank filled Used with Client Order ID and Client Memo for Order Identification'
      - id: subtrader_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'For Allocation (40) and Allocation Cancel (41) messages, the ''Sub-trader ID'' field contains the Market Maker OCC sub-account. For Trade (30) and Trade Cancel (31) messages, the ‘Sub-trader ID’ field contains the last 2 digits of the Trader ID'
      - id: cmta_broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Contains the numeric portion of the Firm ID who will receive the trade in a CMTA'
      - id: client_memo
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, right blank filled Used with Client Account Number and Client Order ID for Order Identification'
      - id: additional_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Contains the numeric portion of the BOX Participant ID (FirmID) to which this message is to be drop-copied In the [0001,9999] range Right justified, zero padded'
      - id: additional_client_memo
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, right blank filled Free text field'
  delete_give_up:
    seq:
      - id: reference_transaction_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'For Message Type 42 – New Allocation Identifies the Unique Transaction ID of the parent Trade under which the Allocation is to be created. For Message Type 43 – Modify Allocation Identifies the Unique Transaction ID of the original Allocation which is to be modified. For Message Type 52 – New Give-Up Identifies the Unique Transaction ID of the parent Trade under which the Give-Up is to be created. For Message Type 53 – Modify Give-Up Identifies the Unique Transaction ID of the original Give- Up which is to be modified'
      - id: reference_trade_number
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the Trade received from the Message Type 30 - Trade This refers to the Trade Number under which a New Allocation (or Give-Up) is to be created or under which an existing Allocation (or Give-Up) is to be modified'

enums:
  message_flag:
    0x52:
      id: 'retransmitted_message'
      doc: 'Re-transmitted message'
    0x44:
      id: 'duplicated_message'
      doc: 'Duplicated message'
  account_type:
    0x36:
      id: 'public_customer'
      doc: 'Public Customer'
    0x37:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x38:
      id: 'market_maker'
      doc: 'Market Maker'
    0x54:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x56:
      id: 'floor_broker_customer'
      doc: 'Floor Broker Customer'
    0x57:
      id: 'broker_dealer_cleared_as_customer'
      doc: 'Broker Dealer Cleared As Customer'
    0x58:
      id: 'away_market_maker'
      doc: 'Away Market Maker'
    0x59:
      id: 'floor_broker_dealer'
      doc: 'Floor Broker Dealer'
    0x5a:
      id: 'floor_market_maker_flex_symbology_symbol_is_prefixed_by_one_of_the_following'
      doc: 'Floor Market Maker Flex Symbology Symbol Is Prefixed By One Of The Following'
  open_close:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
  transaction_type:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put_blank_if_not_an_option'
      doc: 'Put Blank If Not An Option'
  liquidity_status:
    0x4d:
      id: 'maker'
      doc: 'Maker'
    0x54:
      id: 'taker'
      doc: 'Taker'
  trade_type:
    0x4f:
      id: 'crossed_orders_a_trade_with_the_same_firm_id_on_both_sides'
      doc: 'Crossed Orders A Trade With The Same Firm Id On Both Sides'
    0x54:
      id: 'trader_crossed_orders_a_trade_with_the_same_trader_id_on_both_sides'
      doc: 'Trader Crossed Orders A Trade With The Same Trader Id On Both Sides'
    0x4d:
      id: 'tpr_trade_a_trade_done_by_a_third_party_router'
      doc: 'Tpr Trade A Trade Done By A Third Party Router'
    0x50:
      id: 'pip_a_trade_done_at_the_end_of_a_pip_auction'
      doc: 'Pip A Trade Done At The End Of A Pip Auction'
    0x46:
      id: 'firm_do_a_trade_resulting_from_a_directed_order'
      doc: 'Firm Do A Trade Resulting From A Directed Order'
    0x41:
      id: 'as_of_a_trade_entered_by_the_box_moc_to_correct_a_trade_executed_on_a_previous_day'
      doc: 'As Of A Trade Entered By The Box Moc To Correct A Trade Executed On A Previous Day'
    0x45:
      id: 'late_a_trade_entered_by_the_box_moc_to_correct_a_trade_executed_on_the_same_day'
      doc: 'Late A Trade Entered By The Box Moc To Correct A Trade Executed On The Same Day'
    0x53:
      id: 'solicitation_a_trade_done_as_part_of_a_solicitation_auction'
      doc: 'Solicitation A Trade Done As Part Of A Solicitation Auction'
    0x49:
      id: 'facilitation_a_trade_done_as_part_of_a_facilitation_auction'
      doc: 'Facilitation A Trade Done As Part Of A Facilitation Auction'
    0x52:
      id: 'floor_trade'
      doc: 'Floor Trade'
    0x43:
      id: 'customer_cross_orders_or_qualified_contingent_cross_orders'
      doc: 'Customer Cross Orders Or Qualified Contingent Cross Orders'
  opposite_account_type:
    0x36:
      id: 'public_customer'
      doc: 'Public Customer'
    0x37:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x38:
      id: 'market_maker'
      doc: 'Market Maker'
    0x54:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x56:
      id: 'floor_broker_customer'
      doc: 'Floor Broker Customer'
    0x57:
      id: 'broker_dealer_cleared_as_customer'
      doc: 'Broker Dealer Cleared As Customer'
    0x58:
      id: 'away_market_maker'
      doc: 'Away Market Maker'
    0x59:
      id: 'floor_broker_dealer'
      doc: 'Floor Broker Dealer'
    0x5a:
      id: 'floor_market_maker'
      doc: 'Floor Market Maker'

