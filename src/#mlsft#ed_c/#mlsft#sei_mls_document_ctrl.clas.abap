CLASS /mlsft/sei_mls_document_ctrl DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.

    DATA mo_delivery TYPE REF TO /MLSFT/ED_DELIVERy.
    DATA mo_util     TYPE REF TO /mlsft/ed_util.

    DATA ms_head TYPE /mlsft/ed_head.
*CLASS-DATA ms_head TYPE /mlsft/ed_head. " veya
    CONSTANTS mc_action_send             TYPE /mlsft/ED_CHAR20 VALUE 'action_send'. "#EC NOTEXT
    CONSTANTS mc_action_resend           TYPE /mlsft/ED_CHAR20 VALUE 'action_resend'. "#EC NOTEXT
    CONSTANTS mc_action_reply            TYPE /mlsft/ED_CHAR20 VALUE 'action_reply'. "#EC NOTEXT
    CONSTANTS mc_action_show_pdf         TYPE /mlsft/ED_CHAR20 VALUE 'action_show_pdf'. "#EC NOTEXT
    CONSTANTS mv_mess_class              TYPE symsgid VALUE '/MLSFT/ED_SEI'. "#EC NOTEXT
    CONSTANTS mv_object                  TYPE balobj_d VALUE '/MLSFT/ED'. "#EC NOTEXT
    CONSTANTS mv_subobject_out           TYPE balsubobj VALUE 'OUT'. "#EC NOTEXT
    CONSTANTS mv_subobject_in            TYPE balsubobj VALUE 'IN'. "#EC NOTEXT
    CONSTANTS mv_subobject_receipt       TYPE balsubobj VALUE 'RECEIPT'. "#EC NOTEXT
    CONSTANTS mc_action_down_xml         TYPE /mlsft/ED_CHAR20 VALUE 'action_down_xml'. "#EC NOTEXT
    CONSTANTS mc_action_create           TYPE /mlsft/ED_CHAR20 VALUE 'action_create'. "#EC NOTEXT
    CONSTANTS mc_action_show_html        TYPE /mlsft/ED_CHAR20 VALUE 'action_show_html'. "#EC NOTEXT
    CONSTANTS mc_action_show_json        TYPE /mlsft/ED_CHAR20 VALUE 'action_show_json'. "#EC NOTEXT
    CONSTANTS mc_action_show_xml         TYPE /mlsft/ED_CHAR20 VALUE 'action_show_xml'. "#EC NOTEXT
    CONSTANTS mc_action_mail_send        TYPE /mlsft/ED_CHAR20 VALUE 'action_mail_send'. "#EC NOTEXT
    CONSTANTS mc_action_add_note         TYPE /mlsft/ED_CHAR20 VALUE 'action_add_note'. "#EC NOTEXT
    CONSTANTS mc_action_add_time         TYPE /mlsft/ED_CHAR20 VALUE 'action_add_note'. "#EC NOTEXT
    CONSTANTS mc_action_down_pdf         TYPE /mlsft/ED_CHAR20 VALUE 'action_down_pdf'. "#EC NOTEXT
    CONSTANTS mc_action_dtpcheck         TYPE /mlsft/ED_CHAR20 VALUE 'action_dtpcheckf'. "#EC NOTEXT
    CONSTANTS mc_action_create_receipt   TYPE /mlsft/ED_CHAR20 VALUE 'action_reccreate'. "#EC NOTEXT
    CONSTANTS mc_action_send_receipt     TYPE /mlsft/ED_CHAR20 VALUE 'action_recsend'. "#EC NOTEXT
    CONSTANTS mc_action_down_html        TYPE /mlsft/ED_CHAR20 VALUE 'action_down_html'. "#EC NOTEXT
    CONSTANTS mc_action_cancel           TYPE /mlsft/ED_CHAR20 VALUE 'action_cancel'. "#EC NOTEXT
    CONSTANTS mc_action_storno_cancel    TYPE /mlsft/ED_CHAR20 VALUE 'action_storno_cancel'. "#EC NOTEXT
    CONSTANTS mc_action_upd_shipment     TYPE /mlsft/ED_CHAR20 VALUE 'update_shipment'. "#EC NOTEXT
    CONSTANTS mc_action_accept           TYPE /mlsft/ED_CHAR20 VALUE 'action_accept'. "#EC NOTEXT
    CONSTANTS mc_action_reject           TYPE /mlsft/ED_CHAR20 VALUE 'action_reject'. "#EC NOTEXT
    CONSTANTS mc_action_send_vim         TYPE /mlsft/ED_CHAR20 VALUE 'action_send_vim'. "#EC NOTEXT
    CONSTANTS mc_action_workflow         TYPE /mlsft/ED_CHAR20 VALUE 'action_workflow'. "#EC NOTEXT
    CONSTANTS mc_action_attach           TYPE /mlsft/ED_CHAR20 VALUE 'action_attach'. "#EC NOTEXT
    CONSTANTS mc_action_send_mail_onay   TYPE /mlsft/ED_CHAR30 VALUE 'action_send_mail_onay'. "#EC NOTEXT
    CONSTANTS mc_action_handle           TYPE /mlsft/ED_CHAR20 VALUE 'action_handle'. "#EC NOTEXT
    CONSTANTS mc_action_get_bulk_pdf     TYPE /mlsft/ED_CHAR20 VALUE 'action_get_bulk_pdf'. "#EC NOTEXT

    CLASS-METHODS get_instance
      IMPORTING iv_docnum      TYPE /mlsft/ed_head-docnum
      RETURNING VALUE(ro_ctrl) TYPE REF TO /mlsft/sei_mls_document_ctrl.

    CLASS-METHODS create_by_docnum
      IMPORTING iv_docnum      TYPE /mlsft/ed_head-docnum
      RETURNING VALUE(ro_ctrl) TYPE REF TO /mlsft/sei_mls_document_ctrl.
    METHODS constructor
      IMPORTING
                !iv_docnum   TYPE /mlsft/ed_guid OPTIONAL
                !io_document TYPE REF TO /mlsft/ed_cl_document OPTIONAL
      RAISING   /mlsft/cx_ed_exception.
    CLASS-METHODS global_factory
      IMPORTING
        !iv_docnum     TYPE /mlsft/ed_guid
      RETURNING
        VALUE(r_value) TYPE REF TO /mlsft/if_ed_doc_control
      RAISING
        /mlsft/cx_ed_exception.

    CLASS-METHODS factory
      IMPORTING
        !iv_docnum     TYPE /mlsft/ed_guid
      RETURNING
        VALUE(r_value) TYPE REF TO /mlsft/sei_mls_document_ctrl.

    CLASS-METHODS factory_with_object
      IMPORTING
        !io_document   TYPE REF TO /mlsft/ed_cl_document
      RETURNING
        VALUE(r_value) TYPE REF TO /mlsft/sei_mls_document_ctrl.

    CLASS-METHODS defactory.
    CLASS-METHODS defactory_not_logs.

    CLASS-METHODS factory_receipt_from_despatch
      IMPORTING
        !iv_parent     TYPE /mlsft/ed_guid
      RETURNING
        VALUE(r_value) TYPE REF TO /mlsft/sei_mls_document_ctrl.
    METHODS get_docnum
      RETURNING VALUE(rv_docnum) TYPE /mlsft/ed_head-docnum.

    METHODS action_create_receipt
      IMPORTING
        !iv_w_popup        TYPE /mlsft/ED_CHAR1 OPTIONAL
        !is_receipt        TYPE /mlsft/ed_s_receipt OPTIONAL
      RETURNING
        VALUE(ro_document) TYPE REF TO /mlsft/ed_cl_document.

    METHODS action_send_receipt
      RAISING /mlsft/cx_ed_exception.

    METHODS get_delivery
      RETURNING VALUE(ro_delivery) TYPE REF TO /mlsft/ed_delivery.

    METHODS action_delete
      RAISING /mlsft/cx_ed_exception.

    METHODS action_cancel
      RAISING /mlsft/cx_ed_exception.

    METHODS action_storno_cancel
      RAISING /mlsft/cx_ed_exception.

    METHODS action_check
      RAISING /mlsft/cx_ed_exception.

    METHODS action_create
      IMPORTING
                !iv_bukrs TYPE bukrs
                !iv_actvt TYPE /mlsft/ED_CHAR2
      RAISING   /mlsft/cx_ed_exception.

    METHODS action_send
      RAISING /mlsft/cx_ed_exception.

    METHODS action_resend
      RAISING /mlsft/cx_ed_exception.

    METHODS action_accept.
    METHODS action_handle.
    METHODS action_reject.

    METHODS action_checkstatus
      RAISING /mlsft/cx_ed_exception.

    METHODS action_recp_checkstatus
      RAISING /mlsft/cx_ed_exception.

    METHODS action_send_pdf_to_vim
      RAISING /mlsft/cx_ed_exception.

    METHODS create_edocument
      RAISING /mlsft/cx_ed_exception.

    METHODS set_data_structure
      IMPORTING !is_delivery TYPE /mlsft/ed_s_main_wbill.

    METHODS show_html_delivery
