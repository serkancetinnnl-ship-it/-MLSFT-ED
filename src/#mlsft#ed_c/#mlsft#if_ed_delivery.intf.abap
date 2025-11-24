INTERFACE /mlsft/if_ed_delivery
  PUBLIC .

  DATA ms_header TYPE /mlsft/ed_s_head .
  DATA ms_ref TYPE /mlsft/ed_s_eref .
  DATA ms_data TYPE /mlsft/ed_s_data .

  METHODS set_header
    IMPORTING
      VALUE(is_header) TYPE /mlsft/ed_s_head .
  METHODS get_header
    RETURNING
      VALUE(rs_header) TYPE /mlsft/ed_s_head .
  METHODS set_reference
    IMPORTING
      VALUE(is_reference) TYPE /mlsft/ed_s_eref .
  METHODS get_reference
    RETURNING
      VALUE(rs_reference) TYPE /mlsft/ed_s_eref .
  METHODS set_raw
    IMPORTING
      VALUE(is_raw) TYPE /mlsft/ed_s_data .
  METHODS get_raw
    RETURNING
      VALUE(rs_raw) TYPE /mlsft/ed_s_data .
  METHODS collect_data
    RETURNING
      VALUE(ro_mapping) TYPE REF TO /mlsft/if_ed_delivery_mapping .

  METHODS collect_global_data
    RETURNING
      VALUE(ro_mapping) TYPE REF TO /mlsft/if_ed_data_mapping. .
ENDINTERFACE.
