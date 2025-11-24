CLASS /mlsft/exceltosap DEFINITION
  PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_abap_behv_message.

    TYPES: BEGIN OF ty_result,
             inserted TYPE i,
             deleted  TYPE i,
             table    TYPE string,
           END OF ty_result.

    CLASS-METHODS import_xlsx
      IMPORTING
        !iv_table_name TYPE string
        !ix_xlsx       TYPE xstring
        !iv_sheet_name TYPE string OPTIONAL
        !iv_truncate   TYPE abap_bool DEFAULT abap_false
      RETURNING VALUE(rs_result) TYPE ty_result
      RAISING   cx_static_check.

    CLASS-METHODS import_csv_string
      IMPORTING
        !iv_table_name TYPE string
        !iv_csv        TYPE string
        !iv_delim      TYPE string OPTIONAL
        !iv_truncate   TYPE abap_bool DEFAULT abap_false
      RETURNING VALUE(rs_result) TYPE ty_result
      RAISING   cx_static_check.

  PRIVATE SECTION.
    TYPES ty_t_string TYPE STANDARD TABLE OF string WITH EMPTY KEY.

    CLASS-METHODS detect_delim
      IMPORTING iv_header TYPE string
      RETURNING VALUE(rv) TYPE string.

    CLASS-METHODS split_csv_line
      IMPORTING iv_line  TYPE string
                iv_delim TYPE string
      RETURNING VALUE(rt) TYPE ty_t_string.

ENDCLASS.



