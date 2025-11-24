CLASS /mlsft/ed_logs DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    CONSTANTS prio_low TYPE /mlsft/ED_CHAR1 VALUE '4'.      "#EC NOTEXT
    CONSTANTS prio_medium TYPE /mlsft/ED_CHAR1 VALUE '3'.   "#EC NOTEXT
    CONSTANTS prio_high TYPE /mlsft/ED_CHAR1 VALUE '2'.     "#EC NOTEXT
    CONSTANTS prio_top TYPE /mlsft/ED_CHAR1 VALUE '1'.      "#EC NOTEXT
    CLASS-DATA mo_object TYPE REF TO /mlsft/ed_logs .
    CONSTANTS mc_object TYPE balobj_d VALUE '/MLSFT/ED'.    "#EC NOTEXT
    CONSTANTS mc_job_subobject TYPE balsubobj VALUE 'JOBS'. "#EC NOTEXT
    CONSTANTS mc_in_subobject TYPE balsubobj VALUE 'IN'.    "#EC NOTEXT
    CONSTANTS mc_logging_subobject TYPE balsubobj VALUE 'LOGGING'. "#EC NOTEXT
    CONSTANTS mc_out_subobject TYPE balsubobj VALUE 'OUT'.  "#EC NOTEXT
    CONSTANTS mc_reply_subobject TYPE balsubobj VALUE 'REPLY'. "#EC NOTEXT
    CONSTANTS mc_delivery_subobject TYPE balsubobj VALUE 'DELIVERY'. "#EC NOTEXT
    TYPES:
      BEGIN OF ty_message,
        type       TYPE string,
        id         TYPE string,
        number     TYPE string,
        message    TYPE string,
        message_v1 TYPE string,
        message_v2 TYPE string,
        message_v3 TYPE string,
        message_v4 TYPE string,
      END OF ty_message,
      ty_t_message TYPE STANDARD TABLE OF ty_message WITH EMPTY KEY.

    DATA mt_bapiret TYPE ty_t_message.

    METHODS add_bapiret2
      IMPORTING
        it_message TYPE ty_t_message.

    METHODS add_bapiret
      IMPORTING
        !is_message TYPE ty_t_message .
    METHODS add_exception
      IMPORTING
        !io_exception TYPE REF TO object .
    METHODS add_message_as_error
      IMPORTING
        !iv_error TYPE string .
    METHODS show_message .
    METHODS add_sy_message .
    METHODS add_single_msg
      IMPORTING
        VALUE(type)        TYPE bapi_mtype OPTIONAL
        VALUE(id)          TYPE symsgid OPTIONAL
        VALUE(number)      TYPE symsgno OPTIONAL
        VALUE(message)     TYPE any OPTIONAL
        VALUE(log_no)      TYPE any OPTIONAL
        VALUE(log_msg_no)  TYPE any OPTIONAL
        VALUE(message_v1)  TYPE any OPTIONAL
        VALUE(message_v2)  TYPE any OPTIONAL
        VALUE(message_v3)  TYPE any OPTIONAL
        VALUE(message_v4)  TYPE any OPTIONAL
      RETURNING
        VALUE(re_bapiret2) TYPE ty_message .
    METHODS delete_messages .
    METHODS get_handle
      RETURNING
        VALUE(rv_handle) TYPE balloghndl .
**  class-methods SHOW_LOGS
**    importing
**      !IT_LOGS type BAL_T_LOGH
**      !IS_PROFILE type BAL_S_PROF .
    METHODS save_logs
      RETURNING
        VALUE(rv_value) TYPE /mlsft/ED_CHAR1  .
    CLASS-METHODS factory
      IMPORTING
        !iv_object       TYPE balobj_d
        !iv_subobject    TYPE balsubobj
        !iv_extnumber    TYPE any OPTIONAL
        !iv_repid        TYPE /mlsft/ed_char20 OPTIONAL
      RETURNING
        VALUE(ro_object) TYPE REF TO /mlsft/ed_logs .
    CLASS-METHODS defactory .
    CLASS-METHODS get_log_hdr
      IMPORTING
        !iv_log_handle TYPE balloghndl
      RETURNING
        VALUE(re_drm)  TYPE /mlsft/ed_char1 .
    CLASS-METHODS save_dsplog_table
      IMPORTING
        !iv_bukrs   TYPE bukrs
        !iv_refdoc  TYPE /mlsft/ed_refdoc
        !iv_reftype TYPE /mlsft/ED_CHAR1 .
    METHODS check_error_log
      RETURNING
        VALUE(rv_error) TYPE /mlsft/ED_CHAR1 .
    METHODS add_message_as_eswi
      IMPORTING
        !iv_error TYPE string
        !iv_type  TYPE bapi_mtype .
    METHODS get_error_log
      RETURNING
        VALUE(rt_bapiret) TYPE ty_message .
    METHODS get_error_logs
      RETURNING
        VALUE(rt_bapiret) TYPE  ty_t_message .
  PROTECTED SECTION.
  PRIVATE SECTION.
