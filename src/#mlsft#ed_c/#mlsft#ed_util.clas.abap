CLASS /mlsft/ed_util DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
*-- Cloud-uyumlu ham veri tipleri
    TYPES: BEGIN OF xline,
             line TYPE x LENGTH 4096,
           END OF xline.
    TYPES xlinetab TYPE STANDARD TABLE OF xline WITH EMPTY KEY.

    TYPES: BEGIN OF ty_file,
             name TYPE string,
             date TYPE d,
             time TYPE t,
             size TYPE i,
             data TYPE xstring,
           END OF ty_file.
    TYPES tty_files TYPE STANDARD TABLE OF ty_file WITH EMPTY KEY.

*-- Fatura/irsaliye okuma opsiyonları (Invoice)
    TYPES: BEGIN OF z_lbbil_print_data_to_read,
             hd_gen          TYPE abap_bool,
             hd_adr          TYPE abap_bool,
             hd_gen_descript TYPE abap_bool,
             hd_org          TYPE abap_bool,
             hd_part_add     TYPE abap_bool,
             hd_kond         TYPE abap_bool,
             hd_fin          TYPE abap_bool,
             hd_ref          TYPE abap_bool,
             hd_tech         TYPE abap_bool,
             it_gen          TYPE abap_bool,
             it_adr          TYPE abap_bool,
             it_price        TYPE abap_bool,
             it_kond         TYPE abap_bool,
             it_ref          TYPE abap_bool,
             it_refdlv       TYPE abap_bool,
             it_reford       TYPE abap_bool,
             it_refpurord    TYPE abap_bool,
             it_refvag       TYPE abap_bool,
             it_refvg2       TYPE abap_bool,
             it_refvkt       TYPE abap_bool,
             it_tech         TYPE abap_bool,
             it_fin          TYPE abap_bool,
             it_confitm      TYPE abap_bool,
             it_confbatch    TYPE abap_bool,
             msr_hd          TYPE abap_bool,
             msr_it          TYPE abap_bool,
           END OF z_lbbil_print_data_to_read.

*-- Teslimat okuma opsiyonları (Delivery)
    TYPES: BEGIN OF ty_dlv_print_opts,
             hd_gen          TYPE abap_bool,
             hd_adr          TYPE abap_bool,
             hd_gen_descript TYPE abap_bool,
             hd_org          TYPE abap_bool,
             hd_org_adr      TYPE abap_bool,
             hd_org_descript TYPE abap_bool,
             hd_part_add     TYPE abap_bool,
             hd_fin          TYPE abap_bool,
             hd_ft           TYPE abap_bool,
             hd_ft_descript  TYPE abap_bool,
             hd_ref          TYPE abap_bool,
             hd_sched        TYPE abap_bool,
             hd_tech         TYPE abap_bool,
             it_gen          TYPE abap_bool,
             it_gen_descript TYPE abap_bool,
             it_org          TYPE abap_bool,
             it_org_descript TYPE abap_bool,
             it_fin          TYPE abap_bool,
             it_ft           TYPE abap_bool,
             it_ft_descript  TYPE abap_bool,
             it_ref          TYPE abap_bool,
             it_reford       TYPE abap_bool,
             it_refpurord    TYPE abap_bool,
             it_sched        TYPE abap_bool,
             it_tech         TYPE abap_bool,
             it_serno        TYPE abap_bool,
             it_confitm      TYPE abap_bool,
             it_confbatch    TYPE abap_bool,
             it_qm           TYPE abap_bool,
           END OF ty_dlv_print_opts.

*-- XSLT satırları için yerel tip (string tablosu)
    TYPES: BEGIN OF ty_pageline,
             line TYPE string,
           END OF ty_pageline.
    TYPES ty_pageline_table TYPE STANDARD TABLE OF ty_pageline WITH EMPTY KEY.