CLASS /MLSFT/EXCELTOSAP IMPLEMENTATION.


  METHOD import_xlsx.
    RAISE EXCEPTION NEW /mlsft/cx_exceltosap(
      text = |XLSX cannot be parsed in this ABAP Cloud system (no permitted UTF-8/XML APIs). Use IMPORT_CSV_STRING instead.| ).
  ENDMETHOD.


  METHOD import_csv_string.
    rs_result-table = iv_table_name.

    DATA(lv_up) = to_upper( iv_table_name ).
    IF lv_up IS INITIAL OR ( lv_up(1) <> 'Z' AND lv_up(1) <> 'Y' ).
      RAISE EXCEPTION NEW /mlsft/cx_exceltosap( text = |Only custom Z/Y tables allowed in ABAP Cloud| ).
    ENDIF.

    DATA(lo_type) = cl_abap_typedescr=>describe_by_name( lv_up ).
    IF lo_type IS NOT BOUND OR lo_type->type_kind <> cl_abap_typedescr=>typekind_table.
      RAISE EXCEPTION NEW /mlsft/cx_exceltosap( text = |Target is not a table type| ).
    ENDIF.
    DATA(lo_tab)  = CAST cl_abap_tabledescr( lo_type ).
    DATA(lo_line) = CAST cl_abap_structdescr( lo_tab->get_table_line_type( ) ).

    FIELD-SYMBOLS <lt_data> TYPE STANDARD TABLE.
    DATA lr_data TYPE REF TO data.
    CREATE DATA lr_data TYPE HANDLE lo_tab.
    ASSIGN lr_data->* TO <lt_data>.

    DATA lt_components TYPE STANDARD TABLE OF cl_abap_structdescr=>component WITH EMPTY KEY.
    lt_components = lo_line->get_components( ).
    SORT lt_components BY name.

    DATA lt_lines TYPE ty_t_string.
    SPLIT iv_csv AT cl_abap_char_utilities=>newline INTO TABLE lt_lines.
    DELETE lt_lines WHERE table_line IS INITIAL.
    IF lt_lines IS INITIAL.
      RETURN.
    ENDIF.

    DATA(lv_header) = lt_lines[ 1 ].
    DATA(lv_delim)  = COND string( WHEN iv_delim IS NOT INITIAL THEN iv_delim ELSE detect_delim( lv_header ) ).

    TYPES: BEGIN OF ty_map,
             idx       TYPE i,
             fieldname TYPE string,
           END OF ty_map.
    DATA lt_map TYPE STANDARD TABLE OF ty_map WITH EMPTY KEY.

    DATA lt_hdr_cells TYPE ty_t_string.
    lt_hdr_cells = split_csv_line( iv_line = lv_header iv_delim = lv_delim ).

    LOOP AT lt_hdr_cells ASSIGNING FIELD-SYMBOL(<h>).
      DATA(lv_col) = to_upper( condense( <h> ) ).
      IF lv_col IS INITIAL. CONTINUE. ENDIF.
      READ TABLE lt_components ASSIGNING FIELD-SYMBOL(<comp>) WITH KEY name = lv_col BINARY SEARCH.
      IF sy-subrc = 0.
        APPEND VALUE ty_map( idx = sy-tabix fieldname = <comp>-name ) TO lt_map.
      ENDIF.
    ENDLOOP.
    IF lt_map IS INITIAL.
      RAISE EXCEPTION NEW /mlsft/cx_exceltosap( text = |No matching column headers found| ).
    ENDIF.

    FIELD-SYMBOLS <ls_line> TYPE any.
    DATA lr_line TYPE REF TO data.
    CREATE DATA lr_line TYPE HANDLE lo_line.
    ASSIGN lr_line->* TO <ls_line>.

    LOOP AT lt_lines ASSIGNING FIELD-SYMBOL(<line>) FROM 2.
      DATA lt_cells TYPE ty_t_string.
      lt_cells = split_csv_line( iv_line = <line> iv_delim = lv_delim ).
      IF lt_cells IS INITIAL.
        CONTINUE.
      ENDIF.

      CLEAR <ls_line>.
      LOOP AT lt_map ASSIGNING FIELD-SYMBOL(<m>).
        DATA(lv_val) = ||.
        READ TABLE lt_cells INDEX <m>-idx INTO lv_val.
        IF sy-subrc <> 0. CONTINUE. ENDIF.

        FIND REGEX '^\s*\d{4}[-/]\d{2}[-/]\d{2}\s*$' IN lv_val MATCH COUNT DATA(mc_date).
        IF mc_date > 0.
          REPLACE ALL OCCURRENCES OF '-' IN lv_val WITH ''.
          REPLACE ALL OCCURRENCES OF '/' IN lv_val WITH ''.
          CONDENSE lv_val NO-GAPS.
        ELSE.
          FIND REGEX '^\s*\d{2}:\d{2}(:\d{2})?\s*$' IN lv_val MATCH COUNT DATA(mc_time).
          IF mc_time > 0.
            REPLACE ALL OCCURRENCES OF ':' IN lv_val WITH ''.
            CONDENSE lv_val NO-GAPS.
            IF strlen( lv_val ) = 4.
              lv_val = |{ lv_val }00|.
            ENDIF.
          ELSE.
            FIND REGEX '^\s*[\+\-]?\d+(?:[.,]\d+)?\s*$' IN lv_val MATCH COUNT DATA(mc_num).
            IF mc_num > 0.
              REPLACE ALL OCCURRENCES OF ',' IN lv_val WITH '.'.
              CONDENSE lv_val NO-GAPS.
            ENDIF.
          ENDIF.
        ENDIF.

        ASSIGN COMPONENT <m>-fieldname OF STRUCTURE <ls_line> TO FIELD-SYMBOL(<f>).
        IF sy-subrc <> 0. CONTINUE. ENDIF.
        <f> = lv_val.
      ENDLOOP.

      APPEND <ls_line> TO <lt_data>.
    ENDLOOP.

    IF iv_truncate = abap_true.
      DELETE FROM (lv_up).
      rs_result-deleted = sy-dbcnt.
    ENDIF.
    INSERT (lv_up) FROM TABLE @<lt_data>.
    rs_result-inserted = sy-dbcnt.
  ENDMETHOD.


  METHOD detect_delim.
    IF iv_header CS ';'.
      rv = ';'.
    ELSEIF iv_header CS ','.
      rv = ','.
    ELSE.
      rv = cl_abap_char_utilities=>horizontal_tab.
    ENDIF.
  ENDMETHOD.


  METHOD split_csv_line.
    DATA len TYPE i.
    len = strlen( iv_line ).

    DATA pos       TYPE i VALUE 0.
    DATA in_quotes TYPE abap_bool VALUE abap_false.
    DATA token     TYPE string.
    DATA delim     TYPE string.

    delim = iv_delim.
    IF delim IS INITIAL.
      delim = cl_abap_char_utilities=>horizontal_tab.
    ENDIF.

    DATA lt TYPE ty_t_string.

    WHILE pos < len.
      DATA ch TYPE c LENGTH 1.
      ch = substring( val = iv_line off = pos len = 1 ).

      IF ch = '"'.
        in_quotes = xsdbool( in_quotes = abap_false ).
        pos = pos + 1.
        CONTINUE.
      ENDIF.

      IF in_quotes = abap_false AND ch = delim.
        APPEND token TO lt.
        CLEAR token.
        pos = pos + 1.
        CONTINUE.
      ENDIF.

      token = token && ch.
      pos = pos + 1.
    ENDWHILE.

    APPEND token TO lt.

    LOOP AT lt ASSIGNING FIELD-SYMBOL(<t>).
      SHIFT <t> LEFT  DELETING LEADING space.
      SHIFT <t> RIGHT DELETING TRAILING space.

      DATA(len_t) = strlen( <t> ).
      IF len_t >= 2.
        DATA(first_char) = substring( val = <t> off = 0        len = 1 ).
        DATA(last_char)  = substring( val = <t> off = len_t - 1 len = 1 ).
        IF first_char = '"' AND last_char = '"'.
          <t> = substring( val = <t> off = 1 len = len_t - 2 ).
        ENDIF.
      ENDIF.

      REPLACE ALL OCCURRENCES OF '""' IN <t> WITH '"'.
    ENDLOOP.

    rt = lt.
  ENDMETHOD.
ENDCLASS.