**      IMPORTING !iv_repid TYPE sy-repid
      RAISING /mlsft/cx_ed_exception.

    METHODS show_html_wstandart_xslt
**      IMPORTING !iv_repid TYPE sy-repid
      RAISING /mlsft/cx_ed_exception.

    METHODS show_pdf_wstandart_xslt
**      IMPORTING !iv_repid TYPE sy-repid
      RAISING /mlsft/cx_ed_exception.

    METHODS show_json_delivery
**      IMPORTING !iv_repid TYPE sy-repid
      RAISING /mlsft/cx_ed_exception.

    METHODS show_xml_delivery
**      IMPORTING !iv_repid TYPE sy-repid
      RAISING /mlsft/cx_ed_exception.

    METHODS show_sign_xml_delivery
**      IMPORTING !iv_repid TYPE sy-repid
      RAISING /mlsft/cx_ed_exception.

    METHODS show_xml_formatted
**      IMPORTING !iv_repid TYPE sy-repid
      RAISING /mlsft/cx_ed_exception.

    METHODS show_delivery_as_pdf_in
**      IMPORTING
**        !iv_repid TYPE sy-repid
**        !iv_dynnr TYPE sydynnr OPTIONAL
      RAISING /mlsft/cx_ed_exception.

    METHODS show_receipt_as_pdf
**      IMPORTING !iv_repid TYPE sy-repid
      RAISING /mlsft/cx_ed_exception.

    METHODS show_lines_delivery
      RAISING /mlsft/cx_ed_exception.

    METHODS check_despacth_state
      RAISING /mlsft/cx_ed_exception.

    METHODS send_despacth_data
      RAISING /mlsft/cx_ed_exception.

    METHODS action_out_download_xml
      IMPORTING !iv_fullpath TYPE string OPTIONAL
      RAISING   /mlsft/cx_ed_exception.

    METHODS action_in_download_xml
      IMPORTING !iv_fullpath TYPE string OPTIONAL
      RAISING   /mlsft/cx_ed_exception.

    METHODS get_codebase64
      RETURNING VALUE(rv_cosebase64) TYPE string.

    METHODS create_document_with_ref
      IMPORTING
                VALUE(is_ref)      TYPE /mlsft/ed_ref
                !iv_doctype        TYPE /mlsft/ed_direct
      RETURNING VALUE(ro_document) TYPE REF TO /mlsft/ed_cl_document.

    METHODS action_download_html
      IMPORTING
                !iv_fullpath TYPE string OPTIONAL
