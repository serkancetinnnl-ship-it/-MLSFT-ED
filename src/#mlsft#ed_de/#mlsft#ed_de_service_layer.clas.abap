"=====================================================================
"  Public Cloud Compliant Service Layer (Germany)
"  Namespace     : /mlsft/
"  Original      : /mlsag/ed_deu_service_layer
"=====================================================================
CLASS /mlsft/ed_de_service_layer DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    "-----------------------------
    " Tipler
    "-----------------------------
    TYPES: BEGIN OF ty_response,
             status_code TYPE i,
             body        TYPE string,
           END OF ty_response.

    TYPES: BEGIN OF ty_key_value,
             key   TYPE string,
             value TYPE string,
           END OF ty_key_value.

    TYPES ty_t_key_value TYPE STANDARD TABLE OF ty_key_value WITH DEFAULT KEY.

    " Sonuç (documents) için tipler
    TYPES: BEGIN OF ty_doc,
             file_type TYPE string,
             data      TYPE string,
           END OF ty_doc.

    TYPES ty_t_doc TYPE STANDARD TABLE OF ty_doc WITH DEFAULT KEY.

    TYPES: BEGIN OF ty_doc_res,
             documents TYPE ty_t_doc,
           END OF ty_doc_res.

    "-----------------------------
    " Sabitler
    "-----------------------------
    CONSTANTS: c_ct_dest_auth TYPE string VALUE 'ED_DE_AUTH',
               c_ct_dest_gaas TYPE string VALUE 'ED_DE_GAAS'.

    "-----------------------------
    " Yapılandırma (Cloud)
    "-----------------------------
    DATA mv_apikey      TYPE string.
    DATA ms_connection  TYPE /mlsft/sei_t_api.
    DATA ms_url         TYPE /mlsft/sei_param.
    DATA ms_login       TYPE /mlsft/sei_login.
    DATA ms_ref         TYPE /mlsft/ed_ref.
    DATA ms_head        TYPE /mlsft/ed_head.
    DATA ms_raw         TYPE /mlsft/ed_raw.
    DATA gs_response    TYPE string.
    DATA mv_bukrs       TYPE bukrs.
    DATA mo_document    TYPE REF TO /mlsft/ed_cl_document.

    "-----------------------------
    " Kurucu
    "-----------------------------
    METHODS constructor
      IMPORTING
        iv_step     TYPE /mlsft/sei_api_step
        iv_connp    TYPE /mlsft/ed_char4
        io_document TYPE REF TO /mlsft/ed_cl_document OPTIONAL
        iv_doctype  TYPE /mlsft/ed_direct OPTIONAL
        iv_token    TYPE string OPTIONAL.

    "==============================================================
    "  İŞLEVSEL METOTLAR
    "==============================================================
    METHODS step_get_unit_measures.

    METHODS step_get_sales_invoice_xml
      IMPORTING invoiceid  TYPE string
      RETURNING VALUE(out) TYPE string.

    METHODS step_get_sales_invoice_chg
      EXPORTING out TYPE string.

    METHODS step_get_purchase_invoice_chg
      IMPORTING iv_date TYPE xsddatetime_iso
      EXPORTING out     TYPE string.

    METHODS step_sales_invoice_check
      EXPORTING out TYPE /mlsft/ed_ger_s_status_req.

    METHODS step_get_sales_invoice_cancel
      IMPORTING in_body TYPE string
      EXPORTING out     TYPE string.

    METHODS step_get_purchase_invoice_xml
      IMPORTING invoiceid  TYPE string
      RETURNING VALUE(out) TYPE string.

    METHODS create_in_invoice
      IMPORTING is_data   TYPE string
      EXPORTING es_result TYPE /mlsft/ed_ger_message_sc.

    METHODS step_purchase_invoice_check
      EXPORTING out TYPE string.

    METHODS get_response
      RETURNING VALUE(iv_response) TYPE string.

    METHODS send_pdf_to_vim
      EXPORTING out TYPE string.

    METHODS step_get_allcompanies
      IMPORTING in_body TYPE string
      EXPORTING out     TYPE string.

    METHODS auto_approval
      EXPORTING ev_success TYPE abap_bool.

    METHODS send_mailbox
      EXPORTING ev_success TYPE abap_bool.

    METHODS create_vatrecord_json
      IMPORTING is_ref TYPE /mlsft/ed_ref
      EXPORTING es_xml TYPE /mlsft/ed_sei_vatrecord_json.

    METHODS step_vatrecord_individual
      IMPORTING is_ref TYPE /mlsft/ed_ref
      EXPORTING out    TYPE string.

    METHODS step_vatrecord_individual_canc
      IMPORTING is_ref TYPE /mlsft/ed_ref
      EXPORTING out    TYPE string.

    METHODS step_get_storno_cancel
      IMPORTING in_body TYPE string
      EXPORTING out     TYPE string.

    METHODS step_validare
      RETURNING VALUE(out) TYPE string.

    METHODS get_r_auth_token
      IMPORTING iv_step  TYPE /mlsft/sei_api_step OPTIONAL
                iv_connp TYPE /mlsft/ed_char4 OPTIONAL
      EXPORTING out      TYPE string.

    METHODS get_token
      IMPORTING iv_step  TYPE /mlsft/sei_api_step
                iv_connp TYPE /mlsft/ed_char4
      EXPORTING out      TYPE string.

    METHODS step_get_listamesajepaginatie
      IMPORTING iv_start_t TYPE xsddatetime_iso
                iv_end_t   TYPE xsddatetime_iso
                iv_page    TYPE i
      EXPORTING out        TYPE ty_t_doc.

    METHODS get_document
      IMPORTING iv_documentid    TYPE string OPTIONAL
                iv_documenttypes TYPE string OPTIONAL
      EXPORTING out              TYPE ty_doc_res.

    METHODS append_query_field
      IMPORTING iv_query        TYPE string
                iv_key          TYPE string
                iv_value        TYPE string
      RETURNING VALUE(rv_query) TYPE string.

    METHODS step_show_pdf
      IMPORTING
        iv_type       TYPE string
        is_head       TYPE /mlsft/ed_head
      RETURNING
        VALUE(rv_pdf) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS http_get
      IMPORTING i_ct_name     TYPE string
                i_path        TYPE string
                i_query       TYPE string OPTIONAL
                i_headers     TYPE ty_t_key_value OPTIONAL
      RETURNING VALUE(r_resp) TYPE ty_response.

    METHODS http_post
      IMPORTING i_ct_name     TYPE string
                i_path        TYPE string
                i_body        TYPE string
                i_headers     TYPE ty_t_key_value OPTIONAL
      RETURNING VALUE(r_resp) TYPE ty_response.

    METHODS build_auth_headers
      IMPORTING i_bearer         TYPE string OPTIONAL
      RETURNING VALUE(r_headers) TYPE ty_t_key_value.

