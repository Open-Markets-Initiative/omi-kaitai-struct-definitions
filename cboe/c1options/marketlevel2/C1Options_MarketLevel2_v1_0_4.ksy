# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe C1Options MarketLevel2 Csm v1.0.4
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Market Level 2 Feed
#   Encoding: Csm
#   Version: 1.0.4
#   Date: 5/8/2018
#   Specification: cboestreamingbookdepthv1.0.pdf
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
  id: cboe_c1options_marketlevel2_csm_v1_0_4
  title: Cboe C1Options MarketLevel2 Csm v1.0.4
  license: GPL-3.0
  endian: be

doc: 'Chicago Board Options Exchange Cboe C1 Options Market Level 2 Feed Csm v1.0.4'
doc-ref: https://systems.cboe.com/Auth/CFN.aspx

seq:
  - id: packet_header
    type: packet_header_struct
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.message_count

types:
  packet_header_struct:
    seq:
      - id: version
        type: u1
        doc: 'The version associated with the contents and format of this header. Currently, this will be a constant value of 1'
      - id: packet_length
        type: u2
        doc: 'Length of the packet including this length field and the version'
      - id: sending_time
        type: u8
        doc: 'The time that this packet was sent. It applies to all messages in this packet'
      - id: message_count
        type: u1
        doc: 'The number of messages in this packet'
      - id: first_msg_seq_num
        type: u4
        doc: 'The sequence number on the first message in this packet'
  message_struct:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::security_definition_message': security_definition_message
            'template_id::snapshot_full_refresh_message': snapshot_full_refresh_message
            'template_id::incremental_refresh_message': incremental_refresh_message
            'template_id::security_status_message': security_status_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of the message in bytes'
      - id: template_id
        type: u1
        enum: template_id
        doc: 'The Template ID is for decoding the message'
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Code identifying this message type'
      - id: msg_seq_num
        type: u4
        doc: 'Message Sequence Number'
  security_definition_message:
    seq:
      - id: security_type
        type: security_type
      - id: security_exchange
        type: u1
        enum: security_exchange
      - id: symbol
        type: symbol
      - id: target_location_id
        type: target_location_id
      - id: class_key
        type: u4
        doc: 'Product Class key'
      - id: security_id
        type: u4
        doc: 'Product key'
      - id: maturity_date
        type: u8
        doc: 'Expiration date. Format is “YYYYMMDD”'
      - id: price_type
        type: u1
        doc: 'Specifies how to interpret the value in the StrikePrice field'
      - id: strike_price
        type: strike_price
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'This field is required for options'
      - id: minimum_strike_price_fraction
        type: minimum_strike_price_fraction
      - id: max_strike_price
        type: max_strike_price
      - id: premium_break_point
        type: premium_break_point
      - id: minimum_above_premium_fraction
        type: minimum_above_premium_fraction
      - id: minimum_below_premium_fraction
        type: minimum_below_premium_fraction
      - id: exercise_style
        type: u1
        enum: exercise_style
      - id: currency_code
        type: currency_code
      - id: underlying_symbol
        type: underlying_symbol
      - id: underlying_type
        type: underlying_type
      - id: contract_size
        type: u4
        doc: 'The number of contracts per unit of size'
      - id: num_security_definition_leg
        type: u1
        doc: 'Num. of Legs in a strategy product'
      - id: security_definition_leg
        type: security_definition_leg
        repeat: expr
        repeat-expr: num_security_definition_leg
        doc: 'Security Definition Leg'
  security_type:
    seq:
      - id: len_security_type_text
        type: u1
      - id: security_type_text
        type: str
        size: len_security_type_text
        encoding: ASCII
  symbol:
    seq:
      - id: len_symbol_text
        type: u1
        doc: 'Symbol of the class'
      - id: symbol_text
        type: str
        size: len_symbol_text
        encoding: ASCII
        doc: 'Symbol of the class'
  target_location_id:
    seq:
      - id: len_target_location_id_text
        type: u1
      - id: target_location_id_text
        type: str
        size: len_target_location_id_text
        encoding: ASCII
  strike_price:
    seq:
      - id: strike_price_exponent
        type: s1
        doc: 'First byte represents the exponent and the last 4 bytes represent the mantissa'
      - id: strike_price_mantissa
        type: s4
        doc: 'First byte represents the exponent and the last 4 bytes represent the mantissa'
  minimum_strike_price_fraction:
    seq:
      - id: minimum_strike_price_fraction_exponent
        type: s1
        doc: 'The minimum interval between strike prices'
      - id: minimum_strike_price_fraction_mantissa
        type: s4
        doc: 'The minimum interval between strike prices'
  max_strike_price:
    seq:
      - id: max_strike_price_exponent
        type: s1
        doc: 'The maximum allowable strike price'
      - id: max_strike_price_mantissa
        type: s4
        doc: 'The maximum allowable strike price'
  premium_break_point:
    seq:
      - id: premium_break_point_exponent
        type: s1
        doc: 'The premium price where above and below fractions take effect'
      - id: premium_break_point_mantissa
        type: s4
        doc: 'The premium price where above and below fractions take effect'
  minimum_above_premium_fraction:
    seq:
      - id: minimum_above_premium_fraction_exponent
        type: s1
        doc: 'The multiple that premium can be when above the break point'
      - id: minimum_above_premium_fraction_mantissa
        type: s4
        doc: 'The multiple that premium can be when above the break point'
  minimum_below_premium_fraction:
    seq:
      - id: minimum_below_premium_fraction_exponent
        type: s1
        doc: 'The multiple that premium can be when below the break point'
      - id: minimum_below_premium_fraction_mantissa
        type: s4
        doc: 'The multiple that premium can be when below the break point'
  currency_code:
    seq:
      - id: len_currency_code_text
        type: u1
        doc: 'Not used'
      - id: currency_code_text
        type: str
        size: len_currency_code_text
        encoding: ASCII
        doc: 'Not used'
  underlying_symbol:
    seq:
      - id: len_underlying_symbol_text
        type: u1
        doc: 'The underlying symbol'
      - id: underlying_symbol_text
        type: str
        size: len_underlying_symbol_text
        encoding: ASCII
        doc: 'The underlying symbol'
  underlying_type:
    seq:
      - id: len_underlying_type_text
        type: u1
      - id: underlying_type_text
        type: str
        size: len_underlying_type_text
        encoding: ASCII
  security_definition_leg:
    seq:
      - id: leg_ratio_qty
        type: u4
        doc: 'Leg ratio'
      - id: leg_security_id
        type: u4
        doc: 'SecurityID of the leg'
      - id: leg_side
        type: u1
        enum: leg_side
  snapshot_full_refresh_message:
    seq:
      - id: class_key
        type: u4
        doc: 'Product Class key'
      - id: security_id
        type: u4
        doc: 'Product key'
      - id: rpt_seq
        type: u4
        doc: 'Per-product seq number'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
      - id: price_type
        type: u1
        doc: 'Specifies how to interpret the value in the StrikePrice field'
      - id: refresh_indicator
        type: u1
        enum: refresh_indicator
        doc: 'Refresh Indicator'
      - id: num_snapshot_full_refresh_md_entry
        type: u1
        doc: 'Number of MDEntries in this message. The length of the sequence will not be more than 255'
      - id: snapshot_full_refresh_md_entry
        type: snapshot_full_refresh_md_entry
        repeat: expr
        repeat-expr: num_snapshot_full_refresh_md_entry
        doc: 'MDEntry indicating price, side, level, and volume of the book'
  snapshot_full_refresh_md_entry:
    seq:
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Side of book for this entry'
      - id: md_price_level
        type: u1
        doc: 'Level number of book for this MDEntry'
      - id: md_entry_px
        type: md_entry_px
      - id: num_md_volume_entry
        type: u1
        doc: 'Num. of Legs in a strategy product'
      - id: md_volume_entry
        type: md_volume_entry
        repeat: expr
        repeat-expr: num_md_volume_entry
        doc: 'Volume Entry for this price level'
  md_entry_px:
    seq:
      - id: md_entry_px_exponent
        type: s1
        doc: 'Price at this level and side of book'
      - id: md_entry_px_mantissa
        type: s4
        doc: 'Price at this level and side of book'
  md_volume_entry:
    seq:
      - id: md_volume_type
        type: u1
        enum: md_volume_type
      - id: md_entry_size
        type: u4
        doc: 'Quantity for this type of volume'
  incremental_refresh_message:
    seq:
      - id: class_key
        type: u4
        doc: 'Product Class key'
      - id: security_id
        type: u4
        doc: 'Product key'
      - id: rpt_seq
        type: u4
        doc: 'Per-product seq number'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
      - id: price_type
        type: u1
        doc: 'Specifies how to interpret the value in the StrikePrice field'
      - id: num_incremental_refresh_md_entry
        type: u1
        doc: 'Number of MDEntries in this message. The length of the sequence will not be more than 255'
      - id: incremental_refresh_md_entry
        type: incremental_refresh_md_entry
        repeat: expr
        repeat-expr: num_incremental_refresh_md_entry
        doc: 'Incremental Refresh MDEntry'
  incremental_refresh_md_entry:
    seq:
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'Indicates how book structure changed. See table: 24 – MD UpdateActions'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Side of book for this entry'
      - id: md_price_level
        type: u1
        doc: 'Level number of book for this MDEntry'
      - id: md_entry_px
        type: md_entry_px
      - id: num_md_volume_entry
        type: u1
        doc: 'Num. of Legs in a strategy product'
      - id: md_volume_entry
        type: md_volume_entry
        repeat: expr
        repeat-expr: num_md_volume_entry
        doc: 'Volume Entry for this price level'
  security_status_message:
    seq:
      - id: class_key
        type: u4
        doc: 'Product Class key'
      - id: security_id
        type: u4
        doc: 'Product key'
      - id: rpt_seq
        type: u4
        doc: 'Per-product seq number'
      - id: security_trading_status
        type: u1
        enum: security_trading_status

