"======================================================================
" CLASS: /MLSFT/ED_GERMANY_SERVICE_LYR
" DESC : Germany Service Class (Portal Actions Class) - ABAP Cloud compliant
"======================================================================
CLASS /mlsft/ed_germany_service_lyr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    "---------------------- Public Attributes (State) ----------------------
    CLASS-DATA mv_zugfrd_pdf_xml  TYPE string.             " Zugferd Request PDF-XML (base64 ya da raw içerik bilgisi)
    CLASS-DATA mo_document        TYPE REF TO /mlsft/ed_cl_document.
**    CLASS-DATA mv_repid           TYPE repid.
**    CLASS-DATA mv_dynnr           TYPE sydynnr.
    CLASS-DATA c_proccess         TYPE REF TO /mlsft/ed_germany_service_lyr. "self
    CLASS-DATA ca_ubldata         TYPE xstring.            " iXML için kullanılan iç veri (Cloud'da yorum)
    CLASS-DATA cs_header          TYPE /mlsft/edx_shead.   " header yapı
**    CLASS-DATA cs_invfo           TYPE I_InvoiceDocumentHeader."invfo.              " SAP standard (FI/CA line item display)
    CLASS-DATA gv_pdf             TYPE xstring.
    CLASS-DATA cv_node_taxcategory TYPE string VALUE 'TaxCategory'.
    CLASS-DATA gs_response        TYPE string.

    "---------------------- Constructor ----------------------
    METHODS constructor
      IMPORTING
        io_document TYPE REF TO /mlsft/ed_cl_document
**        iv_repid    TYPE repid    OPTIONAL
**        iv_dynnr    TYPE sydynnr  OPTIONAL
      RAISING
        /mlsft/cx_ed_exception.

    "---------------------- Outbound ----------------------
    CLASS-METHODS out_send_invoice
      RAISING /mlsft/cx_ed_exception.

    CLASS-METHODS out_check_invoice
      RAISING /mlsft/cx_ed_exception.

    CLASS-METHODS out_cancel_invoice
      RAISING /mlsft/cx_ed_exception.

    CLASS-METHODS out_show_pdf_invoice
      RETURNING VALUE(rv_pdf) TYPE xstring
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS out_download_pdf_invoice   " Cloud: handler içinde HTTP response ile kullanın
**      IMPORTING io_response TYPE REF TO if_http_response
      RAISING /mlsft/cx_ed_exception.

    CLASS-METHODS out_download_xml_invoice   " Cloud: handler içinde HTTP response ile kullanın
**      IMPORTING io_response TYPE REF TO if_http_response
      RAISING /mlsft/cx_ed_exception.

    CLASS-METHODS out_download_html_invoice. " Boş (istenirse doldur)

**    CLASS-METHODS out_send_attachment_mail.  " Cloud'da mail servisi/Comm. Mgmt entegrasyonu gerekir (yorum)

    "---------------------- Inbound ----------------------
    CLASS-METHODS in_check_invoice
      RAISING /mlsft/cx_ed_exception.

    CLASS-METHODS in_accept_invoice
      RAISING /mlsft/cx_ed_exception.

    CLASS-METHODS in_reject_invoice
      RAISING /mlsft/cx_ed_exception.

    CLASS-METHODS in_show_pdf_invoice
      RETURNING VALUE(rv_pdf) TYPE xstring
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS in_download_pdf_invoice    " Cloud: handler içinde HTTP response ile kullanın
**      IMPORTING io_response TYPE REF TO if_http_response
      RAISING /mlsft/cx_ed_exception.

    CLASS-METHODS in_download_xml_invoice.    " Cloud: handler içinde HTTP response ile kullanın