**        !iv_repid    TYPE sy-repid OPTIONAL
      RAISING   /mlsft/cx_ed_exception.

    METHODS action_out_download_pdf
      IMPORTING
                io_document TYPE REF TO /mlsft/ed_cl_document
      RAISING   /mlsft/cx_ed_exception.

    METHODS action_out_send_inv_as_mail
      RAISING /mlsft/cx_ed_exception.

    METHODS action_in_send_inv_as_mail
      IMPORTING VALUE(im_pdfname) TYPE string OPTIONAL
      RAISING   /mlsft/cx_ed_exception.

    METHODS action_in_send_inv_as_onay_ml
      RAISING /mlsft/cx_ed_exception.

    METHODS action_azer_error_image
      RAISING /mlsft/cx_ed_exception.

    METHODS action_add_note_to_document
      RAISING /mlsft/cx_ed_exception.

    METHODS check_action_authorization
      IMPORTING !iv_action       TYPE any
      RETURNING VALUE(rv_return) TYPE /mlsft/ED_CHAR1.

    METHODS action_actualtime_xml_fields
      IMPORTING
                !iv_date TYPE datum
                !iv_time TYPE uzeit
      RAISING   /mlsft/cx_ed_exception.

    METHODS action_update_shipment_fields
      IMPORTING
                !is_shpmentstage   TYPE /mlsft/ed_s_shpstage
                !is_carrierparty   TYPE /mlsft/ed_s_party
                !iv_update_stage   TYPE /mlsft/ED_CHAR1
                !iv_update_deliver TYPE /mlsft/ED_CHAR1
      RAISING   /mlsft/cx_ed_exception.

    METHODS action_print_all
      RAISING /mlsft/cx_ed_exception.

    METHODS post_fi_incoming_doc
      RAISING /mlsft/cx_ed_exception.

    METHODS post_mm_incoming_doc
      RAISING /mlsft/cx_ed_exception.

    METHODS action_measures
      RAISING /mlsft/cx_ed_exception.

    METHODS show_delivery_as_pdf_out
**      IMPORTING
**        !iv_repid TYPE sy-repid
**        !iv_dynnr TYPE sydynnr OPTIONAL
      RAISING /mlsft/cx_ed_exception.

    METHODS action_in_download_pdf
      RAISING /mlsft/cx_ed_exception.

    METHODS get_xml_delivery RETURNING VALUE(rv_xml) TYPE xstring.

    METHODS save_mm_record.
    METHODS save_fi_record.
    METHODS action_attach_document.
    METHODS action_show_attachment.
    METHODS action_kor_roz.

    METHODS update_order
      IMPORTING VALUE(is_ref) TYPE /mlsft/ed_ref OPTIONAL.

    METHODS send_to_mail_for_response
      RAISING /mlsft/cx_ed_exception.

    METHODS send_to_mail_for_customer
      RAISING /mlsft/cx_ed_exception.

    METHODS show_html_delivery_fiori
**      IMPORTING !iv_repid TYPE sy-repid
      EXPORTING !rv_html TYPE string
      RAISING   /mlsft/cx_ed_exception.

    METHODS show_html_wstandart_xslt_fiori
**      IMPORTING !iv_repid TYPE sy-repid
      EXPORTING !rv_html TYPE string
      RAISING   /mlsft/cx_ed_exception.

    METHODS action_get_bulk_pdf
      IMPORTING !it_uuid      TYPE /mlsft/ed_uuid_tt
      RETURNING VALUE(et_pdf) TYPE /mlsft/ed_bulk_pdf_res
      RAISING   /mlsft/cx_ed_exception.

  PRIVATE SECTION.

    TYPES: xline(4096) TYPE x.
    TYPES: xlinetab TYPE TABLE OF xline.

    CLASS-DATA mr_object TYPE REF TO /mlsft/sei_mls_document_ctrl.
    DATA mv_waybill TYPE /mlsft/ed_ewaybill.
    DATA mv_docnum  TYPE /mlsft/ed_guid.
    DATA mo_document TYPE REF TO /mlsft/ed_cl_document.
    DATA mv_bukrs TYPE bukrs.
    DATA lo_badi TYPE REF TO /mlsft/if_ex_ed_document.
    DATA lo_badi_active TYPE /mlsft/ED_CHAR1.
    CLASS-DATA mr_global TYPE REF TO /mlsft/if_ed_doc_control.
    DATA mv_date TYPE datum.
    DATA mv_time TYPE Uzeit.

    METHODS before_action
      IMPORTING !iv_action       TYPE any
      RETURNING VALUE(rv_cancel) TYPE /mlsft/ED_CHAR1.

    METHODS import_bo.
    METHODS create_xml RAISING /mlsft/cx_ed_exception.

**METHODS action_out_download_pdf.

    METHODS badi_before_action
      IMPORTING !iv_action       TYPE any
      RETURNING VALUE(rv_cancel) TYPE /mlsft/ED_CHAR1.

    METHODS badi_after_action
      IMPORTING !iv_action TYPE any.

    METHODS after_action
      IMPORTING !iv_action TYPE any.

    METHODS check_act_time
      IMPORTING !iv_bukrs TYPE bukrs
      RAISING   /mlsft/cx_ed_exception.

    METHODS check_shipment_details
      RETURNING VALUE(r_result) TYPE /mlsft/ED_CHAR1.

    " ---- Cloud-safe tek noktadan çağrı sarmalayıcı ----
    METHODS _exec_action
      IMPORTING
                iv_action_id TYPE /mlsft/ED_CHAR20
**        iv_repid     TYPE syrepid OPTIONAL
**        iv_dynnr     TYPE sydynnr OPTIONAL
      RAISING   /mlsft/cx_ed_exception.

ENDCLASS.



