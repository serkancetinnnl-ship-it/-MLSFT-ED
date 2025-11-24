"======================================================================
"  CLASS: /mlsft/cl_ed_util
"  TYPE : Utility Class (ABAP Cloud uyumlu)
"======================================================================

CLASS /mlsft/cl_ed_util DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    CONSTANTS mc_log_out TYPE string VALUE 'OUT'.
    CONSTANTS mc_in      TYPE string VALUE 'IN'.
    CONSTANTS mc_reply   TYPE string VALUE 'REPLY'.
    CONSTANTS mc_gen     TYPE string VALUE 'GEN'.
    CONSTANTS mc_logging TYPE string VALUE 'LOGGING'.

    CONSTANTS mc_dtp    TYPE /mlsft/ED_char1 VALUE 'D'.
    CONSTANTS mc_server TYPE /mlsft/ED_char1 VALUE 'S'.
    CONSTANTS mc_ftp    TYPE /mlsft/ED_char1 VALUE 'F'.
    CONSTANTS mc_idoc   TYPE /mlsft/ED_char1 VALUE 'I'.

    TYPES: BEGIN OF ty_print_data,
             delivery_number TYPE vbeln,
             ship_to         TYPE kunnr,
             sold_to         TYPE kunnr,
             output_type     TYPE /mlsft/ED_CHAR4,
             spool_request   TYPE /mlsft/ED_CHAR10,
           END OF ty_print_data.

    CLASS-METHODS class_constructor.

    CLASS-METHODS get_time_delay
      IMPORTING iv_bukrs TYPE bukrs
      CHANGING  cv_date  TYPE datum
                cv_time  TYPE uzeit
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS get_data_read_options
      RETURNING VALUE(r_value) TYPE ty_print_data.

    CLASS-METHODS get_data_read_options_invoice
      RETURNING VALUE(r_value) TYPE ty_print_data.

    CLASS-METHODS convert_to_gib_date
      IMPORTING iv_date         TYPE datum
      RETURNING VALUE(rv_value) TYPE string.

    CLASS-METHODS convert_to_gib_time
      IMPORTING iv_time         TYPE uzeit
      RETURNING VALUE(rv_value) TYPE string.

    CLASS-METHODS convert_xsddatetime_frm_str
      IMPORTING iv_time  TYPE string
      CHANGING  cv_date  TYPE datum OPTIONAL
                cv_uzeit TYPE uzeit OPTIONAL.

    CLASS-METHODS convert_string_to_xstring
      IMPORTING iv_string         TYPE string
      RETURNING VALUE(rv_xstring) TYPE xstring
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS get_uuid
      RETURNING VALUE(re_value) TYPE string
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS convert_unit_measurement
      IMPORTING im_value        TYPE any OPTIONAL
      RETURNING VALUE(re_value) TYPE string.

    CLASS-METHODS convert_gib_currency
      IMPORTING im_value        TYPE any OPTIONAL
      RETURNING VALUE(re_value) TYPE string.

    CLASS-METHODS auth_check_despatch
      IMPORTING im_object            TYPE /mlsft/ED_CHAR10
                im_bukrs             TYPE bukrs
                im_actvt             TYPE /mlsft/ED_CHAR2
                im_showmessage       TYPE abap_bool DEFAULT abap_true
                im_type              TYPE msgty      DEFAULT 'E'
                im_msgnumber         TYPE /mlsft/ED_CHAR3 OPTIONAL
      RETURNING VALUE(ex_authorized) TYPE /mlsft/ED_CHAR1.

    CLASS-METHODS commit_work
      RAISING /mlsft/cx_ed_exception.

    CLASS-METHODS get_xml_string
      IMPORTING i_docnum        TYPE /mlsft/ED_char32
      RETURNING VALUE(re_value) TYPE xstring.

    CLASS-METHODS add_note_to_delivery
      IMPORTING i_docnum       TYPE /mlsft/ED_char32
                i_note         TYPE string
      RETURNING VALUE(r_subrc) TYPE sy-subrc
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS unzip_user_list
      IMPORTING iv_binary         TYPE xstring
      RETURNING VALUE(rt_taxlist) TYPE /mlsft/ed_vkn
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS open_file_dialog
      RETURNING VALUE(rv_filename) TYPE string
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS download_binary
      CHANGING cv_check TYPE /mlsft/ED_char1 OPTIONAL
      RAISING  /mlsft/cx_ed_exception.

    CLASS-METHODS show_xml_formatted
      IMPORTING i_xinvoice TYPE xstring
**                i_repid    TYPE sy-cprog
**                i_dynnr    TYPE sy-dynnr OPTIONAL
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS show_xml
      IMPORTING iv_xml   TYPE xstring
**                iv_repid TYPE sy-cprog
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS show_html
      IMPORTING iv_xml   TYPE xstring
**                iv_repid TYPE sy-cprog
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS show_html_data
      IMPORTING it_data  TYPE xstring
**                iv_repid TYPE sy-cprog
                iv_type  TYPE /mlsft/ED_char10
**                iv_dynnr TYPE sy-dynnr OPTIONAL
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS get_number_next
      RETURNING VALUE(r_value) TYPE /mlsft/ED_char13
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS generate_doc_key
      RETURNING VALUE(r_value) TYPE /mlsft/ED_char13
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS create_document_key
      RETURNING VALUE(rv_uuid) TYPE /mlsft/ED_char32
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS get_next_number
      IMPORTING iv_gjahr        TYPE gjahr
                iv_nrange       TYPE /mlsft/ED_char2
                iv_bukrs        TYPE bukrs
                iv_object       TYPE /mlsft/ED_char10
      RETURNING VALUE(rv_value) TYPE /mlsft/ED_char9
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS get_units
      RETURNING VALUE(rt_units) TYPE /mlsft/ed_t_tunitc.

  PRIVATE SECTION.
    CLASS-DATA mt_units TYPE /mlsft/ed_t_tunitc.
