"=== BEHAVIOR POOL: /mlsft/cl_bp_i_ed_loader
CLASS lhc_Loader DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations
      FOR INSTANCE AUTHORIZATION
      IMPORTING keys
                  REQUEST requested_authorizations
                  FOR Loader
      RESULT    result.

    METHODS ImportCSV
      FOR MODIFY
      IMPORTING keys
                  FOR ACTION Loader~ImportCSV
      RESULT    result.

ENDCLASS.

CLASS lhc_Loader IMPLEMENTATION.

  METHOD get_instance_authorizations.
    " şimdilik boş
  ENDMETHOD.

  METHOD ImportCSV.
    " ---- action parametreleri keys[1]-%param içinden gelir ----
    DATA p TYPE /mlsft/c_ed_loader_importcsv.
    IF lines( keys ) > 0.
      p = keys[ 1 ]-%param.
    ENDIF.

    " yardımcı değişkenler
    DATA(lv_delim)    = COND string( WHEN p-delimiter IS INITIAL THEN '' ELSE p-delimiter ).
    DATA(lv_truncate) = xsdbool( p-truncate_flag = 'X' ).

    TRY.
        " 1) CSV normalize
        DATA(lv_csv) = p-csv.
        REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>cr_lf IN lv_csv WITH cl_abap_char_utilities=>newline.
        REPLACE ALL OCCURRENCES OF REGEX '\r' IN lv_csv WITH ''.

        DATA lt_lines TYPE STANDARD TABLE OF string WITH EMPTY KEY.
        SPLIT lv_csv AT cl_abap_char_utilities=>newline INTO TABLE lt_lines.
        IF lt_lines IS INITIAL.
          reported-Loader = VALUE #( ( %msg = new_message_with_text(
                                           severity = if_abap_behv_message=>severity-warning
                                           text     = |CSV is empty.| ) ) ).
          result = VALUE #( ( ) ).
          RETURN.
        ENDIF.

        " 2) başlıklar
        DATA(lv_header) = lt_lines[ 1 ].
        DATA lt_hdr TYPE STANDARD TABLE OF string WITH EMPTY KEY.
        IF lv_delim IS INITIAL.
          SPLIT lv_header AT ';' INTO TABLE lt_hdr.
        ELSE.
          SPLIT lv_header AT lv_delim INTO TABLE lt_hdr.
        ENDIF.

        " 3) LoaderUUID seçimi
        DATA(lv_loader_uuid) = COND sysuuid_x16(
          WHEN p-loader_uuid IS NOT INITIAL
          THEN p-loader_uuid
          ELSE cl_system_uuid=>create_uuid_x16_static( ) ).
        " 4) child tabloya (önizleme) yaz – child BDEF yok, direkt SQL
        DELETE FROM /mlsft/edlruncol WHERE loader_uuid = @lv_loader_uuid.

        DATA idx TYPE i VALUE 1.
        LOOP AT lt_hdr ASSIGNING FIELD-SYMBOL(<h>).
          DATA(ls_col) = VALUE /mlsft/edlruncol(
                            client       = sy-mandt
                            loader_uuid  = lv_loader_uuid
                            col_idx      = idx
                            header       = <h>
                            sample_value = '' ).

          INSERT /mlsft/edlruncol FROM @ls_col.

          idx += 1.
        ENDLOOP.

        " 5) asıl yükleme (utility sınıfın)
        DATA(lv_tabname) = CONV string( p-table_name ).
        SHIFT lv_tabname RIGHT DELETING TRAILING space.  " trim right

        DATA(res) = /mlsft/exceltosap=>import_csv_string(
                      iv_table_name = lv_tabname
                      iv_csv        = p-csv
                      iv_delim      = lv_delim
                      iv_truncate   = lv_truncate ).


        " 6) mesaj
        reported-Loader = VALUE #( ( %msg = new_message_with_text(
                                      severity = if_abap_behv_message=>severity-success
                                      text     = |{ res-table }: { res-inserted } inserted, { res-deleted } deleted.| ) ) ).

      CATCH /mlsft/cx_exceltosap INTO DATA(lx).
        reported-Loader = VALUE #( ( %msg = new_message_with_text(
                                      severity = if_abap_behv_message=>severity-error
                                      text     = lx->get_text( ) ) ) ).
    ENDTRY.

    result = VALUE #( ( ) ).
  ENDMETHOD.

ENDCLASS.