CLASS /mlsft/sei_mls_document_ctrl IMPLEMENTATION.

  METHOD get_instance.
    DATA lv_guid TYPE /mlsft/ed_guid.

    lv_guid = iv_docnum.        " C(32) → /MLSFT/ED_GUID uyumlu hale getir
    ro_ctrl = NEW /mlsft/sei_mls_document_ctrl( iv_docnum = lv_guid ).
  ENDMETHOD.


  METHOD create_by_docnum.
    DATA lv_guid TYPE /mlsft/ed_guid.

    lv_guid = iv_docnum.     " Dönüşüm burada yapılır

    ro_ctrl = NEW /mlsft/sei_mls_document_ctrl(
                 iv_docnum = lv_guid
               ).
  ENDMETHOD.
  METHOD _exec_action.
    " Cloud-safe: Dinamik CREATE/CALL yok. Tüm iş gateway'e delege edilir.
**    /MLSFT/CL_SERVICE_GATEWAY=>execute(
**      iv_action_id = iv_action_id
**      io_document  = mo_document
**      iv_repid     = iv_repid
**      iv_dynnr     = iv_dynnr ).
  ENDMETHOD.


  METHOD action_accept.
    CHECK before_action( mc_action_accept ) IS INITIAL.
    CHECK badi_before_action( mc_action_accept ) IS INITIAL.
    " Eski dinamik çağrı BLOĞU (Cloud'da yasak) AŞAĞIDA YORUMDA:
    "* ... (get_service_action, CREATE OBJECT TYPE (ls_method-class), CALL METHOD (ls_method-method))
    _exec_action( iv_action_id = mc_action_accept ).
  ENDMETHOD.


  METHOD action_actualtime_xml_fields.
    CHECK before_action( mc_action_add_time ) IS INITIAL.
    CHECK badi_before_action( mc_action_add_time ) IS INITIAL.
    " Orijinal XML tarih alanı güncelleme kodu -> Gateway’e taşındı
    _exec_action( iv_action_id = mc_action_add_time ).
    after_action(  mc_action_add_time ).
    badi_after_action( mc_action_add_time ).
  ENDMETHOD.


  METHOD action_add_note_to_document.
    CHECK before_action( mc_action_send ) IS INITIAL.
    CHECK badi_before_action( mc_action_send ) IS INITIAL.
    _exec_action( iv_action_id = mc_action_ADD_NOTE ).
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_outbound_add_note ).
  ENDMETHOD.


  METHOD action_attach_document.
    CHECK before_action( mc_action_attach ) IS INITIAL.
    CHECK badi_before_action( mc_action_attach ) IS INITIAL.
    _exec_action( iv_action_id = mc_action_ATTACH ).
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_outbound_attach ).
  ENDMETHOD.


  METHOD action_azer_error_image.
    " CHECK'ler istenirse açılabilir
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_azer_error_image ).
  ENDMETHOD.


  METHOD action_cancel.
    CHECK before_action( mc_action_cancel ) IS INITIAL.
    CHECK badi_before_action( mc_action_cancel ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_outbound_cancel ).
  ENDMETHOD.


  METHOD action_check.
    " İsteğe göre gateway’e yönlendirebilirsin
  ENDMETHOD.


  METHOD action_checkstatus.
    CHECK before_action( mc_action_dtpcheck ) IS INITIAL.
    CHECK badi_before_action( mc_action_dtpcheck ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_outbound_check ).
  ENDMETHOD.


  METHOD action_create.
    CHECK before_action( mc_action_create ) IS INITIAL.
    " Orijinal: action_check( ) + create_edocument( ) → Gateway’e taşındı
    _exec_action( iv_action_id = mc_action_create ).
    after_action( mc_action_create ).
  ENDMETHOD.


  METHOD get_docnum.
    rv_docnum = ms_head-docnum.  " ya da ilgili alandan oku
  ENDMETHOD.


  METHOD action_create_receipt.
    CHECK before_action( mc_action_create_receipt ) IS INITIAL.
    CHECK badi_before_action( mc_action_create_receipt ) IS INITIAL.
    _exec_action( iv_action_id = mc_action_create_receipt ).
    after_action( mc_action_create_receipt ).
    badi_after_action( mc_action_create_receipt ).
    ro_document = mo_document. " İsteğe göre gateway döndürebilir
  ENDMETHOD.


  METHOD action_delete.
    CHECK before_action( mc_action_cancel ) IS INITIAL.
    CHECK badi_before_action( mc_action_cancel ) IS INITIAL.
    _exec_action( iv_action_id = mc_action_cancel ).
    badi_after_action( mc_action_cancel ).
  ENDMETHOD.


  METHOD action_download_html.
    CHECK before_action( mc_action_down_html ) IS INITIAL.
    CHECK badi_before_action( mc_action_down_html ) IS INITIAL.
    _exec_action( iv_action_id = mc_action_down_html ).
**                  iv_repid     = iv_repid ).
  ENDMETHOD.


  METHOD action_handle.
    CHECK before_action( mc_action_accept ) IS INITIAL.
    CHECK badi_before_action( mc_action_accept ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_inbound_handle ).
  ENDMETHOD.


  METHOD action_in_download_pdf.
    CHECK before_action( mc_action_down_pdf ) IS INITIAL.
    CHECK badi_before_action( mc_action_down_pdf ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_inbound_down_pdf ).
  ENDMETHOD.


  METHOD action_in_download_xml.
    CHECK before_action( mc_action_down_xml ) IS INITIAL.
    CHECK badi_before_action( mc_action_down_xml ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_inbound_down_xml ).
    after_action( mc_action_down_xml ).
    badi_after_action( mc_action_down_xml ).
  ENDMETHOD.


  METHOD action_in_send_inv_as_mail.
    CHECK before_action( mc_action_show_pdf ) IS INITIAL.
    CHECK badi_before_action( mc_action_show_pdf ) IS INITIAL.
    " im_pdfname → gateway tarafında io_document->set_ref ile işlenmeli
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_inbound_send_mail ).
  ENDMETHOD.


  METHOD action_in_send_inv_as_onay_ml.
    CHECK before_action( mc_action_send_mail_onay ) IS INITIAL.
    CHECK badi_before_action( mc_action_send_mail_onay ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_inbound_send_mail_on ).
  ENDMETHOD.


  METHOD action_kor_roz.
    CHECK before_action( mc_action_send ) IS INITIAL.
    CHECK badi_before_action( mc_action_send ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_outbound_kor_roz ).
  ENDMETHOD.


  METHOD action_measures.
    _exec_action( iv_action_id = 'action_measures' ).
  ENDMETHOD.


  METHOD action_out_download_pdf.
    CHECK before_action( mc_action_down_pdf ) IS INITIAL.
    CHECK badi_before_action( mc_action_down_pdf ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_outbound_down_pdf ).