**      IMPORTING io_response TYPE REF TO if_http_response
**      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS in_download_html_invoice.  " Boş (istenirse doldur)

    CLASS-METHODS in_send_pdf_to_vim_invoice. " On-prem entegrasyon (tamamı yorumda)

    CLASS-METHODS in_save_mm_record.          " On-prem BDC (tamamı yorumda)

    "---------------------- Utilities ----------------------
    CLASS-METHODS merge_pdf_xml_zugferd
      RAISING /mlsft/cx_ed_exception.

    CLASS-METHODS get_pdf_base64
      RETURNING VALUE(re_pdfbase64) TYPE string
      RAISING   /mlsft/cx_ed_exception.
    CLASS-METHODS step_show_pdf
      IMPORTING
                iv_type       TYPE string
                is_head       TYPE /mlsft/ed_head
      RETURNING VALUE(rv_pdf) TYPE string.
  PRIVATE SECTION.

    "---------------------- XML Node Constants (Private) ----------------------
    CONSTANTS cv_node_lmtotal           TYPE string VALUE 'LegalMonetaryTotal'.
    CONSTANTS cv_node_pamount           TYPE string VALUE 'PayableAmount'.
    CONSTANTS cv_node_rate              TYPE string VALUE 'CalculationRate'.
    CONSTANTS cv_node_issued            TYPE string VALUE 'IssueDate'.
    CONSTANTS cv_node_wtaxtotal         TYPE string VALUE 'WithholdingTaxTotal'.
    CONSTANTS cv_node_taxsubtotal       TYPE string VALUE 'TaxSubtotal'.
    CONSTANTS cv_node_taxtotal          TYPE string VALUE 'TaxTotal'.
    CONSTANTS cv_node_uuid              TYPE string VALUE 'UUID'.
    CONSTANTS cv_node_documentresponse  TYPE string VALUE 'cac:DocumentResponse'.
    CONSTANTS cv_node_response          TYPE string VALUE 'cac:Response'.
    CONSTANTS cv_node_referenceid       TYPE string VALUE 'cbc:ReferenceID'.
    CONSTANTS cv_node_responsecode      TYPE string VALUE 'cbc:ResponseCode'.
    CONSTANTS cv_node_description       TYPE string VALUE 'cbc:Description'.
    CONSTANTS cv_node_documentreference TYPE string VALUE 'cac:DocumentReference'.
    CONSTANTS cv_node_id                TYPE string VALUE 'ID'.
    CONSTANTS cv_node_pexchange         TYPE string VALUE 'PaymentExchangeRate'.
    CONSTANTS cv_node_invtype           TYPE string VALUE 'InvoiceTypeCode'.
    CONSTANTS cv_node_issuedate         TYPE string VALUE 'cbc:IssueDate'.
    CONSTANTS cv_percent                TYPE string VALUE 'Percent'.
    CONSTANTS cv_node_documenttypecode  TYPE string VALUE 'cbc:DocumentTypeCode'.
    CONSTANTS cv_node_documenttype      TYPE string VALUE 'cbc:DocumentType'.
    CONSTANTS cv_node_envelopedetail    TYPE string VALUE 'EnvelopeDetail'.
    CONSTANTS cv_node_invoice           TYPE string VALUE 'Invoice'.
    CONSTANTS cv_node_orderreference    TYPE string VALUE 'OrderReference'.

ENDCLASS.



CLASS /MLSFT/ED_GERMANY_SERVICE_LYR IMPLEMENTATION.


  METHOD constructor.
    mo_document = io_document.
**    mv_repid    = iv_repid.
**    mv_dynnr    = iv_dynnr.
  ENDMETHOD.


  METHOD merge_pdf_xml_zugferd.
