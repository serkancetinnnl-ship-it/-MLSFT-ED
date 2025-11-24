"======================================================================
" INTERFACE: /mlsft/if_ed_doc_control
" Açıklama : Document control interface (MLSFT)
"======================================================================
INTERFACE /mlsft/if_ed_doc_control PUBLIC.

  "--------------------------------------------------------------------
  " Create / Send / Cancel / Delete
  "--------------------------------------------------------------------
  METHODS action_create_receipt
    IMPORTING
      iv_w_popup TYPE /MLSFT/ED_CHAR1 OPTIONAL
      is_receipt TYPE /mlsft/ed_s_receipt OPTIONAL
    RETURNING
      VALUE(ro_document) TYPE REF TO /mlsft/ed_cl_document.

  METHODS action_send_receipt
    RAISING /mlsft/cx_ed_exception.

  METHODS get_delivery.
**    RETURNING
**      VALUE(ro_delivery) TYPE REF TO /mlsft/ed_delivery.

  METHODS action_cancel
    RAISING /mlsft/cx_ed_exception.

  METHODS action_delete
    RAISING /mlsft/cx_ed_exception.

  METHODS action_check
    RAISING /mlsft/cx_ed_exception.

  METHODS action_create
    IMPORTING
      iv_bukrs TYPE bukrs
      iv_actvt TYPE /MLSFT/ED_CHAR2
    RAISING /mlsft/cx_ed_exception.

  METHODS action_send
    RAISING /mlsft/cx_ed_exception.

  METHODS action_resend
    RAISING /mlsft/cx_ed_exception.

  METHODS action_checkstatus
    RAISING /mlsft/cx_ed_exception.

  METHODS action_recp_checkstatus
    RAISING /mlsft/cx_ed_exception.

  METHODS create_edocument
    RAISING /mlsft/cx_ed_exception.

  "--------------------------------------------------------------------
  " Show / Display / Download
  "--------------------------------------------------------------------
  METHODS set_data_structure
    IMPORTING
      is_delivery TYPE /mlsft/ed_s_main_wbill.

  METHODS show_html_delivery
    IMPORTING iv_repid TYPE syrepid
    RAISING /mlsft/cx_ed_exception.

  METHODS show_html_wstandart_xslt
    IMPORTING iv_repid TYPE syrepid
    RAISING /mlsft/cx_ed_exception.

  METHODS show_xml_delivery
    IMPORTING iv_repid TYPE syrepid
    RAISING /mlsft/cx_ed_exception.

  METHODS show_xml_formatted
    IMPORTING iv_repid TYPE syrepid
    RAISING /mlsft/cx_ed_exception.

  METHODS show_delivery_as_pdf
**    IMPORTING
**      iv_repid TYPE syrepid
**      iv_dynnr TYPE sydynnr OPTIONAL
    RAISING /mlsft/cx_ed_exception.

  METHODS show_receipt_as_pdf
    IMPORTING iv_repid TYPE syrepid
    RAISING /mlsft/cx_ed_exception.

  METHODS show_lines_delivery
    RAISING /mlsft/cx_ed_exception.

  "--------------------------------------------------------------------
  " Check / Dispatch / Signing / Download
  "--------------------------------------------------------------------
  METHODS check_despatch_state
    RAISING /mlsft/cx_ed_exception.

  METHODS send_despatch_data
    RAISING /mlsft/cx_ed_exception.

  METHODS action_signing
    RAISING /mlsft/cx_ed_exception.

  METHODS action_download_xml
    IMPORTING iv_fullpath TYPE string OPTIONAL
    RAISING /mlsft/cx_ed_exception.

  METHODS get_xml_delivery
    RETURNING VALUE(rv_xml) TYPE xstring.

  METHODS get_codebase64
    RETURNING VALUE(rv_cosebase64) TYPE string.

  METHODS action_download_html
    IMPORTING iv_fullpath TYPE string OPTIONAL
    RAISING /mlsft/cx_ed_exception.

  METHODS action_accept_doc
    RAISING /mlsft/cx_ed_exception.

  METHODS action_reject_doc
    RAISING /mlsft/cx_ed_exception.

  METHODS action_download_pdf
    RAISING /mlsft/cx_ed_exception.

  METHODS check_document_is_deletable
    RETURNING VALUE(rv_deletable) TYPE /MLSFT/ED_CHAR1
    RAISING /mlsft/cx_ed_exception.

  METHODS action_send_delivery_as_mail
    RAISING /mlsft/cx_ed_exception.

  METHODS action_send_delivery_as_mail_f
    IMPORTING
      iv_mail_adress TYPE /MLSFT/ED_CHAR241
      iv_filetype    TYPE /MLSFT/ED_CHAR4.

  METHODS action_add_note_to_document
    RAISING /mlsft/cx_ed_exception.

  METHODS check_action_authorization
    IMPORTING iv_action TYPE any
    RETURNING VALUE(rv_return) TYPE /MLSFT/ED_CHAR1.

  METHODS show_response_xml
    IMPORTING iv_repid TYPE syrepid
    RETURNING VALUE(rv_return) TYPE /MLSFT/ED_CHAR1.

  METHODS action_actualtime_xml_fields
    IMPORTING
      iv_date TYPE datum
      iv_time TYPE uzeit
    RAISING /mlsft/cx_ed_exception.

  METHODS action_update_shipment_fields
    IMPORTING
      is_shpmentstage TYPE /mlsft/ed_s_shpstage
      is_carrierparty TYPE /mlsft/ed_s_party
      iv_update_stage TYPE /MLSFT/ED_CHAR1
      iv_update_deliver TYPE /MLSFT/ED_CHAR1
    RAISING /mlsft/cx_ed_exception.

  METHODS action_print_all
    RAISING /mlsft/cx_ed_exception.

  METHODS action_view_doc.

  METHODS check_doc_reverse
    RETURNING VALUE(rv_return) TYPE /MLSFT/ED_CHAR1.

ENDINTERFACE.
