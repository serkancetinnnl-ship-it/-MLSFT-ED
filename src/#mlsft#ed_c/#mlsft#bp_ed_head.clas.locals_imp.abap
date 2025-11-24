CLASS lhc_Head DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Head RESULT result.

    METHODS CheckStatus FOR MODIFY
      IMPORTING keys FOR ACTION Head~CheckStatus RESULT result.

    METHODS PDFDownload FOR MODIFY
      IMPORTING keys FOR ACTION Head~PDFDownload RESULT result.

    METHODS Refresh FOR MODIFY
      IMPORTING keys FOR ACTION Head~Refresh RESULT result.

    METHODS SAPInvoiceDelete FOR MODIFY
      IMPORTING keys FOR ACTION Head~SAPInvoiceDelete RESULT result.

    METHODS SendEInvoice FOR MODIFY
      IMPORTING keys FOR ACTION Head~SendEInvoice RESULT result.

    METHODS XMLDownload FOR MODIFY
      IMPORTING keys FOR ACTION Head~XMLDownload RESULT result.

    METHODS AttachmentShow FOR MODIFY
      IMPORTING keys FOR ACTION Head~AttachmentShow RESULT result.

ENDCLASS.

CLASS lhc_Head IMPLEMENTATION.

  METHOD get_instance_features.

    "== Sabitler ==
    CONSTANTS:
      c_type_button TYPE /mlsft/sei_param-type  VALUE '01',
      c_val_pdf     TYPE /mlsft/sei_param-value VALUE 'DPDF',
      c_val_xml     TYPE /mlsft/sei_param-value VALUE 'DXML',
      c_val_refresh TYPE /mlsft/sei_param-value VALUE 'REFRESH',
      c_val_handle  TYPE /mlsft/sei_param-value VALUE 'HANDLE',
      c_val_send    TYPE /mlsft/sei_param-value VALUE 'SEND',
      c_val_delete  TYPE /mlsft/sei_param-value VALUE 'DSELECT',
      c_val_attach  TYPE /mlsft/sei_param-value VALUE 'SHOW_ATTAC'.
    READ ENTITIES OF /MLSFT/I_EdHead IN LOCAL MODE
      ENTITY Head
        FIELDS ( docnum doctype )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_head).

    " Parametreleri çek

    LOOP AT lt_head ASSIGNING FIELD-SYMBOL(<ls_head>).

      DATA(lv_country) = 'RO'. " sabit verdik, ileride dinamik yapılabilir

      SELECT type, value FROM /mlsft/sei_param
        WHERE country = @lv_country
          AND doctype = @<ls_head>-doctype
          AND type    = @c_type_button
          AND active  = 'X'
        INTO TABLE @DATA(lt_btns).
      SELECT param,value AS type FROM /mlsft/ed_param
        WHERE active = 'X'
         AND param = @c_val_attach
        INTO TABLE @DATA(lt_param2).
      LOOP AT lt_param2 ASSIGNING FIELD-SYMBOL(<ls_btn>).
        <ls_btn>-type = '01'.
      ENDLOOP.
      TYPES: BEGIN OF ty_btn,
               type  TYPE /mlsft/sei_param-type,
               value TYPE /mlsft/sei_param-value,
             END OF ty_btn.
      TYPES: BEGIN OF ty_btn2,
               type  TYPE /mlsft/sei_param-type,
               param TYPE /mlsft/ed_param-param,
