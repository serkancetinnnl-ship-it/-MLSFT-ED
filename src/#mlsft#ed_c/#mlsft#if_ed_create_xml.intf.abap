INTERFACE /mlsft/if_ed_create_xml PUBLIC.

  DATA ms_aditional_fields TYPE /mlsft/ed_sc_aditional_fields.

  METHODS build_xml_binary
    RETURNING
      VALUE(rt_xml_doc) TYPE REF TO /MLSFT/ED_CL_DOCUMENT.

  METHODS get_binary
    RETURNING
      VALUE(rv_binary) TYPE xstring.

  METHODS get_size
    RETURNING
      VALUE(rv_size) TYPE int4.

  METHODS add_message_to_log
    IMPORTING
      iv_priority TYPE /MLSFT/ED_CHAR1."balprobcl.

  METHODS which_step.

  METHODS put_xml_in_file.

  METHODS get_pdf_binary
    RETURNING
      VALUE(rv_binary) TYPE xstring.

  METHODS get_pdf_size
    RETURNING
      VALUE(rv_size) TYPE int4.

  METHODS get_aditional_fields
    RETURNING
      VALUE(rs_aditional_fields) TYPE /mlsft/ed_sc_aditional_fields.

ENDINTERFACE.
