# ---------------------------------------------------------------------
# Omi Kaitai Struct Definition: Nasdaq PsxEquities TotalView v5.0
#
# Please see end of file for rules and regulations
# ---------------------------------------------------------------------

meta:
  id: psxequities_totalview_v5_0
  title: Nasdaq PsxEquities TotalView Itch v5.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq PSX TotalView Itch Itch v5.0'
doc-ref: http://www.nasdaqtrader.com/content/technicalsupport/specifications/dataproducts/PSXTVITCHSpecification.pdf

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
            'message_type::system_event_message': system_event_message
            'message_type::stock_directory_message': stock_directory_message
            'message_type::stock_trading_action_message': stock_trading_action_message
            'message_type::reg_sho_short_sale_price_test_restricted_indicator_message': reg_sho_short_sale_price_test_restricted_indicator_message
            'message_type::market_participant_position_message': market_participant_position_message
            'message_type::mwcb_decline_level_message': mwcb_decline_level_message
            'message_type::mwcb_status_level_message': mwcb_status_level_message
            'message_type::luld_auction_collar_message': luld_auction_collar_message
            'message_type::operational_halt_message': operational_halt_message
            'message_type::add_order_no_mpid_attribution_message': add_order_no_mpid_attribution_message
            'message_type::add_order_with_mpid_attribution_message': add_order_with_mpid_attribution_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_executed_with_price_message': order_executed_with_price_message
            'message_type::order_cancel_message': order_cancel_message
            'message_type::order_delete_message': order_delete_message
            'message_type::order_replace_message': order_replace_message
            'message_type::trade_message_non_cross': trade_message_non_cross
            'message_type::cross_trade_message': cross_trade_message
            'message_type::broken_trade_message': broken_trade_message
            'message_type::net_order_imbalance_indicator_message': net_order_imbalance_indicator_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  system_event_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'System Event Codes'
  stock_directory_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Indicates Listing market or listing market tier for the issue'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'For NASDAQ-listed issues, this field indicates when a firm is not in compliance with NASDAQ continued listing requirements'
      - id: round_lot_size
        type: u4
        doc: 'Denotes the number of shares that represent a round lot for the issue'
      - id: round_lots_only
        type: u1
        enum: round_lots_only
        doc: 'Indicates if NASDAQ system limits order entry for issue'
      - id: issue_classification
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the security class for the issue as assigned by NASDAQ. See Appendix for allowable values'
      - id: issue_sub_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the security sub-type for the issue as assigned by NASDAQ. See Appendix for allowable values'
      - id: authenticity
        type: u1
        enum: authenticity
        doc: 'Denotes if an issue or quoting participant record is set-up in NASDAQ systems in a live/production, test, or demo state. Please note that firms should only show live issues and quoting participants on public quotation displays'
      - id: short_sale_threshold_indicator
        type: u1
        enum: short_sale_threshold_indicator
        doc: 'Indicates if a security is subject to mandatory close-out of short sales under SEC Rule 203(b)(3)'
      - id: ipo_flag
        type: u1
        enum: ipo_flag
        doc: 'Indicates if the NASDAQ security is set up for IPO release. This field is intended to help NASDAQ market participant firms comply with FINRA Rule 5131(b)'
      - id: luld_reference_price_tier
        type: u1
        enum: luld_reference_price_tier
        doc: 'Indicates which Limit Up / Limit Down price band calculation parameter is to be used for the instrument'
      - id: etp_flag
        type: u1
        enum: etp_flag
        doc: 'Indicates whether the security is an exchange traded product (ETP):'
      - id: etp_leverage_factor
        type: u4
        doc: 'Tracks the integral relationship of the ETP to the underlying
            index.
            Example: If the underlying Index increases by a value of 1 and
            the ETP’s Leverage factor is 3, indicates the ETF will
            increase/decrease (see Inverse) by 3. Leverage Factor is
            rounded to the nearest integer below, e.g. leverage factor 1
            would represent leverage factors of 1 to 1.99. This field is used
            for LULD Tier I price band calculation purposes'
      - id: inverse_indicator
        type: u1
        enum: inverse_indicator
        doc: 'Indicates the directional relationship between the ETP and underlying index. Example: An ETP Leverage Factor of 3 and an Inverse value of ‘Y’ indicates the ETP will decrease by a value of 3'
  stock_trading_action_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'Indicates the current trading state for the stock'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Action reason'
  reg_sho_short_sale_price_test_restricted_indicator_message:
    seq:
      - id: locate_code
        type: u2
        doc: 'Locate code identifying the security'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Denotes the Reg SHO Short Sale Price Test Restriction status for the issue at the time of the message dissemination'
  market_participant_position_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the market participant identifier for which the position message is being generated'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: primary_market_maker
        type: u1
        enum: primary_market_maker
        doc: 'Indicates if the market participant firm qualifies as a Primary Market Maker in accordance with NASDAQ marketplace rules'
      - id: market_maker_mode
        type: u1
        enum: market_maker_mode
        doc: 'Indicates the quoting participant’s registration status in relation to SEC Rules 101 and 104 of Regulation M'
      - id: market_participant_state
        type: u1
        enum: market_participant_state
        doc: 'Indicates the market participant’s current registration status in the issue'
  mwcb_decline_level_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: level_1
        type: u8
        doc: 'Denotes the MWCB Level 1 Value. Implied decimal with scale 1e-8'
      - id: level_2
        type: u8
        doc: 'Denotes the MWCB Level 2 Value. Implied decimal with scale 1e-8'
      - id: level_3
        type: u8
        doc: 'Denotes the MWCB Level 3 Value. Implied decimal with scale 1e-8'
  mwcb_status_level_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: breached_level
        type: u1
        enum: breached_level
        doc: 'Denotes the MWCB Level that was breached'
  luld_auction_collar_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: auction_collar_reference_price
        type: u4
        doc: 'Reference price used to set the Auction Collars. Implied decimal with scale 1e-4'
      - id: upper_auction_collar_price
        type: u4
        doc: 'Indicates the price of the Upper Auction Collar Threshold. Implied decimal with scale 1e-4'
      - id: lower_auction_collar_price
        type: u4
        doc: 'Indicates the price of the Lower Auction Collar Threshold. Implied decimal with scale 1e-4'
      - id: auction_collar_extension
        type: u4
        doc: 'Indicates the number of the extensions to the Reopening Auction'
  operational_halt_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: market_code
        type: u1
        enum: market_code
        doc: 'Market code'
      - id: operational_halt_action
        type: u1
        enum: operational_halt_action
        doc: 'Indicates the current operational halting status of the identified market'
  add_order_no_mpid_attribution_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'The type of order being added'
      - id: shares_integer_4
        type: u4
        doc: 'The total number of shares associated with the order being added to the book'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: price
        type: u4
        doc: 'The display price of the new order. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
  add_order_with_mpid_attribution_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'The type of order being added'
      - id: shares_integer_4
        type: u4
        doc: 'The total number of shares associated with the order being added to the book'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: price
        type: u4
        doc: 'The display price of the new order. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: attribution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'NASDAQ market participant identifier associated with the entered order'
  order_executed_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: executed_shares
        type: u4
        doc: 'The number of shares executed'
      - id: match_number
        type: u8
        doc: 'The Nasdaq PSX generated day unique Match Number of this execution'
  order_executed_with_price_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: executed_shares
        type: u4
        doc: 'The number of shares executed'
      - id: match_number
        type: u8
        doc: 'The Nasdaq PSX generated day unique Match Number of this execution'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the execution should be reflected on time and sale displays and volume calculations'
      - id: execution_price
        type: u4
        doc: 'The price at which the order execution occurred. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
  order_cancel_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: cancelled_shares
        type: u4
        doc: 'The number of shares being removed from the display size of the order as the result of a cancellation'
  order_delete_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
  order_replace_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: original_order_reference_number
        type: u8
        doc: 'The original reference number of the order being replaced'
      - id: new_order_reference_number
        type: u8
        doc: 'The new reference number for this order at time of replacement. Please note that the NASDAQ PSX system will use this new order reference number for all subsequent updates'
      - id: shares_integer_4
        type: u4
        doc: 'The total number of shares associated with the order being added to the book'
      - id: price
        type: u4
        doc: 'The display price of the new order. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
  trade_message_non_cross:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'The type of order being added'
      - id: shares_integer_4
        type: u4
        doc: 'The total number of shares associated with the order being added to the book'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: price
        type: u4
        doc: 'The display price of the new order. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: match_number
        type: u8
        doc: 'The Nasdaq PSX generated day unique Match Number of this execution'
  cross_trade_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: shares_integer_8
        type: u8
        doc: 'The number of shares matched in the Nasdaq PSX Cross'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: cross_price
        type: u4
        doc: 'The price at which the cross occurred. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: match_number
        type: u8
        doc: 'The Nasdaq PSX generated day unique Match Number of this execution'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The Nasdaq PSX cross session for which the message is being generated'
  broken_trade_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: match_number
        type: u8
        doc: 'The Nasdaq PSX generated day unique Match Number of this execution'
  net_order_imbalance_indicator_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: tracking_number
        type: u2
        doc: 'NASDAQ PSX internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: paired_shares
        type: u8
        doc: 'The total number of shares that are eligible to be matched at the Current Reference Price'
      - id: imbalance_shares
        type: u8
        doc: 'The number of shares not paired at the Current Reference Price'
      - id: imbalance_direction
        type: u1
        enum: imbalance_direction
        doc: 'The market side of the order imbalance'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: far_price
        type: u4
        doc: 'A hypothetical auction-clearing price for cross orders only. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: near_price
        type: u4
        doc: 'A hypothetical auction-clearing price for cross orders as well as continuous orders. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: current_reference_price
        type: u4
        doc: 'The price at which the NOII shares are being calculated. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The Nasdaq PSX cross session for which the message is being generated'
      - id: price_variation_indicator
        type: u1
        enum: price_variation_indicator
        doc: 'This field indicates the absolute value of the percentage of deviation of the Near Indicative Clearing Price to the nearest Current Reference Price'