**    DATA ls_ref  TYPE /mlsft/ed_ref.
**    DATA ls_head TYPE /mlsft/ed_head.
**
**    ls_ref  = mo_document->get_ref( ).
**    ls_head = mo_document->get_head( ).
**
**    DATA(lo_service) = NEW /MLSFT/ED_DE_SERVICE_LAYER(
**                          iv_step     = /mlsft/ed_sei_constants=>step_8
**                          iv_connp    = ls_ref-bukrs
**                          io_document = mo_document
**                          iv_doctype  = ls_head-doctype ).
**
**    DATA(ls_out)    TYPE /mlsft/ed_ger_s_merge_pdf_res.
**    DATA(lv_error)  TYPE string.
**
**    lo_service->step_merge_pdf_xml_zugferd(
**      EXPORTING
**        iv_pdf_base64 = /mlsft/cl_pdf_base64_provider=>encode_pdf_base64( mo_document->get_binary_of_inv( ) )
**      IMPORTING
**        out           = ls_out
**        ev_error      = lv_error ).
**
**    IF lv_error IS INITIAL AND ls_out-data IS NOT INITIAL.
**      mv_zugfrd_pdf_xml = ls_out-data. " Muhtemelen base64
**      /mlsft/ed_logs=>mo_object->add_single_msg(
**        EXPORTING type = 'S'
**                  id   = /mlsft/ed_sei_constants=>message_id_sei
**                  number = '070' ).
**    ELSE.
**      /mlsft/ed_logs=>mo_object->add_single_msg(
**        EXPORTING type = 'E'
**                  id   = /mlsft/ed_sei_constants=>message_id_sei
**                  number = '071' ).
**    ENDIF.
  ENDMETHOD.


  METHOD out_send_invoice.
**    DATA ls_ref  TYPE /mlsft/ed_ref.
**    DATA ls_head TYPE /mlsft/ed_head.
**    ls_ref  = mo_document->get_ref( ).
**    ls_head = mo_document->get_head( ).
**
**    IF ls_head-doctype = /mlsft/ed_constants=>mv_doctype_dz.
**      merge_pdf_xml_zugferd( ).
**    ENDIF.
**
**    DATA(lo_service) = NEW /mlsft/ed_deu_service_layer(
**                          iv_step     = /mlsft/ed_sei_constants=>step_3
**                          iv_connp    = ls_ref-bukrs
**                          io_document = mo_document
**                          iv_doctype  = ls_head-doctype ).
**
**    DATA(ls_out)   TYPE /mlsft/ed_ger_s_send_response.
**    DATA(lv_error) TYPE string.
**
**    lo_service->step_sales_invoice_ubl(
**      IMPORTING
**        out     = ls_out
**        ev_error = lv_error ).
**
**    IF ls_out-uuid IS NOT INITIAL.
**      DATA(lr_db) = NEW /mlsft/ed_db_pers_ctrl( ).
**      ls_head-lstatus = /mlsft/ed_constants=>doc_sended_to_cld.
**      ls_ref-uuid     = ls_out-uuid.
**      lr_db->update_header( is_head = ls_head ).
**      lr_db->update_references( is_ref = ls_ref ).
**      lr_db->update_statlg( is_head = ls_head ).
**      /mlsft/ed_util=>commit_work( ).
**      /mlsft/ed_logs=>mo_object->add_single_msg(
**        EXPORTING type = 'S'
**                  id   = /mlsft/ed_sei_constants=>message_id_sei
**                  number   = '002'
**                  message_v1 = ls_ref-docnum
**                  message_v2 = ls_out-message ).
**    ELSE.
**      DATA(lv_errormessage) TYPE string.
**      IF line_exists( ls_out-errors[ 1 ] ).
**        lv_errormessage = ls_out-errors[ 1 ].
**      ELSE.
**        lv_errormessage = lo_service->get_response( ). " JSON içinden mesaj çıkarma senin serviste yapılmalı
**      ENDIF.
**      /mlsft/ed_logs=>mo_object->add_single_msg(
**        EXPORTING type = 'E'
**                  id   = /mlsft/ed_sei_constants=>message_id_sei
**                  number   = '000'
**                  message_v1 = ls_ref-docnum
**                  message_v2 = lv_errormessage ).
**    ENDIF.
  ENDMETHOD.


  METHOD out_check_invoice.