enums:
  template_id:
    13:
      id: 'security_definition_message'
      doc: 'Security definitions describe an exchange’s products by name and trading parameters and associates those products with a product security ID.'
    17:
      id: 'snapshot_full_refresh_message'
      doc: 'Snapshot messages contain the current SecurityTradingStatus for a product and the complete state of the top N levels of the book'
    18:
      id: 'incremental_refresh_message'
      doc: 'IncRefresh messages contain the current SecurityTradingStatus for a product and one or more instructions that indicate how the book structure has incrementally changed since the last book update.'
    19:
      id: 'security_status_message'
      doc: 'Security Status messages contain the SecurityTradingStatus for a product'
    16:
      id: 'heartbeat_message'
      doc: 'This message contains only a standard header. The heartbeat will repeat at a regular interval'
  security_exchange:
    0x43:
      id: 'cboe'
      doc: 'Cboe'
    0x4f:
      id: 'one_chicago_not_supported'
      doc: 'One Chicago Not Supported'
    0x57:
      id: 'cbsx_not_supported'
      doc: 'Cbsx Not Supported'
    0x46:
      id: 'cfecof_not_supported'
      doc: 'Cfecof Not Supported'
    0x32:
      id: 'cboe_2_options_not_supported'
      doc: 'Cboe 2 Options Not Supported'
  put_or_call:
    0:
      id: 'put'
      doc: 'Put'
    1:
      id: 'call'
      doc: 'Call'
  exercise_style:
    0:
      id: 'american'
      doc: 'American'
    1:
      id: 'european'
      doc: 'European'
  leg_side:
    0x42:
      id: 'buy_bid'
      doc: 'Buy Bid'
    0x53:
      id: 'sell_ask'
      doc: 'Sell Ask'
  security_trading_status:
    2:
      id: 'halted'
      doc: 'Market Halted'
    17:
      id: 'open'
      doc: 'Market Open'
    18:
      id: 'closed'
      doc: 'Market Closed'
    21:
      id: 'pre_open'
      doc: 'Pre Open'
    22:
      id: 'opening_rotation'
      doc: 'Market In Opening Rotation'
    23:
      id: 'fast_market'
      doc: 'Fast Market'
    24:
      id: 'strategy_market_in_opening_rotation'
      doc: 'Strategy Market In Opening Rotation'
    25:
      id: 'strategy_market_quotes_non_firm'
      doc: 'Strategy Market Quotes Non Firm'
    26:
      id: 'suspended'
      doc: 'Market Suspended Quotes Are Not Firm'
  refresh_indicator:
    0x59:
      id: 'mandatory_refresh'
      doc: 'Mandatory Refresh By All Recipients Snapshot Must Be Processed'
    0x4e:
      id: 'process_if_necessary'
      doc: 'Process If Necessary'
  md_entry_type:
    0x30:
      id: 'buy_bid'
      doc: 'Buy Bid'
    0x31:
      id: 'sell_ask'
      doc: 'Sell Ask'
  md_volume_type:
    0:
      id: 'total_limit'
      doc: 'Total Limit'
    1:
      id: 'customer_limit'
      doc: 'Customer Limit'
    2:
      id: 'total_contingency_all_or_none'
      doc: 'Total Contingency All Or None'
    3:
      id: 'customer_contingency_all_or_none'
      doc: 'Customer Contingency All Or None'
  md_update_action:
    0:
      id: 'insert'
      doc: 'Insert New Level'
    1:
      id: 'change'
      doc: 'Change Volume Change Of Existing Price'
    2:
      id: 'delete_field'
      doc: 'Delete'
    5:
      id: 'overlay'
      doc: 'Overlay Price And Volume Change Of Existing Level'

