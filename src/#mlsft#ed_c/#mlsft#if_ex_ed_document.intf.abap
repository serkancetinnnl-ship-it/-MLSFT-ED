INTERFACE /MLSFT/IF_EX_ED_DOCUMENT PUBLIC.

  METHODS before_action
    IMPORTING
      io_document TYPE REF TO /mlsft/ed_cl_document
      iv_action   TYPE string
    RAISING
      /mlsft/cx_ed_delivery.

  METHODS after_action
    IMPORTING
      io_document TYPE REF TO /mlsft/ed_cl_document
      iv_action   TYPE string
    RAISING
      /mlsft/cx_ed_delivery.

  METHODS get_dates
    IMPORTING
      io_document TYPE REF TO /mlsft/ed_cl_document OPTIONAL
    CHANGING
      cs_times    TYPE /mlsft/ed_s_dates.

  METHODS generate_gib_id
    IMPORTING
      io_document  TYPE REF TO /mlsft/ed_cl_document
    CHANGING
      rv_skippked  TYPE abap_bool.   " orijinal isim korundu

  METHODS before_send_inv
    IMPORTING
      io_document TYPE REF TO /mlsft/ed_cl_document OPTIONAL
    CHANGING
      cs_input    TYPE REF TO data OPTIONAL.

  METHODS manage_printer
    CHANGING
      cv_printer TYPE string.        " RSPOPNAME yerine string

  METHODS manage_mail_recipients
    CHANGING
      cv_recipients TYPE string.

ENDINTERFACE.