**    DATA ls_ref  TYPE /mlsft/ed_ref.
**    DATA ls_head TYPE /mlsft/ed_head.
**    ls_ref  = mo_document->get_ref( ).
**    ls_head = mo_document->get_head( ).
**
**    DATA(lo_service) = NEW /mlsft/ed_deu_service_layer(
**                          iv_step     = /mlsft/ed_sei_constants=>step_6
**                          iv_connp    = ls_ref-bukrs
**                          io_document = mo_document
**                          iv_doctype  = ls_head-doctype ).
**
**    DATA(ls_out) TYPE /mlsft/ed_ger_s_status_req.
**    lo_service->step_sales_invoice_check( IMPORTING out = ls_out ).
**
**    IF ls_out IS NOT INITIAL.
**      DATA(lr_db) = NEW /mlsft/ed_db_pers_ctrl( ).
**
**      IF ls_out-status = /mlsft/ed_sei_constants=>peppol_incoming_approved
**      OR ls_out-status = /mlsft/ed_sei_constants=>peppol_outgoing_approved.
**        ls_head-lstatus = /mlsft/ed_constants=>doc_accepted.
**      ELSEIF ls_out-status = /mlsft/ed_sei_constants=>peppol_incoming_rejected
**         OR  ls_out-status = /mlsft/ed_sei_constants=>peppol_outgoing_rejected.
**        ls_head-lstatus = /mlsft/ed_constants=>doc_rejected.
**      ELSEIF ls_out-status = /mlsft/ed_sei_constants=>peppol_incoming_acknowledged
**         OR  ls_out-status = /mlsft/ed_sei_constants=>peppol_outgoing_acknowledged.
**        ls_head-lstatus = /mlsft/ed_constants=>doc_acknowledged.
**      ENDIF.
**
**      ls_ref-europe_stat = ls_out-status.
**
**      lr_db->update_header( is_head = ls_head ).
**      lr_db->update_references( is_ref = ls_ref ).
**      lr_db->update_statlg( is_head = ls_head ).
**      /mlsft/ed_util=>commit_work( ).
**
**      /mlsft/ed_logs=>mo_object->add_single_msg(
**        EXPORTING type = 'S'
**                  id   = /mlsft/ed_sei_constants=>message_id_sei
**                  number   = '069'
**                  message_v1 = ls_ref-docnum
**                  message_v2 = ls_out-status ).
**    ENDIF.
  ENDMETHOD.


  METHOD out_cancel_invoice.
    " Cloud: iptal mantığını servis katmanında uygula (örnek) Outbound: iptal (Cloud'da servis üzerinden; on-prem kodu yorumda)
    " Burada benzer şekilde lo_service->step_get_sales_invoice_cancel(...) çağrısı
    " ve DB güncellemeleri yapılmalı.

    "-------------------- ON-PREM (YASAK, SADECE REFERANS) --------------------
    "* Orijinal kod CALL FUNCTION, GUI, vb. içeriyordu. Cloud'da kullanılmaz.
  ENDMETHOD.


  METHOD in_check_invoice.
    " Orijinal kod on-prem SEI sınıflarına dayanıyor; Cloud servis katmanına uyarlayın.
    " İstersen burada /mlsft/ed_deu_service_layer->step_purchase_invoice_check çağrısı yap.
    "-------------------- ON-PREM REFERANS BLOĞU (YORUM) --------------------
    "* (Önceki /MLSAG/.. sınıfındaki uzun akış yorumlandı)
  ENDMETHOD.


  METHOD in_accept_invoice.