**  DATA: lv_docnum TYPE string,"/mlsft/ed_docnum,
**        lv_url    TYPE string,
**        lv_pdf    TYPE xstring,
**        lo_http_client TYPE REF TO if_web_http_client.
**
**  lv_docnum = io_document->get_docnum( ).
**
**  "Docnova API URL
**  lv_url = |https://api-stage.docnova.ai/invoice/generate/pdf?docnum={ lv_docnum }|.
**
**  "APİ çağrısı (XSTRING döner)
**  CALL METHOD /mlsft/cl_http_util=>download_pdf
**    EXPORTING
**      iv_url      = lv_url
**    RECEIVING
**      rv_content  = lv_pdf.
**
**  "İndirme için MIME objesi gösterilebilir
**  cl_gui_frontend_services=>gui_download(
**    EXPORTING
**      bin_filesize = xstrlen( lv_pdf )
**      filename     = 'Invoice.pdf'
**      filetype     = 'BIN'
**    CHANGING
**      data_tab     = lv_pdf ).
**

    " ------------------------------------------------------
    " 1) Ön kontroller (eski logikler varsa)
    " ------------------------------------------------------
    " Eğer bu sabitler ve methodlar sende varsa aktif et:
    " CHECK before_action( mc_action_down_pdf ) IS INITIAL.
    " CHECK badi_before_action( mc_action_down_pdf ) IS INITIAL.

    " ------------------------------------------------------
    " 2) Docnum kontrolü
    " ------------------------------------------------------
    DATA(lv_docnum) = mv_docnum.
    IF lv_docnum IS INITIAL.
      " Docnum yoksa hiçbir şey yapma (istersen log at)
      RETURN.
    ENDIF.

    " ------------------------------------------------------
    " 3) HTTP destination ve client
    "    - DOCNOVA_API: Communication Management'te tanımlı
    "      HTTP destination ID (sen belirleyeceksin)
    " ------------------------------------------------------
    CONSTANTS lc_dest_name TYPE string VALUE 'DOCNOVA_API'.

    DATA: lo_destination TYPE REF TO if_http_destination,
          lo_http_client TYPE REF TO if_web_http_client,
          lo_request     TYPE REF TO if_web_http_request,
          lo_response    TYPE REF TO if_web_http_response,
          lv_status      TYPE i,
          lv_pdf         TYPE xstring.

    TRY.
        " 3.1 Destination'i al
        lo_destination = cl_http_destination_provider=>create_by_cloud_destination(
                           i_name = lc_dest_name ).


        " 3.2 HTTP client yarat
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination(
                           i_destination = lo_destination ).

        " 3.3 Request nesnesi
        lo_request = lo_http_client->get_http_request( ).

        " 3.4 Path ve query param ayarla
        " Base URL destination'da: https://api-stage.docnova.ai
        " Burada sadece relative path ve query gönderiyoruz:
        "   /invoice/generate/pdf?docnum=...
        lo_request->set_uri_path(
          i_uri_path = '/invoice/generate/pdf'
        ).

        lo_request->set_query( |docnum={ lv_docnum }| ).

        " ------------------------------------------------------
        " 4) HTTP çağrısı (GET) - Public Cloud uyumlu
        " ------------------------------------------------------
        lo_response = lo_http_client->execute(
                        i_method = if_web_http_client=>get ).

        DATA(ls_status) = lo_response->get_status( ).
        lv_status = ls_status-code.


        IF lv_status = 200.
          " PDF içeriği XSTRING olarak alıyoruz
          lv_pdf = lo_response->get_binary( ).

          " --------------------------------------------------
          " 5) Buradan sonrası senaryona göre:
          "    - lv_pdf'i /MLSFT/ED_RAW tablosuna yazabiliriz
          "    - ya da ayrı bir media entity üzerinden Fiori'ye verebiliriz
          "    - ya da application log vs. oluşturabiliriz
          " --------------------------------------------------

        ELSE.
          " Hata durumunda istersen application log at
          " örn: ms_head-docnum, lv_status vs. ile mesaj yaz
        ENDIF.

      CATCH cx_http_dest_provider_error INTO DATA(lx_dest).
        " Destination hatası -> log yaz / mesaj at
      CATCH cx_web_http_client_error INTO DATA(lx_http).
        " HTTP çağrısı hatası -> log yaz / mesaj at
    ENDTRY.

  ENDMETHOD.



  METHOD action_out_download_xml.
    CHECK before_action( mc_action_down_xml ) IS INITIAL.
    CHECK badi_before_action( mc_action_down_xml ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_outbound_down_xml ).
    after_action( mc_action_down_xml ).
    badi_after_action( mc_action_down_xml ).
  ENDMETHOD.


  METHOD action_out_send_inv_as_mail.
    CHECK before_action( mc_action_show_pdf ) IS INITIAL.
    CHECK badi_before_action( mc_action_show_pdf ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_outbound_send_mail ).
  ENDMETHOD.


  METHOD action_print_all.
    _exec_action( iv_action_id = 'action_print_all' ).
  ENDMETHOD.


  METHOD action_recp_checkstatus.
    CHECK before_action( mc_action_dtpcheck ) IS INITIAL.
    CHECK badi_before_action( mc_action_dtpcheck ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_inbound_check ).
  ENDMETHOD.


  METHOD action_reject.
    CHECK before_action( mc_action_reject ) IS INITIAL.
    CHECK badi_before_action( mc_action_reject ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_inbound_reject ).
  ENDMETHOD.


  METHOD action_resend.
    CHECK before_action( mc_action_resend ) IS INITIAL.
    CHECK badi_before_action( mc_action_resend ) IS INITIAL.
    _exec_action( iv_action_id = mc_action_resend ).
    after_action( mc_action_resend ).
    badi_after_action( mc_action_resend ).
  ENDMETHOD.


  METHOD action_send.
    CHECK before_action( mc_action_send ) IS INITIAL.
    CHECK badi_before_action( mc_action_send ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_outbound_send ).
  ENDMETHOD.


  METHOD action_send_pdf_to_vim.
    CHECK before_action( mc_action_send_vim ) IS INITIAL.
    CHECK badi_before_action( mc_action_send_vim ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_send_pdf_to_vim ).
  ENDMETHOD.


  METHOD action_send_receipt.
    CHECK before_action( mc_action_send_receipt ) IS INITIAL.
    CHECK badi_before_action( mc_action_send_receipt ) IS INITIAL.
    _exec_action( iv_action_id = mc_action_send_receipt ).
    after_action( mc_action_send_receipt ).
    badi_after_action( mc_action_send_receipt ).
  ENDMETHOD.


  METHOD action_show_attachment.
    CHECK before_action( mc_action_attach ) IS INITIAL.
    CHECK badi_before_action( mc_action_attach ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_inbound_attach ).
  ENDMETHOD.


  METHOD action_storno_cancel.
    CHECK before_action( mc_action_storno_cancel ) IS INITIAL.
    CHECK badi_before_action( mc_action_storno_cancel ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_outbound_storno_canc ).
  ENDMETHOD.


  METHOD action_update_shipment_fields.
    CHECK before_action( mc_action_upd_shipment ) IS INITIAL.
    CHECK badi_before_action( mc_action_upd_shipment ) IS INITIAL.
    _exec_action( iv_action_id = mc_action_upd_shipment ).
    after_action( mc_action_upd_shipment ).
    badi_after_action( mc_action_upd_shipment ).
  ENDMETHOD.


  METHOD after_action.
    CASE iv_action.
      WHEN mc_action_create_receipt.
        mo_document->update_local_status( iv_status = /mlsft/ed_constants=>doc_receipt_created ).
      WHEN mc_action_send_receipt.
        mo_document->update_local_status( iv_status = /mlsft/ed_constants=>doc_receipt_sended ).
    ENDCASE.
  ENDMETHOD.


  METHOD badi_after_action.
    " Cloud: klasik cl_exithandler kullanımı yasak; badi çağrısı gateway’de yapılmalı
  ENDMETHOD.


  METHOD badi_before_action.
    rv_cancel = abap_false.
  ENDMETHOD.


  METHOD before_action.
    rv_cancel = check_action_authorization( iv_action ).
  ENDMETHOD.


  METHOD check_action_authorization.
    DATA lv_actvt TYPE /mlsft/ED_CHAR2.
    DATA lv_symsgno TYPE symsgno.

    CASE iv_action.
      WHEN mc_action_create.            lv_actvt = /mlsft/ed_constants=>auth_check_actvt_01.
      WHEN mc_action_show_html.         lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_05. lv_symsgno = '012'.
      WHEN mc_action_show_xml.          lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_06. lv_symsgno = '013'.
      WHEN mc_action_show_pdf.          lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_07. lv_symsgno = '015'.
      WHEN mc_action_mail_send.         lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_08. lv_symsgno = '016'.
      WHEN mc_action_add_note.          lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_09. lv_symsgno = '017'.
      WHEN mc_action_reply OR mc_action_create_receipt OR mc_action_send_receipt.
        lv_actvt = /mlsft/ed_constants=>auth_check_actvt_10.    lv_symsgno = '018'.
      WHEN mc_action_send.              lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_11. lv_symsgno = '014'.
      WHEN mc_action_down_xml.          lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_12. lv_symsgno = '019'.
      WHEN mc_action_down_html.         lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_13. lv_symsgno = '020'.
      WHEN mc_action_dtpcheck.          lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_14. lv_symsgno = '021'.
      WHEN mc_action_cancel.            lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_15. lv_symsgno = '027'.
      WHEN mc_action_resend.            lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_16. lv_symsgno = '023'.
      WHEN mc_action_upd_shipment.      lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_18. lv_symsgno = '028'.
      WHEN mc_action_down_pdf.          lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_19. lv_symsgno = '022'.
      WHEN mc_action_accept.            lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_21. lv_symsgno = '022'.
      WHEN mc_action_reject.            lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_22. lv_symsgno = '030'.
      WHEN mc_action_send_vim.          lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_23. lv_symsgno = '031'.
      WHEN mc_action_get_bulk_pdf.      lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_36. lv_symsgno = '073'.
      WHEN mc_action_workflow.          lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_24. lv_symsgno = '032'.
      WHEN mc_action_attach.            lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_33. lv_symsgno = '106'.
      WHEN mc_action_storno_cancel.     lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_34. lv_symsgno = '107'.
      WHEN mc_action_send_mail_onay.    lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_35. lv_symsgno = '108'.
      WHEN mc_action_handle.            lv_actvt = /mlsft/ed_constants=>auth_check_eur_actvt_36. lv_symsgno = '111'.
    ENDCASE.

    AUTHORITY-CHECK OBJECT /mlsft/ed_constants=>auth_object_eur
      ID 'ACTVT' FIELD lv_actvt
      ID 'BUKRS' FIELD mv_bukrs.

    rv_return = COND #( WHEN sy-subrc = 0 THEN abap_false ELSE abap_true ).
    " Cloud: log yazımı gateway/eşiğe taşınabilir
  ENDMETHOD.


  METHOD check_act_time.
    " Cloud’da zaman hesapları/güncelleme gateway’de ele alınmalı
    _exec_action( iv_action_id = mc_action_add_time ).
  ENDMETHOD.


  METHOD show_lines_delivery.
  ENDMETHOD.


  METHOD check_despacth_state.
  ENDMETHOD.


  METHOD check_shipment_details.
    r_result = abap_true.
  ENDMETHOD.


  METHOD constructor.
    IF io_document IS BOUND.
      mo_document ?= io_document.
    ELSE.
      CREATE OBJECT mo_document EXPORTING iv_docnum = iv_docnum.
    ENDIF.

    DATA ls_head TYPE /mlsft/ed_head.
    DATA ls_ref  TYPE /mlsft/ed_ref.
    ls_head = mo_document->get_head( ).
    mv_docnum = ls_head-docnum.
    ls_ref  = mo_document->get_ref( ).
    mv_bukrs = ls_ref-bukrs.

    IF ls_head-refdoc IS NOT INITIAL AND ls_head-doctype = /mlsft/ed_constants=>doc_type_doc_out.
      CREATE OBJECT mo_delivery EXPORTING iv_vbeln = ls_head-refdoc.
    ENDIF.

    " Cloud: klasik BAdI exithandler yok; badi çağrıları gateway’de yapılmalı
  ENDMETHOD.



  METHOD create_document_with_ref.
    DATA: lv_type TYPE string.
