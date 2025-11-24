CLASS /mlsft/ed_cl_document DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    "---------------- Constants (Actions) ----------------
    CONSTANTS mc_action_xml_display   TYPE /mlsft/ed_char20 VALUE 'XML_DISPLAY'.
    CONSTANTS mc_action_html_display  TYPE /mlsft/ed_char20 VALUE 'HTML_DISPLAY'.
    CONSTANTS mc_action_pdf_display   TYPE /mlsft/ed_char20 VALUE 'PDF_DISPLAY'.
    CONSTANTS mc_action_mail_send     TYPE /mlsft/ed_char20 VALUE 'SEND_MAIL'.
    CONSTANTS mc_action_send          TYPE /mlsft/ed_char20 VALUE 'SEND_DOCUMENT'.
    CONSTANTS mc_action_html_download TYPE /mlsft/ed_char20 VALUE 'HTML_DOWN'.
    CONSTANTS mc_action_stat_check    TYPE /mlsft/ed_char20 VALUE 'STAT_CHECK'.
    CONSTANTS mc_action_cloud_cancel  TYPE /mlsft/ed_char20 VALUE 'CLOUD_CANCEL'.
    CONSTANTS mc_action_resend        TYPE /mlsft/ed_char20 VALUE 'RESEND_TO_CLOUD'.
    CONSTANTS mc_action_delete_portal TYPE /mlsft/ed_char20 VALUE 'DELETE_CLOUD'.

    "---------------- Constants (XML nodes) --------------
    CONSTANTS mv_node_despatch_adv_q1    TYPE string VALUE 'q1:DespatchAdvice'.
    CONSTANTS mv_node_despatch_adv       TYPE string VALUE 'DespatchAdvice'.
    CONSTANTS mv_node_receipt_advice     TYPE string VALUE 'ReceiptAdvice'.
    CONSTANTS mv_node_delivery           TYPE string VALUE 'Delivery'.
    CONSTANTS mv_node_despatch           TYPE string VALUE 'DespatchAdvice'.
    CONSTANTS mv_node_adesp_time         TYPE string VALUE 'ActualDespatchTime'.
    CONSTANTS mv_node_adesp_date         TYPE string VALUE 'ActualDespatchDate'.
    CONSTANTS mv_node_emb                TYPE string VALUE 'EmbeddedDocumentBinaryObject'.
    CONSTANTS mv_node_gibid              TYPE string VALUE 'ID'.
    CONSTANTS mv_node_add                TYPE string VALUE 'AdditionalDocumentReference'.
    CONSTANTS mv_node_attachment         TYPE string VALUE 'Attachment'.
    CONSTANTS mv_node_actualdespatchtime TYPE string VALUE 'ActualDespatchTime'.
    CONSTANTS mv_node_actualdespatchdate TYPE string VALUE 'ActualDespatchDate'.

    "---------------- Types ----------------
    TYPES: BEGIN OF ty_raw,
             mandt  TYPE sy-mandt,
             docnum TYPE /mlsft/ed_guid,
             binary TYPE xstring,
           END OF ty_raw.

    TYPES ty_json         TYPE string.
    TYPES ty_link         TYPE /mlsft/ed_char40.
    TYPES ty_tt_link      TYPE STANDARD TABLE OF ty_link WITH EMPTY KEY.
    TYPES ty_rawall_tt    TYPE STANDARD TABLE OF xstring WITH EMPTY KEY.
    TYPES ty_raw_at_tt    TYPE STANDARD TABLE OF xstring WITH EMPTY KEY.

    "---------------- Attributes -------------------------
    DATA mv_docnum         TYPE /mlsft/ed_guid READ-ONLY.
    DATA ms_json           TYPE ty_json.
    DATA ms_head           TYPE /mlsft/ed_head.
    DATA ms_ref            TYPE /mlsft/ed_ref.
    DATA ms_data           TYPE ty_raw.
    DATA mt_receipts       TYPE ty_tt_link.
    DATA mo_reply_doc      TYPE REF TO /mlsft/ed_cl_document.
    DATA mv_bactive_param  TYPE /mlsft/ed_char1.
    DATA mt_rawall         TYPE ty_rawall_tt.
    DATA mt_raw_at         TYPE ty_raw_at_tt.

    "---------------- Factory ----------------------------
    CLASS-METHODS get_object_with_uuid
      IMPORTING iv_uuid            TYPE /mlsft/ed_uuid
      RETURNING VALUE(ro_document) TYPE REF TO /mlsft/ed_cl_document
      RAISING   /mlsft/cx_ed_exception.

    "---------------- Lifecycle --------------------------
    METHODS constructor
      IMPORTING iv_docnum TYPE /mlsft/ed_guid
      RAISING   /mlsft/cx_ed_exception.

    "---------------- Rendering --------------------------
    METHODS show_html_w_stnd_xslt_fiori
      IMPORTING iv_repid TYPE /mlsft/ed_char10 "sy-repid
      EXPORTING rv_html  TYPE string
      RAISING   /mlsft/cx_ed_exception.

    METHODS show_html_w_stnd_xslt
      IMPORTING iv_repid TYPE /mlsft/ed_char10 "sy-repid
      EXPORTING rv_html  TYPE string
      RAISING   /mlsft/cx_ed_exception.

    "---------------- Getters / Setters ------------------
    METHODS get_binary RETURNING VALUE(rv_binary) TYPE xstring.
    METHODS set_head             IMPORTING is_head TYPE /mlsft/ed_head.
    METHODS set_update_db_head   IMPORTING is_head TYPE /mlsft/ed_head.
    METHODS set_update_db_raw    IMPORTING is_raw  TYPE ty_raw.
    METHODS set_update_db_ref    IMPORTING is_ref  TYPE /mlsft/ed_ref.

    METHODS generate_gib_serial_id
      IMPORTING io_document TYPE REF TO /mlsft/ed_cl_document
      RAISING   /mlsft/cx_ed_exception.

    METHODS set_ref              IMPORTING is_ref  TYPE /mlsft/ed_ref.
    METHODS set_data             IMPORTING is_data TYPE ty_raw.

    METHODS get_head             RETURNING VALUE(rs_head) TYPE /mlsft/ed_head.
    METHODS get_ref              RETURNING VALUE(rs_ref)  TYPE /mlsft/ed_ref.
    METHODS get_json             RETURNING VALUE(rs_json) TYPE ty_json.
    METHODS get_data             RETURNING VALUE(rs_data) TYPE ty_raw.

    METHODS get_data_rawall      RETURNING VALUE(rt_data) TYPE ty_rawall_tt.
    METHODS set_data_rawall      IMPORTING it_data TYPE ty_rawall_tt.

    METHODS get_codebase64        RETURNING VALUE(rv_cosebase64) TYPE string.
    METHODS get_string_codebase64 RETURNING VALUE(rv_cosebase64) TYPE string.
    METHODS get_binary_of_inv     RETURNING VALUE(rv_inv)        TYPE xstring.
    METHODS get_decodebase64      IMPORTING iv_base64         TYPE string
                                  RETURNING VALUE(rv_decoded) TYPE xstring.

    METHODS update_xml_of_desp
      IMPORTING iv_xdelivery   TYPE xstring
      RETURNING VALUE(rv_bool) TYPE /mlsft/ed_char1.

    METHODS document_is_deletable
      RETURNING VALUE(rv_deletable) TYPE /mlsft/ed_char1.

    METHODS update_local_status
      IMPORTING iv_status       TYPE /mlsft/ed_status
                iv_delflag      TYPE /mlsft/ed_d_del     OPTIONAL
                iv_changed_by   TYPE /mlsft/ed_chg_user  OPTIONAL
                iv_changed_date TYPE /mlsft/ed_chg_date  OPTIONAL
                iv_changed_time TYPE /mlsft/ed_chg_time  OPTIONAL.

    METHODS update_gib_status
      IMPORTING iv_status TYPE any.

  PRIVATE SECTION.