**    DATA ls_ref  TYPE /mlsft/ed_ref.
**    DATA ls_head TYPE /mlsft/ed_head.
**    ls_ref  = mo_document->get_ref( ).
**    ls_head = mo_document->get_head( ).
**
**    DATA(lo_service) = NEW /mlsft/ed_deu_service_layer(
**                          iv_step     = /mlsft/ed_sei_constants=>step_9
**                          iv_connp    = ls_ref-bukrs
**                          io_document = mo_document
**                          iv_doctype  = /mlsft/ed_constants=>mv_doctype_di ).
**
**    DATA ls_out TYPE /mlsft/ed_inv_acc_rej_res.
**    CONSTANTS cv_accept TYPE abap_bool VALUE abap_true.
**
**    lo_service->step_accpt_rjct_inv(
**      EXPORTING is_accept = COND char1( WHEN cv_accept = abap_true THEN 'X' ELSE '' )
**      IMPORTING out       = ls_out ).
**
**    IF ls_out-sendingsuccess = 'true'.
**      DATA(lr_db) = NEW /mlsft/ed_db_pers_ctrl( ).
**      " Basit mantık: kabul → accepted; değilse acknowledged
**      IF /mlsft/ed_eur_constants=>mv_comments = /mlsft/ed_constants=>peppol_accepted
**         AND /mlsft/ed_eur_constants=>mv_comments <> /mlsft/ed_constants=>peppol_acknowledge.
**        ls_head-lstatus = /mlsft/ed_constants=>doc_accepted.
**        ls_ref-europe_stat = /mlsft/ed_sei_constants=>in_statu_approved.
**        ls_ref-gibstat     = /mlsft/ed_sei_constants=>in_statu_approved.
**      ELSE.
**        ls_head-lstatus = /mlsft/ed_constants=>doc_acknowledged.
**        ls_ref-europe_stat = /mlsft/ed_sei_constants=>in_statu_acknowledged.
**        ls_ref-gibstat     = /mlsft/ed_constants=>doc_acknowledged.
**      ENDIF.
**      ls_ref-puuid = ls_out-processid.
**
**      lr_db->update_references( is_ref = ls_ref ).
**      lr_db->update_header(    is_head = ls_head ).
**      /mlsft/ed_util=>commit_work( ).
**
**      /mlsft/ed_logs=>mo_object->add_single_msg(
**        EXPORTING type = 'S'
**                  id   = /mlsft/ed_ger_constants=>message_id_ger
**                  number   = '002'
**                  message_v1 = ls_ref-docnum
**                  message_v2 = ls_ref-europe_stat ).
**    ELSE.
**      /mlsft/ed_logs=>mo_object->add_single_msg(
**        EXPORTING type = 'E'
**                  id   = /mlsft/ed_ger_constants=>message_id_ger
**                  number   = '039'
**                  message_v1 = ls_ref-docnum ).
**    ENDIF.
  ENDMETHOD.


  METHOD in_reject_invoice.
**    DATA ls_ref  TYPE /mlsft/ed_ref.
**    DATA ls_head TYPE /mlsft/ed_head.
**    ls_ref  = mo_document->get_ref( ).
**    ls_head = mo_document->get_head( ).
**
**    DATA(lo_service) = NEW /mlsft/ed_deu_service_layer(
**                          iv_step     = /mlsft/ed_sei_constants=>step_9
**                          iv_connp    = ls_ref-bukrs
**                          io_document = mo_document
**                          iv_doctype  = /mlsft/ed_constants=>mv_doctype_di ).
**
**    DATA ls_out TYPE /mlsft/ed_inv_acc_rej_res.
**    CONSTANTS cv_reject TYPE char1 VALUE ''. " boş = reject
**
**    lo_service->step_accpt_rjct_inv(
**      EXPORTING is_accept = cv_reject
**      IMPORTING out       = ls_out ).
**
**    IF ls_out-sendingsuccess = 'true'.
**      DATA(lr_db) = NEW /mlsft/ed_db_pers_ctrl( ).
**      ls_head-lstatus   = /mlsft/ed_constants=>doc_rejected.
**      ls_ref-europe_stat = /mlsft/ed_sei_constants=>in_statu_rejected.
**      ls_ref-gibstat     = /mlsft/ed_sei_constants=>in_statu_rejected.
**      ls_ref-puuid       = ls_out-processid.
**
**      lr_db->update_references( is_ref = ls_ref ).
**      lr_db->update_header(    is_head = ls_head ).
**      /mlsft/ed_util=>commit_work( ).
**
**      /mlsft/ed_logs=>mo_object->add_single_msg(
**        EXPORTING type = 'S'
**                  id   = /mlsft/ed_ger_constants=>message_id_ger
**                  number   = '002'
**                  message_v1 = ls_ref-docnum
**                  message_v2 = ls_ref-europe_stat ).
**    ELSE.
**      /mlsft/ed_logs=>mo_object->add_single_msg(
**        EXPORTING type = 'E'
**                  id   = /mlsft/ed_ger_constants=>message_id_ger
**                  number   = '040'
**                  message_v1 = ls_ref-docnum ).
**    ENDIF.
  ENDMETHOD.


  METHOD in_show_pdf_invoice.