ENDCLASS.



CLASS /mlsft/ed_de_service_layer IMPLEMENTATION.

  METHOD constructor.
    mv_bukrs    = iv_connp.
    mo_document = io_document.

    SELECT SINGLE *
      FROM /mlsft/sei_t_api
      WHERE step  = @iv_step
        AND connp = @iv_connp
      INTO CORRESPONDING FIELDS OF @ms_connection.

    IF iv_token IS NOT INITIAL.
      mv_apikey = iv_token.
    ELSEIF ms_connection-api_key IS NOT INITIAL.
      mv_apikey = ms_connection-api_key.
    ELSE.
      get_r_auth_token( EXPORTING iv_step = iv_step iv_connp = iv_connp ).
    ENDIF.
  ENDMETHOD.

  METHOD step_get_sales_invoice_xml.
    DATA(lv_path)    = |/sales-invoices/{ invoiceid }|.
    DATA(lt_headers) = build_auth_headers( i_bearer = mv_apikey ).
    DATA(ls_resp)    = http_get(
                         i_ct_name = c_ct_dest_gaas
                         i_path    = lv_path
                         i_headers = lt_headers ).

    IF ls_resp-status_code BETWEEN 200 AND 299.
      out = ls_resp-body.
    ENDIF.
  ENDMETHOD.

  METHOD step_get_sales_invoice_chg.
    CLEAR out.
  ENDMETHOD.

  METHOD step_get_purchase_invoice_chg.
    CLEAR out.
  ENDMETHOD.

  METHOD step_sales_invoice_check.
    CLEAR out.
  ENDMETHOD.

  METHOD step_get_sales_invoice_cancel.
    CLEAR out.
  ENDMETHOD.

  METHOD step_get_purchase_invoice_xml.
    DATA(lv_path)    = |/purchase-invoices/{ invoiceid }|.
    DATA(lt_headers) = build_auth_headers( i_bearer = mv_apikey ).
    DATA(ls_resp)    = http_get(
                         i_ct_name = c_ct_dest_gaas
                         i_path    = lv_path
                         i_headers = lt_headers ).

    IF ls_resp-status_code BETWEEN 200 AND 299.
      out = ls_resp-body.
    ENDIF.
  ENDMETHOD.

  METHOD create_in_invoice.
    CLEAR es_result.
  ENDMETHOD.

  METHOD step_purchase_invoice_check.
    CLEAR out.
  ENDMETHOD.

  METHOD get_response.
    iv_response = gs_response.
  ENDMETHOD.

  METHOD send_pdf_to_vim.
    CLEAR out.
  ENDMETHOD.

  METHOD step_get_allcompanies.
    CLEAR out.
  ENDMETHOD.

  METHOD auto_approval.
    ev_success = abap_false.
  ENDMETHOD.

  METHOD send_mailbox.
    ev_success = abap_false.
  ENDMETHOD.

  METHOD create_vatrecord_json.
    CLEAR es_xml.
  ENDMETHOD.

  METHOD step_vatrecord_individual.
    CLEAR out.
  ENDMETHOD.

  METHOD step_vatrecord_individual_canc.
    CLEAR out.
  ENDMETHOD.

  METHOD step_get_storno_cancel.
    CLEAR out.
  ENDMETHOD.

  METHOD step_validare.
    out = ||.
  ENDMETHOD.

  METHOD get_r_auth_token.
    DATA(ls_headers) = build_auth_headers( ).
    DATA(ls_resp)    = http_post(
                         i_ct_name = c_ct_dest_auth
                         i_path    = '/oauth/token'
                         i_body    = '{"grant_type":"client_credentials"}'
                         i_headers = ls_headers ).
    CLEAR out.
  ENDMETHOD.

  METHOD get_token.
    get_r_auth_token(
      EXPORTING iv_step = iv_step
                iv_connp = iv_connp
      IMPORTING out     = out ).
  ENDMETHOD.

  METHOD step_get_listamesajepaginatie.
    CLEAR out.
  ENDMETHOD.

  METHOD get_document.
    DATA lv_path  TYPE string VALUE '/documents'.
    DATA lv_query TYPE string.

    lv_query = append_query_field(
                 iv_query = lv_query
                 iv_key   = 'documentId'
                 iv_value = iv_documentid ).

    lv_query = append_query_field(
                 iv_query = lv_query
                 iv_key   = 'documentTypes'
                 iv_value = iv_documenttypes ).

    DATA lt_headers TYPE ty_t_key_value.
    lt_headers = build_auth_headers( i_bearer = mv_apikey ).

    DATA ls_resp TYPE ty_response.
    ls_resp = http_get(
                i_ct_name = c_ct_dest_gaas
                i_path    = lv_path
                i_query   = lv_query
                i_headers = lt_headers ).

    CLEAR out.

    IF ls_resp-status_code BETWEEN 200 AND 299 AND ls_resp-body IS NOT INITIAL.
      DATA ls_parsed TYPE ty_doc_res.

      TRY.
          /ui2/cl_json=>deserialize(
            EXPORTING json        = ls_resp-body
                      pretty_name = /ui2/cl_json=>pretty_mode-camel_case
            CHANGING  data        = ls_parsed ).
        CATCH cx_root INTO DATA(lx_json).
          gs_response = |JSON parse error: { lx_json->get_text( ) }|.
      ENDTRY.

      IF ls_parsed-documents IS NOT INITIAL.
        DATA lt_ddic TYPE ty_t_doc.
        DATA ls_row  LIKE LINE OF lt_ddic.

        FIELD-SYMBOLS <d> LIKE LINE OF ls_parsed-documents.
        LOOP AT ls_parsed-documents ASSIGNING <d>.
          CLEAR ls_row.
          MOVE-CORRESPONDING <d> TO ls_row.
          APPEND ls_row TO lt_ddic.
        ENDLOOP.

        out-documents = lt_ddic.
      ENDIF.

      gs_response = ls_resp-body.
    ELSE.
      gs_response = |HTTP error { ls_resp-status_code }|.
    ENDIF.
  ENDMETHOD.

  METHOD append_query_field.
    rv_query = iv_query.

    IF iv_value IS INITIAL.
      RETURN.
    ENDIF.

    IF rv_query IS INITIAL.
      rv_query = |?{ iv_key }={ iv_value }|.
    ELSE.
      rv_query = |{ rv_query }&{ iv_key }={ iv_value }|.
    ENDIF.
  ENDMETHOD.

  METHOD http_get.

    CLEAR r_resp.

    TRY.

        DATA(lo_dest) =
          cl_http_destination_provider=>create_by_cloud_destination(
            i_name = i_ct_name ).

        DATA(lo_http_client) =
          cl_web_http_client_manager=>create_by_http_destination(
            i_destination = lo_dest ).

        DATA(lo_request) = lo_http_client->get_http_request( ).

        " Path + Query
        IF i_query IS INITIAL.
          lo_request->set_uri_path( i_path ).
        ELSE.
          lo_request->set_uri_path( |{ i_path }{ i_query }| ).
        ENDIF.

        " Headers
        LOOP AT i_headers ASSIGNING FIELD-SYMBOL(<h>).
          lo_request->set_header_field(
            i_name  = <h>-key
            i_value = <h>-value ).
        ENDLOOP.

        " Execute GET
        DATA(lo_response) =
          lo_http_client->execute( i_method = if_web_http_client=>get ).

        DATA(ls_status) = lo_response->get_status( ).
        r_resp-status_code = ls_status-code.
        r_resp-body        = lo_response->get_text( ).

      CATCH cx_web_http_client_error INTO DATA(lx_client).
        r_resp-status_code = -1.
        r_resp-body        = lx_client->get_text( ).

      CATCH cx_http_dest_provider_error INTO DATA(lx_dest).
        r_resp-status_code = -2.
        r_resp-body        = lx_dest->get_text( ).

    ENDTRY.

  ENDMETHOD.


  METHOD http_post.

    CLEAR r_resp.

    TRY.
        " ---- Destination ----
        DATA(lo_dest) =
          cl_http_destination_provider=>create_by_cloud_destination(
            i_name = i_ct_name ).

        " ---- HTTP Client ----
        DATA(lo_http_client) =
          cl_web_http_client_manager=>create_by_http_destination(
            i_destination = lo_dest ).

        " ---- Request ----
        DATA(lo_request) = lo_http_client->get_http_request( ).

        " PATH
        lo_request->set_uri_path( i_path ).

        " Headers
        LOOP AT i_headers ASSIGNING FIELD-SYMBOL(<h>).
          lo_request->set_header_field(
            i_name  = <h>-key
            i_value = <h>-value
          ).
        ENDLOOP.

        " JSON Body
        lo_request->set_content_type( 'application/json' ).
        lo_request->set_text( i_body ).

        " ---- Execute POST ----
        DATA(lo_response) =
          lo_http_client->execute( i_method = if_web_http_client=>post ).

        DATA(ls_status) = lo_response->get_status( ).
        r_resp-status_code = ls_status-code.
        r_resp-body        = lo_response->get_text( ).

      CATCH cx_web_http_client_error INTO DATA(lx_client).
        r_resp-status_code = -1.
        r_resp-body        = lx_client->get_text( ).

      CATCH cx_http_dest_provider_error INTO DATA(lx_dest).
        r_resp-status_code = -2.
        r_resp-body        = lx_dest->get_text( ).

    ENDTRY.

  ENDMETHOD.


  METHOD build_auth_headers.
    DATA ls TYPE ty_key_value.

    IF i_bearer IS NOT INITIAL.
      ls-key   = 'Authorization'.
      ls-value = |Bearer { i_bearer }|.
      INSERT ls INTO TABLE r_headers.
    ENDIF.

    IF ms_connection-api_key IS NOT INITIAL.
      ls-key   = 'x-api-key'.
      ls-value = ms_connection-api_key.
      INSERT ls INTO TABLE r_headers.
    ENDIF.

    ls-key   = 'Accept'.
    ls-value = 'application/json'.
    INSERT ls INTO TABLE r_headers.
  ENDMETHOD.

  METHOD step_get_unit_measures.
  ENDMETHOD.

  METHOD step_show_pdf.
  ENDMETHOD.

ENDCLASS.