*               value TYPE /mlsft/ed_param-value,
             END OF ty_btn2.
      DATA lt_btn_set TYPE HASHED TABLE OF ty_btn WITH UNIQUE KEY type value.
      lt_btn_set = CORRESPONDING #( lt_btns ).
      DATA lt_btn_set2 TYPE HASHED TABLE OF ty_btn2 WITH UNIQUE KEY type param .
      lt_btn_set2 = CORRESPONDING #( lt_param2 ).
      " Her bir buton için aktiflik kontrolü
      DATA(lv_pdf_on)     = xsdbool( line_exists( lt_btn_set[ type = c_type_button value = c_val_pdf     ] ) ).
      DATA(lv_xml_on)     = xsdbool( line_exists( lt_btn_set[ type = c_type_button value = c_val_xml     ] ) ).
      DATA(lv_refresh_on) = xsdbool( line_exists( lt_btn_set[ type = c_type_button value = c_val_refresh ] ) ).
      DATA(lv_handle_on)  = xsdbool( line_exists( lt_btn_set[ type = c_type_button value = c_val_handle  ] ) ).
      DATA(lv_send_on)    = xsdbool( line_exists( lt_btn_set[ type = c_type_button value = c_val_send    ] ) ).
      DATA(lv_del_on)     = xsdbool( line_exists( lt_btn_set[ type = c_type_button value = c_val_delete  ] ) ).
      DATA(lv_attach_on)  = xsdbool( line_exists( lt_btn_set2[ type = c_type_button  param = c_val_attach ] ) ).

      " Sonuç nesnesine append
      APPEND VALUE #(
        %tky = <ls_head>-%tky

        %features-%action-PDFDownload      = COND #( WHEN lv_pdf_on     = abap_true THEN if_abap_behv=>fc-o-enabled ELSE if_abap_behv=>fc-o-disabled )
        %features-%action-XMLDownload      = COND #( WHEN lv_xml_on     = abap_true THEN if_abap_behv=>fc-o-enabled ELSE if_abap_behv=>fc-o-disabled )
        %features-%action-Refresh          = COND #( WHEN lv_refresh_on = abap_true THEN if_abap_behv=>fc-o-enabled ELSE if_abap_behv=>fc-o-disabled )
        %features-%action-CheckStatus      = COND #( WHEN lv_handle_on  = abap_true THEN if_abap_behv=>fc-o-enabled ELSE if_abap_behv=>fc-o-disabled )
        %features-%action-SendEInvoice     = COND #( WHEN lv_send_on    = abap_true THEN if_abap_behv=>fc-o-enabled ELSE if_abap_behv=>fc-o-disabled )
        %features-%action-SAPInvoiceDelete = COND #( WHEN lv_del_on     = abap_true THEN if_abap_behv=>fc-o-enabled ELSE if_abap_behv=>fc-o-disabled )
        %features-%action-AttachmentShow   = COND #( WHEN lv_attach_on  = abap_true THEN if_abap_behv=>fc-o-enabled ELSE if_abap_behv=>fc-o-disabled )

      ) TO result.

    ENDLOOP.

  ENDMETHOD.

  METHOD CheckStatus.
  ENDMETHOD.

  METHOD PDFDownload.

    READ ENTITIES OF /MLSFT/I_EdHead IN LOCAL MODE
      ENTITY Head
        FIELDS ( docnum )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_head).

    LOOP AT lt_head ASSIGNING FIELD-SYMBOL(<ls_head>).

      " Document controller örneği
      DATA(lo_ctrl) = /mlsft/sei_mls_document_ctrl=>get_instance(
                         iv_docnum = <ls_head>-docnum ).

      DATA lv_guid TYPE /mlsft/ed_guid.

      lv_guid = <ls_head>-docnum.   " C(32) → GUID dönüşümü burada yapılır

      DATA(lo_document) = NEW /mlsft/ed_cl_document(
                            iv_docnum = lv_guid ).

      lo_ctrl->action_out_download_pdf(
        io_document = lo_document
      ).

      " Action result (UI tarafında gerekirse doldurursun)
      APPEND VALUE #( %tky = <ls_head>-%tky ) TO result.

    ENDLOOP.

  ENDMETHOD.


  METHOD Refresh.
  ENDMETHOD.

  METHOD SAPInvoiceDelete.
  ENDMETHOD.

  METHOD SendEInvoice.
  ENDMETHOD.

  METHOD XMLDownload.
  ENDMETHOD.

  METHOD AttachmentShow.
  ENDMETHOD.

ENDCLASS.