ENDCLASS.



CLASS /MLSFT/ED_CL_DOCUMENT IMPLEMENTATION.


  METHOD constructor.
    mv_docnum = iv_docnum.
    CLEAR: ms_json, ms_head, ms_ref, ms_data, mt_rawall, mt_raw_at, mt_receipts.
    ms_data-docnum = iv_docnum.
  ENDMETHOD.


  METHOD get_object_with_uuid.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Method not yet implemented for UUID lookup' ).
  ENDMETHOD.


  METHOD show_html_w_stnd_xslt_fiori.
    rv_html = ''.
    IF ms_head-doctype IS INITIAL OR ms_data-binary IS INITIAL.
      RETURN.
    ENDIF.

    TRY.
        IF iv_repid IS INITIAL.
          CALL TRANSFORMATION id
            SOURCE XML ms_data-binary
            RESULT XML rv_html.
        ELSE.
          " Özel XSLT varsa onu kullan
          CALL TRANSFORMATION (iv_repid)
            SOURCE XML ms_data-binary
            RESULT XML rv_html.
        ENDIF.
      CATCH cx_root INTO DATA(lx).
        RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = lx->get_text( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD show_html_w_stnd_xslt.
    rv_html = ''.
    TRY.
        me->show_html_w_stnd_xslt_fiori(
          EXPORTING iv_repid = iv_repid
          IMPORTING rv_html  = rv_html ).
      CATCH /mlsft/cx_ed_exception INTO DATA(lxe).
        RAISE EXCEPTION lxe.
    ENDTRY.
  ENDMETHOD.


  METHOD get_binary.
    rv_binary = ms_data-binary.
  ENDMETHOD.


  METHOD set_head.
    ms_head = is_head.
  ENDMETHOD.


  METHOD set_update_db_head.
    ms_head = is_head.
  ENDMETHOD.


  METHOD set_update_db_raw.
    ms_data = is_raw.
  ENDMETHOD.


  METHOD set_update_db_ref.
    ms_ref = is_ref.
  ENDMETHOD.


METHOD generate_gib_serial_id.

  IF ms_ref-gibid IS INITIAL.

    " Sistem tarihi (YYYYMMDD)
    DATA(lv_date) = cl_abap_context_info=>get_system_date( ).
    DATA(lv_year) = lv_date(4).

    " Sistem zamanı (HHMMSS)
    DATA(lv_time) = cl_abap_context_info=>get_system_time( ).

    " Eski sy-timlo karşılığı → sadece saat, dakika, saniye
    DATA(lv_nr) = |{ lv_time }|.

    ms_ref-gibid = |MLS{ lv_year }{ lv_nr }|.

  ENDIF.

ENDMETHOD.



  METHOD set_ref.
    ms_ref = is_ref.
  ENDMETHOD.


  METHOD set_data.
    ms_data = is_data.
  ENDMETHOD.


  METHOD get_head.
    rs_head = ms_head.
  ENDMETHOD.


  METHOD get_ref.
    rs_ref = ms_ref.
  ENDMETHOD.


  METHOD get_json.
    rs_json = ms_json.
  ENDMETHOD.


  METHOD get_data.
    rs_data = ms_data.
  ENDMETHOD.


  METHOD get_data_rawall.
    rt_data = mt_rawall.
  ENDMETHOD.


  METHOD set_data_rawall.
    mt_rawall = it_data.
  ENDMETHOD.


  METHOD get_codebase64.
    " XSTRING → Base64 (Cloud-safe)
    rv_cosebase64 = cl_web_http_utility=>encode_x_base64( ms_data-binary ).
  ENDMETHOD.


  METHOD get_string_codebase64.
    " XSTRING (XML içerik) → STRING → Base64
    DATA(lv_str) = CONV string( '' ).

    " XML içeriği metne çevir (identity transformation)
    CALL TRANSFORMATION id
      SOURCE XML ms_data-binary
      RESULT XML lv_str.

    " STRING → Base64
    rv_cosebase64 = cl_web_http_utility=>encode_base64( lv_str ).
  ENDMETHOD.


  METHOD get_binary_of_inv.
    rv_inv = ms_data-binary.
  ENDMETHOD.


  METHOD get_decodebase64.
    " Base64 → XSTRING (Cloud-safe)
    rv_decoded = cl_web_http_utility=>decode_x_base64( iv_base64 ).
  ENDMETHOD.


  METHOD update_xml_of_desp.
    ms_data-binary = iv_xdelivery.
    rv_bool = 'X'.
  ENDMETHOD.


  METHOD document_is_deletable.
    rv_deletable = space.
  ENDMETHOD.


  METHOD update_local_status.
    ms_head-lstatus = iv_status.
    IF iv_changed_by   IS NOT INITIAL. ms_head-changed_by   = iv_changed_by.   ENDIF.
    IF iv_changed_date IS NOT INITIAL. ms_head-change_date  = iv_changed_date. ENDIF.
    IF iv_changed_time IS NOT INITIAL. ms_head-change_time  = iv_changed_time. ENDIF.
    IF iv_delflag      IS NOT INITIAL. ms_head-delflag      = iv_delflag.      ENDIF.
  ENDMETHOD.


  METHOD update_gib_status.
    ms_ref-gibstat = iv_status.
  ENDMETHOD.
ENDCLASS.