*-- (BAL yasak) -> Sembolik sabitler
    CLASS-DATA mc_log_out TYPE string VALUE 'OUT'.      " #EC NOTEXT
    CLASS-DATA mc_in      TYPE string VALUE 'IN'.       " Gelen irsaliye log
    CLASS-DATA mc_reply   TYPE string VALUE 'REPLY'.    " Yanıt log
    CLASS-DATA mc_gen     TYPE string VALUE 'GEN'.      " Genel log
    CLASS-DATA mc_logging TYPE string VALUE 'LOGGING'.  " Çıkış log

*-- Ortam sabitleri (örnek)
    CLASS-DATA mc_dtp    TYPE /mlsft/ed_entg VALUE 'D'. " #EC NOTEXT
    CLASS-DATA mc_server TYPE /mlsft/ed_entg VALUE 'S'.
    CLASS-DATA mc_ftp    TYPE /mlsft/ed_entg VALUE 'F'.
    CLASS-DATA mc_idoc   TYPE /mlsft/ed_entg VALUE 'I'.

    CLASS-METHODS class_constructor.

*-- Zaman farkı
    CLASS-METHODS get_time_delay
      IMPORTING
        iv_bukrs TYPE bukrs
      CHANGING
        cv_date  TYPE datum
        cv_time  TYPE uzeit
      RAISING
        /mlsft/cx_ed_exception.

*-- LE teslimat okuma opsiyonları
    CLASS-METHODS get_data_read_options
      RETURNING VALUE(r_value) TYPE ty_dlv_print_opts.

    CLASS-METHODS get_data_read_options_invoice
      RETURNING VALUE(r_value) TYPE z_lbbil_print_data_to_read.

*-- Dosya seçimi (GUI yasak) -> placeholder
    CLASS-METHODS open_file_dialog
      RETURNING VALUE(rv_filename) TYPE string
      RAISING   /mlsft/cx_ed_exception.

*-- XSLT hazırlama (runtime XSLT yasak) -> placeholder
    CLASS-METHODS set_transformation
      IMPORTING
        iv_xxslt            TYPE xstring
        ir_processor        TYPE REF TO object         " placeholder
        ir_cl_streamfactory TYPE REF TO object         " placeholder
        iv_encoding         TYPE REF TO object         " placeholder
        iv_filename         TYPE /mlsft/ed_char50
      RETURNING VALUE(rv_result)    TYPE progname.

*-- Numara üretim
    CLASS-METHODS get_number_next
      RETURNING VALUE(r_value) TYPE /mlsft/ed_ewaybill .

    CLASS-METHODS generate_doc_key
      RETURNING VALUE(r_value) TYPE /mlsft/ed_ewaybill.

*-- Biçim dönüşümleri
    CLASS-METHODS convert_to_gib_date
      IMPORTING iv_date         TYPE datum
      RETURNING VALUE(rv_value) TYPE string.

    CLASS-METHODS convert_xsddatetime_to_sap
      IMPORTING
        iv_time  TYPE xsddatetime_iso
      CHANGING
        cv_date  TYPE datum
        cv_uzeit TYPE uzeit OPTIONAL.

    CLASS-METHODS convert_sap_to_xsddatetime
      IMPORTING
        iv_date        TYPE datum
        iv_uzeit       TYPE uzeit
      RETURNING VALUE(rv_time) TYPE xsddatetime_iso.

    CLASS-METHODS convert_xsddatetime_frm_str
      IMPORTING iv_time  TYPE string
      CHANGING
        cv_date  TYPE datum OPTIONAL
        cv_uzeit TYPE uzeit OPTIONAL.

    CLASS-METHODS convert_string_to_xstring
      IMPORTING iv_string         TYPE string
      RETURNING VALUE(rv_xstring) TYPE xstring.

    CLASS-METHODS convert_to_gib_time
      IMPORTING iv_time         TYPE uzeit
      RETURNING VALUE(rv_value) TYPE string.

    CLASS-METHODS convert_unit_measurement
      IMPORTING im_value        TYPE any OPTIONAL
      RETURNING VALUE(re_value) TYPE string.

    CLASS-METHODS xslt_lines_code_64
      IMPORTING
        im_lines         TYPE /mlsft/ed_tt_o2pageline OPTIONAL
        im_xsltname      TYPE /mlsft/ed_char40       OPTIONAL
      RETURNING VALUE(ex_string) TYPE string.

    CLASS-METHODS convert_gib_currency
      IMPORTING im_value        TYPE any OPTIONAL
      RETURNING VALUE(re_value) TYPE string.

    CLASS-METHODS get_uuid
      RETURNING VALUE(re_value) TYPE sysuuid_c36
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS update_log_frm_exception
      IMPORTING
        ir_excp TYPE REF TO cx_static_check OPTIONAL
        iv_type TYPE string OPTIONAL.

    CLASS-METHODS auth_check_despatch
      IMPORTING
        im_object            TYPE /mlsft/ed_char10 "xuobject
        im_bukrs             TYPE bukrs
        im_actvt             TYPE /mlsft/ed_char2
        im_showmessage       TYPE abap_bool DEFAULT abap_true
        im_type              TYPE msgty      DEFAULT 'E'
        im_msgnumber         TYPE /mlsft/ed_char3 OPTIONAL
      RETURNING VALUE(ex_authorized) TYPE /mlsft/ed_char1.

    CLASS-METHODS create_document_key
      RETURNING VALUE(rv_uuid) TYPE /mlsft/ed_guid
      RAISING
        /mlsft/cx_ed_delivery
        /mlsft/cx_ex_delivery.

