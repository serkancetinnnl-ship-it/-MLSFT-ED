CLASS /mlsft/ed_parent_delivery DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES /mlsft/if_ed_delivery.

    ALIASES ms_data
      FOR /mlsft/if_ed_delivery~ms_data.
    ALIASES ms_header
      FOR /mlsft/if_ed_delivery~ms_header.
    ALIASES ms_ref
      FOR /mlsft/if_ed_delivery~ms_ref.
    ALIASES get_header
      FOR /mlsft/if_ed_delivery~get_header.
    ALIASES get_raw
      FOR /mlsft/if_ed_delivery~get_raw.
    ALIASES get_reference
      FOR /mlsft/if_ed_delivery~get_reference.
    ALIASES set_header
      FOR /mlsft/if_ed_delivery~set_header.
    ALIASES set_raw
      FOR /mlsft/if_ed_delivery~set_raw.
    ALIASES set_reference
      FOR /mlsft/if_ed_delivery~set_reference.
    ALIASES collect_data
      FOR /mlsft/if_ed_delivery~collect_data.

  PROTECTED SECTION.
    TYPES: BEGIN OF lty_likp,
             vbeln TYPE vbeln,
             vkorg TYPE /mlsft/ED_CHAR4,
             vstel TYPE /mlsft/ED_CHAR4,
             kunnr TYPE kunnr,
             lifnr TYPE kunnr,
             lfart TYPE /mlsft/ED_CHAR4,
           END OF lty_likp.
    DATA ms_likp    TYPE lty_likp." I_DeliveryDocument.
    DATA mv_vbeln   TYPE vbeln .
    DATA mv_vbtyp   TYPE string.""vbtyp_n.
    DATA mv_gjahr   TYPE gjahr.

    DATA mt_lips    TYPE /mlsft/ed_tt_lips."string."

    DATA ms_dlv_delnote TYPE string." ledlv_delnote.
    DATA mv_binary TYPE xstring.
    DATA mv_size   TYPE int4.

    DATA ms_delivery TYPE /mlsft/ed_s_main_wbill.

    DATA ms_partner  TYPE REF TO /mlsft/ed_partner.

    DATA mr_xml TYPE REF TO /mlsft/ed_create_del_xml.

    DATA ms_nast TYPE string ."nast.

    DATA mo_object TYPE REF TO /mlsft/ed_delivery.

    DATA mv_doctype TYPE /mlsft/ed_direct.

    DATA ms_mkpf TYPE string. "mkpf.
    DATA mt_mseg TYPE string."mb_mseg.

  PRIVATE SECTION.

ENDCLASS.



CLASS /MLSFT/ED_PARENT_DELIVERY IMPLEMENTATION.


  METHOD /mlsft/if_ed_delivery~collect_data.
  ENDMETHOD.


  METHOD /mlsft/if_ed_delivery~collect_global_data.
  ENDMETHOD.


  METHOD /mlsft/if_ed_delivery~get_header.
    rs_header = ms_header.
  ENDMETHOD.


  METHOD /mlsft/if_ed_delivery~get_raw.
    rs_raw = ms_data.
  ENDMETHOD.


  METHOD /mlsft/if_ed_delivery~get_reference.
    rs_reference = ms_ref.
  ENDMETHOD.


  METHOD /mlsft/if_ed_delivery~set_header.
    ms_header = is_header.
  ENDMETHOD.


  METHOD /mlsft/if_ed_delivery~set_raw.
    ms_data = is_raw.
  ENDMETHOD.


  METHOD /mlsft/if_ed_delivery~set_reference.
    ms_ref = is_reference.
  ENDMETHOD.
ENDCLASS.