*    DATA mt_bapiret TYPE STANDARD TABLE OF bapiret2 WITH EMPTY KEY.
    DATA mv_log_handle TYPE balloghndl .
    DATA mv_default_msgid TYPE symsgid VALUE '/MLSFT/ED'.   "#EC NOTEXT
    CLASS-DATA gv_found TYPE /mlsft/ed_char1 .
    DATA mv_object TYPE balobj_d .
    DATA mv_subobject TYPE balsubobj .
    DATA ms_appl_log TYPE /mlsft/ed_clog .
**  data MV_APPL_LOG_NAME type BALNREXT .
**  data MT_BAPIRET type ty_t_message .
****  data MO_LOG type ref to CL_PTU_MESSAGE .

    METHODS constructor
      IMPORTING
        !iv_object    TYPE balobj_d
        !iv_subobject TYPE balsubobj
        !iv_extnumber TYPE any OPTIONAL
        !iv_repid     TYPE /MLSFT/ed_char20 OPTIONAL .
ENDCLASS.



CLASS /MLSFT/ED_LOGS IMPLEMENTATION.


  METHOD add_bapiret.
    APPEND LINES OF is_message TO mt_bapiret.
  ENDMETHOD.


  METHOD add_bapiret2.
    APPEND LINES OF it_message TO mt_bapiret.
  ENDMETHOD.


  METHOD add_exception.
    DATA lx_root    TYPE REF TO cx_root.
    DATA lv_message TYPE string.
    DATA lv_len     TYPE i.
    DATA lv_off     TYPE i.
    DATA lv_take    TYPE i.
    DATA ls_msg     TYPE ty_message.

    TRY.
        lx_root ?= io_exception.
        lv_message = lx_root->get_text( ).
      CATCH cx_root INTO lx_root.
        lv_message = 'Unknown error occurred'.
    ENDTRY.

    ls_msg-id     = '/MLSFT/ED'.
    ls_msg-number = '000'.
    ls_msg-type   = 'E'.
    ls_msg-message = lv_message.

    lv_len = strlen( lv_message ).

    " V1
    lv_off = 0.
    IF lv_len > lv_off.
      lv_take = lv_len - lv_off.
      IF lv_take > 50. lv_take = 50. ENDIF.
      ls_msg-message_v1 = substring( val = lv_message off = lv_off len = lv_take ).
    ENDIF.

    " V2
    lv_off = 50.
    IF lv_len > lv_off.
      lv_take = lv_len - lv_off.
      IF lv_take > 50. lv_take = 50. ENDIF.
      ls_msg-message_v2 = substring( val = lv_message off = lv_off len = lv_take ).
    ENDIF.

    " V3
    lv_off = 100.
    IF lv_len > lv_off.
      lv_take = lv_len - lv_off.
      IF lv_take > 50. lv_take = 50. ENDIF.
      ls_msg-message_v3 = substring( val = lv_message off = lv_off len = lv_take ).
    ENDIF.

    " V4
    lv_off = 150.
    IF lv_len > lv_off.
      lv_take = lv_len - lv_off.
      IF lv_take > 50. lv_take = 50. ENDIF.
      ls_msg-message_v4 = substring( val = lv_message off = lv_off len = lv_take ).
    ENDIF.

    APPEND ls_msg TO mt_bapiret.
  ENDMETHOD.


  METHOD add_message_as_error.
    DATA ls_msg   TYPE ty_message.
    DATA lv_len   TYPE i.
    DATA lv_off   TYPE i.
    DATA lv_take  TYPE i.

    ls_msg-id      = '/MLSFT/ED'.
    ls_msg-number  = '000'.
    ls_msg-type    = 'E'.
    ls_msg-message = iv_error.

    lv_len = strlen( iv_error ).

    " V1 (0-49)
    lv_off = 0.
    IF lv_len > lv_off.
      lv_take = lv_len - lv_off.
      IF lv_take > 50. lv_take = 50. ENDIF.
      ls_msg-message_v1 = substring( val = iv_error off = lv_off len = lv_take ).
    ENDIF.

    " V2 (50-99)
    lv_off = 50.
    IF lv_len > lv_off.
      lv_take = lv_len - lv_off.
      IF lv_take > 50. lv_take = 50. ENDIF.
      ls_msg-message_v2 = substring( val = iv_error off = lv_off len = lv_take ).
    ENDIF.

    " V3 (100-149)
    lv_off = 100.
    IF lv_len > lv_off.
      lv_take = lv_len - lv_off.
      IF lv_take > 50. lv_take = 50. ENDIF.
      ls_msg-message_v3 = substring( val = iv_error off = lv_off len = lv_take ).
    ENDIF.

    " V4 (150-199)
    lv_off = 150.
    IF lv_len > lv_off.
      lv_take = lv_len - lv_off.
      IF lv_take > 50. lv_take = 50. ENDIF.
      ls_msg-message_v4 = substring( val = iv_error off = lv_off len = lv_take ).
    ENDIF.

    APPEND ls_msg TO mt_bapiret.
  ENDMETHOD.


  METHOD add_single_msg.


    CLEAR re_bapiret2.