**    DATA ls_ref  TYPE /mlsft/ed_ref.
**    DATA ls_head TYPE /mlsft/ed_head.
**    ls_ref  = mo_document->get_ref( ).
**    ls_head = mo_document->get_head( ).
**
**    DATA lv_type TYPE string.
**    IF ls_head-doctype = /mlsft/ed_constants=>mv_doctype_do
**    OR ls_head-doctype = /mlsft/ed_constants=>mv_doctype_di.
**      lv_type = /mlsft/ed_constants=>mv_germany_inv_xrechnung.
**    ELSEIF ls_head-doctype = /mlsft/ed_constants=>mv_doctype_dz
**       OR  ls_head-doctype = /mlsft/ed_constants=>mv_doctype_dy.
**      lv_type = /mlsft/ed_constants=>mv_germany_inv_zugferd.
**    ENDIF.
**
**    IF lv_type IS NOT INITIAL.
**      DATA(lo_service) = NEW /mlsft/ed_deu_service_layer(
**                            iv_step     = /mlsft/ed_sei_constants=>step_1
**                            iv_connp    = ls_ref-bukrs
**                            io_document = mo_document
**                            iv_doctype  = ls_head-doctype ).
**      rv_pdf = lo_service->step_show_pdf( iv_type = lv_type is_head = ls_head ).
**    ELSE.
**      " Ekteki rawall'dan PDF bul (type_03 varsayımı)
**      DATA(lt_rawall) = mo_document->get_data_rawall( ).
**      LOOP AT lt_rawall ASSIGNING FIELD-SYMBOL(<ls_raw>) WHERE <ls_raw>-dtype = /mlsft/ed_constants=>document_type_03.
**        rv_pdf = <ls_raw>-binary.
**        EXIT.
**      ENDLOOP.
**    ENDIF.
  ENDMETHOD.


  METHOD out_show_pdf_invoice.
    DATA ls_ref  TYPE /mlsft/ed_ref.
    DATA ls_head TYPE /mlsft/ed_head.
    ls_ref  = mo_document->get_ref( ).
    ls_head = mo_document->get_head( ).

    DATA lv_type TYPE string.
    IF ls_head-doctype = /mlsft/ed_constants=>mv_doctype_do.
      lv_type = /mlsft/ed_constants=>mv_germany_inv_xrechnung.
    ELSEIF ls_head-doctype = /mlsft/ed_constants=>mv_doctype_dz.
      lv_type = /mlsft/ed_constants=>mv_germany_inv_zugferd.
    ENDIF.

    DATA(lo_service) = NEW /mlsft/ed_de_service_layer(
                          iv_step     = /mlsft/ed_sei_constants=>step_1
                          iv_connp    = ls_ref-bukrs
                          io_document = mo_document
                          iv_doctype  = ls_head-doctype ).
    rv_pdf = lo_service->step_show_pdf( iv_type = lv_type is_head = ls_head ).
  ENDMETHOD.


  METHOD get_pdf_base64.
**    DATA(lv_pdf) = out_show_pdf_invoice( ).
**    re_pdfbase64 = /mlsft/cl_pdf_base64_provider=>encode_pdf_base64( lv_pdf ).
  ENDMETHOD.


  METHOD in_download_pdf_invoice.