**    ro_document = /MLSFT/CL_SERVICE_GATEWAY=>create_document_with_ref(
**      is_ref     = is_ref
**      iv_doctype = iv_doctype ).
  ENDMETHOD.


  METHOD create_edocument.
**    _exec_action( iv_action_id = 'action_create_edocument' ).
  ENDMETHOD.


  METHOD create_xml.
    _exec_action( iv_action_id = 'action_create_xml' ).
  ENDMETHOD.


  METHOD defactory.
    FREE /mlsft/sei_mls_document_ctrl=>mr_object.
    FREE /mlsft/sei_mls_document_ctrl=>mr_global.
    "/MLSFT/ED_LOGS=>defactory( ).  " Cloud: log sınıfı released ise aç
  ENDMETHOD.


  METHOD defactory_not_logs.
    FREE /mlsft/sei_mls_document_ctrl=>mr_object.
    FREE /mlsft/sei_mls_document_ctrl=>mr_global.
  ENDMETHOD.


  METHOD factory.
    IF /mlsft/sei_mls_document_ctrl=>mr_object IS INITIAL.
      CREATE OBJECT /mlsft/sei_mls_document_ctrl=>mr_object
        EXPORTING
          iv_docnum = iv_docnum.
    ENDIF.
    r_value = /mlsft/sei_mls_document_ctrl=>mr_object.
  ENDMETHOD.


  METHOD factory_receipt_from_despatch.
    " Eski seçimler gateway’e taşınmalı
    IF /mlsft/sei_mls_document_ctrl=>mr_object IS INITIAL.
      CREATE OBJECT /mlsft/sei_mls_document_ctrl=>mr_object
        EXPORTING
          iv_docnum = iv_parent.
    ENDIF.
    r_value ?= /mlsft/sei_mls_document_ctrl=>mr_object.
  ENDMETHOD.


  METHOD factory_with_object.
    IF /mlsft/sei_mls_document_ctrl=>mr_object IS INITIAL.
      CREATE OBJECT /mlsft/sei_mls_document_ctrl=>mr_object
        EXPORTING
          io_document = io_document.
    ENDIF.
    r_value = /mlsft/sei_mls_document_ctrl=>mr_object.
  ENDMETHOD.


  METHOD get_codebase64.
    DATA lv_unencoded TYPE xstring.
    get_xml_delivery( RECEIVING rv_xml = lv_unencoded ).
