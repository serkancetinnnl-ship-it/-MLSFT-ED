INTERFACE /MLSFT/IF_ED_DATA_MAPPING PUBLIC.

  DATA ms_main TYPE REF TO data.

  METHODS get_main_structure
    EXPORTING
      VALUE(rs_main) TYPE any.

  METHODS set_main_structure
    IMPORTING
      VALUE(is_main) TYPE any OPTIONAL.

  METHODS collect_data.

ENDINTERFACE.
