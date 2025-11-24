CLASS /mlsft/ed_sei_constants DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.

    CONSTANTS:
      mv_cancelcomments       TYPE /MLSFT/ED_CHAR100 VALUE '',
      mv_comments             TYPE /MLSFT/ED_CHAR100 VALUE '',
      step_1                  TYPE /mlsft/sei_api_step VALUE '1',
      step_2                  TYPE /mlsft/sei_api_step VALUE '2',
      step_3                  TYPE /mlsft/sei_api_step VALUE '3',
      step_4                  TYPE /mlsft/sei_api_step VALUE '4',
      step_5                  TYPE /mlsft/sei_api_step VALUE '5',
      step_6                  TYPE /mlsft/sei_api_step VALUE '6',
      step_7                  TYPE /mlsft/sei_api_step VALUE '7',
      step_8                  TYPE /mlsft/sei_api_step VALUE '8',
      step_9                  TYPE /mlsft/sei_api_step VALUE '9',
      step_10                 TYPE /mlsft/sei_api_step VALUE '10',
      step_11                 TYPE /mlsft/sei_api_step VALUE '11',
      step_12                 TYPE /mlsft/sei_api_step VALUE '12',
      step_13                 TYPE /mlsft/sei_api_step VALUE '13',
      step_14                 TYPE /mlsft/sei_api_step VALUE '14',
      step_15                 TYPE /mlsft/sei_api_step VALUE '15',
      step_16                 TYPE /mlsft/sei_api_step VALUE '16',
      step_17                 TYPE /mlsft/sei_api_step VALUE '17',
      step_18                 TYPE /mlsft/sei_api_step VALUE '18',
      step_19                 TYPE /mlsft/sei_api_step VALUE '19',
      step_20                 TYPE /mlsft/sei_api_step VALUE '20',
      step_21                 TYPE /mlsft/sei_api_step VALUE '21',
      step_22                 TYPE /mlsft/sei_api_step VALUE '22',
      step_23                 TYPE /mlsft/sei_api_step VALUE '23',
      step_24                 TYPE /mlsft/sei_api_step VALUE '24',
      step_25                 TYPE /mlsft/sei_api_step VALUE '25',
      step_26                 TYPE /mlsft/sei_api_step VALUE '26',
      step_27                 TYPE /mlsft/sei_api_step VALUE '27',
      step_28                 TYPE /mlsft/sei_api_step VALUE '28',
      step_29                 TYPE /mlsft/sei_api_step VALUE '29',
      step_30                 TYPE /mlsft/sei_api_step VALUE '30',
      step_31                 TYPE /mlsft/sei_api_step VALUE '31',
      step_32                 TYPE /mlsft/sei_api_step VALUE '32',
      step_98                 TYPE /mlsft/sei_api_step VALUE '98',
      step_99                 TYPE /mlsft/sei_api_step VALUE '99',

      mv_doctype_so           TYPE /mlsft/ed_direct VALUE 'SO',
      mv_doctype_si           TYPE /mlsft/ed_direct VALUE 'SI',
      xml_class               TYPE /mlsft/ed_clstype VALUE 'XML',
      mapping_class           TYPE /mlsft/ed_clstype VALUE 'MAPPING',
      control_class           TYPE /mlsft/ed_clstype VALUE 'CONTROL',

      vbrk                    TYPE awtyp VALUE 'VBRK',
      bkpf                    TYPE awtyp VALUE 'BKPF',
      rbkp                    TYPE awtyp VALUE 'RBKP',

      param_item_tax          TYPE /mlsft/ed_dparam VALUE 'ITEM_TAX',
      param_item_allow        TYPE /mlsft/ed_dparam VALUE 'ITEM_ALLOW',
      param_add_allow         TYPE /mlsft/ed_dparam VALUE 'ADD_ALLOW',

      eur                     TYPE waers VALUE 'EUR',
      usd                     TYPE waers VALUE 'USD',

      inv_t_sales             TYPE /MLSFT/ED_CHAR60 VALUE '380',
      inv_t_return            TYPE /MLSFT/ED_CHAR60 VALUE '326',
      inv_t_credit            TYPE /MLSFT/ED_CHAR60 VALUE '381',

      date_format_104         TYPE /MLSFT/ED_CHAR10 VALUE '104',
      date_format_102         TYPE /MLSFT/ED_CHAR10 VALUE '102',

      typecode_vat            TYPE /MLSFT/ED_CHAR10 VALUE 'VAT',
      schemaid_0088           TYPE /MLSFT/ED_CHAR10 VALUE '0088',
      folder_name_invoice     TYPE string VALUE 'E-INVOICE',

      inv_profile_basic       TYPE /MLSFT/EDX_PID VALUE '1',
      inv_profile_export      TYPE /mlsft/edx_pid VALUE '4',

      supplier                TYPE /MLSFT/EDX_PTYPE VALUE 'S',
      customer                TYPE /mlsft/edx_ptype VALUE 'C',
      seller                  TYPE /mlsft/edx_ptype VALUE 'B',
      buyer                   TYPE /mlsft/edx_ptype VALUE 'A',
      taxrepresentative       TYPE /mlsft/edx_ptype VALUE 'T',

      inv_send_mail           TYPE /MLSFT/ED_CHAR16 VALUE 'ELEKTRONIK',
      inv_send_paper          TYPE /MLSFT/ED_CHAR16 VALUE 'KAGIT',

      order_reference         TYPE /mlsft/edx_rtype VALUE 'O',
      despatch_reference      TYPE /mlsft/edx_rtype VALUE 'D',
      receipt_reference       TYPE /mlsft/edx_rtype VALUE 'R',
      contractrefrence        TYPE /mlsft/edx_rtype VALUE 'C',
      originatordocumentref   TYPE /mlsft/edx_rtype VALUE 'L',
      add_reference           TYPE /mlsft/edx_rtype VALUE 'A',

      message_id_sei          TYPE sy-msgid VALUE '/mlsft/ED_SEI',
      a                       TYPE /MLSFT/ED_CHAR1 VALUE 'A',
      i                       TYPE /MLSFT/ED_CHAR1 VALUE 'I',

      query_requestid         TYPE string VALUE 'requestId',
      query_sendtocir         TYPE string VALUE 'sendToCir',
      query_invoiceid         TYPE string VALUE 'invoiceId',
      query_date              TYPE string VALUE 'date',
      query_datefrom          TYPE string VALUE 'dateFrom',
      query_dateto            TYPE string VALUE 'dateTo',

      mls_url                 TYPE string VALUE 'https://invoice-dev.melarecon.com',
      sei_url                 TYPE string VALUE 'https://demoefaktura.mfin.gov.rs',

      documentpdf             TYPE string VALUE 'DocumentPdf',
      mv_documentheader       TYPE string VALUE 'DocumentHeader',
      mv_env                  TYPE string VALUE 'env',

      tr                      TYPE /MLSFT/ED_CHAR2 VALUE 'TR', "spras
      sh                      TYPE /MLSFT/ED_CHAR2 VALUE 'SH',

      out_statu_approved      TYPE /mlsft/ed_europe_stat VALUE 'Approved',
      out_statu_sent          TYPE /mlsft/ed_europe_stat VALUE 'Sent',
      out_statu_cancelled     TYPE /mlsft/ed_europe_stat VALUE 'Cancelled',
      out_statu_storno        TYPE /mlsft/ed_europe_stat VALUE 'Storno',
      out_statu_sending       TYPE /mlsft/ed_europe_stat VALUE 'Sending',
      out_statu_rejected      TYPE /mlsft/ed_europe_stat VALUE 'Rejected',
      out_statu_sendingmistake TYPE /mlsft/ed_europe_stat VALUE 'Sending mistake',
      out_statu_mistake       TYPE /mlsft/ed_europe_stat VALUE 'Mistake',

      in_statu_new            TYPE /mlsft/ed_europe_stat VALUE 'New',
      in_statu_seen           TYPE /mlsft/ed_europe_stat VALUE 'Seen',
      in_statu_reminded       TYPE /mlsft/ed_europe_stat VALUE 'Reminded',
      in_statu_renotified     TYPE /mlsft/ed_europe_stat VALUE 'Renotified',
      in_statu_cancelled      TYPE /mlsft/ed_europe_stat VALUE 'Cancelled',
      in_statu_storno         TYPE /mlsft/ed_europe_stat VALUE 'Storno',
      in_statu_acknowledged   TYPE /mlsft/ed_europe_stat VALUE 'Acknowledged',
      in_statu_approved       TYPE /mlsft/ed_europe_stat VALUE 'Approved',
      in_statu_deleted        TYPE /mlsft/ed_europe_stat VALUE 'Deleted',
      in_statu_rejected       TYPE /mlsft/ed_europe_stat VALUE 'Rejected',

      peppol_incoming_rejected   TYPE /mlsft/ed_europe_stat VALUE 'INCOMING_RESPONSE_REJECTED',
      peppol_outgoing_rejected   TYPE /mlsft/ed_europe_stat VALUE 'OUTGOING_RESPONSE_REJECTED',
      peppol_incoming_acknowledged TYPE /mlsft/ed_europe_stat VALUE 'INCOMING_RESPONSE_ACKNOWLEDGED',
      peppol_incoming_approved  TYPE /mlsft/ed_europe_stat VALUE 'INCOMING_RESPONSE_ACCEPTED',
      peppol_outgoing_acknowledged TYPE /mlsft/ed_europe_stat VALUE 'OUTGOING_RESPONSE_ACKNOWLEDGED',
      peppol_outgoing_approved  TYPE /mlsft/ed_europe_stat VALUE 'OUTGOING_RESPONSE_ACCEPTED',

      status_cancel            TYPE /mlsft/ed_status VALUE '09',

      gib_belge_turleri        TYPE string VALUE 'gibBelgeTurleri',
      gib_odeme_turleri        TYPE string VALUE 'gibOdemeTurleri',
      other                    TYPE string VALUE 'other',
      ana_hesap                TYPE string VALUE 'anaHesap'.

ENDCLASS.



CLASS /MLSFT/ED_SEI_CONSTANTS IMPLEMENTATION.
ENDCLASS.