enums:
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'Reflects the number of seconds past midnight that the Timestamp message was generated.'
    0x52:
      id: 'stock_directory_message'
      doc: 'Market data redistributors should process this message to populate the Financial Status Indicator (required display field) and the Market Category (recommended display field) for NASDAQ-listed issues.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'Nasdaq PSX uses this administrative message to indicate the current trading status of a security to the trading community.'
    0x59:
      id: 'reg_sho_short_sale_price_test_restricted_indicator_message'
      doc: 'NASDAQ PSX processes orders based on the most Reg SHO Restriction status value.'
    0x4c:
      id: 'market_participant_position_message'
      doc: 'Throughout the day, Nasdaq PSX will send out this message only if Nasdaq Operations changes the status of a market participant firm in an issue.'
    0x56:
      id: 'mwcb_decline_level_message'
      doc: 'Informs data recipients what the daily MWCB breach points are set to for the current trading day.'
    0x57:
      id: 'mwcb_status_level_message'
      doc: 'Informs data recipients when a MWCB has breached one of the established levels'
    0x4a:
      id: 'luld_auction_collar_message'
      doc: 'Indicates the auction collar thresholds within which a paused security can reopen following a LULD Trading Pause'
    0x68:
      id: 'operational_halt_message'
      doc: 'Nasdaq uses this administrative message to indicate the current trading status of the three market centers operated by Nasdaq.'
    0x41:
      id: 'add_order_no_mpid_attribution_message'
      doc: 'This message will be generated for unattributed orders accepted by the NASDAQ PSX system.'
    0x46:
      id: 'add_order_with_mpid_attribution_message'
      doc: 'This message will be generated for attributed orders and quotations accepted by the NASDAQ PSX system.'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part. It is possible to receive several Order Executed Messages for the same order reference number if that order is executed in several parts. The multiple Order Executed Messages on the same order are cumulative.'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part at a price different from the initial display price. Since the execution price is different than the display price of the original Add Order, Nasdaq PSX includes a price field within this execution message.'
    0x58:
      id: 'order_cancel_message'
      doc: 'This message is sent whenever an order on the book is modified as a result of a partial cancellation.'
    0x44:
      id: 'order_delete_message'
      doc: 'This message is sent whenever an order on the book is being cancelled.  All remaining shares are no longer accessible so the order must be removed from the book.'
    0x55:
      id: 'order_replace_message'
      doc: 'This message is sent whenever an order on the book has been cancel-replaced. All remaining shares from the original order are no longer accessible, and must be removed. The new order details are provided for the replacement, along with a new order reference number which will be used henceforth. Since the side, stock symbol and attribution (if any) cannot be changed by an Order Replace event, these fields are not included in the message. Firms should retain the side, stock symbol and MPID from the original Add Order message.'
    0x50:
      id: 'trade_message_non_cross'
      doc: 'The Trade Message is designed to provide execution details for normal match events involving non-displayable order types. (Note: There is a separate message for Nasdaq PSX cross events.)'
    0x51:
      id: 'cross_trade_message'
      doc: 'Cross Trade message indicates that Nasdaq PSX has completed its cross process for a specific security. Nasdaq PSX sends out a Cross Trade message for all active issues in the system following the Opening, Closing and EMC cross events. Firms may use the Cross Trade message to determine when the cross for each security has been completed. (Note: For the halted / paused securities, firms should use the Trading Action message to determine when an issue has been released for trading.)'
    0x42:
      id: 'broken_trade_message'
      doc: 'The Broken Trade Message is sent whenever an execution on Nasdaq PSX is broken. An execution may be broken if it is found to be “clearly erroneous” pursuant to Nasdaq’s Clearly Erroneous Policy. A trade break is final; once a trade is broken, it cannot be reinstated.'
    0x49:
      id: 'net_order_imbalance_indicator_message'
      doc: 'NASDAQ PSX disseminates NOII data at 5-second intervals in the minutes leading up to the NASDAQ Opening Cross and NASDAQ Closing Cross'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Outside Of Time Stamp Messages The Start Of Day Message Is The First Message Sent In Any Trading Day'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This Message Indicates That Nasdaq Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are Available For Execution'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are No Longer Available For Execution'
    0x45:
      id: 'end_of_system_hours'
      doc: 'It Indicates That Nasdaq Is Now Closed And Will Not Accept Any New Orders Today It Is Still Possible To Receive Broken Trade Messages And Order Delete Messages After The End Of Day'
    0x43:
      id: 'end_of_messages'
      doc: 'This Is Always The Last Message Sent In Any Trading Day'
  market_category:
    0x51:
      id: 'nasdaq_global_select_market'
      doc: 'Nasdaq Global Select Market'
    0x47:
      id: 'nasdaq_global_market'
      doc: 'Nasdaq Global Market'
    0x53:
      id: 'nasdaq_capital_market'
      doc: 'Nasdaq Capital Market'
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange'
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x50:
      id: 'nyse_arca'
      doc: 'New York Stock Exchange Arca'
    0x5a:
      id: 'bats_z'
      doc: 'Bats Z Exchange'
    0x4d:
      id: 'nyse_texas'
      doc: 'Nyse Texas'
    0x56:
      id: 'investors_exchange_llc'
      doc: 'Investors Exchange Llc'
    0x20:
      id: 'na'
      doc: 'Not Available'
  financial_status_indicator:
    0x44:
      id: 'deficient'
      doc: 'Deficient'
    0x45:
      id: 'delinquent'
      doc: 'Delinquent'
    0x51:
      id: 'bankrupt'
      doc: 'Bankrupt'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x47:
      id: 'deficient_and_bankrupt'
      doc: 'Deficient And Bankrupt'
    0x48:
      id: 'deficient_and_delinquent'
      doc: 'Deficient And Delinquent'
    0x4a:
      id: 'delinquent_and_bankrupt'
      doc: 'Delinquent And Bankrupt'
    0x4b:
      id: 'deficient_delinquent_and_bankrupt'
      doc: 'Deficient Delinquent And Bankrupt'
    0x43:
      id: 'creations_and_redemptions_suspended'
      doc: 'Creations Andor Redemptions Suspended For Exchange Traded Product'
    0x4e:
      id: 'normal'
      doc: 'Issuer Is Not Deficient Delinquent Or Bankrupt'
    0x20:
      id: 'na'
      doc: 'Not Available Firms Should Refer To Siac Feeds For Code If Needed'
  round_lots_only:
    0x59:
      id: 'yes'
      doc: 'Nasdaq System Only Accepts Round Lots'
    0x4e:
      id: 'no'
      doc: 'Nasdaq System Does Not Have Any Order Size Restrictions For This Security Odd And Mixed Lot Orders Are Allowed'
  authenticity:
    0x50:
      id: 'live_production'
      doc: 'Live Production'
    0x54:
      id: 'test'
      doc: 'Test'
  short_sale_threshold_indicator:
    0x59:
      id: 'restricted'
      doc: 'Issue Is Restricted Under Sec Rule 203 B 3'
    0x4e:
      id: 'not_restricted'
      doc: 'Issue Is Not Restricted'
    0x20:
      id: 'na'
      doc: 'Threshold Indicator Not Available'
  ipo_flag:
    0x59:
      id: 'yes'
      doc: 'Set Up For Ipo Release'
    0x4e:
      id: 'no'
      doc: 'Not Set Up For Ipo Release'
    0x20:
      id: 'na'
      doc: 'Not Available'
  luld_reference_price_tier:
    0x31:
      id: 'tier_1'
      doc: 'Tier 1 Nms Stocks And Select Et Ps'
    0x32:
      id: 'tier_2'
      doc: 'Tier 2 Nms Stocks'
    0x20:
      id: 'na'
      doc: 'Not Available'
  etp_flag:
    0x59:
      id: 'etp'
      doc: 'Instrument Is An Etp'
    0x4e:
      id: 'not_etp'
      doc: 'Instrument Is Not An Etp'
    0x20:
      id: 'na'
      doc: 'Not Available'
  inverse_indicator:
    0x59:
      id: 'inverse_etp'
      doc: 'Etp Is An Inverse Etp'
    0x4e:
      id: 'not_inverse_etp'
      doc: 'Etp Is Not An Inverse Etp'
  trading_state:
    0x48:
      id: 'halted'
      doc: 'Halted Across All Us Equity Markets Sr Os'
    0x50:
      id: 'paused'
      doc: 'Paused Across All Us Equity Markets Sr Os Nasda Qlisted Securities Only'
    0x51:
      id: 'quotation_only_period'
      doc: 'Quotation Only Period For Cross Sro Halt Or Pause'
    0x54:
      id: 'trading'
      doc: 'Trading On Nasdaq Psx'
  reg_sho_action:
    0x30:
      id: 'no_price_test'
      doc: 'No Price Test In Place'
    0x31:
      id: 'reg_sho_short_sale_price_test_restriction'
      doc: 'Reg Sho Short Sale Price Test Restriction In Effect Due To An Intraday Price Drop In Security'
    0x32:
      id: 'test_restriction_remains'
      doc: 'Reg Sho Short Sale Price Test Restriction Remains In Effect'
  primary_market_maker:
    0x59:
      id: 'primary'
      doc: 'Primary Market Maker'
    0x4e:
      id: 'non_primary'
      doc: 'Nonprimary Market Maker'
  market_maker_mode:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x50:
      id: 'passive'
      doc: 'Passive'
    0x53:
      id: 'syndicate'
      doc: 'Syndicate'
    0x52:
      id: 'pre_syndicate'
      doc: 'Presyndicate'
    0x4c:
      id: 'penalty'
      doc: 'Penalty'
  market_participant_state:
    0x41:
      id: 'active'
      doc: 'Active'
    0x45:
      id: 'excused_withdrawn'
      doc: 'Excused Withdrawn'
    0x57:
      id: 'withdrawn'
      doc: 'Withdrawn'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x44:
      id: 'deleted'
      doc: 'Deleted'
  breached_level:
    0x31:
      id: 'level_1'
      doc: 'Level 1'
    0x32:
      id: 'level_2'
      doc: 'Level 2'
    0x33:
      id: 'level_3'
      doc: 'Level 3'
  market_code:
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x42:
      id: 'nasdaq_texas'
      doc: 'Nasdaq Texas'
    0x58:
      id: 'psx'
      doc: 'Psx'
  operational_halt_action:
    0x48:
      id: 'halted'
      doc: 'Operationally Halted On The Identified Market'
    0x54:
      id: 'resumed'
      doc: 'Operational Halt Has Been Lifted And Trading Resumed'
  buy_sell_indicator:
    0x42:
      id: 'buy'
      doc: 'Buy Order'
    0x53:
      id: 'sell'
      doc: 'Sell Order'
  printable:
    0x4e:
      id: 'non_printable'
      doc: 'Nonprintable'
    0x59:
      id: 'printable'
      doc: 'Printable'
  cross_type:
    0x4f:
      id: 'opening_cross'
      doc: 'Nasdaq Psx Opening Cross'
    0x43:
      id: 'closing_cross'
      doc: 'Nasdaq Psx Closing Cross'
    0x48:
      id: 'cross_halted_or_paused'
      doc: 'Cross For Ipo And Halted Paused Securities'
    0x49:
      id: 'intraday_cross_and_post_close_cross'
      doc: 'Nasdaq Psx Cross Network Intraday Cross And Post Close Cross'
  imbalance_direction:
    0x42:
      id: 'buy'
      doc: 'Buy Imbalance'
    0x53:
      id: 'sell'
      doc: 'Sell Imbalance'
    0x4e:
      id: 'no_imbalance'
      doc: 'No Imbalance'
    0x4f:
      id: 'insufficient_orders'
      doc: 'Insufficient Orders To Calculate'
  price_variation_indicator:
    0x4c:
      id: 'less_than_1'
      doc: 'Less Than 1'
    0x31:
      id: 'value_x31'
      doc: '1 To 199'
    0x32:
      id: 'value_x32'
      doc: '2 To 299'
    0x33:
      id: 'value_x33'
      doc: '3 To 399'
    0x34:
      id: 'value_x34'
      doc: '4 To 499'
    0x35:
      id: 'value_x35'
      doc: '5 To 599'
    0x36:
      id: 'value_x36'
      doc: '6 To 699'
    0x37:
      id: 'value_x37'
      doc: '7 To 799'
    0x38:
      id: 'value_x38'
      doc: '8 To 899'
    0x39:
      id: 'value_x39'
      doc: '9 To 999'
    0x41:
      id: 'value_x41'
      doc: '10 To 1999'
    0x42:
      id: 'value_x42'
      doc: '20 To 2999'
    0x43:
      id: 'value_x43'
      doc: '30 Or Greater'
    0x20:
      id: 'no_calculation'
      doc: 'Cannot Be Calculated'

# ---------------------------------------------------------------------
# Kaitai struct definitions are an easily edited and modified cross-platform parsing solution.
# Feel free to modify. Enjoy.
# ---------------------------------------------------------------------
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Version: 5.0
#   Date: 02/13/2026
#   Specification: PSXTVITCHSpecification.pdf
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
