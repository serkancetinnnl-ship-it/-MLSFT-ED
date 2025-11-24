INTERFACE /mlsft/if_ed_invoice PUBLIC.

  "------------------------------------------------------
  " Attributes
  "------------------------------------------------------
  DATA ms_header TYPE /mlsft/ed_s_head.
  DATA ms_ref    TYPE /mlsft/ed_s_ref.
  DATA ms_data   TYPE /mlsft/ed_s_data.

  "------------------------------------------------------
  " Methods
  "------------------------------------------------------
  METHODS set_header
    IMPORTING
      is_header TYPE /mlsft/ed_s_head.

  METHODS get_header
    RETURNING
      VALUE(rs_header) TYPE /mlsft/ed_s_head.

  METHODS set_reference
    IMPORTING
      is_reference TYPE /mlsft/ed_s_ref.

  METHODS get_reference
    RETURNING
      VALUE(rs_reference) TYPE /mlsft/ed_s_ref.

  METHODS set_raw
    IMPORTING
      is_raw TYPE /mlsft/ed_s_data.

  METHODS get_raw
    RETURNING
      VALUE(rs_raw) TYPE /mlsft/ed_s_data.

  METHODS collect_data.
**    EXPORTING
**      es_mapping TYPE /mlsft/if_ed_data_mapping.

ENDINTERFACE.