**    DATA(lv_pdf) = in_show_pdf_invoice( ).
**    /mlsft/cl_pdf_http_downloader=>send_as_attachment(
**      iv_pdf      = lv_pdf
**      iv_filename = 'inbound_invoice.pdf'
**      io_response = io_response ).
  ENDMETHOD.


  METHOD out_download_pdf_invoice.
**    DATA(lv_pdf) = out_show_pdf_invoice( ).
**    /mlsft/cl_pdf_http_downloader=>send_as_attachment(
**      iv_pdf      = lv_pdf
**      iv_filename = 'outbound_invoice.pdf'
**      io_response = io_response ).
  ENDMETHOD.


  METHOD in_download_xml_invoice.
**    DATA(ls_raw) = mo_document->get_data( ). " ty_raw: binary => XML xstring
**    io_response->set_header_field( i_name = 'Content-Type'        i_value = 'application/xml' ).
**    io_response->set_header_field( i_name = 'Content-Disposition' i_value = |attachment; filename="inbound_invoice.xml"| ).
**    io_response->set_binary( ls_raw-binary ).
**    io_response->set_status( i_code = 200 i_reason = 'OK' ).
**
**    "-------------------- ON-PREM (YASAK, SADECE REFERANS) --------------------
**    "* SCMS_XSTRING_TO_BINARY + /mlsag/ed_util=>download_binary vb. kullanımlar yasak.
  ENDMETHOD.


  METHOD out_download_xml_invoice.
**    DATA(ls_raw) = mo_document->get_data( ).
**    io_response->set_header_field( i_name = 'Content-Type'        i_value = 'application/xml' ).
**    io_response->set_header_field( i_name = 'Content-Disposition' i_value = |attachment; filename="outbound_invoice.xml"| ).
**    io_response->set_binary( ls_raw-binary ).
**    io_response->set_status( i_code = 200 i_reason = 'OK' ).
  ENDMETHOD.


  METHOD in_download_html_invoice.
  ENDMETHOD.


  METHOD out_download_html_invoice.
  ENDMETHOD.


  METHOD in_send_pdf_to_vim_invoice.
    "-------------------- ON-PREM REFERANS BLOĞU (YORUM) --------------------
    "* Eski kodda: service->step_get_purchase_invoice_xml, base64 decode,
    "* OPEN DATASET ile network path’e yazma vb. Cloud’da yasaktır.
    "* Cloud’da bunun karşılığı: BTP DMS/Object Store API kullanımı veya
    "* harici servis entegrasyonu ile yapılmalı.
  ENDMETHOD.


  METHOD in_save_mm_record.
    "-------------------- ON-PREM REFERANS BLOĞU (YORUM) --------------------
    "* BDC, CALL TRANSACTION, SET PARAMETER ID vb. Cloud’da yasaktır.
    "* Bu işlev Cloud’da RAP/Business Object API’leri (MM/FI) üzerinden
    "* servis çağrıları ile yapılmalıdır.
  ENDMETHOD.


  METHOD step_show_pdf.
    " Amaç: Belgeyi (PDF) dış servisten ya da SAP'den çekmek

    " Eğer API üzerinden PDF base64 formatında gelecekse burada çağırılacak
**  DATA(lv_document_id) = is_head-documentid.   " veya kendi field'ına göre

    " TODO: Dış sistem API çağrısı / PDF üretimi yapılabilir.
    " Şimdilik placeholder bir değer döndürüyoruz.
**    rv_pdf = |PDF content for type { iv_type } and document { lv_document_id }|.

    " Örnek olarak HTTP çağrısı yapmak istersen:
    " DATA(ls_resp) = http_get( i_ct_name = c_ct_dest_gaas
    "                           i_path    = |/pdf/{ lv_document_id }| ).
    " IF ls_resp-status_code = 200.
    "   rv_pdf = ls_resp-body.
    " ENDIF.

  ENDMETHOD.
ENDCLASS.
