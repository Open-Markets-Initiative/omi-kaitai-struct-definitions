# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq Uqdf Output Utp v3.0.c
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Output
#   Encoding: Utp
#   Version: 3.0.c
#   Date: 02/01/2026
#   Specification: UtpBinaryOutputSpec.pdf
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: nasdaq_uqdf_output_utp_v3_0_c
  title: Nasdaq Uqdf Output Utp v3.0.c
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq UTP Quote Data Feed Output Utp v3.0.c'
doc-ref: https://www.utpplan.com/technical

seq:
  - id: udp_packet_header
    type: udp_packet_header_struct
    doc: 'Utp Mold Udp 64 Packet Header'
  - id: messages
    repeat: expr
    repeat-expr: udp_packet_header.message_count
    type:
      switch-on: udp_packet_header.message_count
      cases:
        _: message

types:
  udp_packet_header_struct:
    seq:
      - id: udp_session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: udp_sequence_number
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Utp Mold Udp 64 Message Header'
      - id: category_payload
        size: message_header.message_length - 4
        type:
          switch-on: message_header.message_category
          cases:
            '"Q"': quote_message
            '"A"': administrative_message
            '"C"': control_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: version
        type: str
        size: 1
        encoding: ASCII
        doc: 'Protocol Version. Allows each message format to be updated while still supporting previous versions during transition'
      - id: message_category
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message category'
  quote_message:
    seq:
      - id: quote_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Quote message type'
      - id: quote_message_payload
        type:
          switch-on: quote_message_type
          cases:
            '"E"': utp_quote_shortform_message
            '"F"': utp_quote_longform_message
            '"M"': finra_adf_market_participant_quotation_message
            '"C"': combined_quote_message_short_form_message
            '"D"': combined_quote_message_long_form_message
            '"A"': odd_lot_quote_message_short_form_message
            '"B"': odd_lot_quote_message_long_form_message
  utp_quote_shortform_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: symbol_short
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: bid_price_short
        type: decimal_u2_2
        doc: 'Bid Price, 2 implied decimal places. Implied decimal with scale 1e-2'
      - id: bid_size_short
        type: u2
        doc: 'Bid Size, in number of actual shares'
      - id: ask_price_short
        type: decimal_u2_2
        doc: 'Ask Price, 2 implied decimal places. Implied decimal with scale 1e-2'
      - id: ask_size_short
        type: u2
        doc: 'Ask Size, in number of actual shares'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition Code'
      - id: sip_generated_update_flag
        type: u1
        enum: sip_generated_update_flag
        doc: 'Indicates if the message is the result of a SIP-generated transaction'
      - id: luld_bbo_indicator
        type: u1
        enum: luld_bbo_indicator
        doc: 'LULD BBO Indicator'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'Retail Interest Code'
      - id: nbbo_appendage_indicator
        type: u1
        enum: nbbo_appendage_indicator
        doc: 'NBBO Appendage Indicator'
      - id: luld_national_bbo_indicator
        type: u1
        enum: luld_national_bbo_indicator
        doc: 'LULD National BBO Indicator'
      - id: national_bbo_appendage_shortform
        type: national_bbo_appendage_shortform
        doc: 'National BBO Appendage Short-form'
      - id: national_bbo_appendage_longform
        type: national_bbo_appendage_longform
        doc: 'National BBO Appendage Long-form'
  national_bbo_appendage_shortform:
    seq:
      - id: nbbo_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'NBBO Quote Condition'
      - id: national_best_bid_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'National Best Bid Market Center'
      - id: national_best_bid_price_short
        type: decimal_u2_2
        doc: 'National Best Bid Price, 2 implied decimal places. Implied decimal with scale 1e-2'
      - id: national_best_bid_size_short
        type: u2
        doc: 'National Best Bid Size'
      - id: national_best_ask_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'National Best Ask Market Center'
      - id: national_best_ask_price_short
        type: decimal_u2_2
        doc: 'National Best Ask Price, 2 implied decimal places. Implied decimal with scale 1e-2'
      - id: national_best_ask_size_short
        type: u2
        doc: 'National Best Ask Size'
  national_bbo_appendage_longform:
    seq:
      - id: nbbo_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'NBBO Quote Condition'
      - id: national_best_bid_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'National Best Bid Market Center'
      - id: national_best_bid_price_long
        type: decimal_u8_6
        doc: 'National Best Bid Price. Implied decimal with scale 1e-6'
      - id: national_best_bid_size_long
        type: u4
        doc: 'National Best Bid Size'
      - id: national_best_ask_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'National Best Ask Market Center'
      - id: national_best_ask_price_long
        type: decimal_u8_6
        doc: 'National Best Ask Price. Implied decimal with scale 1e-6'
      - id: national_best_ask_size_long
        type: u4
        doc: 'National Best Ask Size'
  utp_quote_longform_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: timestamp_2
        type: nanosecond_timestamp_nullable
        doc: 'FINRA Timestamp, nanoseconds since Epoch. Set to 0 if from an exchange. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: bid_price_long
        type: decimal_u8_6
        doc: 'Bid Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: bid_size_long
        type: u4
        doc: 'Bid Size, in number of actual shares'
      - id: ask_price_long
        type: decimal_u8_6
        doc: 'Ask Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: ask_size_long
        type: u4
        doc: 'Ask Size, in number of actual shares'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition Code'
      - id: sip_generated_update_flag
        type: u1
        enum: sip_generated_update_flag
        doc: 'Indicates if the message is the result of a SIP-generated transaction'
      - id: luld_bbo_indicator
        type: u1
        enum: luld_bbo_indicator
        doc: 'LULD BBO Indicator'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'Retail Interest Code'
      - id: nbbo_appendage_indicator
        type: u1
        enum: nbbo_appendage_indicator
        doc: 'NBBO Appendage Indicator'
      - id: luld_national_bbo_indicator
        type: u1
        enum: luld_national_bbo_indicator
        doc: 'LULD National BBO Indicator'
      - id: finra_adf_mpid_appendage_indicator
        type: u1
        enum: finra_adf_mpid_appendage_indicator
        doc: 'FINRA ADF MPID Appendage Indicator'
      - id: national_bbo_appendage_shortform
        type: national_bbo_appendage_shortform
        doc: 'National BBO Appendage Short-form'
      - id: national_bbo_appendage_longform
        type: national_bbo_appendage_longform
        doc: 'National BBO Appendage Long-form'
  finra_adf_market_participant_quotation_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: timestamp_2
        type: nanosecond_timestamp_nullable
        doc: 'FINRA Timestamp, nanoseconds since Epoch. Set to 0 if from an exchange. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: bid_price_long
        type: decimal_u8_6
        doc: 'Bid Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: bid_size_long
        type: u4
        doc: 'Bid Size, in number of actual shares'
      - id: ask_price_long
        type: decimal_u8_6
        doc: 'Ask Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: ask_size_long
        type: u4
        doc: 'Ask Size, in number of actual shares'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition Code'
      - id: finra_market_participant
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'FINRA Market Participant identifier'
  combined_quote_message_short_form_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: symbol_short
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: protected_bid_price_short
        type: decimal_u2_2
        doc: 'Protected Bid Price, 2 implied decimal places. Implied decimal with scale 1e-2'
      - id: protected_bid_size_short
        type: u2
        doc: 'Protected Bid Size'
      - id: protected_ask_price_short
        type: decimal_u2_2
        doc: 'Protected Ask Price, 2 implied decimal places. Implied decimal with scale 1e-2'
      - id: protected_ask_size_short
        type: u2
        doc: 'Protected Ask Size'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition Code'
      - id: sip_generated_update_flag
        type: u1
        enum: sip_generated_update_flag
        doc: 'Indicates if the message is the result of a SIP-generated transaction'
      - id: luld_bbo_indicator
        type: u1
        enum: luld_bbo_indicator
        doc: 'LULD BBO Indicator'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'Retail Interest Code'
      - id: nbbo_appendage_indicator
        type: u1
        enum: nbbo_appendage_indicator
        doc: 'NBBO Appendage Indicator'
      - id: luld_national_bbo_indicator
        type: u1
        enum: luld_national_bbo_indicator
        doc: 'LULD National BBO Indicator'
      - id: bolo_appendage_indicator
        type: u1
        enum: bolo_appendage_indicator
        doc: 'BOLO Appendage Indicator'
      - id: odd_lot_attachment_type
        type: u1
        enum: odd_lot_attachment_type
        doc: 'Odd Lot Attachment Type'
      - id: odd_lot_attachment_count
        type: u2
        doc: 'Number of odd lot price levels included in the attachment'
      - id: national_bbo_appendage_shortform
        type: national_bbo_appendage_shortform
        doc: 'National BBO Appendage Short-form'
      - id: national_bbo_appendage_longform
        type: national_bbo_appendage_longform
        doc: 'National BBO Appendage Long-form'
      - id: bolo_appendage_short_form
        type: bolo_appendage_short_form
        doc: 'BOLO Appendage Short Form'
      - id: bolo_appendage_long_form
        type: bolo_appendage_long_form
        doc: 'BOLO Appendage Long Form'
      - id: bolo_appendage_mpid_form
        type: bolo_appendage_mpid_form
        doc: 'BOLO Appendage MPID Form'
  bolo_appendage_short_form:
    seq:
      - id: bolo_best_bid_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'BOLO Best Bid Market Center'
      - id: bolo_bid_price_short
        type: decimal_u2_2
        doc: 'BOLO Bid Price, 2 implied decimal places. Implied decimal with scale 1e-2'
      - id: bolo_bid_size
        type: u2
        doc: 'BOLO Bid Size'
      - id: bolo_best_ask_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'BOLO Best Ask Market Center'
      - id: bolo_ask_price_short
        type: decimal_u2_2
        doc: 'BOLO Ask Price, 2 implied decimal places. Implied decimal with scale 1e-2'
      - id: bolo_ask_size
        type: u2
        doc: 'BOLO Ask Size'
  bolo_appendage_long_form:
    seq:
      - id: bolo_best_bid_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'BOLO Best Bid Market Center'
      - id: bolo_bid_price_long
        type: decimal_u8_6
        doc: 'BOLO Bid Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: bolo_bid_size
        type: u2
        doc: 'BOLO Bid Size'
      - id: bolo_best_ask_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'BOLO Best Ask Market Center'
      - id: bolo_ask_price_long
        type: decimal_u8_6
        doc: 'BOLO Ask Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: bolo_ask_size
        type: u2
        doc: 'BOLO Ask Size'
  bolo_appendage_mpid_form:
    seq:
      - id: bolo_best_bid_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'BOLO Best Bid Market Center'
      - id: bolo_bid_price_long
        type: decimal_u8_6
        doc: 'BOLO Bid Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: bolo_bid_size
        type: u2
        doc: 'BOLO Bid Size'
      - id: bolo_best_ask_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'BOLO Best Ask Market Center'
      - id: bolo_ask_price_long
        type: decimal_u8_6
        doc: 'BOLO Ask Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: bolo_ask_size
        type: u2
        doc: 'BOLO Ask Size'
      - id: bolo_best_bid_market_participant_identifier
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'BOLO Best Bid Market Participant Identifier (ADF MPID)'
      - id: bolo_best_ask_market_participant_identifier
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'BOLO Best Ask Market Participant Identifier (ADF MPID)'
  combined_quote_message_long_form_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: adf_timestamp
        type: nanosecond_timestamp
        doc: 'ADF Timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: protected_bid_price_long
        type: decimal_u8_6
        doc: 'Protected Bid Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: protected_bid_size_long
        type: u4
        doc: 'Protected Bid Size'
      - id: protected_ask_price_long
        type: decimal_u8_6
        doc: 'Protected Ask Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: protected_ask_size_long
        type: u4
        doc: 'Protected Ask Size'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition Code'
      - id: sip_generated_update_flag
        type: u1
        enum: sip_generated_update_flag
        doc: 'Indicates if the message is the result of a SIP-generated transaction'
      - id: luld_bbo_indicator
        type: u1
        enum: luld_bbo_indicator
        doc: 'LULD BBO Indicator'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'Retail Interest Code'
      - id: nbbo_appendage_indicator
        type: u1
        enum: nbbo_appendage_indicator
        doc: 'NBBO Appendage Indicator'
      - id: luld_national_bbo_indicator
        type: u1
        enum: luld_national_bbo_indicator
        doc: 'LULD National BBO Indicator'
      - id: finra_adf_mpid_appendage_indicator
        type: u1
        enum: finra_adf_mpid_appendage_indicator
        doc: 'FINRA ADF MPID Appendage Indicator'
      - id: bolo_appendage_indicator
        type: u1
        enum: bolo_appendage_indicator
        doc: 'BOLO Appendage Indicator'
      - id: odd_lot_attachment_type
        type: u1
        enum: odd_lot_attachment_type
        doc: 'Odd Lot Attachment Type'
      - id: odd_lot_attachment_count
        type: u2
        doc: 'Number of odd lot price levels included in the attachment'
      - id: national_bbo_appendage_shortform
        type: national_bbo_appendage_shortform
        doc: 'National BBO Appendage Short-form'
      - id: national_bbo_appendage_longform
        type: national_bbo_appendage_longform
        doc: 'National BBO Appendage Long-form'
      - id: finra_adf_mpid_appendage
        type: finra_adf_mpid_appendage
        doc: 'FINRA ADF MPID Appendage'
      - id: bolo_appendage_short_form
        type: bolo_appendage_short_form
        doc: 'BOLO Appendage Short Form'
      - id: bolo_appendage_long_form
        type: bolo_appendage_long_form
        doc: 'BOLO Appendage Long Form'
      - id: bolo_appendage_mpid_form
        type: bolo_appendage_mpid_form
        doc: 'BOLO Appendage MPID Form'
  finra_adf_mpid_appendage:
    seq:
      - id: bid_adf_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bid ADF Market Participant Identifier'
      - id: ask_adf_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ask ADF Market Participant Identifier'
  odd_lot_quote_message_short_form_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: symbol_short
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: sip_generated_update_flag
        type: u1
        enum: sip_generated_update_flag
        doc: 'Indicates if the message is the result of a SIP-generated transaction'
      - id: bolo_appendage_indicator
        type: u1
        enum: bolo_appendage_indicator
        doc: 'BOLO Appendage Indicator'
      - id: odd_lot_attachment_type
        type: u1
        enum: odd_lot_attachment_type
        doc: 'Odd Lot Attachment Type'
      - id: odd_lot_attachment_count
        type: u2
        doc: 'Number of odd lot price levels included in the attachment'
      - id: bolo_appendage_short_form
        type: bolo_appendage_short_form
        doc: 'BOLO Appendage Short Form'
      - id: bolo_appendage_long_form
        type: bolo_appendage_long_form
        doc: 'BOLO Appendage Long Form'
      - id: bolo_appendage_mpid_form
        type: bolo_appendage_mpid_form
        doc: 'BOLO Appendage MPID Form'
  odd_lot_quote_message_long_form_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: adf_timestamp
        type: nanosecond_timestamp
        doc: 'ADF Timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: sip_generated_update_flag
        type: u1
        enum: sip_generated_update_flag
        doc: 'Indicates if the message is the result of a SIP-generated transaction'
      - id: bolo_appendage_indicator
        type: u1
        enum: bolo_appendage_indicator
        doc: 'BOLO Appendage Indicator'
      - id: odd_lot_attachment_type
        type: u1
        enum: odd_lot_attachment_type
        doc: 'Odd Lot Attachment Type'
      - id: odd_lot_attachment_count
        type: u2
        doc: 'Number of odd lot price levels included in the attachment'
      - id: bolo_appendage_short_form
        type: bolo_appendage_short_form
        doc: 'BOLO Appendage Short Form'
      - id: bolo_appendage_long_form
        type: bolo_appendage_long_form
        doc: 'BOLO Appendage Long Form'
      - id: bolo_appendage_mpid_form
        type: bolo_appendage_mpid_form
        doc: 'BOLO Appendage MPID Form'
  administrative_message:
    seq:
      - id: administrative_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Administrative message type'
      - id: administrative_message_payload
        type:
          switch-on: administrative_message_type
          cases:
            '"A"': general_administrative_message
            '"H"': cross_sro_trading_action_message
            '"K"': market_center_trading_action_message
            '"B"': issue_symbol_directory_message
            '"V"': reg_sho_short_sale_price_test_restricted_indicator_message
            '"P"': limit_up_limit_down_price_band_message
            '"C"': market_wide_circuit_breaker_decline_level_message
            '"D"': market_wide_circuit_breaker_status_message
            '"E"': auction_collar_message
            '"R"': session_close_recap_message
  general_administrative_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: len_text
        type: u2
        doc: 'Length of the variable Text field'
      - id: text
        type: str
        size: len_text
        encoding: ASCII
        pad-right: 0x20
        doc: 'Administrative text; variable-length, sized by Text Length'
  cross_sro_trading_action_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: trading_action_code
        type: u1
        enum: trading_action_code
        doc: 'Trading Action Code'
      - id: trading_action_sequence_number
        type: u4
        doc: 'Trading Action Sequence Number (UTP SIP internal use only)'
      - id: action_time
        type: nanosecond_timestamp
        doc: 'Timestamp of when the action occurred. Nanoseconds since Unix epoch'
      - id: reason_for_the_trading_action
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Action Reason Code'
  market_center_trading_action_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: trading_action_code
        type: u1
        enum: trading_action_code
        doc: 'Trading Action Code'
      - id: action_time
        type: nanosecond_timestamp
        doc: 'Timestamp of when the action occurred. Nanoseconds since Unix epoch'
      - id: market_center_identifier
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market Center Identifier'
  issue_symbol_directory_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: old_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Old Symbol'
      - id: issue_name
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issue Name'
      - id: issue_type
        type: u1
        enum: issue_type
        doc: 'Issue Type'
      - id: issue_subtype
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issue Subtype'
      - id: market_tier
        type: u1
        enum: market_tier
        doc: 'Market Tier'
      - id: authenticity
        type: u1
        enum: authenticity
        doc: 'Authenticity'
      - id: short_sale_threshold_indicator
        type: u1
        enum: short_sale_threshold_indicator
        doc: 'Short Sale Threshold Indicator'
      - id: round_lot_size
        type: u2
        doc: 'Round Lot Size (00001 to 99999)'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Financial Status Indicator'
  reg_sho_short_sale_price_test_restricted_indicator_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Reg SHO Action Code'
  limit_up_limit_down_price_band_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: luld_price_band_indicator
        type: u1
        enum: luld_price_band_indicator
        doc: 'LULD Price Band Indicator'
      - id: luld_price_band_effective_time
        type: nanosecond_timestamp
        doc: 'LULD Price Band Effective Time. Nanoseconds since Unix epoch'
      - id: limit_down_price
        type: decimal_u8_6
        doc: 'Limit Down Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: limit_up_price
        type: decimal_u8_6
        doc: 'Limit Up Price, 6 implied decimal places. Implied decimal with scale 1e-6'
  market_wide_circuit_breaker_decline_level_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: mwcb_level_1
        type: u8
        doc: 'MWCB Level 1 (7% decline) price'
      - id: mwcb_level_2
        type: u8
        doc: 'MWCB Level 2 (13% decline) price'
      - id: mwcb_level_3
        type: u8
        doc: 'MWCB Level 3 (20% decline) price'
  market_wide_circuit_breaker_status_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: mwcb_status_level_indicator
        type: u1
        enum: mwcb_status_level_indicator
        doc: 'MWCB Status Level Indicator'
  auction_collar_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: trading_action_sequence_number
        type: u4
        doc: 'Trading Action Sequence Number (UTP SIP internal use only)'
      - id: collar_reference_price
        type: decimal_u8_6
        doc: 'Reference price used to set collar. Implied decimal with scale 1e-6'
      - id: collar_up_price
        type: decimal_u8_6
        doc: 'Collar Up Price. Implied decimal with scale 1e-6'
      - id: collar_down_price
        type: decimal_u8_6
        doc: 'Collar Down Price. Implied decimal with scale 1e-6'
      - id: collar_extension_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Collar Extension Indicator (0-255). Resets to 0 on each new pause event'
  session_close_recap_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: national_best_bid_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'National Best Bid Market Center'
      - id: national_best_bid_price_long
        type: decimal_u8_6
        doc: 'National Best Bid Price. Implied decimal with scale 1e-6'
      - id: national_best_bid_size
        type: u8
        doc: 'National Best Bid Size'
      - id: national_best_ask_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'National Best Ask Market Center'
      - id: national_best_ask_price_long
        type: decimal_u8_6
        doc: 'National Best Ask Price. Implied decimal with scale 1e-6'
      - id: national_best_ask_size
        type: u8
        doc: 'National Best Ask Size'
      - id: special_condition
        type: u1
        enum: special_condition
        doc: 'Special Condition'
      - id: num_market_center_close_recap
        type: u2
        doc: 'Number of Market Center Attachments'
      - id: market_center_close_recap
        type: market_center_close_recap
        repeat: expr
        repeat-expr: num_market_center_close_recap
        doc: 'Market Center Close Recap attachment following the Session Close Recap Message. Reflects each UTP participant''s most recent BBO quote at the market close. Repeats Number of Market Center Attachments times'
  market_center_close_recap:
    seq:
      - id: market_center_identifier
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market Center Identifier'
      - id: market_center_bid_price
        type: decimal_u8_6
        doc: 'Market Center Bid Price. Implied decimal with scale 1e-6'
      - id: market_center_bid_size
        type: u8
        doc: 'Market Center Bid Size'
      - id: market_center_ask_price
        type: decimal_u8_6
        doc: 'Market Center Ask Price. Implied decimal with scale 1e-6'
      - id: market_center_ask_size
        type: u8
        doc: 'Market Center Ask Size'
  control_message:
    seq:
      - id: control_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Control message type'
      - id: control_message_payload
        type:
          switch-on: control_message_type
          cases:
            '"I"': start_of_day_message
            '"J"': end_of_day_message
            '"O"': market_session_open_message
            '"C"': market_session_close_message
            '"Z"': end_of_transmissions_message
            '"P"': quote_wipe_out_message
  start_of_day_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
  end_of_day_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
  market_session_open_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
  market_session_close_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
  end_of_transmissions_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
  quote_wipe_out_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'UTP participant or system that originated the message'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Used for reporting trades originated by FINRA ADF or a FINRA TRF'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'Time the outbound message is produced by the SIP, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token. Intended for UTP SIP internal use only'
  nanosecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000000000 % 24
      minute:
        value: time / 60000000000 % 60
      second:
        value: time / 1000000000 % 60
      millisecond:
        value: time / 1000000 % 1000
  nanosecond_timestamp_nullable:
    seq:
      - id: value
        type: nanosecond_timestamp
    instances:
      is_null:
        value: value.time == 0
  decimal_u2_2:
    seq:
      - id: mantissa
        type: u2
    instances:
      real:
        value: mantissa / 100.0
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0