*-- XML gösterim – Cloud’da GUI yok, placeholder
    CLASS-METHODS show_xml_formatted
      IMPORTING
        i_xinvoice TYPE xstring
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS show_xml
      IMPORTING
        iv_xml TYPE xstring
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS generate_html
      IMPORTING iv_xml TYPE xstring.

    CLASS-METHODS show_html
      IMPORTING
        iv_xml TYPE xstring
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS get_next_number
      IMPORTING
        iv_gjahr        TYPE gjahr
        iv_nrange       TYPE /mlsft/ed_char2
        iv_bukrs        TYPE bukrs
        iv_object       TYPE /mlsft/ed_char10
      RETURNING VALUE(rv_value) TYPE char9
      RAISING   /mlsft/cx_ed_exception .

    CLASS-METHODS unzip_user_list
      IMPORTING
        iv_binary         TYPE xstring
        iv_entry_name     TYPE string OPTIONAL
      RETURNING
        VALUE(rt_taxlist) TYPE /mlsft/ed_tt_vkn
      RAISING
        /mlsft/cx_ed_exception.

    CLASS-METHODS commit_work
      RAISING /mlsft/cx_ed_exception.

    CLASS-METHODS add_note_to_delivery
      IMPORTING
        i_docnum       TYPE /mlsft/ed_guid
        i_note         TYPE string
      RETURNING VALUE(r_subrc) TYPE sy-subrc.

    CLASS-METHODS get_xml_string
      IMPORTING i_docnum        TYPE /mlsft/ed_guid
      RETURNING VALUE(re_value) TYPE xstring.

    CLASS-METHODS show_html_data
      IMPORTING
        it_data TYPE xlinetab
        iv_type TYPE /mlsft/ed_char10.

    CLASS-METHODS get_xslt_lines
      IMPORTING im_xsltname     TYPE /mlsft/ed_char40
      RETURNING VALUE(re_table) TYPE /mlsft/ed_tt_o2pageline.

    CLASS-METHODS get_html
      IMPORTING iv_xml           TYPE xstring
      RETURNING VALUE(re_return) TYPE xstring
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS update_xml_date_fields
      IMPORTING
        i_docnum       TYPE /mlsft/ed_guid
        i_load_date    TYPE datum
        i_load_time    TYPE uzeit
      RETURNING VALUE(r_subrc) TYPE sy-subrc.

    CLASS-METHODS get_today_date RETURNING VALUE(rv_date) TYPE d.
    CLASS-METHODS get_now_time   RETURNING VALUE(rv_time) TYPE t.

    CLASS-METHODS timestamp_plusminus
      IMPORTING
        iv_startdate  TYPE datum
        iv_startime   TYPE uzeit
        iv_seconds    TYPE int4
      CHANGING
        cv_resultdate TYPE datum
        cv_resultime  TYPE uzeit
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS chart_to_num
      IMPORTING iv_char   TYPE /mlsft/ed_dparam_value
      EXPORTING rv_second TYPE int4
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS get_system_timezone
      RETURNING VALUE(rv_timezone) TYPE string.

    CLASS-METHODS get_country_timezone
      IMPORTING iv_country         TYPE land1
      RETURNING VALUE(rv_timezone) TYPE string.

    CLASS-METHODS sample
      IMPORTING
        iv_param1 TYPE /mlsft/ed_char1 OPTIONAL
        iv_param2 TYPE /mlsft/ed_char1 OPTIONAL
        iv_param  TYPE REF TO data OPTIONAL.

    CLASS-METHODS convert_isodatetime_local
      IMPORTING im_isodate TYPE xsddatetime_iso
      EXPORTING
        ex_time    TYPE uzeit
        ex_date    TYPE datum.

    CLASS-METHODS add_sei_note_to_delivery
      IMPORTING
        i_docnum       TYPE /mlsft/ed_guid
        i_note         TYPE string
      RETURNING VALUE(r_subrc) TYPE sy-subrc.

    CLASS-METHODS add_ger_note_to_delivery
      IMPORTING
        i_docnum       TYPE /mlsft/ed_guid
        i_note         TYPE string
      RETURNING VALUE(r_subrc) TYPE sy-subrc.

    CLASS-METHODS convert_gib_to_sap_currency
      IMPORTING im_value        TYPE string OPTIONAL
      RETURNING VALUE(re_value) TYPE waers.

    CLASS-METHODS convert_gib_to_sap_date
      IMPORTING im_value        TYPE string OPTIONAL
      RETURNING VALUE(re_value) TYPE datum.

    CLASS-METHODS convert_unit_measure_for_land
      IMPORTING
        iv_land1        TYPE land1 OPTIONAL
        im_value        TYPE any   OPTIONAL
      RETURNING VALUE(re_value) TYPE string.

    CLASS-METHODS show_message_in_html
      IMPORTING
        iv_message TYPE string OPTIONAL
        iv_header  TYPE string OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /MLSFT/ED_UTIL IMPLEMENTATION.


  METHOD class_constructor.
  ENDMETHOD.


  METHOD get_uuid.
    TRY.
        re_value = cl_system_uuid=>create_uuid_c36_static( ).
      CATCH cx_uuid_error.
        RAISE EXCEPTION TYPE /mlsft/cx_ed_exception.
    ENDTRY.
  ENDMETHOD.


  METHOD convert_to_gib_date.
    rv_value = |{ iv_date+0(4) }-{ iv_date+4(2) }-{ iv_date+6(2) }|.
  ENDMETHOD.


  METHOD convert_to_gib_time.
    rv_value = |{ iv_time+0(2) }:{ iv_time+2(2) }:{ iv_time+4(2) }|.
  ENDMETHOD.


  METHOD convert_string_to_xstring.
    DATA(lo_conv) = cl_abap_conv_codepage=>create_out( ).
    rv_xstring = lo_conv->convert( iv_string ).
  ENDMETHOD.


  METHOD convert_xsddatetime_frm_str.
    IF strlen( iv_time ) > 14.
      CONCATENATE iv_time+0(4) iv_time+5(2) iv_time+8(2) INTO cv_date.
      CONCATENATE iv_time+11(2) iv_time+14(2) iv_time+17(2) INTO cv_uzeit.
    ELSE.
      CONCATENATE iv_time+0(4) iv_time+4(2) iv_time+6(2) INTO cv_date.
      CONCATENATE iv_time+8(2) iv_time+10(2) iv_time+12(2) INTO cv_uzeit.
    ENDIF.
  ENDMETHOD.


  METHOD convert_sap_to_xsddatetime.
    rv_time = |{ iv_date+0(4) }-{ iv_date+4(2) }-{ iv_date+6(2) }T{ iv_uzeit+0(2) }:{ iv_uzeit+2(2) }:{ iv_uzeit+4(2) }|.
  ENDMETHOD.


  METHOD convert_xsddatetime_to_sap.
    DATA(lv) = iv_time.
    IF lv CS 'T'.
      cv_date  = |{ lv(4) }{ lv+5(2) }{ lv+8(2) }|.
      cv_uzeit = |{ lv+11(2) }{ lv+14(2) }{ lv+17(2) }|.
    ENDIF.
  ENDMETHOD.


  METHOD get_system_timezone.
    TRY.
        rv_timezone = cl_abap_context_info=>get_user_time_zone( ).
      CATCH cx_abap_context_info_error.
        rv_timezone = 'UTC'.
    ENDTRY.
  ENDMETHOD.


  METHOD get_country_timezone.
    TRY.
        " Basit yaklaşım: kullanıcı TZ; gerekiyorsa ülkeye göre mapping tablo ekleyin
        rv_timezone = cl_abap_context_info=>get_user_time_zone( ).
      CATCH cx_abap_context_info_error.
        rv_timezone = 'UTC'.
    ENDTRY.
  ENDMETHOD.


  METHOD get_time_delay.
    cv_date = cl_abap_context_info=>get_system_date( ).
    cv_time = cl_abap_context_info=>get_system_time( ).
  ENDMETHOD.


  METHOD auth_check_despatch.
    ex_authorized = abap_true.
  ENDMETHOD.


  METHOD get_xml_string.
    DATA(lv_data) = VALUE xstring( ).
    SELECT SINGLE binary FROM /mlsft/ed_raw
      WHERE docnum = @i_docnum
      INTO @lv_data.
    re_value = lv_data.
  ENDMETHOD.


  METHOD add_note_to_delivery.
    r_subrc = 0.
    DATA(xml) = get_xml_string( i_docnum = i_docnum ).
    IF xml IS INITIAL OR i_note IS INITIAL.
      RETURN.
    ENDIF.

    DATA(xml_str) = cl_abap_conv_codepage=>create_in( )->convert( xml ).
    REPLACE FIRST OCCURRENCE OF '</DespatchAdvice>' IN xml_str
      WITH |<cbc:Note>{ i_note }</cbc:Note></DespatchAdvice>|.
    xml = cl_abap_conv_codepage=>create_out( )->convert( xml_str ).

    DATA(lv_len) = xstrlen( xml ).
    UPDATE /mlsft/ed_raw
      SET binary = @xml,
          docs   = @lv_len
      WHERE docnum = @i_docnum.
    IF sy-subrc <> 0.
      r_subrc = 4.
    ENDIF.
  ENDMETHOD.


  METHOD add_sei_note_to_delivery.
    r_subrc = add_note_to_delivery( i_docnum = i_docnum i_note = i_note ).
  ENDMETHOD.


  METHOD add_ger_note_to_delivery.
    r_subrc = add_note_to_delivery( i_docnum = i_docnum i_note = i_note ).
  ENDMETHOD.


  METHOD commit_work.
    RETURN.
  ENDMETHOD.


  METHOD convert_gib_currency.
    IF im_value IS INITIAL.
      re_value = 'TRY'.
    ELSE.
      re_value = CONV string( im_value ).
    ENDIF.
  ENDMETHOD.


  METHOD convert_gib_to_sap_currency.
    re_value = COND waers( WHEN im_value IS INITIAL THEN 'TRY' ELSE im_value ).
  ENDMETHOD.


  METHOD convert_gib_to_sap_date.
    IF im_value IS INITIAL.
      RETURN.
    ENDIF.
    re_value = |{ im_value(4) }{ im_value+5(2) }{ im_value+8(2) }|.
  ENDMETHOD.


  METHOD convert_unit_measurement.
    re_value = CONV string( im_value ).
  ENDMETHOD.


  METHOD convert_unit_measure_for_land.
    re_value = CONV string( im_value ).
  ENDMETHOD.


  METHOD chart_to_num.
    TRY.
        rv_second = CONV int4( iv_char ).
      CATCH cx_sy_conversion_no_number.
        RAISE EXCEPTION TYPE /mlsft/cx_ed_exception.
    ENDTRY.
  ENDMETHOD.


  METHOD get_today_date.
    rv_date = cl_abap_context_info=>get_system_date( ).
  ENDMETHOD.


  METHOD get_now_time.
    rv_time = cl_abap_context_info=>get_system_time( ).
  ENDMETHOD.


  METHOD timestamp_plusminus.
    DATA: lv_h      TYPE i,
          lv_m      TYPE i,
          lv_s      TYPE i,
          lv_total  TYPE i,
          lv_days   TYPE i,
          lv_rest   TYPE i,
          lv_time_s TYPE string.

    lv_h = iv_startime+0(2).
    lv_m = iv_startime+2(2).
    lv_s = iv_startime+4(2).
    lv_total = lv_h * 3600 + lv_m * 60 + lv_s.
    lv_total = lv_total + iv_seconds.

    IF lv_total >= 0.
      lv_days = lv_total DIV 86400.
      lv_rest = lv_total MOD 86400.
    ELSE.
      lv_days = - ( ( - lv_total + 86399 ) DIV 86400 ).
      lv_rest = lv_total - lv_days * 86400.
    ENDIF.

    cv_resultdate = iv_startdate + lv_days.

    lv_h    = lv_rest DIV 3600.
    lv_rest = lv_rest MOD 3600.
    lv_m    = lv_rest DIV 60.
    lv_s    = lv_rest MOD 60.

    lv_time_s   = |{ lv_h WIDTH = 2 PAD = '0' ALIGN = RIGHT }{ lv_m WIDTH = 2 PAD = '0' ALIGN = RIGHT }{ lv_s WIDTH = 2 PAD = '0' ALIGN = RIGHT }|.
    cv_resultime = lv_time_s.
  ENDMETHOD.


  METHOD get_next_number.
    " NUMBER_GET_NEXT yasak — kendi NR tablonuza göre uyarlayın (placeholder)
  ENDMETHOD.


  METHOD unzip_user_list.
    DATA lo_zip        TYPE REF TO cl_abap_zip.
    DATA lv_content    TYPE xstring.
    DATA lv_found      TYPE abap_bool VALUE abap_false.
    DATA lt_candidates TYPE STANDARD TABLE OF string WITH EMPTY KEY.

    TRY.
        lo_zip = NEW cl_abap_zip( ).
        lo_zip->load( zip = iv_binary ).

        IF iv_entry_name IS NOT INITIAL.
          APPEND iv_entry_name TO lt_candidates.
        ELSE.
          lt_candidates = VALUE #( ( `data.xml` )
                                   ( `content.xml` )
                                   ( `document.xml` )
                                   ( `taxlist.xml` )
                                   ( `invoice.xml` ) ).
        ENDIF.

        LOOP AT lt_candidates INTO DATA(lv_name).
          TRY.
              lo_zip->get(
                EXPORTING
                  name    = lv_name
                IMPORTING
                  content = lv_content ).
              lv_found = abap_true.
              EXIT.
            CATCH cx_root.
          ENDTRY.
        ENDLOOP.

        IF lv_found = abap_false.
          RAISE EXCEPTION TYPE /mlsft/cx_ed_exception.
        ENDIF.

        " TODO: lv_content (XML) parse edilerek rt_taxlist doldurulacak
        rt_taxlist = VALUE #( ).

      CATCH cx_root.
        RAISE EXCEPTION TYPE /mlsft/cx_ed_exception.
    ENDTRY.
  ENDMETHOD.


  METHOD get_data_read_options.
    r_value = VALUE ty_dlv_print_opts(
                 hd_gen          = abap_true
                 hd_adr          = abap_true
                 hd_gen_descript = abap_true
                 hd_org          = abap_true
                 hd_org_adr      = abap_true
                 hd_org_descript = abap_true
                 hd_part_add     = abap_true
                 hd_fin          = abap_true
                 hd_ft           = abap_true
                 hd_ft_descript  = abap_true
                 hd_ref          = abap_true
                 hd_sched        = abap_true
                 hd_tech         = abap_true
                 it_gen          = abap_true
                 it_gen_descript = abap_true
                 it_org          = abap_true
                 it_org_descript = abap_true
                 it_fin          = abap_true
                 it_ft           = abap_true
                 it_ft_descript  = abap_true
                 it_ref          = abap_true
                 it_reford       = abap_true
                 it_refpurord    = abap_true
                 it_sched        = abap_true
                 it_tech         = abap_true
                 it_serno        = abap_true
                 it_confitm      = abap_true
                 it_confbatch    = abap_true
                 it_qm           = abap_true ).
  ENDMETHOD.


  METHOD get_data_read_options_invoice.
    r_value = VALUE #( ).
    ASSIGN COMPONENT 1 OF STRUCTURE r_value TO FIELD-SYMBOL(<fs>).
    WHILE sy-subrc = 0.
      <fs> = abap_true.
      ASSIGN COMPONENT sy-tabix + 1 OF STRUCTURE r_value TO <fs>.
    ENDWHILE.
  ENDMETHOD.


  METHOD open_file_dialog.
    RAISE EXCEPTION TYPE /mlsft/cx_ed_exception.
  ENDMETHOD.


  METHOD set_transformation.
    rv_result = ''.
  ENDMETHOD.


  METHOD show_xml_formatted.
    RAISE EXCEPTION TYPE /mlsft/cx_ed_exception.
  ENDMETHOD.


  METHOD show_xml.
    RAISE EXCEPTION TYPE /mlsft/cx_ed_exception.
  ENDMETHOD.


  METHOD generate_html.
    RETURN.
  ENDMETHOD.


  METHOD show_html.
    RAISE EXCEPTION TYPE /mlsft/cx_ed_exception.
  ENDMETHOD.


  METHOD show_html_data.
    RETURN.
  ENDMETHOD.


  METHOD get_xslt_lines.
    re_table = VALUE #( ).
  ENDMETHOD.


