INTERFACE /mlsft/if_ed_delivery_mapping PUBLIC.


  DATA ms_main TYPE /mlsft/ed_s_main_wbill.

  METHODS get_main_structure
    RETURNING
      VALUE(rs_main) TYPE /mlsft/ed_s_main_wbill.

  METHODS set_main_structure
    IMPORTING
      VALUE(is_main) TYPE /mlsft/ed_s_main_wbill OPTIONAL.

ENDINTERFACE.