**    data:es_msg_handle type line of bal_t_msgh.

    re_bapiret2-type       = type      .
    re_bapiret2-id         = id        .
    re_bapiret2-number     = number    .
    re_bapiret2-message    = message   .
    re_bapiret2-number = log_msg_no.

    IF message IS INITIAL.
      re_bapiret2-message_v1 = message_v1.
      re_bapiret2-message_v2 = message_v2.
      re_bapiret2-message_v3 = message_v3.
      re_bapiret2-message_v4 = message_v4.

    ELSE.
      re_bapiret2-message_v1 =   re_bapiret2-message+0(50).
      re_bapiret2-message_v2 =   re_bapiret2-message+50(50).
      re_bapiret2-message_v3 =   re_bapiret2-message+100(50).
      re_bapiret2-message_v4 =   re_bapiret2-message+150(50).
    ENDIF.
    DATA:iv_type TYPE symsgty,
         iv_text TYPE /mlsft/ED_CHAR200.



    APPEND re_bapiret2 TO mt_bapiret.



  ENDMETHOD.


  METHOD add_sy_message.

    DATA ls_bapiret2 TYPE ty_message.
    ls_bapiret2-type       = sy-msgty .
    ls_bapiret2-id         = sy-msgid .
    ls_bapiret2-number     = sy-msgno   .
    ls_bapiret2-message_v1 = sy-msgv1.
    ls_bapiret2-message_v2 = sy-msgv2..
    ls_bapiret2-message_v3 = sy-msgv3..
    ls_bapiret2-message_v4 = sy-msgv4..




    APPEND ls_bapiret2 TO mt_bapiret.
  ENDMETHOD.


  METHOD check_error_log.
    DATA ls_bapiret TYPE ty_message.
    READ TABLE mt_bapiret INTO ls_bapiret
    WITH KEY type = /MLSFT/ed_constants=>message_error.
    IF sy-subrc IS INITIAL.
      rv_error = abap_true.
    ENDIF.

  ENDMETHOD.


  METHOD constructor.

**    data ls_log type bal_s_log.
**    ls_log-object = iv_object.
**    ls_log-subobject = iv_subobject.
**    ls_log-extnumber = iv_extnumber.
**    ls_log-aldate = sy-datum.
**    ls_log-altime = sy-uzeit.
**    ls_log-aluser = sy-uname.
**    ls_log-altcode = sy-tcode.
**    if iv_repid is not initial.
**      ls_log-alprog = iv_repid.
**    else.
**      ls_log-alprog = sy-repid.
**    endif.
**
**    create object mo_log
**      exporting
**        is_log           = ls_log   " Application Log: Log header data
***       iv_log_handle    =     " Application log: Log handle
***       iv_trace_level   = CL_PTU_CONSTANTS=>GC_TRACE_ADDITIONAL    " Trace Level
***       iv_max_errors    =     " Maximum number of E-messages
***       iv_save_on_abort = 'X'    " Save on Termination
***       iv_display_on_abort = 'X'    " Display on Termination
**      exceptions
**        log_not_valid    = 1
**        handle_not_valid = 2
**        others           = 3.
**    if sy-subrc <> 0.
***     message id sy-msgid type sy-msgty number sy-msgno
***                with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
**    endif.

  ENDMETHOD.


  METHOD defactory.

    IF /MLSFT/ed_logs=>mo_object IS BOUND.
      /MLSFT/ed_logs=>mo_object->save_logs( ).
      CLEAR /MLSFT/ed_logs=>mo_object .
    ENDIF.

  ENDMETHOD.


  METHOD delete_messages.

    CLEAR mt_bapiret.
**    mo_log->delete_messages( ).


  ENDMETHOD.


  METHOD factory.

    IF /MLSFT/ed_logs=>mo_object IS INITIAL.

      DATA lv_prog TYPE /MLSFT/ed_char20.
      lv_prog = '/MLSFT/ED_LOGS'.

      CREATE OBJECT /MLSFT/ed_logs=>mo_object
        EXPORTING
          iv_object    = iv_object
          iv_subobject = iv_subobject
          iv_extnumber = iv_extnumber
          iv_repid     = lv_prog.

    ENDIF.

    ro_object = /MLSFT/ed_logs=>mo_object.

  ENDMETHOD.


  METHOD get_handle .

