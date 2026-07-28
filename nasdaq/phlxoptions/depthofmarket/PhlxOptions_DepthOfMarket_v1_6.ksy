# ---------------------------------------------------------------------
# Omi Kaitai Struct Definition: Nasdaq PhlxOptions DepthOfMarket v1.6
#
# Please see end of file for rules and regulations
# ---------------------------------------------------------------------

meta:
  id: phlxoptions_depthofmarket_v1_6
  title: Nasdaq PhlxOptions DepthOfMarket Itch v1.6
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq PHLX Depth Of Market Itch v1.6'
doc-ref: http://www.phlx.com/Trader.aspx?id=DPSpecs#options_x

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Itch Mold Udp 64 Packet Header'
  - id: messages
    repeat: expr
    repeat-expr: packet_header.message_count
    type:
      switch-on: packet_header.message_count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mold Udp 64 Message Header'
      - id: payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::seconds_message': seconds_message
            'message_type::system_event_message': system_event_message
            'message_type::base_reference_message': base_reference_message
            'message_type::option_directory_message': option_directory_message
            'message_type::trading_action_message': trading_action_message
            'message_type::security_open_message': security_open_message
            'message_type::add_order_short_message': add_order_short_message
            'message_type::add_order_long_message': add_order_long_message
            'message_type::add_quote_short_message': add_quote_short_message
            'message_type::add_quote_long_message': add_quote_long_message
            'message_type::single_side_executed_message': single_side_executed_message
            'message_type::single_side_executed_with_price_message': single_side_executed_with_price_message
            'message_type::single_side_cancel_message': single_side_cancel_message
            'message_type::single_side_replace_short_message': single_side_replace_short_message
            'message_type::single_side_replace_long_message': single_side_replace_long_message
            'message_type::order_replace_short_message': order_replace_short_message
            'message_type::order_replace_long_message': order_replace_long_message
            'message_type::single_side_delete_message': single_side_delete_message
            'message_type::single_side_update_message': single_side_update_message
            'message_type::quote_replace_short_message': quote_replace_short_message
            'message_type::quote_replace_long_message': quote_replace_long_message
            'message_type::quote_delete_message': quote_delete_message
            'message_type::block_delete_message': block_delete_message
            'message_type::non_auction_options_trade_message': non_auction_options_trade_message
            'message_type::options_cross_trade_message': options_cross_trade_message
            'message_type::broken_trade_order_executed_message': broken_trade_order_executed_message
            'message_type::auction_notification_message': auction_notification_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  seconds_message:
    seq:
      - id: second
        type: u4
        doc: 'Number of seconds since midnight. Seconds since Midnight epoch'
  system_event_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'System Event Code'
  base_reference_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: base_reference_number
        type: u8
        doc: 'The base reference number'
  option_directory_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: security_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol'
      - id: expiration_year
        type: u1
        doc: 'Last two digits of the year of the option expiration'
      - id: expiration_month
        type: u1
        doc: 'Expiration Month (1-12)'
      - id: expiration_date
        type: u1
        doc: 'Day of the Month of expiration (1- 31)'
      - id: explicit_strike_price
        type: s4
        doc: 'Explicit strike price. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Option Type value'
      - id: source
        type: u1
        doc: 'Identifies the source of the Option, valid for the trading day'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the unique symbol assigned to the underlying security within exchange'
      - id: options_closing_type
        type: u1
        enum: options_closing_type
        doc: 'Denotes which System Event is used to trigger the option closing process'
      - id: tradable
        type: u1
        enum: tradable
        doc: 'Denotes whether or not this option is tradable at the exchange'
      - id: mpv
        type: u1
        enum: mpv
        doc: 'Minimum Price Variation for this option'
  trading_action_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Reflects the current trading state for the options security in the Options Market'
  security_open_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: open_state
        type: u1
        enum: open_state
        doc: 'Open State value'
  add_order_short_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_reference_number_delta
        type: u4
        doc: 'The unique reference number delta assigned to the new order. The order reference number is Increasing, but not necessarily sequential'
      - id: market_side
        type: u1
        enum: market_side
        doc: 'The type of order being added. Note: AON order is not posted on the option’s book. Hence it should not be used to calculate the best bid/ask'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: short_price
        type: s2
        doc: 'The display price of the new order being added to the book. NOTE: When converted to a decimal format, this price is in fixed point format with 3 whole number places followed by 2 decimal digits. Implied decimal with scale 1e-2'
      - id: short_volume
        type: u2
        doc: 'The total number of contracts of the new order being added to the book'
      - id: order_id
        type: u4
        doc: 'PHLX assigned order ID'
  add_order_long_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_reference_number_delta
        type: u4
        doc: 'The unique reference number delta assigned to the new order. The order reference number is Increasing, but not necessarily sequential'
      - id: market_side
        type: u1
        enum: market_side
        doc: 'The type of order being added. Note: AON order is not posted on the option’s book. Hence it should not be used to calculate the best bid/ask'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: price
        type: s4
        doc: 'NOTE: When converted to a decimal format, this price is in fixed point format with 6 whole number places followed by 4 decimal digits. The display price of the new order being added to the book. Implied decimal with scale 1e-4'
      - id: volume
        type: u4
        doc: 'The total number of contracts of the new order being added to the book'
      - id: order_id
        type: u4
        doc: 'PHLX assigned order ID'
  add_quote_short_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: bid_reference_number_delta
        type: u4
        doc: 'The bid reference number delta associated with the new quote'
      - id: ask_reference_number_delta
        type: u4
        doc: 'The ask reference number delta associated with the new quote'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: short_bid_price
        type: s2
        doc: 'NOTE: When converted to a decimal format, this price is in fixed point format with 3 whole number places followed by 2 decimal digits. The display bid price of the new quote. Implied decimal with scale 1e-2'
      - id: short_bid_size
        type: u2
        doc: 'The bid contracts of the new quote'
      - id: short_ask_price
        type: s2
        doc: 'The display ask price of the new quote. Implied decimal with scale 1e-2'
      - id: short_ask_size
        type: u2
        doc: 'The ask contracts of the new quote'
  add_quote_long_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: bid_reference_number_delta
        type: u4
        doc: 'The bid reference number delta associated with the new quote'
      - id: ask_reference_number_delta
        type: u4
        doc: 'The ask reference number delta associated with the new quote'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: bid_price
        type: s4
        doc: 'The display bid price of the new quote.  NOTE: When converted to a decimal format, this price is in fixed point format with 6 whole number places followed by 4 decimal digits. Implied decimal with scale 1e-4'
      - id: bid_size
        type: u4
        doc: 'The bid contracts of the new quote'
      - id: ask_price
        type: s4
        doc: 'NOTE: When converted to a decimal format, this price is in fixed point format with 6 whole number places followed by 4 decimal digits. The display ask price of the new quote. Implied decimal with scale 1e-4'
      - id: ask_size
        type: u4
        doc: 'The ask contracts of the new quote'
  single_side_executed_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: reference_number_delta
        type: u4
        doc: 'The order/quote reference number delta associated with the executed order'
      - id: executed_contracts
        type: u4
        doc: 'The number of contracts executed'
      - id: cross_number
        type: u4
        doc: 'Trade Group Id. Ties together all trades of a given atomic transaction in the matching engine'
      - id: match_number
        type: u4
        doc: 'Execution Id. Identifies the component of an execution. Unique for a given day.  The match number is also referenced in the Trade Break Message'
  single_side_executed_with_price_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: reference_number_delta
        type: u4
        doc: 'The order/quote reference number delta associated with the executed order'
      - id: cross_number
        type: u4
        doc: 'Trade Group Id. Ties together all trades of a given atomic transaction in the matching engine'
      - id: match_number
        type: u4
        doc: 'Execution Id. Identifies the component of an execution. Unique for a given day.  The match number is also referenced in the Trade Break Message'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the execution should be reflected on time and sale displays and volume calculations'
      - id: price
        type: s4
        doc: 'NOTE: When converted to a decimal format, this price is in fixed point format with 6 whole number places followed by 4 decimal digits. The display price of the new order being added to the book. Implied decimal with scale 1e-4'
      - id: volume
        type: u4
        doc: 'The total number of contracts of the new order being added to the book'
  single_side_cancel_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: reference_number_delta
        type: u4
        doc: 'The order/quote reference number delta associated with the executed order'
      - id: cancelled_contracts
        type: u4
        doc: 'The number of contracts to be removed from the display size of the order/quote as the result of a cancellation'
  single_side_replace_short_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: original_reference_number_delta
        type: u4
        doc: 'The original reference number delta associated with the order being replaced'
      - id: new_reference_number_delta
        type: u4
        doc: 'The new reference number delta associated with the new order'
      - id: short_price
        type: s2
        doc: 'The display price of the new order being added to the book. NOTE: When converted to a decimal format, this price is in fixed point format with 3 whole number places followed by 2 decimal digits. Implied decimal with scale 1e-2'
      - id: short_volume
        type: u2
        doc: 'The total number of contracts of the new order being added to the book'
  single_side_replace_long_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: original_reference_number_delta
        type: u4
        doc: 'The original reference number delta associated with the order being replaced'
      - id: new_reference_number_delta
        type: u4
        doc: 'The new reference number delta associated with the new order'
      - id: price
        type: s4
        doc: 'NOTE: When converted to a decimal format, this price is in fixed point format with 6 whole number places followed by 4 decimal digits. The display price of the new order being added to the book. Implied decimal with scale 1e-4'
      - id: volume
        type: u4
        doc: 'The total number of contracts of the new order being added to the book'
  order_replace_short_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: original_reference_number_delta
        type: u4
        doc: 'The original reference number delta associated with the order being replaced'
      - id: new_reference_number_delta
        type: u4
        doc: 'The new reference number delta associated with the new order'
      - id: short_price
        type: s2
        doc: 'The display price of the new order being added to the book. NOTE: When converted to a decimal format, this price is in fixed point format with 3 whole number places followed by 2 decimal digits. Implied decimal with scale 1e-2'
      - id: short_volume
        type: u2
        doc: 'The total number of contracts of the new order being added to the book'
      - id: order_id
        type: u4
        doc: 'PHLX assigned order ID'
  order_replace_long_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: original_reference_number_delta
        type: u4
        doc: 'The original reference number delta associated with the order being replaced'
      - id: new_reference_number_delta
        type: u4
        doc: 'The new reference number delta associated with the new order'
      - id: price
        type: s4
        doc: 'NOTE: When converted to a decimal format, this price is in fixed point format with 6 whole number places followed by 4 decimal digits. The display price of the new order being added to the book. Implied decimal with scale 1e-4'
      - id: volume
        type: u4
        doc: 'The total number of contracts of the new order being added to the book'
      - id: order_id
        type: u4
        doc: 'PHLX assigned order ID'
  single_side_delete_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: reference_number_delta
        type: u4
        doc: 'The order/quote reference number delta associated with the executed order'
  single_side_update_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: reference_number_delta
        type: u4
        doc: 'The order/quote reference number delta associated with the executed order'
      - id: change_reason
        type: u1
        enum: change_reason
      - id: price
        type: s4
        doc: 'NOTE: When converted to a decimal format, this price is in fixed point format with 6 whole number places followed by 4 decimal digits. The display price of the new order being added to the book. Implied decimal with scale 1e-4'
      - id: volume
        type: u4
        doc: 'The total number of contracts of the new order being added to the book'
  quote_replace_short_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: original_bid_reference_number_delta
        type: u4
        doc: 'The original bid reference number delta associated with the order being replaced'
      - id: bid_reference_number_delta
        type: u4
        doc: 'The bid reference number delta associated with the new quote'
      - id: original_ask_reference_number_delta
        type: u4
        doc: 'The original ask reference number delta associated with the order being replaced'
      - id: ask_reference_number_delta
        type: u4
        doc: 'The ask reference number delta associated with the new quote'
      - id: short_bid_price
        type: s2
        doc: 'NOTE: When converted to a decimal format, this price is in fixed point format with 3 whole number places followed by 2 decimal digits. The display bid price of the new quote. Implied decimal with scale 1e-2'
      - id: short_bid_size
        type: u2
        doc: 'The bid contracts of the new quote'
      - id: short_ask_price
        type: s2
        doc: 'The display ask price of the new quote. Implied decimal with scale 1e-2'
      - id: short_ask_size
        type: u2
        doc: 'The ask contracts of the new quote'
  quote_replace_long_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: original_bid_reference_number_delta
        type: u4
        doc: 'The original bid reference number delta associated with the order being replaced'
      - id: bid_reference_number_delta
        type: u4
        doc: 'The bid reference number delta associated with the new quote'
      - id: original_ask_reference_number_delta
        type: u4
        doc: 'The original ask reference number delta associated with the order being replaced'
      - id: ask_reference_number_delta
        type: u4
        doc: 'The ask reference number delta associated with the new quote'
      - id: bid_price
        type: s4
        doc: 'The display bid price of the new quote.  NOTE: When converted to a decimal format, this price is in fixed point format with 6 whole number places followed by 4 decimal digits. Implied decimal with scale 1e-4'
      - id: bid_size
        type: u4
        doc: 'The bid contracts of the new quote'
      - id: ask_price
        type: s4
        doc: 'NOTE: When converted to a decimal format, this price is in fixed point format with 6 whole number places followed by 4 decimal digits. The display ask price of the new quote. Implied decimal with scale 1e-4'
      - id: ask_size
        type: u4
        doc: 'The ask contracts of the new quote'
  quote_delete_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: bid_reference_number_delta
        type: u4
        doc: 'The bid reference number delta associated with the new quote'
      - id: ask_reference_number_delta
        type: u4
        doc: 'The ask reference number delta associated with the new quote'
  block_delete_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: number_of_reference_number_deltas
        type: u2
        doc: 'The number of single side deletes in this block. Max possible value = 360'
      - id: reference_number_delta
        type: u4
        doc: 'The order/quote reference number delta associated with the executed order'
  non_auction_options_trade_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_indicator
        type: u1
        enum: trade_indicator
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: cross_number
        type: u4
        doc: 'Trade Group Id. Ties together all trades of a given atomic transaction in the matching engine'
      - id: match_number
        type: u4
        doc: 'Execution Id. Identifies the component of an execution. Unique for a given day.  The match number is also referenced in the Trade Break Message'
      - id: price
        type: s4
        doc: 'NOTE: When converted to a decimal format, this price is in fixed point format with 6 whole number places followed by 4 decimal digits. The display price of the new order being added to the book. Implied decimal with scale 1e-4'
      - id: volume
        type: u4
        doc: 'The total number of contracts of the new order being added to the book'
  options_cross_trade_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: cross_number
        type: u4
        doc: 'Trade Group Id. Ties together all trades of a given atomic transaction in the matching engine'
      - id: match_number
        type: u4
        doc: 'Execution Id. Identifies the component of an execution. Unique for a given day.  The match number is also referenced in the Trade Break Message'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The PHLX® auction session for which the message is being generated'
      - id: price
        type: s4
        doc: 'NOTE: When converted to a decimal format, this price is in fixed point format with 6 whole number places followed by 4 decimal digits. The display price of the new order being added to the book. Implied decimal with scale 1e-4'
      - id: volume
        type: u4
        doc: 'The total number of contracts of the new order being added to the book'
  broken_trade_order_executed_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: cross_number
        type: u4
        doc: 'Trade Group Id. Ties together all trades of a given atomic transaction in the matching engine'
      - id: match_number
        type: u4
        doc: 'Execution Id. Identifies the component of an execution. Unique for a given day.  The match number is also referenced in the Trade Break Message'
  auction_notification_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: auction_id
        type: u4
        doc: 'Uniquely identifies the Auction for the trading day'
      - id: auction_type
        type: u1
        enum: auction_type
      - id: paired_contracts
        type: u4
        doc: 'The total number of contracts that are eligible to be matched at the Current Reference Price. Zero for Order Exposure notifications'
      - id: imbalance_direction
        type: u1
        enum: imbalance_direction
        doc: 'Indicates the market side of the imbalance'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: imbalance_price
        type: s4
        doc: 'The imbalance price. Implied decimal with scale 1e-4'
      - id: imbalance_volume
        type: u4
        doc: 'The imbalance contracts'
      - id: customer_indicator
        type: u1
        enum: customer_indicator
        doc: 'For Order Exposure only'
      - id: reserved
        size: 3
        doc: 'Reserved for future use'