METHOD xslt_lines_code_64.
  DATA lv_str TYPE string.

  IF im_lines IS SUPPLIED AND im_lines IS NOT INITIAL.
    FIELD-SYMBOLS: <lref> TYPE REF TO /mlsft/ed_s_o2pageline,
                   <ls>   TYPE /mlsft/ed_s_o2pageline.

    LOOP AT im_lines ASSIGNING <lref>.
      CHECK <lref> IS BOUND.
      ASSIGN <lref>->* TO <ls>.
      CHECK sy-subrc = 0.

      DATA(lv_piece) = CONV string( <ls>-line ).

      IF lv_str IS INITIAL.
        lv_str = lv_piece.
      ELSE.
        lv_str = |{ lv_str }{ cl_abap_char_utilities=>cr_lf }{ lv_piece }|.
      ENDIF.
    ENDLOOP.
  ENDIF.

  " string -> xstring
  DATA(lv_x) = convert_string_to_xstring( lv_str ).

  " xstring -> Base64 (ABAP Cloud: CL_WEB_HTTP_UTILITY kullan)
  DATA(lv_b64) = cl_web_http_utility=>encode_x_base64( lv_x ).

  ex_string = lv_b64.
ENDMETHOD.


  METHOD get_html.
    RAISE EXCEPTION TYPE /mlsft/cx_ed_exception.
  ENDMETHOD.


  METHOD update_xml_date_fields.
    r_subrc = 0.
  ENDMETHOD.


  METHOD update_log_frm_exception.
    RETURN.
  ENDMETHOD.


  METHOD get_number_next.
  ENDMETHOD.


  METHOD generate_doc_key.
  ENDMETHOD.


  METHOD create_document_key.
    rv_uuid = get_uuid( ).
  ENDMETHOD.


  METHOD sample.
  ENDMETHOD.


  METHOD convert_isodatetime_local.
    ex_time+0(2) = im_isodate+11(2).
    ex_time+2(2) = im_isodate+14(2).
    ex_time+4(2) = im_isodate+16(2).
    ex_date+0(4) = im_isodate+0(4).
    ex_date+4(2) = im_isodate+5(2).
    ex_date+6(2) = im_isodate+8(2).
  ENDMETHOD.


  METHOD show_message_in_html.
    RETURN.
  ENDMETHOD.
ENDCLASS.