ENDCLASS.



CLASS /MLSFT/CL_ED_UTIL IMPLEMENTATION.


  METHOD class_constructor.
  ENDMETHOD.


  METHOD get_time_delay.
    DATA(lv_utc)   = cl_abap_context_info=>get_system_time( ).
    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).
    cv_date = lv_today.
    cv_time = lv_utc.
  ENDMETHOD.


  METHOD get_data_read_options.
    CLEAR r_value.
  ENDMETHOD.


  METHOD get_data_read_options_invoice.
    CLEAR r_value.
  ENDMETHOD.


  METHOD convert_to_gib_date.
    CONCATENATE iv_date(4) '-' iv_date+4(2) '-' iv_date+6(2) INTO rv_value.
  ENDMETHOD.


  METHOD convert_to_gib_time.
    CONCATENATE iv_time(2) ':' iv_time+2(2) ':' iv_time+4(2) INTO rv_value.
  ENDMETHOD.


  METHOD convert_xsddatetime_frm_str.
    IF strlen( iv_time ) GT 14.
      CONCATENATE iv_time+0(4)  iv_time+5(2)  iv_time+8(2)  INTO cv_date.
      CONCATENATE iv_time+11(2) iv_time+14(2) iv_time+17(2) INTO cv_uzeit.
    ELSE.
      CONCATENATE iv_time+0(4)  iv_time+4(2)  iv_time+6(2)  INTO cv_date.
      CONCATENATE iv_time+8(2)  iv_time+10(2) iv_time+12(2) INTO cv_uzeit.
    ENDIF.
  ENDMETHOD.


  METHOD convert_string_to_xstring.
    " Şu anda sisteminde XCO CP dönüşüm sınıfları aktif değil
    " Buraya encoding aktif olduğunda uygun çağrı eklenecek
    rv_xstring = iv_string. " Geçici çözüm (cloud uyumlu değilse string pass)
  ENDMETHOD.


  METHOD get_uuid.
    DATA lv_uuid TYPE sysuuid_c36.
**    cl_system_uuid=>create_uuid_c36_static( RECEIVING uuid = lv_uuid ).
    re_value = lv_uuid.
  ENDMETHOD.


  METHOD convert_unit_measurement.
    DATA lt_units TYPE /mlsft/ed_t_tunitc.
    DATA ls_units LIKE LINE OF lt_units.
    lt_units = /mlsft/cl_ed_util=>get_units( ).
    READ TABLE lt_units INTO ls_units WITH KEY meins = im_value.
    IF sy-subrc = 0.
      re_value = ls_units-isocode.
      RETURN.
    ENDIF.
    READ TABLE lt_units INTO ls_units WITH KEY meins = ''.
    IF sy-subrc = 0.
      re_value = ls_units-isocode.
    ENDIF.
  ENDMETHOD.


  METHOD convert_gib_currency.
    " get_parameter_table henüz tanımlı değil, sabit değer kullanıyoruz
    re_value = 'TRY'.
  ENDMETHOD.


  METHOD auth_check_despatch.
    ex_authorized = abap_true.
  ENDMETHOD.


  METHOD commit_work.
  ENDMETHOD.


  METHOD get_xml_string.
    SELECT SINGLE binary
      FROM /mlsft/ed_raw
      WHERE docnum = @i_docnum
      INTO @re_value.
  ENDMETHOD.


  METHOD add_note_to_delivery.
    r_subrc = 4.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Not supported in ABAP Cloud: XML DOM editing (use ST).' ).
  ENDMETHOD.


  METHOD unzip_user_list.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Not supported in ABAP Cloud: unzip + XML DOM (use ST & HTTP services).' ).
  ENDMETHOD.


  METHOD open_file_dialog.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Not supported in ABAP Cloud: File dialog.' ).
  ENDMETHOD.


  METHOD download_binary.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Not supported in ABAP Cloud: GUI_DOWNLOAD.' ).
  ENDMETHOD.


  METHOD show_xml_formatted.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Not supported in ABAP Cloud: GUI HTML viewer.' ).
  ENDMETHOD.


  METHOD show_xml.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Not supported in ABAP Cloud: GUI HTML viewer.' ).
  ENDMETHOD.


  METHOD show_html.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Not supported in ABAP Cloud: GUI HTML viewer.' ).
  ENDMETHOD.


  METHOD show_html_data.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Not supported in ABAP Cloud: GUI HTML viewer.' ).
  ENDMETHOD.


  METHOD get_number_next.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Not supported in ABAP Cloud: NUMBER_GET_NEXT.' ).
  ENDMETHOD.


  METHOD generate_doc_key.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Not supported in ABAP Cloud: NUMBER_GET_NEXT.' ).
  ENDMETHOD.


  METHOD create_document_key.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Use UUIDs in ABAP Cloud (no dynamic class/FM).' ).
  ENDMETHOD.


  METHOD get_next_number.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Not supported in ABAP Cloud: NUMBER_GET_NEXT (SNRO).' ).
  ENDMETHOD.


  METHOD get_units.
    IF mt_units IS INITIAL.
      SELECT *
        FROM /mlsft/ed_tunitc
        INTO TABLE @mt_units.
    ENDIF.
    rt_units = mt_units.
  ENDMETHOD.
ENDCLASS.