**    cl_http_utility=>if_http_utility~encode_x_base64(
**      exporting unencoded = lv_unencoded
**      receiving encoded   = rv_cosebase64 ).
  ENDMETHOD.


  METHOD get_delivery.
    ro_delivery = me->mo_delivery.
  ENDMETHOD.


  METHOD get_xml_delivery.
    " XML doğrudan dokümandan okunur; Cloud-safe
    DATA ls_data TYPE /mlsft/ed_raw.
**    ls_data = mo_document->get_data( ).
    rv_xml  = ls_data-binary.
  ENDMETHOD.


  METHOD global_factory.
    " Ülke/doküman tipine göre farklı controller gerekiyorsa Gateway’de çözümlenecek
    IF /mlsft/sei_mls_document_ctrl=>mr_global IS INITIAL.
      " Default global instance
      /mlsft/sei_mls_document_ctrl=>mr_global ?= /mlsft/sei_mls_document_ctrl=>factory( iv_docnum ).
    ENDIF.
    r_value = /mlsft/sei_mls_document_ctrl=>mr_global.
  ENDMETHOD.


  METHOD import_bo.
  ENDMETHOD.


  METHOD post_fi_incoming_doc.
    " Cloud’da CALL TRANSACTION/BDC yok → Gateway tarafında API tabanlı post
    _exec_action( iv_action_id = 'post_fi_incoming_doc' ).
  ENDMETHOD.


  METHOD post_mm_incoming_doc.
    _exec_action( iv_action_id = 'post_mm_incoming_doc' ).
  ENDMETHOD.


  METHOD save_fi_record.
    CHECK before_action( mc_action_send_vim ) IS INITIAL.
    CHECK badi_before_action( mc_action_send_vim ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_save_fi_record ).
  ENDMETHOD.


  METHOD save_mm_record.
    CHECK before_action( mc_action_send_vim ) IS INITIAL.
    CHECK badi_before_action( mc_action_send_vim ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_save_mm_record ).
  ENDMETHOD.


  METHOD send_despacth_data.
    _exec_action( iv_action_id = 'send_despacth_data' ).
  ENDMETHOD.


  METHOD send_to_mail_for_response.
    CHECK before_action( mc_action_send_vim ) IS INITIAL.
    CHECK badi_before_action( mc_action_send_vim ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_send_to_response_ml ).
  ENDMETHOD.


  METHOD set_data_structure.
    mo_delivery->set_data_structure( is_delivery = is_delivery ).
  ENDMETHOD.


  METHOD show_delivery_as_pdf_in.
    CHECK before_action( mc_action_show_pdf ) IS INITIAL.
    CHECK badi_before_action( mc_action_show_pdf ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_inbound_show_pdf
**                  iv_repid     = iv_repid
**                  iv_dynnr     = iv_dynnr ).
  ENDMETHOD.


  METHOD show_delivery_as_pdf_out.
    CHECK before_action( mc_action_show_pdf ) IS INITIAL.
    CHECK badi_before_action( mc_action_show_pdf ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_outbound_show_pdf
**                  iv_repid     = iv_repid
**                  iv_dynnr     = iv_dynnr ).
  ENDMETHOD.


  METHOD show_html_delivery.
    CHECK before_action( mc_action_show_html ) IS INITIAL.
    CHECK badi_before_action( mc_action_show_html ) IS INITIAL.