enums:
  market_center_originator:
    0x59:
      id: 'cboe_byx_exchange_inc'
      doc: 'Cboe Byx Exchange Inc'
    0x5a:
      id: 'cboe_bzx_exchange_inc'
      doc: 'Cboe Bzx Exchange Inc'
    0x4a:
      id: 'cboe_edga_exchange_inc'
      doc: 'Cboe Edga Exchange Inc'
    0x4b:
      id: 'cboe_edgx_exchange_inc'
      doc: 'Cboe Edgx Exchange Inc'
    0x57:
      id: 'cboe_exchange_inc'
      doc: 'Cboe Exchange Inc'
    0x42:
      id: 'nasdaq_texas_llc'
      doc: 'Nasdaq Texas Llc'
    0x58:
      id: 'nasdaq_phlx_llc'
      doc: 'Nasdaq Phlx Llc'
    0x51:
      id: 'nasdaq_inc'
      doc: 'Nasdaq Inc'
    0x49:
      id: 'nasdaq_ise_llc'
      doc: 'Nasdaq Ise Llc'
    0x4e:
      id: 'new_york_stock_exchange_llc'
      doc: 'New York Stock Exchange Llc'
    0x50:
      id: 'nyse_arca_inc'
      doc: 'Nyse Arca Inc'
    0x41:
      id: 'nyse_american_llc'
      doc: 'Nyse American Llc'
    0x43:
      id: 'nyse_national_inc'
      doc: 'Nyse National Inc'
    0x4d:
      id: 'nyse_texas'
      doc: 'Nyse Texas'
    0x46:
      id: 'texas_stock_exchange_llc'
      doc: 'Texas Stock Exchange Llc'
    0x47:
      id: 'n_24_x_national_exchange_llc'
      doc: 'N 24 X National Exchange Llc'
    0x44:
      id: 'financial_industry_regulatory_authority'
      doc: 'Financial Industry Regulatory Authority'
    0x56:
      id: 'investors_exchange_llc'
      doc: 'Investors Exchange Llc'
    0x4c:
      id: 'long_term_stock_exchange'
      doc: 'Long Term Stock Exchange'
    0x48:
      id: 'miax_pearl_llc'
      doc: 'Miax Pearl Llc'
    0x55:
      id: 'memx_llc'
      doc: 'Memx Llc'
    0x45:
      id: 'market_independent_generated_by_sip'
      doc: 'Market Independent Generated By Sip'
  sub_market_center_id:
    0x4e:
      id: 'finra_nyse_trf'
      doc: 'Finra Nyse Trf'
    0x51:
      id: 'finra_nasdaq_trf_carteret'
      doc: 'Finra Nasdaq Trf Carteret'
    0x42:
      id: 'finra_nasdaq_trf_chicago'
      doc: 'Finra Nasdaq Trf Chicago'
    0x20:
      id: 'trade_originates_from_finra_alternative_display_facility'
      doc: 'Trade Originates From Finra Alternative Display Facility'
  quote_condition:
    0x41:
      id: 'manual_ask_automated_bid'
      doc: 'Manual Ask Automated Bid'
    0x42:
      id: 'manual_bid_automated_ask'
      doc: 'Manual Bid Automated Ask'
    0x46:
      id: 'fast_trading'
      doc: 'Fast Trading'
    0x48:
      id: 'manual_bid_and_ask'
      doc: 'Manual Bid And Ask'
    0x49:
      id: 'order_imbalance'
      doc: 'Order Imbalance'
    0x4c:
      id: 'closed_quote'
      doc: 'Closed Quote'
    0x4e:
      id: 'nonfirm_quote'
      doc: 'Nonfirm Quote'
    0x4f:
      id: 'opening_quote_automated'
      doc: 'Opening Quote Automated'
    0x52:
      id: 'regular_twosided_open_quote_automated'
      doc: 'Regular Twosided Open Quote Automated'
    0x55:
      id: 'manual_bid_and_ask_nonfirm'
      doc: 'Manual Bid And Ask Nonfirm'
    0x58:
      id: 'order_influx'
      doc: 'Order Influx'
    0x59:
      id: 'automated_bid_no_offer_or_automated_offer_no_bid'
      doc: 'Automated Bid No Offer Or Automated Offer No Bid'
    0x5a:
      id: 'no_open_no_resume'
      doc: 'No Open No Resume'
    0x34:
      id: 'intraday_auction'
      doc: 'Intraday Auction'
  sip_generated_update_flag:
    0x20:
      id: 'transaction_originated_from_market_participant'
      doc: 'Transaction Originated From Market Participant'
    0x45:
      id: 'si_pgenerated_transaction_eg_price_band_change'
      doc: 'Si Pgenerated Transaction Eg Price Band Change'
  luld_bbo_indicator:
    0x20:
      id: 'limit_up_limit_down_not_applicable'
      doc: 'Limit Up Limit Down Not Applicable'
    0x41:
      id: 'bid_price_above_upper_limit_price_band_bid_is_non_executable'
      doc: 'Bid Price Above Upper Limit Price Band Bid Is Non Executable'
    0x42:
      id: 'ask_price_below_lower_limit_price_band_ask_is_non_executable'
      doc: 'Ask Price Below Lower Limit Price Band Ask Is Non Executable'
    0x43:
      id: 'bid_and_ask_outside_price_band_not_executable'
      doc: 'Bid And Ask Outside Price Band Not Executable'
  retail_interest_indicator:
    0x20:
      id: 'retail_interest_not_applicable'
      doc: 'Retail Interest Not Applicable'
    0x41:
      id: 'retail_interest_on_bid_quote'
      doc: 'Retail Interest On Bid Quote'
    0x42:
      id: 'retail_interest_on_ask_quote'
      doc: 'Retail Interest On Ask Quote'
    0x43:
      id: 'retail_interest_on_both_bid_and_ask_quote'
      doc: 'Retail Interest On Both Bid And Ask Quote'
  nbbo_appendage_indicator:
    0x30:
      id: 'no_national_bbo_change'
      doc: 'No National Bbo Change'
    0x31:
      id: 'no_national_bbo_can_be_calculated'
      doc: 'No National Bbo Can Be Calculated'
    0x32:
      id: 'short_form_national_bbo_appendage_attached'
      doc: 'Short Form National Bbo Appendage Attached'
    0x33:
      id: 'long_form_national_bbo_appendage_attached'
      doc: 'Long Form National Bbo Appendage Attached'
    0x34:
      id: 'quote_contains_all_national_bbo_information'
      doc: 'Quote Contains All National Bbo Information'
  luld_national_bbo_indicator:
    0x20:
      id: 'limit_up_limit_down_not_applicable'
      doc: 'Limit Up Limit Down Not Applicable'
    0x41:
      id: 'national_best_bid_and_national_best_ask_are_executable'
      doc: 'National Best Bid And National Best Ask Are Executable'
    0x42:
      id: 'national_best_bid_below_lower_limit_price_band_non_executable'
      doc: 'National Best Bid Below Lower Limit Price Band Non Executable'
    0x43:
      id: 'national_best_ask_above_upper_limit_price_band_non_executable'
      doc: 'National Best Ask Above Upper Limit Price Band Non Executable'
    0x44:
      id: 'national_best_bid_below_lower_and_national_best_ask_above_upper_limit_price_bands_non_executable'
      doc: 'National Best Bid Below Lower And National Best Ask Above Upper Limit Price Bands Non Executable'
    0x45:
      id: 'national_best_bid_equals_upper_limit_price_band_national_best_bid_is_in_limit_state'
      doc: 'National Best Bid Equals Upper Limit Price Band National Best Bid Is In Limit State'
    0x46:
      id: 'national_best_offer_equals_lower_limit_price_band_national_best_ask_is_in_limit_state'
      doc: 'National Best Offer Equals Lower Limit Price Band National Best Ask Is In Limit State'
    0x47:
      id: 'national_best_bid_equals_upper_limit_price_band_in_limit_state_and_national_best_ask_above_upper_limit_price_band_non_executable'
      doc: 'National Best Bid Equals Upper Limit Price Band In Limit State And National Best Ask Above Upper Limit Price Band Non Executable'
    0x48:
      id: 'national_best_ask_equals_lower_limit_price_band_in_limit_state_and_national_best_bid_below_lower_limit_price_band_non_executable'
      doc: 'National Best Ask Equals Lower Limit Price Band In Limit State And National Best Bid Below Lower Limit Price Band Non Executable'
    0x49:
      id: 'national_best_bid_equals_upper_limit_price_band_and_national_best_ask_equals_lower_limit_price_band_crossed_not_in_limit_state'
      doc: 'National Best Bid Equals Upper Limit Price Band And National Best Ask Equals Lower Limit Price Band Crossed Not In Limit State'
  finra_adf_mpid_appendage_indicator:
    0x20:
      id: 'not_applicable_quotation_originates_from_a_utp_participant_other_than_finra'
      doc: 'Not Applicable Quotation Originates From A Utp Participant Other Than Finra'
    0x30:
      id: 'no_adf_mpid_changes_current_adf_quote_does_not_affect_the_finra_mpid'
      doc: 'No Adf Mpid Changes Current Adf Quote Does Not Affect The Finra Mpid'
    0x31:
      id: 'no_adf_mpid_exists_no_calculation_of_the_finra_mpid'
      doc: 'No Adf Mpid Exists No Calculation Of The Finra Mpid'
    0x32:
      id: 'adf_mpi_ds_attached_finra_mpid_was_generated'
      doc: 'Adf Mpi Ds Attached Finra Mpid Was Generated'
  bolo_appendage_indicator:
    0x30:
      id: 'no_bolo_change'
      doc: 'No Bolo Change'
    0x31:
      id: 'no_bolo_can_be_calculated'
      doc: 'No Bolo Can Be Calculated'
    0x32:
      id: 'short_form_bolo_appendage_attached'
      doc: 'Short Form Bolo Appendage Attached'
    0x33:
      id: 'long_form_bolo_appendage_attached'
      doc: 'Long Form Bolo Appendage Attached'
    0x35:
      id: 'mpid_form_bolo_appendage_attached'
      doc: 'Mpid Form Bolo Appendage Attached'
  odd_lot_attachment_type:
    0x30:
      id: 'no_odd_lot_price_levels_attached'
      doc: 'No Odd Lot Price Levels Attached'
    0x32:
      id: 'short_form_odd_lot_price_levels_attached'
      doc: 'Short Form Odd Lot Price Levels Attached'
    0x33:
      id: 'long_form_odd_lot_price_levels_attached'
      doc: 'Long Form Odd Lot Price Levels Attached'
    0x35:
      id: 'mpid_form_odd_lot_price_levels_attached'
      doc: 'Mpid Form Odd Lot Price Levels Attached'
  trading_action_code:
    0x48:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x51:
      id: 'quotation_resumption_including_after_ema'
      doc: 'Quotation Resumption Including After Ema'
    0x54:
      id: 'trading_resumption'
      doc: 'Trading Resumption'
    0x50:
      id: 'volatility_trading_pause'
      doc: 'Volatility Trading Pause'
  issue_type:
    0x41:
      id: 'american_depository_receipt'
      doc: 'American Depository Receipt'
    0x42:
      id: 'bond'
      doc: 'Bond'
    0x43:
      id: 'common_stock'
      doc: 'Common Stock'
    0x46:
      id: 'depository_receipt'
      doc: 'Depository Receipt'
    0x49:
      id: 'sec_144_a'
      doc: 'Sec 144 A'
    0x4c:
      id: 'limited_partnership'
      doc: 'Limited Partnership'
    0x4e:
      id: 'note'
      doc: 'Note'
    0x4f:
      id: 'ordinary_shares'
      doc: 'Ordinary Shares'
    0x50:
      id: 'preferred_stock'
      doc: 'Preferred Stock'
    0x51:
      id: 'other_securities'
      doc: 'Other Securities'
    0x52:
      id: 'rights'
      doc: 'Rights'
    0x53:
      id: 'shares_of_beneficial_interest'
      doc: 'Shares Of Beneficial Interest'
    0x54:
      id: 'convertible_debenture'
      doc: 'Convertible Debenture'
    0x55:
      id: 'unit'
      doc: 'Unit'
    0x56:
      id: 'units_of_beneficial_interest'
      doc: 'Units Of Beneficial Interest'
    0x57:
      id: 'warrant'
      doc: 'Warrant'
  market_tier:
    0x51:
      id: 'nasdaq_global_select_market'
      doc: 'Nasdaq Global Select Market'
    0x47:
      id: 'nasdaq_global_market'
      doc: 'Nasdaq Global Market'
    0x53:
      id: 'nasdaq_capital_market'
      doc: 'Nasdaq Capital Market'
  authenticity:
    0x50:
      id: 'live_production'
      doc: 'Live Production'
    0x54:
      id: 'test'
      doc: 'Test'
    0x44:
      id: 'demo'
      doc: 'Demo'
    0x58:
      id: 'deleted'
      doc: 'Deleted'
  short_sale_threshold_indicator:
    0x59:
      id: 'issue_is_restricted_under_sec_rule_203_b_3'
      doc: 'Issue Is Restricted Under Sec Rule 203 B 3'
    0x4e:
      id: 'issue_is_not_restricted'
      doc: 'Issue Is Not Restricted'
    0x20:
      id: 'threshold_indicator_not_available'
      doc: 'Threshold Indicator Not Available'
  financial_status_indicator:
    0x43:
      id: 'creations_andor_redemptions_suspended_for_exchange_traded_product'
      doc: 'Creations Andor Redemptions Suspended For Exchange Traded Product'
    0x44:
      id: 'deficient_issuer_failed_to_meet_nasdaq_continued_listing_requirements'
      doc: 'Deficient Issuer Failed To Meet Nasdaq Continued Listing Requirements'
    0x45:
      id: 'delinquent_issuer_missed_regulatory_filing_deadline'
      doc: 'Delinquent Issuer Missed Regulatory Filing Deadline'
    0x51:
      id: 'bankrupt_issuer_has_filed_for_bankruptcy'
      doc: 'Bankrupt Issuer Has Filed For Bankruptcy'
    0x4e:
      id: 'normal_default_issuer_is_not_deficient_delinquent_or_bankrupt'
      doc: 'Normal Default Issuer Is Not Deficient Delinquent Or Bankrupt'
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
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_effect'
      doc: 'No Price Test In Effect'
    0x31:
      id: 'reg_sho_in_effect_due_to_an_intra_day_price_drop_in_security'
      doc: 'Reg Sho In Effect Due To An Intra Day Price Drop In Security'
    0x32:
      id: 'reg_sho_restriction_remains_in_effect'
      doc: 'Reg Sho Restriction Remains In Effect'
  luld_price_band_indicator:
    0x41:
      id: 'opening_update'
      doc: 'Opening Update'
    0x42:
      id: 'intra_day_update'
      doc: 'Intra Day Update'
    0x43:
      id: 'restated_value'
      doc: 'Restated Value'
    0x44:
      id: 'suspended_during_trading_halt_or_trading_pause'
      doc: 'Suspended During Trading Halt Or Trading Pause'
    0x45:
      id: 're_opening_update'
      doc: 'Re Opening Update'
    0x46:
      id: 'outside_price_band_rule_hours'
      doc: 'Outside Price Band Rule Hours'
    0x20:
      id: 'none_provided'
      doc: 'None Provided'
  mwcb_status_level_indicator:
    0x31:
      id: 'market_wide_circuit_breaker_decline_level_1_breached_7_decline'
      doc: 'Market Wide Circuit Breaker Decline Level 1 Breached 7 Decline'
    0x32:
      id: 'market_wide_circuit_breaker_decline_level_2_breached_13_decline'
      doc: 'Market Wide Circuit Breaker Decline Level 2 Breached 13 Decline'
    0x33:
      id: 'market_wide_circuit_breaker_decline_level_3_breached_20_decline'
      doc: 'Market Wide Circuit Breaker Decline Level 3 Breached 20 Decline'
  special_condition:
    0x4f:
      id: 'onesided_national_bbo_at_market_close'
      doc: 'Onesided National Bbo At Market Close'
    0x48:
      id: 'trading_halt_in_effect_at_market_close'
      doc: 'Trading Halt In Effect At Market Close'
    0x4d:
      id: 'no_eligible_market_participant_quotes_in_issue_at_market_close'
      doc: 'No Eligible Market Participant Quotes In Issue At Market Close'
    0x20:
      id: 'no_special_condition_exists'
      doc: 'No Special Condition Exists'