**    mo_log->get_handle(
**     importing
**        ev_log_handle = rv_handle    " Application log: Log handle
**    ).

  ENDMETHOD.


  METHOD get_log_hdr.
**    data: ls_statistics type bal_s_scnt.
* are there any messages in this log ?
**    call function 'BAL_LOG_HDR_READ'
**      exporting
**        i_log_handle = iv_log_handle
**      importing
**        e_statistics = ls_statistics
**      exceptions
**        others       = 1.

**    if sy-subrc = 0 and ls_statistics-msg_cnt_al > 0.
**      " at least one message
**      re_drm = abap_true.
**    endif.

  ENDMETHOD.


  METHOD save_dsplog_table.
*
    DATA: ls_bapiret2 TYPE bapiret2.
    DATA: ls_logs TYPE /MLSFT/ed_dsplog_sc.
    DATA: lt_logs TYPE /MLSFT/ed_dsplog_tt.

**    loop at mo_object->mt_bapiret into ls_bapiret2.
**
**      add 1 to ls_logs-posnr.
**      ls_logs-bukrs = iv_bukrs.
**      ls_logs-refdoc = iv_refdoc.
**      ls_logs-reftype = iv_reftype.
**      ls_logs-ldate = sy-datum.
**      ls_logs-ltime = sy-uzeit.
**      ls_logs-uname = sy-uname.
**      ls_logs-id = ls_bapiret2-id.
**      ls_logs-msgno = ls_bapiret2-number.
**      ls_logs-message_v1 = ls_bapiret2-message_v1.
**      ls_logs-message_v2 = ls_bapiret2-message_v2.
**      ls_logs-message_v3 = ls_bapiret2-message_v3.
**      ls_logs-message_v4 = ls_bapiret2-message_v4.

**      append ls_logs to lt_logs.

**    endloop.

**    modify /MLSFT/ed_dsplog from table @lt_logs.

  ENDMETHOD.


  METHOD save_logs.

    DATA: ls_system TYPE /MLSFT/ed_system.
**    data: lt_msg_handle type bal_t_msgh.
    ls_system = /MLSFT/ed_select=>get_system_settings( ).

**    mo_log->add_bapiret2_tab(
**      exporting
**        it_bapiret2   = mt_bapiret     " Return Parameters
***        iv_level      = CL_PTU_CONSTANTS=>GC_TRACE_ADDITIONAL    " Trace Level
***        iv_detlevel   = '1'    " Application Log: Level of Detail
***        iv_tag        =     " Indicator
***        iv_check_t100 =     " Checkbox
**      importing
**        et_msg_handle = lt_msg_handle    " Application Log: Message Handle Table
**    ).

    CHECK ls_system-logactive = abap_true.
**    mo_log->save_logs(
**      exporting
**        iv_client         = sy-mandt    " Client
**        iv_save_all       =  abap_true   " Save all log
**    ).
    IF sy-subrc <> 0.
      rv_value = abap_true.
    ENDIF.




  ENDMETHOD.


  METHOD add_message_as_eswi.

    DATA ls_bapiret TYPE ty_message.

    ls_bapiret-message = iv_error.
    ls_bapiret-message_v1 = ls_bapiret-message+0(50).
    ls_bapiret-message_v2 = ls_bapiret-message+51(50).
    ls_bapiret-message_v3 = ls_bapiret-message+101(50).
    ls_bapiret-message_v4 = ls_bapiret-message+151(50).
    ls_bapiret-id =  '/MLSFT/ED'.
    ls_bapiret-number = '000'.

    IF iv_type IS NOT INITIAL.
      ls_bapiret-type = iv_type.
    ELSE.
      ls_bapiret-type = 'E'.
    ENDIF.
    APPEND ls_bapiret TO mt_bapiret.

  ENDMETHOD.


  METHOD get_error_log.
    READ TABLE mt_bapiret
         INTO rt_bapiret
         WITH KEY type = /mlsft/ed_constants=>message_error.
  ENDMETHOD.


  METHOD get_error_logs.
    APPEND LINES OF mt_bapiret TO rt_bapiret.
  ENDMETHOD.


  METHOD show_message.

**    mo_log->add_bapiret2_tab(
**      exporting
**        it_bapiret2   =  mt_bapiret   " Return Parameters
**    ).

**    mo_log->display_log(
**  exporting
**     iv_title            = 'Application Log'    " Application Log: Screen Title
**    ).

  ENDMETHOD.
ENDCLASS.