**    _exec_action( iv_action_id = mc_action_show_html
**                  iv_repid     = iv_repid ).
  ENDMETHOD.


  METHOD show_html_wstandart_xslt.
    CHECK before_action( mc_action_show_html ) IS INITIAL.
    CHECK badi_before_action( mc_action_show_html ) IS INITIAL.
**    _exec_action( iv_action_id = 'show_html_std_xslt'
**                  iv_repid     = iv_repid ).
  ENDMETHOD.


  METHOD show_json_delivery.
    CHECK before_action( mc_action_show_json ) IS INITIAL.
    CHECK badi_before_action( mc_action_show_json ) IS INITIAL.
**    _exec_action( iv_action_id = mc_action_show_json
**                  iv_repid     = iv_repid ).
  ENDMETHOD.


  METHOD show_pdf_wstandart_xslt.
    CHECK before_action( mc_action_show_html ) IS INITIAL.
    CHECK badi_before_action( mc_action_show_html ) IS INITIAL.
**    _exec_action( iv_action_id = 'show_pdf_std_xslt'
**                  iv_repid     = iv_repid ).
  ENDMETHOD.


  METHOD show_receipt_as_pdf.
    CHECK before_action( mc_action_show_pdf ) IS INITIAL.
    CHECK badi_before_action( mc_action_show_pdf ) IS INITIAL.
**    _exec_action( iv_action_id = 'show_receipt_pdf'
**                  iv_repid     = iv_repid ).
    after_action( mc_action_show_pdf ).
    badi_after_action( mc_action_show_pdf ).
  ENDMETHOD.


  METHOD show_sign_xml_delivery.
    CHECK before_action( mc_action_show_xml ) IS INITIAL.
    CHECK badi_before_action( mc_action_show_xml ) IS INITIAL.
    _exec_action( iv_action_id = 'show_sign_xml' ).
**                  iv_repid     = iv_repid ).
  ENDMETHOD.


  METHOD show_xml_delivery.
    CHECK before_action( mc_action_show_xml ) IS INITIAL.
    CHECK badi_before_action( mc_action_show_xml ) IS INITIAL.
    _exec_action( iv_action_id = mc_action_show_xml ).
**                  iv_repid     = iv_repid ).
  ENDMETHOD.


  METHOD show_xml_formatted.
    CHECK before_action( mc_action_show_xml ) IS INITIAL.
    CHECK badi_before_action( mc_action_show_xml ) IS INITIAL.
    _exec_action( iv_action_id = 'show_xml_formatted' ).
**                  iv_repid     = iv_repid ).
  ENDMETHOD.


  METHOD show_html_delivery_fiori.
    CHECK before_action( mc_action_show_html ) IS INITIAL.
    CHECK badi_before_action( mc_action_show_html ) IS INITIAL.
    _exec_action( iv_action_id = 'show_html_fiori' ).
**                  iv_repid     = iv_repid ).
    rv_html = ''. " Gateway isterse doldurur
  ENDMETHOD.


  METHOD show_html_wstandart_xslt_fiori.
    CHECK before_action( mc_action_show_html ) IS INITIAL.
    CHECK badi_before_action( mc_action_show_html ) IS INITIAL.
**    _exec_action( iv_action_id = 'show_html_std_xslt_fiori' ).
****                  iv_repid     = iv_repid ).
**    rv_html = ''. " Gateway isterse doldurur
  ENDMETHOD.


  METHOD update_order.
    " Basitçe gateway’e yönlendir; orijinal loglar gateway’de kalsın
    _exec_action( iv_action_id = 'update_order' ).
  ENDMETHOD.


  METHOD send_to_mail_for_customer.
    CHECK before_action( mc_action_send ) IS INITIAL.
    CHECK badi_before_action( mc_action_send ) IS INITIAL.
**    _exec_action( iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_send_to_customer_ml ).
  ENDMETHOD.


  METHOD action_get_bulk_pdf.
    CHECK before_action( mc_action_get_bulk_pdf ) IS INITIAL.
    CHECK badi_before_action( mc_action_get_bulk_pdf ) IS INITIAL.
    " Bulk için gateway'in execute_bulk_pdf metodunu çağırıyoruz:
**    /MLSFT/CL_SERVICE_GATEWAY=>execute_bulk_pdf(
**      iv_action_id = /MLSFT/ED_CONSTANTS=>mv_action_get_bulk_pdf
**      io_document  = mo_document
**      it_uuid      = it_uuid
**      IMPORTING et_pdf = et_pdf ).
  ENDMETHOD.
ENDCLASS.