enums:
  message_type:
    0x54:
      id: 'seconds_message'
      doc: 'This message is sent every second for which at least one PHLX Depth message is being generated.'
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x4c:
      id: 'base_reference_message'
      doc: 'This message indicates the base reference number to which all the order/quote/trade reference number deltas must be added to obtain the absolute order/quote PHLX reference number.'
    0x52:
      id: 'option_directory_message'
      doc: 'At the start of each trading day, the options system disseminates option symbol directory messages for all active option symbols in the PHLX ® options system.'
    0x48:
      id: 'trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the PHLX Options Market.'
    0x4f:
      id: 'security_open_message'
      doc: 'The options system plans to disseminate the Option Open Message for each option as soon as the opening is completed.  Upon receipt of the open state message, firms should be advised that the option denoted in the message is now available for auto execution within the PHLX ® Options Market System.  Upon receipt of the closed state message, firms should be advised that the option is no longer eligible for auto-execution within the Options Market System.'
    0x61:
      id: 'add_order_short_message'
      doc: 'An Add Order Message indicates that a new order has been accepted by the options system and was added to the displayable book. The message includes a day-unique Order Reference Number used by options system to track the order.'
    0x41:
      id: 'add_order_long_message'
      doc: 'An Add Order Message indicates that a new order has been accepted by the options system and was added to the displayable book. The message includes a day-unique Order Reference Number used by options system to track the order.'
    0x6a:
      id: 'add_quote_short_message'
      doc: 'An Add Quote Message indicates that a new quote has been accepted by the PHLX ® options system and was added to the displayable book. The message includes a unique Bid/Ask Reference Numbers used by the options system to track the quote.'
    0x4a:
      id: 'add_quote_long_message'
      doc: 'An Add Quote Message indicates that a new quote has been accepted by the PHLX ® options system and was added to the displayable book. The message includes a unique Bid/Ask Reference Numbers used by the options system to track the quote.'
    0x45:
      id: 'single_side_executed_message'
      doc: 'This message is sent whenever a Side order is executed in whole or in part. It is possible to receive several Single Side Executed Messages for the same Side order if that Side order is executed in several parts. The multiple Single Side Executed Messages on the same order are cumulative. By combining the executions received separately via two types of Single Side Executed Messages and Trade Messages, it is possible to build a complete view of all non-auction executions that happen on PHLX ®. Auction execution information is available in one bulk print via the Auction Trade Message.'
    0x43:
      id: 'single_side_executed_with_price_message'
      doc: 'This message is sent whenever an incoming Side order is executed against the book in whole or in part at a price different from the initial display price. Since the execution price is different than the display price of the original Add/Replace, the options system includes a price field within this execution message. It is possible to receive multiple Single Side Executed and Single Side Executed with Price messages for the same Side order if that Side order is executed in several parts. The multiple Single Side Executed messages on the same Side order are cumulative.'
    0x58:
      id: 'single_side_cancel_message'
      doc: 'This message is sent whenever an order or a side of a quote on the book is modified as a result of a partial cancellation.'
    0x75:
      id: 'single_side_replace_short_message'
      doc: 'This message is sent whenever one side of a quote on the book is replaced. The replacement has a new reference number and replaces the prior reference number.'
    0x55:
      id: 'single_side_replace_long_message'
      doc: 'This message is sent whenever one side of a quote on the book is replaced. The replacement has a new reference number and replaces the prior reference number.'
    0x76:
      id: 'order_replace_short_message'
      doc: 'This message is sent whenever an order on the book is replaced. The replacement has a new reference number and replaces the prior reference number.'
    0x56:
      id: 'order_replace_long_message'
      doc: 'This message is sent whenever an order on the book is replaced. The replacement has a new reference number and replaces the prior reference number.'
    0x44:
      id: 'single_side_delete_message'
      doc: 'The message is sent when an order or a side of a quote is being cancelled. All remaining contracts are no longer accessible so the side should be removed from the book.'
    0x47:
      id: 'single_side_update_message'
      doc: 'This message is sent whenever an order or a side of a quote is being updated for price and (or) contracts. The reference number associated with the order quote is unchanged.'
    0x6b:
      id: 'quote_replace_short_message'
      doc: 'This message is sent whenever a quote on the book is replaced. The replaced quote has new reference numbers on both sides.'
    0x4b:
      id: 'quote_replace_long_message'
      doc: 'This message is sent whenever a quote on the book is replaced. The replaced quote has new reference numbers on both sides.'
    0x59:
      id: 'quote_delete_message'
      doc: 'The message is sent when a single quote is being cancelled. All remaining contracts are no longer accessible so the quote should be removed from the book.'
    0x5a:
      id: 'block_delete_message'
      doc: 'This message contains a block of Single Side Deletes. Each reference number inside the block represents an order or a side of a quote that is being cancelled. All remaining contracts are no longer accessible so the side should be removed from the book.'
    0x50:
      id: 'non_auction_options_trade_message'
      doc: 'This Options Trade Message is designed to provide execution details for match events involving non-displayable order types and Complex orders. (Note: There is a separate message for Option auction events.)'
    0x51:
      id: 'options_cross_trade_message'
      doc: 'Options Auction Trade message is sent for every option when an auction in that option is completed. The message indicates the bulk volume associated with the auction event.'
    0x42:
      id: 'broken_trade_order_executed_message'
      doc: 'The Broken Trade Message is sent whenever an execution on PHLX ® is broken. An execution may be broken if it is found to be “clearly erroneous” pursuant to PHLX ® Clearly Erroneous Policy. A trade break is final; once a trade is broken, it cannot be reinstated.'
    0x49:
      id: 'auction_notification_message'
      doc: 'This message is also sent as notification that there is an exposed buy (sell) order available for execution at the National Best Offer (Bid).'
  event_code:
    0x4f:
      id: 'start_of_messages_this_is_always_the_first_message_sent_in_any_trading_day'
      doc: 'After 400 Am'
    0x53:
      id: 'start_of_system_hours_this_message_indicates_that_phlx_is_open_and_ready_to_start_accepting_orders'
      doc: '700 Am'
    0x51:
      id: 'start_of_opening_process_this_message_is_intended_to_indicate_that_phlx_has_started_its_opening_auction_process'
      doc: '93000 Am'
    0x4e:
      id: 'end_of_normal_hours_processing_this_message_is_intended_to_indicate_that_phlx_will_no_longer_accept_any_new_orders_or_changes_to_existing_orders_for_options_that_trade_during_normal_trading_hours'
      doc: '40000 Pm'
    0x4c:
      id: 'end_of_late_hours_processing_this_message_is_intended_to_indicate_that_phlx_will_no_longer_accept_any_new_orders_or_changes_to_existing_orders_for_options_that_trade_during_extended_hours'
      doc: '41500 Pm'
    0x45:
      id: 'end_of_system_hours_this_message_indicates_that_phlx_options_system_is_now_closed'
      doc: '515 Pm'
    0x43:
      id: 'end_of_messages_this_is_always_the_last_message_sent_in_any_trading_day'
      doc: '520 Pm'
    0x57:
      id: 'end_of_wco_early_closing_this_message_is_intended_to_indicate_that_the_exchange_will_no_longer_accept_any_new_orders_or_changes_to_existing_orders_on_last_trading_date_of_wco_options'
      doc: '1200 Noon'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call Option'
    0x50:
      id: 'put'
      doc: 'Put Option'
  options_closing_type:
    0x4e:
      id: 'normal'
      doc: 'Normal Hours'
    0x4c:
      id: 'late'
      doc: 'Late Hours'
    0x57:
      id: 'wco_early_closing'
      doc: 'Wco Early Closing At 1200 Noon'
  tradable:
    0x59:
      id: 'tradable'
      doc: 'Option Is Tradable'
    0x4e:
      id: 'not_tradable'
      doc: 'Option Is Not Tradable'
  mpv:
    0x45:
      id: 'everywhere'
      doc: 'Penny Everywhere'
    0x53:
      id: 'scaled'
      doc: 'Scaled'
    0x50:
      id: 'pilot'
      doc: 'Penny Pilot'
  current_trading_state:
    0x48:
      id: 'halt'
      doc: 'Halt In Effect'
    0x54:
      id: 'trading'
      doc: 'Trading On Phlx®'
    0x42:
      id: 'buy_side_trading_suspended_or_exhausted'
      doc: 'Buy Side Trading Suspended Exhausted Ie Buy Orders Are Not Executable And Buy Side Book Is Non Firm'
    0x53:
      id: 'sell_side_trading_suspended_or_exhausted'
      doc: 'Sell Side Trading Suspended Exhausted Ie Sell Orders Are Not Executable And Sell Side Book Is Non Firm'
  open_state:
    0x59:
      id: 'open'
      doc: 'Open For Auto Execution'
    0x4e:
      id: 'closed'
      doc: 'Closed For Auto Execution'
  market_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x58:
      id: 'buy_x58'
      doc: 'Buy Aon'
    0x59:
      id: 'sell_x59'
      doc: 'Sell Aon'
    0x4d:
      id: 'buy_x4d'
      doc: 'Buy Implied'
    0x4e:
      id: 'sell_x4e'
      doc: 'Sell Implied'
  printable:
    0x4e:
      id: 'nonprintable'
      doc: 'Nonprintable'
    0x59:
      id: 'printable'
      doc: 'Printable'
  change_reason:
    0x55:
      id: 'user'
      doc: 'User'
    0x52:
      id: 'reprice'
      doc: 'Reprice'
    0x53:
      id: 'suspend'
      doc: 'Suspend'
    0x45:
      id: 'exhausted'
      doc: 'Exhausted'
  trade_indicator:
    0x4f:
      id: 'non_displayable'
      doc: 'Non Displayable Simple Order Cross'
    0x43:
      id: 'complex'
      doc: 'Complex Order Cross'
    0x50:
      id: 'pixl'
      doc: 'Pixl Auction Cross'
  cross_type:
    0x4f:
      id: 'opening_reopening'
      doc: 'Opening Reopening Auction'
  auction_type:
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x52:
      id: 'reopening'
      doc: 'Reopening'
    0x49:
      id: 'exposure'
      doc: 'Order Exposure'
  imbalance_direction:
    0x42:
      id: 'buy'
      doc: 'Buy Imbalance'
    0x53:
      id: 'sell'
      doc: 'Sell Imbalance'
  customer_indicator:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x46:
      id: 'firm'
      doc: 'Firm'
    0x4d:
      id: 'onfloor'
      doc: 'Onfloor Market Maker'
    0x50:
      id: 'professional'
      doc: 'Professional Customer'
    0x42:
      id: 'non_phlx'
      doc: 'Broker Dealer Non Phlx'

# ---------------------------------------------------------------------
# Kaitai struct definitions are an easily edited and modified cross-platform parsing solution.
# Feel free to modify. Enjoy.
# ---------------------------------------------------------------------
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Version: 1.6
#   Date: 03/08/2018
#   Specification: phlxdepth.pdf
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
# The Binary Data Compiler technologies used to produce this file
# are the subject of patents owned by Scaled Sources LLC.  Those patent
# rights are retained and are not transferred by this contribution:
#   https://patents.google.com/patent/US20240129382A1/en
#   https://patents.google.com/patent/US20240419416A1/en
#
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
# ---------------------------------------------------------------------
