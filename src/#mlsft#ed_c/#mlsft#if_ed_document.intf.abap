INTERFACE /mlsft/if_ed_document
  public .


  data ms_header type /mlsft/ed_s_head .
  data ms_ref type /mlsft/ed_s_eref .
  data ms_data type /mlsft/ed_s_data .

  methods set_header
    importing
      value(is_header) type /mlsft/ed_s_head .
  methods get_header
    returning
      value(rs_header) type /mlsft/ed_s_head .
  methods set_reference
    importing
      value(is_reference) type /mlsft/ed_s_eref .
  methods get_reference
    returning
      value(rs_reference) type /mlsft/ed_s_eref .
  methods set_raw
    importing
      value(is_raw) type /mlsft/ed_s_data .
  methods get_raw
    returning
      value(rs_raw) type /mlsft/ed_s_data .
  methods collect_data
    returning
      value(ro_mapping) type ref to /mlsft/if_ed_data_mapping. .

  methods collect_global_data
    returning
      value(ro_mapping) type ref to /mlsft/if_ed_data_mapping. .

ENDINTERFACE.
