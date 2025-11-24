CLASS /MLSFT/ed_create_del_xml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING io_mapping  TYPE REF TO  /MLSFT/if_ed_delivery_mapping
                io_delivery TYPE REF TO  /MLSFT/ed_parent_delivery.

    METHODS build_xml_binary
      RETURNING VALUE(rt_xml_doc) TYPE xstring.
**      RETURNING VALUE(rt_xml_doc) TYPE REF TO cl_xml_document.

    METHODS get_binary
      RETURNING VALUE(rv_binary) TYPE xstring.

    METHODS get_size
      RETURNING VALUE(rv_size) TYPE int4.

    INTERFACES /MLSFT/if_ed_delivery_xml .

  PROTECTED SECTION.

  PRIVATE SECTION.

    ALIASES adddocrefrence
      FOR /mlsft/if_ed_delivery_xml~node_adddocrefrence .
    ALIASES buyercustomerparty
      FOR /mlsft/if_ed_delivery_xml~node_buyercustomerparty .
    ALIASES close
      FOR /mlsft/if_ed_delivery_xml~close .
    ALIASES copyindicator
      FOR /mlsft/if_ed_delivery_xml~node_copyindicator .
    ALIASES customizationid
      FOR /mlsft/if_ed_delivery_xml~node_customizationid .
    ALIASES deliverycustomerparty
      FOR /mlsft/if_ed_delivery_xml~node_deliverycustomerparty .
    ALIASES despatchadvicetypecode
      FOR /mlsft/if_ed_delivery_xml~node_despatchadvicetypecode .
    ALIASES despatchline
      FOR /mlsft/if_ed_delivery_xml~node_despatchline .
    ALIASES despatchsupplierparty
      FOR /mlsft/if_ed_delivery_xml~node_despatchsupplierparty .
    ALIASES head
      FOR /mlsft/if_ed_delivery_xml~node_head .
    ALIASES id
      FOR /mlsft/if_ed_delivery_xml~node_id .
    ALIASES issuedate
      FOR /mlsft/if_ed_delivery_xml~node_issuedate .
    ALIASES issuetime
      FOR /mlsft/if_ed_delivery_xml~node_issuetime .
    ALIASES notes
      FOR /mlsft/if_ed_delivery_xml~node_notes .
    ALIASES orderreference
      FOR /mlsft/if_ed_delivery_xml~node_orderreference .
    ALIASES originatorcustomerparty
      FOR /mlsft/if_ed_delivery_xml~node_originatorcustomerparty .
    ALIASES profileid
      FOR /mlsft/if_ed_delivery_xml~node_profileid .
    ALIASES sellersupplierparty
      FOR /mlsft/if_ed_delivery_xml~node_sellersupplierparty .
    ALIASES shipment
      FOR /mlsft/if_ed_delivery_xml~node_shipment .
    ALIASES signature
      FOR /mlsft/if_ed_delivery_xml~node_signature .
    ALIASES ublextensions
      FOR /mlsft/if_ed_delivery_xml~node_ublextensions .
    ALIASES ublversionid
      FOR /mlsft/if_ed_delivery_xml~node_ublversionid .
    ALIASES uuid
      FOR /mlsft/if_ed_delivery_xml~node_uuid .

    TYPES:
      BEGIN OF ty_s_xml_line,
        data TYPE xstring, "solix,
      END OF ty_s_xml_line .

    DATA ms_ref TYPE /mlsft/ed_s_eref .
    DATA ms_wbill TYPE /mlsft/ed_s_main_wbill .
    DATA mt_xml_to_abap TYPE TABLE OF ty_s_xml_line .
    DATA mv_xmlfile TYPE string .
    DATA mr_cl_ixml TYPE REF TO object.""if_ixml .
    DATA mr_cl_streamfactory TYPE REF TO  object." if_ixml_stream_factory .
    DATA mr_cl_parser TYPE REF TO  object."if_ixml_parser .
**    DATA mr_cl_istream TYPE REF TO if_ixml_istream .
    DATA mr_cl_istream TYPE REF TO object.
    DATA mr_cl_document TYPE REF TO if_ixml_document .
    DATA mv_xmldata TYPE xstring .
    DATA mr_ixml TYPE REF TO  object."if_ixml .
    DATA mr_streamfactory TYPE REF TO  object."if_ixml_stream_factory .
    DATA mr_ostream TYPE REF TO  object."if_ixml_ostream .
    DATA mr_stream TYPE REF TO  object."if_ixml_ostream .
    DATA mr_renderer TYPE REF TO  object."if_ixml_renderer .
    DATA mr_el_waybill TYPE REF TO if_ixml_element .
    DATA mr_el_waybills TYPE REF TO if_ixml_element .
    DATA mt_xml_table TYPE STANDARD TABLE OF xstring WITH EMPTY KEY.."solix_tab .
    DATA mv_xml_size TYPE i .
    DATA mv_rc TYPE i .
    DATA mr_srcstr TYPE REF TO  object." if_ixml_istream .
    DATA mr_document TYPE REF TO if_ixml_document .
    DATA mv_xsxml TYPE xstring .
    DATA mv_xlen TYPE i .
    DATA mr_appl_log TYPE REF TO /mlsft/ed_logs .

    METHODS which_step .
    METHODS add_message_to_log
      IMPORTING
        iv_priority TYPE string.
    METHODS download_file
      IMPORTING
        !iv_xml_size        TYPE i
        VALUE(it_xml_table) TYPE xstring." solix_tab .
    METHODS put_xml_in_file .
    METHODS node_party
      IMPORTING
        !ir_xml_document  TYPE REF TO if_ixml_document
        !i_partyname      TYPE string
        !i_party          TYPE /mlsft/ed_s_party
      RETURNING
        VALUE(re_element) TYPE REF TO if_ixml_element .
    METHODS add_node
      IMPORTING
        !im_nodename      TYPE string
        !im_value         TYPE any
        !ir_xml_document  TYPE REF TO if_ixml_document
      RETURNING
        VALUE(re_element) TYPE REF TO if_ixml_element .
    METHODS node_person
      IMPORTING
        !i_party     TYPE /mlsft/ed_s_party
      CHANGING
        !cr_el_party TYPE REF TO if_ixml_element
        !cr_el_node  TYPE REF TO if_ixml_element
        !cr_xml_doc  TYPE REF TO if_ixml_document
        !cv_value    TYPE string .
    METHODS node_contact
      IMPORTING
        !i_party      TYPE /mlsft/ed_s_party
      CHANGING
        !cr_el_party  TYPE REF TO if_ixml_element
        !cr_el_node   TYPE REF TO if_ixml_element
        !cr_el_parent TYPE REF TO if_ixml_element
        !cr_el_child  TYPE REF TO if_ixml_element
        !cr_xml_doc   TYPE REF TO if_ixml_document
        !cv_value     TYPE string .
    METHODS node_address_delivery
      IMPORTING
        !is_address       TYPE /mlsft/ed_s_address
      CHANGING
        !cr_postaladdress TYPE REF TO if_ixml_element
        !cr_xml_doc       TYPE REF TO if_ixml_document .
    METHODS node_address
      IMPORTING
        !is_address       TYPE /mlsft/ed_s_address
      CHANGING
        !cr_postaladdress TYPE REF TO if_ixml_element
        !cr_xml_doc       TYPE REF TO if_ixml_document .
    METHODS add_quantity_node
      IMPORTING
        !im_nodename      TYPE string
        !im_value         TYPE /mlsft/ed_s_quan
        !ir_xml_document  TYPE REF TO if_ixml_document
      RETURNING
        VALUE(re_element) TYPE REF TO if_ixml_element .
    METHODS add_price_node
      IMPORTING
        !im_nodename      TYPE string
        !im_value         TYPE /mlsft/ed_s_amount
        !ir_xml_document  TYPE REF TO if_ixml_document
      RETURNING
        VALUE(re_element) TYPE REF TO if_ixml_element .
    METHODS add_item_note
      EXPORTING
        !er_item    TYPE REF TO if_ixml_element
      CHANGING
        !cr_xml_doc TYPE REF TO if_ixml_document
        !cs_line    TYPE /mlsft/ed_s_item .
    METHODS get_xslt_name
      RETURNING
        VALUE(re_xslt) TYPE string. .
    METHODS prepare_shipment_node
      IMPORTING
        !is_shipment       TYPE /mlsft/ed_s_shp
        !ir_xml_document   TYPE REF TO if_ixml_document
      RETURNING
        VALUE(rr_shipment) TYPE REF TO if_ixml_element .
    METHODS node_phys_address
      IMPORTING
        !is_address     TYPE /mlsft/ed_s_phyloc
      CHANGING
        !cr_physaddress TYPE REF TO if_ixml_element
        !cr_xml_doc     TYPE REF TO if_ixml_document .

    METHODS download_file_cloud
      IMPORTING
        iv_xml_size TYPE i
**        it_xml_table TYPE solix_tab
        iv_xstring  TYPE xstring.
ENDCLASS.



CLASS /MLSFT/ED_CREATE_DEL_XML IMPLEMENTATION.


  METHOD close.
    " XML içeriğini tabloya koy (gerekliyse)
    CLEAR mt_xml_table.
    IF mv_xsxml IS NOT INITIAL.
      APPEND mv_xsxml TO mt_xml_table.
    ENDIF.

    " Uzunluğu hesapla
    mv_xlen = xstrlen( mv_xsxml ).

    " Devam işlemleri
    put_xml_in_file( ).
    which_step( ).
  ENDMETHOD.


  METHOD adddocrefrence.
    DATA: lr_adddocref                 TYPE REF TO if_ixml_element,
          lr_id                        TYPE REF TO if_ixml_element,
          lr_issuedate                 TYPE REF TO if_ixml_element,
          lr_dtcodetype                TYPE REF TO if_ixml_element,
          lr_ddesc                     TYPE REF TO if_ixml_element,
          lr_el_child                  TYPE REF TO if_ixml_element,
          lr_el_node_attachment        TYPE REF TO if_ixml_element,
          lr_el_node_externalreference TYPE REF TO if_ixml_element,
          lr_node_uri                  TYPE REF TO if_ixml_element,
          lr_xml_doc                   TYPE REF TO if_ixml_document.

    DATA: lv_value            TYPE string,
          lv_filename         TYPE string,
          lv_mime             TYPE string,
          lv_charactersetcode TYPE string,
          lv_encodingcode     TYPE string.

    DATA: lr_adddocref_row TYPE REF TO /mlsft/ed_s_docref.
    FIELD-SYMBOLS <adddocref> TYPE /mlsft/ed_s_docref.

    lr_xml_doc = ir_xml_document.

    LOOP AT me->ms_wbill-adddocref INTO lr_adddocref_row.
      IF lr_adddocref_row IS INITIAL.
        CONTINUE.
      ENDIF.
      ASSIGN lr_adddocref_row->* TO <adddocref>.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      lr_adddocref = lr_xml_doc->create_element( name = 'cac:AdditionalDocumentReference' ).

      " ID
      lr_id = lr_xml_doc->create_element( name = 'cbc:ID' ).
      lr_id->set_value( <adddocref>-id ).
      lr_adddocref->append_child( lr_id ).

      " IssueDate
      lv_value = /mlsft/ed_util=>convert_to_gib_date( iv_date = <adddocref>-issuedate ).
      lr_issuedate = lr_xml_doc->create_element( name = 'cbc:IssueDate' ).
      lr_issuedate->set_value( lv_value ).
      lr_adddocref->append_child( lr_issuedate ).

      " DocumentTypeCode
      IF <adddocref>-dtypecode IS NOT INITIAL.
        lr_dtcodetype = lr_xml_doc->create_element( name = 'cbc:DocumentTypeCode' ).
        lr_dtcodetype->set_value( <adddocref>-dtypecode ).
        lr_adddocref->append_child( lr_dtcodetype ).
      ENDIF.

      " DocumentType
      IF <adddocref>-dtypecode IS NOT INITIAL.
        IF <adddocref>-dtypecode = 'SendingDate'.
          DATA(lv_datum) = <adddocref>-issuedate.
          lv_value = /mlsft/ed_util=>convert_to_gib_date( iv_date = lv_datum ).
        ELSE.
          lv_value = <adddocref>-dtype.
        ENDIF.
        IF lv_value IS NOT INITIAL.
          lr_el_child = lr_xml_doc->create_element( name = 'cbc:DocumentType' ).
          lr_el_child->set_value( lv_value ).
          lr_adddocref->append_child( lr_el_child ).
        ENDIF.
      ENDIF.

      " DocumentDescription
      DATA lr_desc_row TYPE REF TO data.
      FIELD-SYMBOLS: <row>  TYPE any,
                     <text> TYPE any.
      DATA lv_desc_val TYPE string.

      LOOP AT <adddocref>-ddesc REFERENCE INTO lr_desc_row.
        ASSIGN lr_desc_row->* TO <row>.
        IF sy-subrc <> 0 OR <row> IS INITIAL.
          CONTINUE.
        ENDIF.

        DATA(lo_descr) = cl_abap_typedescr=>describe_by_data( <row> ).
        CLEAR lv_desc_val.

        CASE lo_descr->type_kind.
          WHEN cl_abap_typedescr=>typekind_string
            OR cl_abap_typedescr=>typekind_char.
            lv_desc_val = CONV string( <row> ).
          WHEN cl_abap_typedescr=>typekind_struct1
            OR cl_abap_typedescr=>typekind_struct2.
            ASSIGN COMPONENT 'TEXT' OF STRUCTURE <row> TO <text>.
            IF sy-subrc <> 0.
              ASSIGN COMPONENT 'TEXTSTRING' OF STRUCTURE <row> TO <text>.
            ENDIF.
            IF sy-subrc = 0 AND <text> IS ASSIGNED.
              lv_desc_val = CONV string( <text> ).
            ELSE.
              CONTINUE.
            ENDIF.
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.

        IF lv_desc_val IS NOT INITIAL.
          lr_ddesc = lr_xml_doc->create_element( name = 'cbc:DocumentDescription' ).
          lr_ddesc->set_value( lv_desc_val ).
          lr_adddocref->append_child( lr_ddesc ).
        ENDIF.
      ENDLOOP.

      " Attachment
      IF <adddocref>-attachment IS NOT INITIAL.
        lr_el_node_attachment = lr_xml_doc->create_element( name = 'cac:Attachment' ).
        lr_el_child = lr_xml_doc->create_element( name = 'cbc:EmbeddedDocumentBinaryObject' ).

        lv_charactersetcode = <adddocref>-attachment-binaryobj-charset.
        IF lv_charactersetcode IS NOT INITIAL.
          lr_el_child->set_attribute( name = 'characterSetCode' value = lv_charactersetcode ).
        ENDIF.
        lv_encodingcode = <adddocref>-attachment-binaryobj-encoding.
        IF lv_encodingcode IS NOT INITIAL.
          lr_el_child->set_attribute( name = 'encodingCode' value = lv_encodingcode ).
        ENDIF.
        lv_filename = <adddocref>-attachment-binaryobj-filename.
        IF lv_filename IS NOT INITIAL.
          lr_el_child->set_attribute( name = 'filename' value = lv_filename ).
        ENDIF.
        lv_mime = <adddocref>-attachment-binaryobj-mimetype.
        IF lv_mime IS INITIAL.
          lv_mime = 'application/octet-stream'.
        ENDIF.
        lr_el_child->set_attribute( name = 'mimeCode' value = lv_mime ).
        lr_el_child->set_value( <adddocref>-attachment-binaryobj-data ).

        lr_el_node_attachment->append_child( lr_el_child ).
        lr_adddocref->append_child( lr_el_node_attachment ).
      ENDIF.

      ir_xml_element->append_child( lr_adddocref ).
    ENDLOOP.

    " XSLT referansı
    DATA(lv_xslt_name) = me->get_xslt_name( ).
    IF lv_xslt_name IS NOT INITIAL.
**      DATA(lv_b64_xslt) = /mlsft/ed_util=>xslt_lines_code_64( im_xsltname = lv_xslt_name ).
      DATA lv_xslt_c40 TYPE /mlsft/ed_char40.
      lv_xslt_c40 = lv_xslt_name.

      DATA(lv_b64_xslt) = /mlsft/ed_util=>xslt_lines_code_64(
        im_xsltname = lv_xslt_c40
      ).

      DATA(lr_el_node) = lr_xml_doc->create_element( name = 'cac:AdditionalDocumentReference' ).

      lr_el_child = lr_xml_doc->create_element( name = 'cbc:ID' ).
      lr_el_child->set_value( ms_wbill-id ).
      lr_el_node->append_child( lr_el_child ).
      DATA(lv_date) = cl_abap_context_info=>get_system_date( ).
      lr_el_child = lr_xml_doc->create_element( name = 'cbc:IssueDate' ).
      lr_el_child->set_value( /mlsft/ed_util=>convert_to_gib_date( iv_date = lv_date ) ).
      lr_el_node->append_child( lr_el_child ).

      lr_el_child = lr_xml_doc->create_element( name = 'cbc:DocumentType' ).
      lr_el_child->set_value( 'XSLT' ).
      lr_el_node->append_child( lr_el_child ).

      lr_el_node_attachment = lr_xml_doc->create_element( name = 'cac:Attachment' ).
      lr_el_child = lr_xml_doc->create_element( name = 'cbc:EmbeddedDocumentBinaryObject' ).
      lv_filename = |{ ms_wbill-id }.xslt|.
      IF lv_filename IS NOT INITIAL.
        lr_el_child->set_attribute( name = 'filename' value = lv_filename ).
      ENDIF.
      lr_el_child->set_attribute( name = 'characterSetCode' value = 'UTF-8' ).
      lr_el_child->set_attribute( name = 'encodingCode'     value = 'Base64' ).
      lr_el_child->set_attribute( name = 'mimeCode'         value = 'application/xml' ).
      lr_el_child->set_value( lv_b64_xslt ).

      lr_el_node_externalreference = lr_xml_doc->create_element( name = 'cac:ExternalReference' ).
      lr_node_uri = lr_xml_doc->create_element( name = 'cbc:URI' ).
      lr_node_uri->set_value( |#Xslt-Id-{ ms_wbill-id }| ).
      lr_el_node_externalreference->append_child( lr_node_uri ).

      lr_el_node_attachment->append_child( lr_el_child ).
      lr_el_node_attachment->append_child( lr_el_node_externalreference ).
      lr_el_node->append_child( lr_el_node_attachment ).

      ir_xml_element->append_child( lr_el_node ).
    ENDIF.

    which_step( ).
  ENDMETHOD.


  METHOD buyercustomerparty.
    DATA: lr_dsupparty TYPE REF TO if_ixml_element,
          lr_party     TYPE REF TO if_ixml_element,
          lr_dcontact  TYPE REF TO if_ixml_element,
          lr_name      TYPE REF TO if_ixml_element,
          lr_xml_doc   TYPE REF TO if_ixml_document.

    DATA ls_party TYPE /mlsft/ed_s_dsparty.
    ls_party = me->ms_wbill-parties.

    IF ls_party IS INITIAL OR
       ls_party-partytype <> /mlsft/ed_constants=>buyercustomerparty.
      RETURN.
    ENDIF.

    lr_xml_doc   = ir_xml_document.
    lr_dsupparty = lr_xml_doc->create_element( name = 'cac:BuyerCustomerParty' ).

    node_party(
      EXPORTING
        ir_xml_document = ir_xml_document
        i_partyname     = 'Party'
        i_party         = ls_party-party
      RECEIVING
        re_element      = lr_party
    ).
    lr_dsupparty->append_child( lr_party ).

    DATA lv_name TYPE string.
    LOOP AT ls_party-contact INTO lv_name.
      IF lv_name IS INITIAL.
        CONTINUE.
      ENDIF.
      lr_dcontact = lr_xml_doc->create_element( name = 'cac:BuyerCustomerPartyContact' ).
      lr_name     = lr_xml_doc->create_element( name = 'cbc:Name' ).
      lr_name->set_value( lv_name ).
      lr_dcontact->append_child( lr_name ).
      lr_dsupparty->append_child( lr_dcontact ).
    ENDLOOP.

    ir_xml_element->append_child( lr_dsupparty ).
    which_step( ).
  ENDMETHOD.


  METHOD /MLSFT/if_ed_delivery_xml~node_copyindicator.
    DATA: lr_el_node TYPE REF TO if_ixml_element,
          lv_value   TYPE string,
          lr_xml_doc TYPE REF TO if_ixml_document.

    lr_xml_doc = ir_xml_document.
    lr_el_node = lr_xml_doc->create_element( name = 'cbc:CopyIndicator' ).
    lv_value   = ms_wbill-copyindicator.
    lr_el_node->set_value( lv_value ).
    ir_xml_element->append_child( lr_el_node ).
    which_step( ).
  ENDMETHOD.


  METHOD /MLSFT/if_ed_delivery_xml~node_customizationid.
    DATA: lr_el_node TYPE REF TO if_ixml_element,
          lv_value   TYPE string,
          lr_xml_doc TYPE REF TO if_ixml_document.
    lr_xml_doc = ir_xml_document.
    lr_el_node = lr_xml_doc->create_element( name = 'cbc:CustomizationID' ).
    lv_value   = 'TR1.2.1'.
    lr_el_node->set_value( lv_value ).
    ir_xml_element->append_child( lr_el_node ).
    which_step( ).
  ENDMETHOD.


  METHOD /MLSFT/if_ed_delivery_xml~node_deliverycustomerparty.
    DATA: lr_dsupparty TYPE REF TO if_ixml_element,
          lr_party     TYPE REF TO if_ixml_element,
          lr_dcontact  TYPE REF TO if_ixml_element,
          lr_name      TYPE REF TO if_ixml_element,
          lr_xml_doc   TYPE REF TO if_ixml_document.

    DATA ls_party TYPE /mlsft/ed_s_dsparty.
    ls_party = ms_wbill-parties.

    IF ls_party IS INITIAL OR
       ls_party-partytype <> /mlsft/ed_constants=>deliverycustomerparty.
      RETURN.
    ENDIF.

    lr_xml_doc   = ir_xml_document.
    lr_dsupparty = lr_xml_doc->create_element( name = 'cac:DeliveryCustomerParty' ).

    node_party(
      EXPORTING
        ir_xml_document = ir_xml_document
        i_partyname     = 'Party'
        i_party         = ls_party-party
      RECEIVING
        re_element      = lr_party
    ).
    lr_dsupparty->append_child( lr_party ).

    DATA lv_name TYPE string.
    LOOP AT ls_party-contact INTO lv_name.
      IF lv_name IS INITIAL.
        CONTINUE.
      ENDIF.
      lr_dcontact = lr_xml_doc->create_element( name = 'cac:DeliveryCustomerPartyContact' ).
      lr_name     = lr_xml_doc->create_element( name = 'cbc:Name' ).
      lr_name->set_value( lv_name ).
      lr_dcontact->append_child( lr_name ).
      lr_dsupparty->append_child( lr_dcontact ).
    ENDLOOP.

    ir_xml_element->append_child( lr_dsupparty ).
    which_step( ).
  ENDMETHOD.


  METHOD /MLSFT/if_ed_delivery_xml~node_despatchadvicetypecode.
    DATA: lr_el_node TYPE REF TO if_ixml_element,
          lv_value   TYPE string,
          lr_xml_doc TYPE REF TO if_ixml_document.
    lr_xml_doc = ir_xml_document.
    lr_el_node = lr_xml_doc->create_element( name = 'cbc:DespatchAdviceTypeCode' ).
    lv_value   = ms_wbill-datypecode.
    lr_el_node->set_value( lv_value ).
    ir_xml_element->append_child( lr_el_node ).
    which_step( ).
  ENDMETHOD.


  METHOD /MLSFT/if_ed_delivery_xml~node_despatchline.
    DATA: lr_xml_doc      TYPE REF TO if_ixml_document,
          lr_despatchline TYPE REF TO if_ixml_element,
          lr_orderlref    TYPE REF TO if_ixml_element,
          lr_item         TYPE REF TO if_ixml_element,
          lr_shipment     TYPE REF TO if_ixml_element,
          lr_goodsitem    TYPE REF TO if_ixml_element,
          lr_invline      TYPE REF TO if_ixml_element,
          lr_price        TYPE REF TO if_ixml_element,
          lr_node         TYPE REF TO if_ixml_element.

    DATA lr_line_ref TYPE REF TO data.
    FIELD-SYMBOLS <line> TYPE /mlsft/ed_s_line.

    lr_xml_doc = ir_xml_document.

    LOOP AT me->ms_wbill-despatchl REFERENCE INTO lr_line_ref.
      ASSIGN lr_line_ref->* TO <line>.
      IF sy-subrc <> 0 OR <line> IS INITIAL.
        CONTINUE.
      ENDIF.

      lr_despatchline = lr_xml_doc->create_element( name = 'cac:DespatchLine' ).

      " ID
      lr_node = lr_xml_doc->create_element( name = 'cbc:ID' ).
      lr_node->set_value( <line>-id ).
      lr_despatchline->append_child( lr_node ).

      " Note
      IF <line>-note IS NOT INITIAL.
        lr_node = lr_xml_doc->create_element( name = 'cbc:Note' ).
        lr_node->set_value( <line>-note ).
        lr_despatchline->append_child( lr_node ).
      ENDIF.

      " DeliveredQuantity
      FIELD-SYMBOLS: <dqty>     TYPE any, <amount> TYPE any, <unitcode> TYPE any.
      ASSIGN COMPONENT 'DQUANTITY' OF STRUCTURE <line> TO <dqty>.
      IF sy-subrc = 0 AND <dqty> IS ASSIGNED.
        lr_node = lr_xml_doc->create_element( name = 'cbc:DeliveredQuantity' ).
        ASSIGN COMPONENT 'AMOUNT'   OF STRUCTURE <dqty> TO <amount>.
        IF sy-subrc = 0 AND <amount> IS ASSIGNED AND <amount> IS NOT INITIAL.
          lr_node->set_value( CONV string( <amount> ) ).
        ENDIF.
        ASSIGN COMPONENT 'UNITCODE' OF STRUCTURE <dqty> TO <unitcode>.
        IF sy-subrc = 0 AND <unitcode> IS ASSIGNED AND <unitcode> IS NOT INITIAL.
          DATA(lv_uom) = /mlsft/ed_util=>convert_unit_measurement( CONV string( <unitcode> ) ).
          lr_node->set_attribute( name = 'unitCode' value = lv_uom ).
        ENDIF.
        lr_despatchline->append_child( lr_node ).
      ENDIF.

      " OrderLineReference / LineID
      lr_orderlref = lr_xml_doc->create_element( name = 'cac:OrderLineReference' ).
      lr_node      = lr_xml_doc->create_element( name = 'cbc:LineID' ).

      FIELD-SYMBOLS :<olineref> TYPE any, <lineid> TYPE any.
      ASSIGN COMPONENT 'OLINEREF' OF STRUCTURE <line> TO <olineref>.
      IF sy-subrc = 0 AND <olineref> IS ASSIGNED.
        ASSIGN COMPONENT 'LINEID' OF STRUCTURE <olineref> TO <lineid>.
      ENDIF.

      DATA(lv_lineid) = COND string(
                           WHEN sy-subrc = 0 AND <lineid> IS ASSIGNED AND <lineid> IS NOT INITIAL
                           THEN CONV string( <lineid> )
                           ELSE <line>-id ).
      lr_node->set_value( lv_lineid ).
      lr_orderlref->append_child( lr_node ).
      lr_despatchline->append_child( lr_orderlref ).

      " Item
      IF <line>-item IS NOT INITIAL.
        add_item_note(
          IMPORTING er_item    = lr_item
          CHANGING  cr_xml_doc = lr_xml_doc
                   cs_line    = <line>-item ).
        lr_despatchline->append_child( lr_item ).
      ENDIF.

      " Shipment
      IF <line>-shipment IS NOT INITIAL.
        lr_shipment = lr_xml_doc->create_element( name = 'cac:Shipment' ).
        prepare_shipment_node(
          EXPORTING is_shipment     = <line>-shipment
                    ir_xml_document = lr_xml_doc
          RECEIVING rr_shipment     = lr_shipment ).
        lr_goodsitem = lr_xml_doc->create_element( name = 'cac:GoodsItem' ).

        DATA lr_il_ref TYPE REF TO data.
        FIELD-SYMBOLS <il_row> TYPE any.

        LOOP AT <line>-shipment-goodsitem-invline REFERENCE INTO lr_il_ref.
          ASSIGN lr_il_ref->* TO <il_row>.
          IF sy-subrc <> 0 OR <il_row> IS INITIAL.
            CONTINUE.
          ENDIF.

          lr_invline = lr_xml_doc->create_element( name = 'cac:InvoiceLine' ).

          " ID
          FIELD-SYMBOLS <id> TYPE any.
          ASSIGN COMPONENT 'ID' OF STRUCTURE <il_row> TO <id>.
          IF sy-subrc = 0 AND <id> IS ASSIGNED AND <id> IS NOT INITIAL.
            lr_node = lr_xml_doc->create_element( name = 'cbc:ID' ).
            lr_node->set_value( CONV string( <id> ) ).
            lr_invline->append_child( lr_node ).
          ENDIF.

          " InvoicedQuantity
          FIELD-SYMBOLS: <dq>          TYPE any, <dq_amount> TYPE any, <dq_unitcode> TYPE any.
          ASSIGN COMPONENT 'DQUANTITY' OF STRUCTURE <il_row> TO <dq>.
          IF sy-subrc = 0 AND <dq> IS ASSIGNED.
            ASSIGN COMPONENT 'AMOUNT'   OF STRUCTURE <dq> TO <dq_amount>.
            ASSIGN COMPONENT 'UNITCODE' OF STRUCTURE <dq> TO <dq_unitcode>.
            IF ( ( <dq_amount> IS ASSIGNED AND <dq_amount> IS NOT INITIAL )
              OR  ( <dq_unitcode> IS ASSIGNED AND <dq_unitcode> IS NOT INITIAL ) ).
              lr_node = lr_xml_doc->create_element( name = 'cbc:InvoicedQuantity' ).
              IF <dq_amount> IS ASSIGNED AND <dq_amount> IS NOT INITIAL.
                lr_node->set_value( CONV string( <dq_amount> ) ).
              ENDIF.
              IF <dq_unitcode> IS ASSIGNED AND <dq_unitcode> IS NOT INITIAL.
                DATA(lv_uom2) = /mlsft/ed_util=>convert_unit_measurement( CONV string( <dq_unitcode> ) ).
                lr_node->set_attribute( name = 'unitCode' value = lv_uom2 ).
              ENDIF.
              lr_invline->append_child( lr_node ).
            ENDIF.
          ENDIF.

          " LineExtensionAmount
          FIELD-SYMBOLS <price> TYPE any.
          ASSIGN COMPONENT 'PRICE' OF STRUCTURE <il_row> TO <price>.
          IF sy-subrc = 0 AND <price> IS ASSIGNED AND <price> IS NOT INITIAL.
            add_price_node(
              EXPORTING im_nodename     = 'cbc:LineExtensionAmount'
                        im_value        = <price>
                        ir_xml_document = lr_xml_doc
              RECEIVING re_element      = lr_node ).
            lr_invline->append_child( lr_node ).
          ENDIF.

          " Item
          FIELD-SYMBOLS <it> TYPE any.
          ASSIGN COMPONENT 'ITEM' OF STRUCTURE <il_row> TO <it>.
          IF sy-subrc = 0 AND <it> IS ASSIGNED AND <it> IS NOT INITIAL.
            add_item_note(
              IMPORTING er_item    = lr_item
              CHANGING  cr_xml_doc = lr_xml_doc
                        cs_line    = <it> ).
            lr_invline->append_child( lr_item ).
          ENDIF.

          " Price node (cbc:PriceAmount)
          IF <price> IS ASSIGNED AND <price> IS NOT INITIAL.
            lr_price = lr_xml_doc->create_element( name = 'cac:Price' ).
            add_price_node(
              EXPORTING im_nodename     = 'cbc:PriceAmount'
                        im_value        = <price>
                        ir_xml_document = lr_xml_doc
              RECEIVING re_element      = lr_node ).
            lr_price->append_child( lr_node ).
            lr_invline->append_child( lr_price ).
          ENDIF.

          lr_goodsitem->append_child( lr_invline ).
        ENDLOOP.

        lr_shipment->append_child( lr_goodsitem ).
        lr_despatchline->append_child( lr_shipment ).
      ENDIF.

      ir_xml_element->append_child( lr_despatchline ).
    ENDLOOP.
  ENDMETHOD.


  METHOD /MLSFT/if_ed_delivery_xml~node_despatchsupplierparty.
    DATA: lr_dsupparty TYPE REF TO if_ixml_element,
          lr_party     TYPE REF TO if_ixml_element,
          lr_dcontact  TYPE REF TO if_ixml_element,
          lr_name      TYPE REF TO if_ixml_element,
          lr_xml_doc   TYPE REF TO if_ixml_document.

    DATA ls_party TYPE /mlsft/ed_s_dsparty.
    ls_party = ms_wbill-parties.

    IF ls_party IS INITIAL OR
       ls_party-partytype <> /mlsft/ed_constants=>despatchsupplierparty.
      RETURN.
    ENDIF.

    lr_xml_doc   = ir_xml_document.
    lr_dsupparty = lr_xml_doc->create_element( name = 'cac:DespatchSupplierParty' ).

    node_party(
      EXPORTING
        ir_xml_document = ir_xml_document
        i_partyname     = 'Party'
        i_party         = ls_party-party
      RECEIVING
        re_element      = lr_party
    ).
    lr_dsupparty->append_child( lr_party ).

    DATA lv_name TYPE string.
    LOOP AT ls_party-contact INTO lv_name.
      IF lv_name IS INITIAL.
        CONTINUE.
      ENDIF.
      lr_dcontact = lr_xml_doc->create_element( name = 'cac:DespatchContact' ).
      lr_name     = lr_xml_doc->create_element( name = 'cbc:Name' ).
      lr_name->set_value( lv_name ).
      lr_dcontact->append_child( lr_name ).
      lr_dsupparty->append_child( lr_dcontact ).
    ENDLOOP.

    ir_xml_element->append_child( lr_dsupparty ).
    which_step( ).
  ENDMETHOD.


  METHOD /MLSFT/if_ed_delivery_xml~node_head.
    DATA: lr_xml_doc TYPE REF TO if_ixml_document.
    DATA: lr_el_applicationresponse TYPE REF TO if_ixml_element.
    DATA: lv_value TYPE string.
    DATA: lv_rc TYPE i.

    lr_xml_doc = ir_xml_document.

    lr_el_applicationresponse = lr_xml_doc->create_element( name = 'DespatchAdvice' ).

    lv_value = 'urn:oasis:names:specification:ubl:schema:xsd:DespatchAdvice-2'.
    lr_el_applicationresponse->set_attribute( name = 'xmlns' value = lv_value ).

    lv_value = 'urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2'.
    lv_rc = lr_el_applicationresponse->set_attribute( name = 'xmlns:cac' value = lv_value ).

    lv_value = 'urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2'.
    lv_rc = lr_el_applicationresponse->set_attribute( name = 'xmlns:cbc' value = lv_value ).

    lv_value = 'http://www.w3.org/2001/XMLSchema-instance'.
    lv_rc = lr_el_applicationresponse->set_attribute( name = 'xmlns:xsi' value = lv_value ).

    lv_value = 'urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2'.
    lv_rc = lr_el_applicationresponse->set_attribute( name = 'xmlns:ext' value = lv_value ).

    lv_value = 'urn:oasis:names:specification:ubl:schema:xsd:DespatchAdvice-2 ../xsdrt/maindoc/UBL-DespatchAdvice-2.1.xsd'.
    lv_rc = lr_el_applicationresponse->set_attribute( name = 'xsi:schemaLocation' value = lv_value ).

    lv_value = 'http://www.altova.com/samplexml/other-namespace'.
    lv_rc = lr_el_applicationresponse->set_attribute( name = 'xmlns:n4' value = lv_value ).

    mr_el_waybill  = lr_el_applicationresponse.
    mr_el_waybills = mr_el_waybills.

    which_step( ).
  ENDMETHOD.


  METHOD /MLSFT/if_ed_delivery_xml~node_id.
    DATA: lr_el_node TYPE REF TO if_ixml_element,
          lr_xml_doc TYPE REF TO if_ixml_document.
    lr_xml_doc = ir_xml_document.

    lr_el_node = lr_xml_doc->create_element( name = 'cbc:ID' ).
    lr_el_node->set_value( ms_wbill-id ).
    ir_xml_element->append_child( lr_el_node ).
    which_step( ).
  ENDMETHOD.


  METHOD /MLSFT/if_ed_delivery_xml~node_issuedate.
    DATA: lr_el_node TYPE REF TO if_ixml_element,
          lv_value   TYPE string,
          lr_xml_doc TYPE REF TO if_ixml_document.
    lr_xml_doc = ir_xml_document.
    lr_el_node = lr_xml_doc->create_element( name = 'cbc:IssueDate' ).
    lv_value   = /MLSFT/ed_util=>convert_to_gib_date( iv_date = ms_wbill-issuedate ).
    lr_el_node->set_value( lv_value ).
    ir_xml_element->append_child( lr_el_node ).
    which_step( ).
  ENDMETHOD.


  METHOD /MLSFT/if_ed_delivery_xml~node_issuetime.
    DATA: lr_el_node TYPE REF TO if_ixml_element,
          lv_value   TYPE string,
          lr_xml_doc TYPE REF TO if_ixml_document.
    IF ms_wbill-issuetime IS NOT INITIAL.
      lr_xml_doc = ir_xml_document.
      lr_el_node = lr_xml_doc->create_element( name = 'cbc:IssueTime' ).
      lv_value   = /MLSFT/ed_util=>convert_to_gib_time( iv_time = ms_wbill-issuetime ).
      lr_el_node->set_value( lv_value ).
      ir_xml_element->append_child( lr_el_node ).
      which_step( ).
    ENDIF.
  ENDMETHOD.


  METHOD notes.
    DATA: lr_el_note TYPE REF TO if_ixml_element,
          lr_xml_doc TYPE REF TO if_ixml_document,
          lv_value   TYPE string.

    lr_xml_doc = ir_xml_document.

    DATA lr_row TYPE REF TO data.
    FIELD-SYMBOLS: <row>  TYPE any,
                   <text> TYPE any.

    LOOP AT ms_wbill-notes REFERENCE INTO lr_row.
      ASSIGN lr_row->* TO <row>.
      IF sy-subrc <> 0 OR <row> IS INITIAL.
        CONTINUE.
      ENDIF.

      CLEAR lv_value.
      DATA(lo_td) = cl_abap_typedescr=>describe_by_data( <row> ).

      CASE lo_td->type_kind.
        WHEN cl_abap_typedescr=>typekind_string
          OR cl_abap_typedescr=>typekind_char.
          lv_value = CONV string( <row> ).
        WHEN cl_abap_typedescr=>typekind_struct1
          OR cl_abap_typedescr=>typekind_struct2.
          ASSIGN COMPONENT 'TEXT' OF STRUCTURE <row> TO <text>.
          IF sy-subrc <> 0.
            ASSIGN COMPONENT 'TEXTSTRING' OF STRUCTURE <row> TO <text>.
          ENDIF.
          IF sy-subrc = 0 AND <text> IS ASSIGNED.
            lv_value = CONV string( <text> ).
          ELSE.
            CONTINUE.
          ENDIF.
        WHEN OTHERS.
          CONTINUE.
      ENDCASE.

      IF lv_value IS INITIAL.
        CONTINUE.
      ENDIF.

      lr_el_note = lr_xml_doc->create_element( name = 'cbc:Note' ).
      lr_el_note->set_value( lv_value ).
      ir_xml_element->append_child( lr_el_note ).
      which_step( ).
    ENDLOOP.
  ENDMETHOD.


  METHOD /MLSFT/if_ed_delivery_xml~node_orderreference.
    DATA: lr_orderreference TYPE REF TO if_ixml_element,
          lr_id             TYPE REF TO if_ixml_element,
          lr_ordtypecode    TYPE REF TO if_ixml_element,
          lr_issuedate      TYPE REF TO if_ixml_element,
          lr_xml_doc        TYPE REF TO if_ixml_document,
          lv_value          TYPE string.

    DATA lr_row TYPE REF TO data.
    FIELD-SYMBOLS <orderref> TYPE /mlsft/ed_s_orderref.

    lr_xml_doc = ir_xml_document.

    LOOP AT me->ms_wbill-orderref REFERENCE INTO lr_row.
      ASSIGN lr_row->* TO <orderref>.
      IF sy-subrc <> 0 OR <orderref> IS INITIAL.
        CONTINUE.
      ENDIF.

      IF <orderref>-issuedate IS INITIAL.
        CONTINUE.
      ENDIF.

      lr_orderreference = lr_xml_doc->create_element( name = 'cac:OrderReference' ).

      lv_value = /mlsft/ed_util=>convert_to_gib_date( iv_date = <orderref>-issuedate ).
      lr_issuedate = lr_xml_doc->create_element( name = 'cbc:IssueDate' ).
      lr_issuedate->set_value( lv_value ).

      lr_id = lr_xml_doc->create_element( name = 'cbc:ID' ).
      lv_value = <orderref>-id.
      lr_id->set_value( lv_value ).

      lr_orderreference->append_child( lr_id ).
      lr_orderreference->append_child( lr_issuedate ).

      IF <orderref>-ordertypecode IS NOT INITIAL.
        lr_ordtypecode = lr_xml_doc->create_element( name = 'cbc:OrderTypeCode' ).
        lv_value = <orderref>-ordertypecode.
        lr_ordtypecode->set_value( lv_value ).
        lr_orderreference->append_child( lr_ordtypecode ).
      ENDIF.

      ir_xml_element->append_child( lr_orderreference ).
    ENDLOOP.

    which_step( ).
  ENDMETHOD.


  METHOD originatorcustomerparty.
    DATA: lr_dsupparty TYPE REF TO if_ixml_element,
          lr_party     TYPE REF TO if_ixml_element,
          lr_dcontact  TYPE REF TO if_ixml_element,
          lr_name      TYPE REF TO if_ixml_element,
          lr_xml_doc   TYPE REF TO if_ixml_document.

    DATA ls_party TYPE /mlsft/ed_s_dsparty.
    ls_party = ms_wbill-parties.

    IF ls_party IS INITIAL OR
       ls_party-partytype <> /mlsft/ed_constants=>orinatorcustomerparty.
      RETURN.
    ENDIF.

    lr_xml_doc   = ir_xml_document.
    lr_dsupparty = lr_xml_doc->create_element( name = 'cac:OriginatorCustomerParty' ).

    node_party(
      EXPORTING
        ir_xml_document = ir_xml_document
        i_partyname     = 'Party'
        i_party         = ls_party-party
      RECEIVING
        re_element      = lr_party
    ).
    lr_dsupparty->append_child( lr_party ).

    DATA lv_name TYPE string.
    LOOP AT ls_party-contact INTO lv_name.
      IF lv_name IS INITIAL.
        CONTINUE.
      ENDIF.
      lr_dcontact = lr_xml_doc->create_element( name = 'cac:OriginatorCustomerPartyContact' ).
      lr_name     = lr_xml_doc->create_element( name = 'cbc:Name' ).
      lr_name->set_value( lv_name ).
      lr_dcontact->append_child( lr_name ).
      lr_dsupparty->append_child( lr_dcontact ).
    ENDLOOP.

    ir_xml_element->append_child( lr_dsupparty ).
    which_step( ).
  ENDMETHOD.


  METHOD /MLSFT/if_ed_delivery_xml~node_profileid.
    DATA: lr_el_node TYPE REF TO if_ixml_element,
          lv_value   TYPE string,
          lr_xml_doc TYPE REF TO if_ixml_document.
    lr_xml_doc = ir_xml_document.
    lr_el_node = lr_xml_doc->create_element( name = 'cbc:ProfileID' ).
    lv_value   = 'TEMELIRSALIYE'.
    lr_el_node->set_value( lv_value ).
    ir_xml_element->append_child( lr_el_node ).
    which_step( ).
  ENDMETHOD.


  METHOD sellersupplierparty.
    DATA: lr_dsupparty TYPE REF TO if_ixml_element,
          lr_party     TYPE REF TO if_ixml_element,
          lr_dcontact  TYPE REF TO if_ixml_element,
          lr_name      TYPE REF TO if_ixml_element,
          lr_xml_doc   TYPE REF TO if_ixml_document.

    DATA ls_party TYPE /mlsft/ed_s_dsparty.
    ls_party = ms_wbill-parties.

    IF ls_party IS INITIAL OR
       ls_party-partytype <> /mlsft/ed_constants=>sellersupplierparty.
      RETURN.
    ENDIF.

    lr_xml_doc   = ir_xml_document.
    lr_dsupparty = lr_xml_doc->create_element( name = 'cac:SellerSupplierParty' ).

    node_party(
      EXPORTING
        ir_xml_document = ir_xml_document
        i_partyname     = 'Party'
        i_party         = ls_party-party
      RECEIVING
        re_element      = lr_party
    ).
    lr_dsupparty->append_child( lr_party ).

    DATA lv_name TYPE string.
    LOOP AT ls_party-contact INTO lv_name.
      IF lv_name IS INITIAL.
        CONTINUE.
      ENDIF.
      lr_dcontact = lr_xml_doc->create_element( name = 'cac:SellerSupplierPartyContact' ).
      lr_name     = lr_xml_doc->create_element( name = 'cbc:Name' ).
      lr_name->set_value( lv_name ).
      lr_dcontact->append_child( lr_name ).
      lr_dsupparty->append_child( lr_dcontact ).
    ENDLOOP.

    ir_xml_element->append_child( lr_dsupparty ).
    which_step( ).
  ENDMETHOD.


  METHOD /mlsft/if_ed_delivery_xml~node_shipment.
    DATA: lr_el_shipment    TYPE REF TO if_ixml_element,
          lr_el_child       TYPE REF TO if_ixml_element,
          lr_xml_doc        TYPE REF TO if_ixml_document,
          lr_shipmentstage  TYPE REF TO if_ixml_element,
          lr_tmeans         TYPE REF TO if_ixml_element,
          lr_roadtransport  TYPE REF TO if_ixml_element,
          lr_delivery       TYPE REF TO if_ixml_element,
          lr_deliveryaddres TYPE REF TO if_ixml_element,
          lr_party          TYPE REF TO if_ixml_element.

    DATA ls_shipment TYPE /mlsft/ed_s_shp.
    ls_shipment = ms_wbill-shipment.

    lr_xml_doc     = ir_xml_document.
    lr_el_shipment = lr_xml_doc->create_element( name = 'cac:Shipment' ).

    " ID
    lr_el_child = lr_xml_doc->create_element( name = 'cbc:ID' ).
    lr_el_child->set_value( ls_shipment-ids ).
    lr_el_shipment->append_child( lr_el_child ).

    " Gross
    IF ls_shipment-gwmeasure-amount IS NOT INITIAL.
      lr_el_child = lr_xml_doc->create_element( name = 'cbc:GrossWeightMeasure' ).
      lr_el_child->set_value( ls_shipment-gwmeasure-amount ).
      lr_el_child->set_attribute(
        name  = 'unitCode'
        value = /mlsft/ed_util=>convert_unit_measurement( ls_shipment-gwmeasure-unitcode ) ).
      lr_el_shipment->append_child( lr_el_child ).
    ENDIF.

    " Net
    IF ls_shipment-nwmeasure-amount IS NOT INITIAL.
      lr_el_child = lr_xml_doc->create_element( name = 'cbc:NetWeightMeasure' ).
      lr_el_child->set_value( ls_shipment-nwmeasure-amount ).
      lr_el_child->set_attribute(
        name  = 'unitCode'
        value = /mlsft/ed_util=>convert_unit_measurement( ls_shipment-nwmeasure-unitcode ) ).
      lr_el_shipment->append_child( lr_el_child ).
    ENDIF.

    " Delivery node
    lr_delivery = lr_xml_doc->create_element( name = 'cac:Delivery' ).

    IF ms_wbill-shipment-delivery-delvadr IS NOT INITIAL.
      node_address_delivery(
        EXPORTING is_address       = ms_wbill-shipment-delivery-delvadr
        CHANGING  cr_postaladdress = lr_deliveryaddres
                  cr_xml_doc       = lr_xml_doc ).
    ELSEIF ms_wbill-parties-party-postaladdress IS NOT INITIAL.
      DATA(ls_del_addr) = ms_wbill-parties-party-postaladdress.
      IF ls_del_addr-postalzone IS INITIAL AND ls_del_addr-postbox IS NOT INITIAL.
        ls_del_addr-postalzone = ls_del_addr-postbox.
      ENDIF.
      node_address_delivery(
        EXPORTING is_address       = ls_del_addr
        CHANGING  cr_postaladdress = lr_deliveryaddres
                  cr_xml_doc       = lr_xml_doc ).
    ENDIF.

    IF lr_deliveryaddres IS BOUND.
      lr_delivery->append_child( lr_deliveryaddres ).
    ENDIF.

    " CarrierParty
    IF ls_shipment-carrierparty-partyname IS NOT INITIAL.
      node_party(
        EXPORTING ir_xml_document = ir_xml_document
                  i_partyname     = 'CarrierParty'
                  i_party         = ls_shipment-carrierparty
        RECEIVING re_element      = lr_party ).
      IF lr_party IS BOUND.
        lr_delivery->append_child( lr_party ).
      ENDIF.
    ENDIF.

    " Despatch date/time
    DATA(lr_despatch) = lr_xml_doc->create_element( name = 'cac:Despatch' ).
    lr_el_child = lr_xml_doc->create_element( name = 'cbc:ActualDespatchDate' ).
    lr_el_child->set_value( /mlsft/ed_util=>convert_to_gib_date( iv_date = ls_shipment-delivery-despatch-addate ) ).
    lr_despatch->append_child( lr_el_child ).

    lr_el_child = lr_xml_doc->create_element( name = 'cbc:ActualDespatchTime' ).
    lr_el_child->set_value( /mlsft/ed_util=>convert_to_gib_time( ls_shipment-delivery-despatch-adtime ) ).
    lr_despatch->append_child( lr_el_child ).
    lr_delivery->append_child( lr_despatch ).
    lr_el_shipment->append_child( lr_delivery ).

    ir_xml_element->append_child( lr_el_shipment ).
    which_step( ).
  ENDMETHOD.


  METHOD /MLSFT/if_ed_delivery_xml~node_signature.
    DATA: lr_el_signature           TYPE REF TO if_ixml_element,
          lr_el_signatoryparty      TYPE REF TO if_ixml_element,
          lr_el_partyidentification TYPE REF TO if_ixml_element,
          lr_el_postaladdress       TYPE REF TO if_ixml_element,
          lr_el_country             TYPE REF TO if_ixml_element,
          lr_el_node                TYPE REF TO if_ixml_element,
          lr_el_child               TYPE REF TO if_ixml_element,
          lr_el_dsattachment        TYPE REF TO if_ixml_element,
          lr_el_externalreference   TYPE REF TO if_ixml_element,
          lr_xml_doc                TYPE REF TO if_ixml_document,
          lv_value                  TYPE string.

    DATA ls_signature TYPE /MLSFT/ed_s_party.
    ls_signature = ms_wbill-signature.

    DATA ls_partiden TYPE /MLSFT/ed_s_partyidentif.

    lr_xml_doc = ir_xml_document.
    lr_el_signature = lr_xml_doc->create_element( name = 'cac:Signature' ).

    lr_el_child = lr_xml_doc->create_element( name = 'cbc:ID' ).
    lv_value =  ls_partiden-id.
    lr_el_child->set_value( lv_value ).
    lr_el_child->set_attribute( name  = 'schemeID' value =  'VKN_TCKN' ).
    lr_el_signature->append_child( lr_el_child ).

    lr_el_signatoryparty = lr_xml_doc->create_element( name = 'cac:SignatoryParty' ).
    IF ls_signature-websuri IS NOT INITIAL.
      lr_el_child = lr_xml_doc->create_element( name = 'cbc:WebsiteURI' ).
      lv_value = ls_signature-websuri.
      lr_el_child->set_value( lv_value ).
      lr_el_signatoryparty->append_child( lr_el_child ).
    ENDIF.

    lr_el_partyidentification = lr_xml_doc->create_element( name = 'cac:PartyIdentification' ).
    lr_el_child = lr_xml_doc->create_element( name = 'cbc:ID' ).
    lv_value =  ls_partiden-id.
    lr_el_child->set_value( lv_value ).
    lr_el_child->set_attribute( name  = 'schemeID' value = ls_partiden-schemeid ).
    lr_el_partyidentification->append_child( lr_el_child ).
    lr_el_signatoryparty->append_child( lr_el_partyidentification ).

    lr_el_signature->append_child( lr_el_signatoryparty ).

    lr_el_postaladdress =  lr_xml_doc->create_element( name = 'cac:PostalAddress' ).

    lr_el_node = lr_xml_doc->create_element( name = 'cbc:StreetName' ).
    lv_value = ls_signature-postaladdress-streetname.
    lr_el_node->set_value( lv_value ).
    lr_el_postaladdress->append_child( lr_el_node ).

    lr_el_node = lr_xml_doc->create_element( name = 'cbc:CitySubdivisionName' ).
    lv_value = ls_signature-postaladdress-csubdivisionname.
    lr_el_node->set_value( lv_value ).
    lr_el_postaladdress->append_child( lr_el_node ).

    lr_el_node = lr_xml_doc->create_element( name = 'cbc:CityName' ).
    lv_value = ls_signature-postaladdress-cityname.
    lr_el_node->set_value( lv_value ).
    lr_el_postaladdress->append_child( lr_el_node ).

    lr_el_node = lr_xml_doc->create_element( name = 'cbc:PostalZone' ).
    lv_value = ls_signature-postaladdress-postalzone.
    lr_el_node->set_value( lv_value ).
    lr_el_postaladdress->append_child( lr_el_node ).

    lr_el_country = lr_xml_doc->create_element( name = 'cac:Country' ).
    lr_el_child =  lr_xml_doc->create_element( name = 'cbc:Name' ).
    lv_value   = ls_signature-postaladdress-country-name.
    lr_el_child->set_value( lv_value ).
    lr_el_country->append_child( lr_el_child ).
    lr_el_postaladdress->append_child( lr_el_country ).

    lr_el_node = lr_xml_doc->create_element( name = 'cac:PartyTaxScheme' ).
    DATA(lr_taxscheme) = lr_xml_doc->create_element( name = 'cac:TaxScheme' ).
    lr_el_child = lr_xml_doc->create_element( name = 'cbc:Name' ).
    lv_value = ls_signature-partytaxscheme-name.
    lr_el_child->set_value( lv_value ).
    lr_taxscheme->append_child( lr_el_child ).
    lr_el_node->append_child( lr_taxscheme ).
    lr_el_signatoryparty->append_child( lr_el_node ).

    DATA(lr_contact) = lr_xml_doc->create_element( name = 'cac:Contact' ).
    IF ls_signature-contact-tel IS NOT INITIAL.
      lr_el_child = lr_xml_doc->create_element( name = 'cbc:Telephone' ).
      lr_el_child->set_value( ls_signature-contact-tel ).
      lr_contact->append_child( lr_el_child ).
    ENDIF.
    IF ls_signature-contact-fax IS NOT INITIAL.
      lr_el_child = lr_xml_doc->create_element( name = 'cbc:Telefax' ).
      lr_el_child->set_value( ls_signature-contact-fax ).
      lr_contact->append_child( lr_el_child ).
    ENDIF.
    IF ls_signature-contact-mail IS NOT INITIAL.
      lr_el_child = lr_xml_doc->create_element( name = 'cbc:ElectronicMail' ).
      lr_el_child->set_value( ls_signature-contact-mail ).
      lr_contact->append_child( lr_el_child ).
    ENDIF.
    lr_el_signatoryparty->append_child( lr_contact ).

    lr_el_signature->append_child( lr_el_signatoryparty ).
    lr_el_dsattachment      = lr_xml_doc->create_element( name = 'cac:DigitalSignatureAttachment' ).
    lr_el_externalreference = lr_xml_doc->create_element( name = 'cac:ExternalReference' ).
    lr_el_child             = lr_xml_doc->create_element( name = 'cbc:URI' ).
    CONCATENATE '#Signature' '' INTO lv_value SEPARATED BY '_'.
    lr_el_child->set_value( lv_value ).
    lr_el_externalreference->append_child( lr_el_child ).
    lr_el_dsattachment->append_child( lr_el_externalreference ).
    lr_el_signature->append_child( lr_el_dsattachment ).
    ir_xml_element->append_child( lr_el_signature ).
    which_step( ).
  ENDMETHOD.


  METHOD /MLSFT/if_ed_delivery_xml~node_ublextensions.
    DATA: lr_el_ublextensions    TYPE REF TO if_ixml_element,
          lr_el_ublextension     TYPE REF TO if_ixml_element,
          lr_el_extensioncontent TYPE REF TO if_ixml_element,
          lr_xml_doc             TYPE REF TO if_ixml_document.

    lr_xml_doc = ir_xml_document.
    lr_el_ublextensions   = lr_xml_doc->create_element( name = 'ext:UBLExtensions' ).
    lr_el_ublextension    = lr_xml_doc->create_element( name = 'ext:UBLExtension' ).
    lr_el_extensioncontent = lr_xml_doc->create_element( name = 'ext:ExtensionContent' ).

    lr_el_ublextensions->append_child( lr_el_ublextension ).
    lr_el_ublextension->append_child( lr_el_extensioncontent ).

    mr_el_waybill->append_child( lr_el_ublextensions ).
    ir_xml_element->append_child( lr_el_ublextensions ).
    which_step( ).
  ENDMETHOD.


  METHOD /MLSFT/if_ed_delivery_xml~node_ublversionid.
    DATA: lr_el_node TYPE REF TO if_ixml_element,
          lr_xml_doc TYPE REF TO if_ixml_document.
    lr_xml_doc = ir_xml_document.
    lr_el_node = lr_xml_doc->create_element( name = 'cbc:UBLVersionID' ).
    lr_el_node->set_value( '2.1' ).
    ir_xml_element->append_child( lr_el_node ).
    which_step( ).
  ENDMETHOD.


  METHOD /MLSFT/if_ed_delivery_xml~node_uuid.
    DATA: lr_el_node TYPE REF TO if_ixml_element,
          lr_xml_doc TYPE REF TO if_ixml_document.
    lr_xml_doc = ir_xml_document.
    lr_el_node = lr_xml_doc->create_element( name = 'cbc:UUID' ).

    lr_el_node->set_value( CONV string( ms_ref-uuid ) ).
    ir_xml_element->append_child( lr_el_node ).
    which_step( ).
  ENDMETHOD.


  METHOD add_item_note.
    DATA lr_selleritem       TYPE REF TO if_ixml_element.
    DATA lr_iteminstance     TYPE REF TO if_ixml_element.
    DATA lr_additemproperty  TYPE REF TO if_ixml_element.
    DATA lr_lotide           TYPE REF TO if_ixml_element.
    DATA lr_node             TYPE REF TO if_ixml_element.
    DATA lv_value            TYPE string.

    er_item = cr_xml_doc->create_element( name = 'cac:Item' ).

    IF cs_line-desc IS NOT INITIAL.
      lr_node  = cr_xml_doc->create_element( name = 'cbc:Description' ).
      lr_node->set_value( cs_line-desc ).
      er_item->append_child( lr_node ).
    ENDIF.

    lr_node  = cr_xml_doc->create_element( name = 'cbc:Name' ).
    lr_node->set_value( cs_line-name ).
    er_item->append_child( lr_node ).

    IF cs_line-keyword IS NOT INITIAL.
      lr_node  = cr_xml_doc->create_element( name = 'cbc:Keyword' ).
      lr_node->set_value( cs_line-keyword ).
      er_item->append_child( lr_node ).
    ENDIF.

    IF cs_line-brandname IS NOT INITIAL.
      lr_node  = cr_xml_doc->create_element( name = 'cbc:BrandName' ).
      lr_node->set_value( cs_line-brandname ).
      er_item->append_child( lr_node ).
    ENDIF.

    IF cs_line-modelname IS NOT INITIAL.
      lr_node  = cr_xml_doc->create_element( name = 'cbc:ModelName' ).
      lr_node->set_value( cs_line-modelname ).
      er_item->append_child( lr_node ).
    ENDIF.

    IF cs_line-bitmident IS NOT INITIAL.
      lr_selleritem = cr_xml_doc->create_element( name = 'cac:BuyersItemIdentification' ).
      lr_node  = cr_xml_doc->create_element( name = 'cbc:ID' ).
      lr_node->set_value( cs_line-bitmident ).
      lr_selleritem->append_child( lr_node ).
      er_item->append_child( lr_selleritem ).
    ENDIF.

    IF cs_line-sitmident IS NOT INITIAL.
      lr_selleritem = cr_xml_doc->create_element( name = 'cac:SellersItemIdentification' ).
      lr_node  = cr_xml_doc->create_element( name = 'cbc:ID' ).
      lr_node->set_value( cs_line-sitmident ).
      lr_selleritem->append_child( lr_node ).
      er_item->append_child( lr_selleritem ).
    ENDIF.

    IF cs_line-mitmident IS NOT INITIAL.
      lr_selleritem = cr_xml_doc->create_element( name = 'cac:ManufacturersItemIdentification' ).
      lr_node  = cr_xml_doc->create_element( name = 'cbc:ID' ).
      lr_node->set_value( cs_line-mitmident ).
      lr_selleritem->append_child( lr_node ).
      er_item->append_child( lr_selleritem ).
    ENDIF.

    IF cs_line-iteminstance IS NOT INITIAL.
      lr_iteminstance = cr_xml_doc->create_element( name = 'cac:ItemInstance' ).

      IF cs_line-iteminstance-ptraceid IS NOT INITIAL.
        lr_node  = cr_xml_doc->create_element( name = 'cbc:ProductTraceID' ).
        lr_node->set_value( cs_line-iteminstance-ptraceid ).
        lr_iteminstance->append_child( lr_node ).
      ENDIF.

      DATA lr_addproperty TYPE REF TO /MLSFT/ed_st_addproperty.
      FIELD-SYMBOLS <ap> TYPE /MLSFT/ed_st_addproperty.

      LOOP AT cs_line-iteminstance-addproperty INTO lr_addproperty.
        IF lr_addproperty IS INITIAL.
          CONTINUE.
        ENDIF.
        ASSIGN lr_addproperty->* TO <ap>.
        IF sy-subrc <> 0 OR <ap> IS INITIAL.
          CONTINUE.
        ENDIF.

        lr_additemproperty = cr_xml_doc->create_element( name = 'cac:AdditionalItemProperty' ).

        lr_node  = cr_xml_doc->create_element( name = 'cbc:ID' ).
        lr_node->set_value( <ap>-id ).
        lr_additemproperty->append_child( lr_node ).

        lr_node  = cr_xml_doc->create_element( name = 'cbc:Name' ).
        lr_node->set_value( <ap>-name ).
        lr_additemproperty->append_child( lr_node ).

        lr_node  = cr_xml_doc->create_element( name = 'cbc:NameCode' ).
        lr_node->set_value( <ap>-name_code ).
        lr_additemproperty->append_child( lr_node ).

        lr_node  = cr_xml_doc->create_element( name = 'cbc:Value' ).
        lr_node->set_value( <ap>-value ).
        lr_additemproperty->append_child( lr_node ).

        lr_iteminstance->append_child( lr_additemproperty ).
      ENDLOOP.

      IF cs_line-iteminstance-lotident-lotnumberid IS NOT INITIAL.
        lr_lotide = cr_xml_doc->create_element( name = 'cac:LotIdentification' ).
        lr_node   = cr_xml_doc->create_element( name = 'cbc:LotNumberID' ).
        lr_node->set_value( cs_line-iteminstance-lotident-lotnumberid ).
        lr_lotide->append_child( lr_node ).
        lr_iteminstance->append_child( lr_lotide ).
      ENDIF.

      er_item->append_child( lr_iteminstance ).
    ENDIF.
  ENDMETHOD.


  METHOD add_message_to_log.
    DATA: lv_priority TYPE string.
    CHECK mr_appl_log IS BOUND.
    lv_priority = iv_priority.
    IF lv_priority IS INITIAL.
**    iv_priority = gc_error.
      lv_priority = '3'.
    ENDIF.
  ENDMETHOD.


  METHOD add_node.
    DATA lr_xml_doc TYPE REF TO if_ixml_document.
    lr_xml_doc = ir_xml_document.
    re_element = lr_xml_doc->create_element( name = im_nodename ).
    re_element->set_value( CONV string( im_value ) ).
  ENDMETHOD.


  METHOD add_price_node.
    DATA lr_xml_doc TYPE REF TO if_ixml_document.
    lr_xml_doc = ir_xml_document.
    re_element = lr_xml_doc->create_element( name = im_nodename ).
    re_element->set_value( im_value-amount ).
    re_element->set_attribute(
      name  = 'currencyID'
      value = /MLSFT/ed_util=>convert_gib_currency( im_value-currency ) ).
  ENDMETHOD.


  METHOD add_quantity_node.
    DATA lr_xml_doc TYPE REF TO if_ixml_document.
    lr_xml_doc = ir_xml_document.
    re_element = lr_xml_doc->create_element( name = im_nodename ).
    re_element->set_value( im_value-amount ).
    re_element->set_attribute(
      name  = 'unitCode'
      value = /mlsft/ed_util=>convert_unit_measurement( im_value-unitcode ) ).
  ENDMETHOD.


  METHOD build_xml_binary.
    DATA(lo_stream) = cl_sxml_string_writer=>create( type = if_sxml=>co_xt_xml10 ).
    DATA(lo_writer) = CAST if_sxml_writer( lo_stream ).

    lo_writer->open_element( name = 'DespatchAdvice' ).

    " === head ===
    lo_writer->open_element( name = 'cbc:ID' ).
    lo_writer->write_value( value = 'ID-001' ).
    lo_writer->close_element( ).

    " === ublExtensions ===
    lo_writer->open_element( name = 'ext:UBLExtensions' ).
    lo_writer->open_element( name = 'ext:UBLExtension' ).
    lo_writer->open_element( name = 'ext:ExtensionContent' ).
    lo_writer->close_element( ).
    lo_writer->close_element( ).
    lo_writer->close_element( ).

    " === UBLVersionID ===
    lo_writer->open_element( name = 'cbc:UBLVersionID' ).
    lo_writer->write_value( value = '2.1' ).
    lo_writer->close_element( ).

    " === CustomizationID ===
    lo_writer->open_element( name = 'cbc:CustomizationID' ).
    lo_writer->write_value( value = 'TR1.2' ).
    lo_writer->close_element( ).

    " === ProfileID ===
    lo_writer->open_element( name = 'cbc:ProfileID' ).
    lo_writer->write_value( value = 'EWaybill' ).
    lo_writer->close_element( ).

    " === ID ===
    lo_writer->open_element( name = 'cbc:ID' ).
    lo_writer->write_value( value = 'WAYBILL-0001' ).
    lo_writer->close_element( ).

    " === CopyIndicator ===
    lo_writer->open_element( name = 'cbc:CopyIndicator' ).
    lo_writer->write_value( value = 'false' ).
    lo_writer->close_element( ).

    " === UUID ===
    lo_writer->open_element( name = 'cbc:UUID' ).
    lo_writer->write_value( value = '00000000-0000-0000-0000-000000000000' ).
    lo_writer->close_element( ).

    " === IssueDate ===
    lo_writer->open_element( name = 'cbc:IssueDate' ).
    lo_writer->write_value( value = '2025-01-01' ).
    lo_writer->close_element( ).

    " === IssueTime ===
    lo_writer->open_element( name = 'cbc:IssueTime' ).
    lo_writer->write_value( value = '10:00:00' ).
    lo_writer->close_element( ).

    " === DespatchAdviceTypeCode ===
    lo_writer->open_element( name = 'cbc:DespatchAdviceTypeCode' ).
    lo_writer->write_value( value = 'Send' ).
    lo_writer->close_element( ).

    " === Notes ===
    lo_writer->open_element( name = 'cbc:Note' ).
    lo_writer->write_value( value = 'Sample note' ).
    lo_writer->close_element( ).

    " === OrderReference ===
    lo_writer->open_element( name = 'cac:OrderReference' ).
    lo_writer->open_element( name = 'cbc:ID' ).
    lo_writer->write_value( value = 'PO-12345' ).
    lo_writer->close_element( ).
    lo_writer->close_element( ).

    " === AdditionalDocumentReference ===
    lo_writer->open_element( name = 'cac:AdditionalDocumentReference' ).
    lo_writer->open_element( name = 'cbc:ID' ).
    lo_writer->write_value( value = 'DOC-REF-1' ).
    lo_writer->close_element( ).
    lo_writer->close_element( ).

    " === Signature ===
    lo_writer->open_element( name = 'cac:Signature' ).
    lo_writer->open_element( name = 'cbc:ID' ).
    lo_writer->write_value( value = 'SIG-1' ).
    lo_writer->close_element( ).
    lo_writer->close_element( ).

    " === DespatchSupplierParty ===
    lo_writer->open_element( name = 'cac:DespatchSupplierParty' ).
    lo_writer->open_element( name = 'cac:Party' ).
    lo_writer->open_element( name = 'cbc:WebsiteURI' ).
    lo_writer->write_value( value = 'https://supplier.example' ).
    lo_writer->close_element( ).
    lo_writer->close_element( ).
    lo_writer->close_element( ).

    " === DeliveryCustomerParty ===
    lo_writer->open_element( name = 'cac:DeliveryCustomerParty' ).
    lo_writer->open_element( name = 'cac:Party' ).
    lo_writer->open_element( name = 'cbc:WebsiteURI' ).
    lo_writer->write_value( value = 'https://customer.example' ).
    lo_writer->close_element( ).
    lo_writer->close_element( ).
    lo_writer->close_element( ).

    " === BuyerCustomerParty ===
    lo_writer->open_element( name = 'cac:BuyerCustomerParty' ).
    lo_writer->open_element( name = 'cac:Party' ).
    lo_writer->open_element( name = 'cbc:EndpointID' ).
    lo_writer->write_value( value = 'BUYER-001' ).
    lo_writer->close_element( ).
    lo_writer->close_element( ).
    lo_writer->close_element( ).

    " === SellerSupplierParty ===
    lo_writer->open_element( name = 'cac:SellerSupplierParty' ).
    lo_writer->open_element( name = 'cac:Party' ).
    lo_writer->open_element( name = 'cbc:EndpointID' ).
    lo_writer->write_value( value = 'SELLER-001' ).
    lo_writer->close_element( ).
    lo_writer->close_element( ).
    lo_writer->close_element( ).

    " === OriginatorCustomerParty ===
    lo_writer->open_element( name = 'cac:OriginatorCustomerParty' ).
    lo_writer->open_element( name = 'cac:Party' ).
    lo_writer->open_element( name = 'cbc:EndpointID' ).
    lo_writer->write_value( value = 'ORIGINATOR-001' ).
    lo_writer->close_element( ).
    lo_writer->close_element( ).
    lo_writer->close_element( ).

    " === Shipment ===
    lo_writer->open_element( name = 'cac:Shipment' ).
    lo_writer->open_element( name = 'cbc:ID' ).
    lo_writer->write_value( value = 'SHIP-001' ).
    lo_writer->close_element( ).
    lo_writer->open_element( name = 'cac:GoodsItem' ).
    lo_writer->open_element( name = 'cbc:Description' ).
    lo_writer->write_value( value = 'Goods description' ).
    lo_writer->close_element( ).
    lo_writer->close_element( ). " GoodsItem
    lo_writer->open_element( name = 'cac:Delivery' ).
    lo_writer->open_element( name = 'cbc:TrackingID' ).
    lo_writer->write_value( value = 'TRACK-001' ).
    lo_writer->close_element( ).
    lo_writer->close_element( ). " Delivery
    lo_writer->close_element( ). " Shipment

    " === DespatchLine ===
    lo_writer->open_element( name = 'cac:DespatchLine' ).
    lo_writer->open_element( name = 'cbc:ID' ).
    lo_writer->write_value( value = '1' ).
    lo_writer->close_element( ).
    lo_writer->open_element( name = 'cac:DeliveredQuantity' ).
    lo_writer->write_value( value = '10' ).
    lo_writer->close_element( ). " DeliveredQuantity
    lo_writer->open_element( name = 'cac:Item' ).
    lo_writer->open_element( name = 'cbc:Description' ).
    lo_writer->write_value( value = 'Item A' ).
    lo_writer->close_element( ). " Description
    lo_writer->close_element( ). " Item
    lo_writer->close_element( ). " DespatchLine

    lo_writer->close_element( ). " DespatchAdvice

    rt_xml_doc = lo_stream->get_output( ).
    close( ).
  ENDMETHOD.


  METHOD constructor.
    ms_wbill = io_mapping->get_main_structure( ).
    ms_ref   = io_delivery->get_reference( ).
  ENDMETHOD.


  METHOD download_file.
    download_file_cloud(
      iv_xml_size  = iv_xml_size
**      it_xml_table = it_xml_table
      iv_xstring   = mv_xsxml ).
    which_step( ).
  ENDMETHOD.


  METHOD get_binary.
    rv_binary = mv_xsxml.
  ENDMETHOD.


  METHOD get_size.
    rv_size = mv_xlen.
  ENDMETHOD.


  METHOD get_xslt_name.
    DATA: ls_txslt TYPE /MLSFT/ed_txslt.
    SELECT SINGLE * FROM /MLSFT/ed_txslt
      WHERE bukrs   = @ms_wbill-bukrs
        AND kschl   = @ms_wbill-kschl
        AND doctype = @/MLSFT/ed_constants=>doc_type_doc_out
      INTO @ls_txslt.
    IF sy-subrc IS INITIAL.
      re_xslt = ls_txslt-xslt.
    ELSE.
      re_xslt = '/MLSFT/ED_STANDART_GIB_IRS'.
    ENDIF.
  ENDMETHOD.


  METHOD node_address.
    DATA lr_el_citysubdivisionname TYPE REF TO if_ixml_element.
    DATA lr_el_cityname TYPE REF TO if_ixml_element.
    DATA lr_el_country TYPE REF TO if_ixml_element.
    DATA lr_el_node TYPE REF TO if_ixml_element.
    DATA lv_value TYPE string.

    cr_postaladdress =  cr_xml_doc->create_element( name = 'cac:PostalAddress' ).

    lr_el_node = cr_xml_doc->create_element( name = 'cbc:ID' ).
    lr_el_node->set_value( is_address-id ).
    cr_postaladdress->append_child( lr_el_node ).

    IF is_address-streetname IS NOT INITIAL.
      lr_el_node = cr_xml_doc->create_element( name = 'cbc:StreetName' ).
      lr_el_node->set_value( is_address-streetname ).
      cr_postaladdress->append_child( lr_el_node ).
    ENDIF.

    IF is_address-buildingnumber IS NOT INITIAL.
      lr_el_node = cr_xml_doc->create_element( name = 'cbc:BuildingNumber' ).
      lr_el_node->set_value( is_address-buildingnumber ).
      cr_postaladdress->append_child( lr_el_node ).
    ENDIF.

    lr_el_citysubdivisionname = cr_xml_doc->create_element( name = 'cbc:CitySubdivisionName' ).
    lr_el_citysubdivisionname->set_value( is_address-csubdivisionname ).
    cr_postaladdress->append_child( lr_el_citysubdivisionname ).

    lr_el_cityname = cr_xml_doc->create_element( name = 'cbc:CityName' ).
    lr_el_cityname->set_value( is_address-cityname ).
    cr_postaladdress->append_child( lr_el_cityname ).

    IF is_address-postalzone IS NOT INITIAL.
      lr_el_node = cr_xml_doc->create_element( name = 'cbc:PostalZone' ).
      lr_el_node->set_value( is_address-postalzone ).
      cr_postaladdress->append_child( lr_el_node ).
    ENDIF.

    IF is_address-region IS NOT INITIAL.
      lr_el_node = cr_xml_doc->create_element( name = 'cbc:Region' ).
      lr_el_node->set_value( is_address-region ).
      cr_postaladdress->append_child( lr_el_node ).
    ENDIF.

    IF is_address-district IS NOT INITIAL.
      lr_el_node = cr_xml_doc->create_element( name = 'cbc:District' ).
      lr_el_node->set_value( is_address-district ).
      cr_postaladdress->append_child( lr_el_node ).
    ENDIF.

    IF is_address-country-code IS NOT INITIAL.
      lr_el_country = cr_xml_doc->create_element( name = 'cac:Country' ).
      lr_el_node = cr_xml_doc->create_element( name = 'cbc:IdentificationCode' ).
      lr_el_node->set_value( is_address-country-code ).
      lr_el_country->append_child( lr_el_node ).
    ENDIF.

    IF is_address-country-name IS NOT INITIAL.
      lr_el_node =  cr_xml_doc->create_element( name = 'cbc:Name' ).
      lr_el_node->set_value( is_address-country-name ).
      lr_el_country->append_child( lr_el_node ).
      cr_postaladdress->append_child( lr_el_country ).
    ENDIF.
  ENDMETHOD.


  METHOD node_address_delivery.
    DATA lr_el_citysubdivisionname TYPE REF TO if_ixml_element.
    DATA lr_el_cityname TYPE REF TO if_ixml_element.
    DATA lr_el_country TYPE REF TO if_ixml_element.
    DATA lr_el_node TYPE REF TO if_ixml_element.
    DATA lv_value TYPE string.

    cr_postaladdress =  cr_xml_doc->create_element( name = 'cac:DeliveryAddress' ).

    lr_el_node = cr_xml_doc->create_element( name = 'cbc:ID' ).
    lr_el_node->set_value( is_address-id ).
    cr_postaladdress->append_child( lr_el_node ).

    IF is_address-streetname IS NOT INITIAL.
      lr_el_node = cr_xml_doc->create_element( name = 'cbc:StreetName' ).
      lr_el_node->set_value( is_address-streetname ).
      cr_postaladdress->append_child( lr_el_node ).
    ENDIF.

    IF is_address-buildingnumber IS NOT INITIAL.
      lr_el_node = cr_xml_doc->create_element( name = 'cbc:BuildingNumber' ).
      lr_el_node->set_value( is_address-buildingnumber ).
      cr_postaladdress->append_child( lr_el_node ).
    ENDIF.

    lr_el_citysubdivisionname = cr_xml_doc->create_element( name = 'cbc:CitySubdivisionName' ).
    lr_el_citysubdivisionname->set_value( is_address-csubdivisionname ).
    cr_postaladdress->append_child( lr_el_citysubdivisionname ).

    lr_el_cityname = cr_xml_doc->create_element( name = 'cbc:CityName' ).
    lr_el_cityname->set_value( is_address-cityname ).
    cr_postaladdress->append_child( lr_el_cityname ).

    IF is_address-postalzone IS NOT INITIAL.
      lr_el_node = cr_xml_doc->create_element( name = 'cbc:PostalZone' ).
      lr_el_node->set_value( is_address-postalzone ).
      cr_postaladdress->append_child( lr_el_node ).
    ENDIF.

    IF is_address-region IS NOT INITIAL.
      lr_el_node = cr_xml_doc->create_element( name = 'cbc:Region' ).
      lr_el_node->set_value( is_address-region ).
      cr_postaladdress->append_child( lr_el_node ).
    ENDIF.

    IF is_address-district IS NOT INITIAL.
      lr_el_node = cr_xml_doc->create_element( name = 'cbc:District' ).
      lr_el_node->set_value( is_address-district ).
      cr_postaladdress->append_child( lr_el_node ).
    ENDIF.

    IF is_address-country-code IS NOT INITIAL.
      lr_el_country = cr_xml_doc->create_element( name = 'cac:Country' ).
      lr_el_node = cr_xml_doc->create_element( name = 'cbc:IdentificationCode' ).
      lr_el_node->set_value( is_address-country-code ).
      lr_el_country->append_child( lr_el_node ).
    ENDIF.

    IF is_address-country-name IS NOT INITIAL.
      lr_el_node =  cr_xml_doc->create_element( name = 'cbc:Name' ).
      lr_el_node->set_value( is_address-country-name ).
      lr_el_country->append_child( lr_el_node ).
      cr_postaladdress->append_child( lr_el_country ).
    ENDIF.
  ENDMETHOD.


  METHOD node_contact.
    DATA lr_el_contact TYPE REF TO if_ixml_element.

    IF i_party-contact IS NOT INITIAL.
      lr_el_contact = cr_xml_doc->create_element( name = 'cac:Contact' ).

      IF i_party-contact-tel IS NOT INITIAL.
        cr_el_child = cr_xml_doc->create_element( name = 'cbc:Telephone' ).
        cv_value = i_party-contact-tel.
        cr_el_child->set_value( cv_value ).
        lr_el_contact->append_child( cr_el_child ).
      ENDIF.

      IF i_party-contact-fax IS NOT INITIAL.
        cr_el_child = cr_xml_doc->create_element( name = 'cbc:Telefax' ).
        cv_value = i_party-contact-fax.
        cr_el_child->set_value( cv_value ).
        lr_el_contact->append_child( cr_el_child ).
      ENDIF.

      IF i_party-contact-mail IS NOT INITIAL.
        cr_el_child = cr_xml_doc->create_element( name = 'cbc:ElectronicMail' ).
        cv_value = i_party-contact-mail.
        cr_el_child->set_value( cv_value ).
        lr_el_contact->append_child( cr_el_child ).
      ENDIF.

      IF i_party-contact-note IS NOT INITIAL.
        cr_el_child = cr_xml_doc->create_element( name = 'cbc:Note' ).
        cv_value = i_party-contact-note.
        cr_el_child->set_value( cv_value ).
        lr_el_contact->append_child( cr_el_child ).
      ENDIF.

      DATA lr_ocomm TYPE REF TO /mlsft/ed_s_ocomm.
      FIELD-SYMBOLS <ls_ocomm> TYPE /mlsft/ed_s_ocomm.

      LOOP AT i_party-contact-othercom INTO lr_ocomm.
        IF lr_ocomm IS INITIAL.
          CONTINUE.
        ENDIF.
        ASSIGN lr_ocomm->* TO <ls_ocomm>.
        IF sy-subrc <> 0 OR <ls_ocomm> IS INITIAL.
          CONTINUE.
        ENDIF.

        cr_el_parent = cr_xml_doc->create_element( name = 'cac:OtherCommunication' ).

        cr_el_node = cr_xml_doc->create_element( name = 'cbc:ChannelCode' ).
        cv_value = <ls_ocomm>-channelcode.
        cr_el_node->set_value( cv_value ).
        cr_el_parent->append_child( cr_el_node ).

        cr_el_node = cr_xml_doc->create_element( name = 'cbc:Channel' ).
        cv_value = <ls_ocomm>-channel.
        cr_el_node->set_value( cv_value ).
        cr_el_parent->append_child( cr_el_node ).

        cr_el_node = cr_xml_doc->create_element( name = 'cbc:Value' ).
        cv_value = <ls_ocomm>-value.
        cr_el_node->set_value( cv_value ).
        cr_el_parent->append_child( cr_el_node ).

        lr_el_contact->append_child( cr_el_parent ).
      ENDLOOP.

      cr_el_party->append_child( lr_el_contact ).
    ENDIF.
  ENDMETHOD.


  METHOD node_party.
    DATA: lr_el_party               TYPE REF TO if_ixml_element,
          lr_el_partyidentification TYPE REF TO if_ixml_element,
          lr_el_partyname           TYPE REF TO if_ixml_element,
          lr_el_name                TYPE REF TO if_ixml_element,
          lr_el_postaladdress       TYPE REF TO if_ixml_element,
          lr_el_node                TYPE REF TO if_ixml_element,
          lr_el_parent              TYPE REF TO if_ixml_element,
          lr_el_child               TYPE REF TO if_ixml_element,
          lr_xml_doc                TYPE REF TO if_ixml_document,
          lv_value                  TYPE string,
          lr_el_physaddress         TYPE REF TO if_ixml_element.

    lr_xml_doc = ir_xml_document.

    DATA(lv_name) = |cac:{ i_partyname }|.
    lr_el_party = lr_xml_doc->create_element( name = lv_name ).

    IF i_party-websuri IS NOT INITIAL.
      lr_el_node = lr_xml_doc->create_element( name = 'cbc:WebsiteURI' ).
      lr_el_node->set_value( i_party-websuri ).
      lr_el_party->append_child( lr_el_node ).
    ENDIF.

    IF i_party-iclasscode IS NOT INITIAL.
      lr_el_node = lr_xml_doc->create_element( name = 'cbc:IndustryClassificationCode' ).
      lr_el_node->set_value( i_party-iclasscode ).
      lr_el_party->append_child( lr_el_node ).
    ENDIF.

    DATA lr_partyid TYPE REF TO /MLSFT/ed_s_partyidentif.
    FIELD-SYMBOLS <ls_partyid> TYPE /MLSFT/ed_s_partyidentif.

    LOOP AT i_party-partyidentif INTO lr_partyid.
      IF lr_partyid IS INITIAL.
        CONTINUE.
      ENDIF.
      ASSIGN lr_partyid->* TO <ls_partyid>.
      IF sy-subrc <> 0 OR <ls_partyid> IS INITIAL.
        CONTINUE.
      ENDIF.

      lr_el_partyidentification = lr_xml_doc->create_element( name = 'cac:PartyIdentification' ).
      lr_el_node = lr_xml_doc->create_element( name = 'cbc:ID' ).
      lr_el_node->set_value( <ls_partyid>-id ).
      IF <ls_partyid>-schemeid IS NOT INITIAL.
        lr_el_node->set_attribute( name = 'schemeID' value = <ls_partyid>-schemeid ).
      ENDIF.
      lr_el_partyidentification->append_child( lr_el_node ).
      lr_el_party->append_child( lr_el_partyidentification ).
    ENDLOOP.

    lr_el_partyname = lr_xml_doc->create_element( name = 'cac:PartyName' ).
    add_node(
      EXPORTING im_nodename     = 'cbc:Name'
                im_value        = i_party-partyname
                ir_xml_document = lr_xml_doc
      RECEIVING re_element      = lr_el_name ).
    lr_el_partyname->append_child( lr_el_name ).
    lr_el_party->append_child( lr_el_partyname ).

    node_address(
      EXPORTING is_address       = i_party-postaladdress
      CHANGING  cr_postaladdress = lr_el_postaladdress
                cr_xml_doc       = lr_xml_doc ).
    IF lr_el_postaladdress IS BOUND.
      lr_el_party->append_child( lr_el_postaladdress ).
    ENDIF.

    IF i_party-physicalloc IS NOT INITIAL.
      node_phys_address(
        EXPORTING is_address     = i_party-physicalloc
        CHANGING  cr_physaddress = lr_el_physaddress
                  cr_xml_doc     = lr_xml_doc ).
      IF lr_el_physaddress IS BOUND.
        lr_el_party->append_child( lr_el_physaddress ).
      ENDIF.
    ENDIF.

    IF i_party-partytaxscheme IS NOT INITIAL.
      lr_el_parent = lr_xml_doc->create_element( name = 'cac:PartyTaxScheme' ).
      lr_el_node   = lr_xml_doc->create_element( name = 'cac:TaxScheme' ).
      lr_el_child  = lr_xml_doc->create_element( name = 'cbc:Name' ).
      lr_el_child->set_value( i_party-partytaxscheme-name ).
      lr_el_node->append_child( lr_el_child ).
      lr_el_parent->append_child( lr_el_node ).
      lr_el_party->append_child( lr_el_parent ).
    ENDIF.

    node_contact(
      EXPORTING i_party = i_party
      CHANGING  cr_el_party  = lr_el_party
                cr_el_node   = lr_el_node
                cr_el_parent = lr_el_parent
                cr_el_child  = lr_el_child
                cr_xml_doc   = lr_xml_doc
                cv_value     = lv_value ).

    node_person(
      EXPORTING i_party = i_party
      CHANGING  cr_el_party = lr_el_party
                cr_el_node  = lr_el_node
                cr_xml_doc  = lr_xml_doc
                cv_value    = lv_value ).

    re_element = lr_el_party.
    which_step( ).
  ENDMETHOD.


  METHOD node_person.
    DATA lr_el_person   TYPE REF TO if_ixml_element.
    DATA lr_el_faccount TYPE REF TO if_ixml_element.
    DATA lr_el_fibranch TYPE REF TO if_ixml_element.
    DATA lr_el_fib      TYPE REF TO if_ixml_element.

    IF i_party-person IS NOT INITIAL.
      lr_el_person = cr_xml_doc->create_element( name = 'cac:Person' ).

      IF i_party-person-firstname IS NOT INITIAL.
        cr_el_node = cr_xml_doc->create_element( name = 'cbc:FirstName' ).
        cv_value = i_party-person-firstname.
        cr_el_node->set_value( cv_value ).
        lr_el_person->append_child( cr_el_node ).
      ENDIF.

      IF i_party-person-familyname IS NOT INITIAL.
        cr_el_node = cr_xml_doc->create_element( name = 'cbc:FamilyName' ).
        cv_value = i_party-person-familyname.
        cr_el_node->set_value( cv_value ).
        lr_el_person->append_child( cr_el_node ).
      ENDIF.

      IF i_party-person-title IS NOT INITIAL.
        cr_el_node = cr_xml_doc->create_element( name = 'cbc:Title' ).
        cv_value = i_party-person-title.
        cr_el_node->set_value( cv_value ).
        lr_el_person->append_child( cr_el_node ).
      ENDIF.

      IF i_party-person-middlename IS NOT INITIAL.
        cr_el_node = cr_xml_doc->create_element( name = 'cbc:MiddleName' ).
        cv_value = i_party-person-middlename.
        cr_el_node->set_value( cv_value ).
        lr_el_person->append_child( cr_el_node ).
      ENDIF.

      IF i_party-person-namesuffix IS NOT INITIAL.
        cr_el_node = cr_xml_doc->create_element( name = 'cbc:NameSuffix' ).
        cv_value = i_party-person-namesuffix.
        cr_el_node->set_value( cv_value ).
        lr_el_person->append_child( cr_el_node ).
      ENDIF.

      IF i_party-person-nationalityid IS NOT INITIAL.
        cr_el_node = cr_xml_doc->create_element( name = 'cbc:NationalityID' ).
        cv_value = i_party-person-nationalityid.
        cr_el_node->set_value( cv_value ).
        lr_el_person->append_child( cr_el_node ).
      ENDIF.

      IF i_party-person-faccount IS NOT INITIAL.
        lr_el_faccount = cr_xml_doc->create_element( name = 'cac:FinancialAccount' ).

        lr_el_fibranch  = cr_xml_doc->create_element( name = 'cac:FinancialInstitutionBranch' ).
        IF i_party-person-faccount-dinstitutionname IS NOT INITIAL.
          cr_el_node = cr_xml_doc->create_element( name = 'cbc:Name' ).
          cv_value = i_party-person-faccount-dinstitutionname.
          cr_el_node->set_value( cv_value ).
          lr_el_fibranch->append_child( cr_el_node ).
        ENDIF.

        IF i_party-person-faccount-name IS NOT INITIAL.
          lr_el_fib = cr_xml_doc->create_element( name = 'cac:FinancialInstitution' ).
          cr_el_node = cr_xml_doc->create_element( name = 'cbc:Name' ).
          cv_value = i_party-person-faccount-name.
          cr_el_node->set_value( cv_value ).
          lr_el_fib->append_child( cr_el_node ).
          lr_el_fibranch->append_child( lr_el_fib ).
        ENDIF.

        lr_el_faccount->append_child( lr_el_fibranch ).
        lr_el_person->append_child( lr_el_faccount ).
      ENDIF.

      cr_el_party->append_child( lr_el_person ).
    ENDIF.
  ENDMETHOD.


  METHOD prepare_shipment_node.
    DATA: lr_el_child      TYPE REF TO if_ixml_element,
          lr_xml_doc       TYPE REF TO if_ixml_document,
          lv_value         TYPE string,
          lr_tmeans        TYPE REF TO if_ixml_element,
          lr_shipmentstage TYPE REF TO if_ixml_element,
          lr_roadtransport TYPE REF TO if_ixml_element.

    DATA ls_shipment TYPE /MLSFT/ed_s_shp.
    ls_shipment = is_shipment.
    lr_xml_doc  = ir_xml_document.

    rr_shipment = lr_xml_doc->create_element( name = 'cac:Shipment' ).

    lr_el_child = lr_xml_doc->create_element( name = 'cbc:ID' ).
    lr_el_child->set_value( ls_shipment-ids ).
    rr_shipment->append_child( lr_el_child ).

    IF ls_shipment-gwmeasure-amount IS NOT INITIAL.
      lr_el_child = lr_xml_doc->create_element( name = 'cbc:GrossWeightMeasure' ).
      lr_el_child->set_value( ls_shipment-gwmeasure-amount ).
      lv_value = /mlsft/ed_util=>convert_unit_measurement( ls_shipment-gwmeasure-unitcode ).
      lr_el_child->set_attribute( name = 'unitCode' value = lv_value ).
      rr_shipment->append_child( lr_el_child ).
    ENDIF.

    IF ls_shipment-nwmeasure-amount IS NOT INITIAL.
      lr_el_child = lr_xml_doc->create_element( name = 'cbc:NetWeightMeasure' ).
      lr_el_child->set_value( ls_shipment-nwmeasure-amount ).
      lv_value = /mlsft/ed_util=>convert_unit_measurement( ls_shipment-nwmeasure-unitcode ).
      lr_el_child->set_attribute( name = 'unitCode' value = lv_value ).
      rr_shipment->append_child( lr_el_child ).
    ENDIF.

    DATA lr_drv_ref TYPE REF TO /mlsft/ed_s_driver.
    FIELD-SYMBOLS <ls_driver> TYPE /mlsft/ed_s_driver.
    DATA lv_shpstage_control TYPE abap_bool VALUE abap_false.

    LOOP AT ls_shipment-shpstage-drivers INTO lr_drv_ref.
      IF lr_drv_ref IS INITIAL.
        CONTINUE.
      ENDIF.
      ASSIGN lr_drv_ref->* TO <ls_driver>.
      IF sy-subrc <> 0 OR <ls_driver> IS INITIAL.
        CONTINUE.
      ENDIF.
      IF <ls_driver>-nid IS NOT INITIAL
         AND <ls_driver>-fname IS NOT INITIAL
         AND ls_shipment-shpstage-tmeancode-lplateid IS NOT INITIAL.
        lv_shpstage_control = abap_true.
        EXIT.
      ENDIF.
    ENDLOOP.

    IF lv_shpstage_control = abap_true.
      lr_shipmentstage = lr_xml_doc->create_element( name = 'cac:ShipmentStage' ).
      lr_tmeans        = lr_xml_doc->create_element( name = 'cac:TransportMeans' ).
      lr_roadtransport = lr_xml_doc->create_element( name = 'cac:RoadTransport' ).

      lr_el_child = lr_xml_doc->create_element( name = 'cbc:LicensePlateID' ).
      lr_el_child->set_value( ls_shipment-shpstage-tmeancode-lplateid-name ).
      lr_el_child->set_attribute(
        name  = 'schemeID'
        value = ls_shipment-shpstage-tmeancode-lplateid-taxtypecode ).
      lr_roadtransport->append_child( lr_el_child ).
      lr_tmeans->append_child( lr_roadtransport ).
      lr_shipmentstage->append_child( lr_tmeans ).

      LOOP AT ls_shipment-shpstage-drivers INTO lr_drv_ref.
        IF lr_drv_ref IS INITIAL.
          CONTINUE.
        ENDIF.
        ASSIGN lr_drv_ref->* TO <ls_driver>.
        IF sy-subrc <> 0 OR <ls_driver> IS INITIAL.
          CONTINUE.
        ENDIF.

        DATA(lr_driverperson) = lr_xml_doc->create_element( name = 'cac:DriverPerson' ).

        lr_el_child = lr_xml_doc->create_element( name = 'cbc:FirstName' ).
        lr_el_child->set_value( <ls_driver>-fname ).
        lr_driverperson->append_child( lr_el_child ).

        lr_el_child = lr_xml_doc->create_element( name = 'cbc:FamilyName' ).
        lr_el_child->set_value( <ls_driver>-lname ).
        lr_driverperson->append_child( lr_el_child ).

        IF <ls_driver>-title IS NOT INITIAL.
          lr_el_child = lr_xml_doc->create_element( name = 'cbc:Title' ).
          lr_el_child->set_value( <ls_driver>-title ).
          lr_driverperson->append_child( lr_el_child ).
        ENDIF.

        IF <ls_driver>-nid IS NOT INITIAL.
          lr_el_child = lr_xml_doc->create_element( name = 'cbc:NationalityID' ).
          lr_el_child->set_value( <ls_driver>-nid ).
          lr_driverperson->append_child( lr_el_child ).
        ENDIF.

        lr_shipmentstage->append_child( lr_driverperson ).
      ENDLOOP.

      rr_shipment->append_child( lr_shipmentstage ).
    ENDIF.

    DATA lr_delivery TYPE REF TO if_ixml_element.
    lr_delivery = lr_xml_doc->create_element( name = 'cac:Delivery' ).

    IF ls_shipment-delivery-despatch IS NOT INITIAL.
      DATA(lr_despatch) = lr_xml_doc->create_element( name = 'cac:Despatch' ).

      IF ls_shipment-delivery-despatch-addate IS NOT INITIAL.
        lr_el_child = lr_xml_doc->create_element( name = 'cbc:ActualDespatchDate' ).
        lr_el_child->set_value( /mlsft/ed_util=>convert_to_gib_date( ls_shipment-delivery-despatch-addate ) ).
        lr_despatch->append_child( lr_el_child ).
      ENDIF.

      IF ls_shipment-delivery-despatch-adtime IS NOT INITIAL.
        lr_el_child = lr_xml_doc->create_element( name = 'cbc:ActualDespatchTime' ).
        lr_el_child->set_value( /mlsft/ed_util=>convert_to_gib_time( ls_shipment-delivery-despatch-adtime ) ).
        lr_despatch->append_child( lr_el_child ).
      ENDIF.

      lr_delivery->append_child( lr_despatch ).
    ENDIF.

    IF ls_shipment-carrierparty-partyname IS NOT INITIAL.
      DATA lr_party TYPE REF TO if_ixml_element.
      CLEAR lr_party.
      node_party(
        EXPORTING ir_xml_document = ir_xml_document
                  i_partyname     = 'CarrierParty'
                  i_party         = ls_shipment-carrierparty
        RECEIVING re_element      = lr_party ).
      IF lr_party IS BOUND.
        lr_delivery->append_child( lr_party ).
      ENDIF.
    ENDIF.

    IF ls_shipment-thunit IS NOT INITIAL.
      DATA(lr_trhunit) = lr_xml_doc->create_element( name = 'cac:TransportHandlingUnit' ).

      FIELD-SYMBOLS <thunit> TYPE any.
      ASSIGN ls_shipment-thunit TO <thunit>.
      IF sy-subrc = 0 AND <thunit> IS ASSIGNED.
        FIELD-SYMBOLS <actualpack_tab> TYPE STANDARD TABLE.
        ASSIGN COMPONENT 'ACTUALPACK' OF STRUCTURE <thunit> TO <actualpack_tab>.
        IF sy-subrc = 0 AND <actualpack_tab> IS ASSIGNED.
          DATA lr_actualpack TYPE REF TO /mlsft/ed_s_actpc.
          FIELD-SYMBOLS <ls_actualpack> TYPE /mlsft/ed_s_actpc.

          LOOP AT <actualpack_tab> REFERENCE INTO lr_actualpack.
            IF lr_actualpack IS INITIAL.
              CONTINUE.
            ENDIF.
            ASSIGN lr_actualpack->* TO <ls_actualpack>.
            IF sy-subrc <> 0 OR <ls_actualpack> IS INITIAL.
              CONTINUE.
            ENDIF.

            DATA(lr_actualpackage) = lr_xml_doc->create_element( name = 'cac:ActualPackage' ).

            IF <ls_actualpack>-id IS NOT INITIAL.
              lr_el_child = lr_xml_doc->create_element( name = 'cbc:ID' ).
              lr_el_child->set_value( <ls_actualpack>-id ).
              lr_actualpackage->append_child( lr_el_child ).
            ENDIF.

            IF <ls_actualpack>-quan-amount IS NOT INITIAL OR <ls_actualpack>-quan-unitcode IS NOT INITIAL.
              lr_el_child = lr_xml_doc->create_element( name = 'cbc:Quantity' ).
              IF <ls_actualpack>-quan-amount IS NOT INITIAL.
                lr_el_child->set_value( <ls_actualpack>-quan-amount ).
              ENDIF.
              IF <ls_actualpack>-quan-unitcode IS NOT INITIAL.
                lv_value = /mlsft/ed_util=>convert_unit_measurement( <ls_actualpack>-quan-unitcode ).
                lr_el_child->set_attribute( name = 'unitCode' value = lv_value ).
              ENDIF.
              lr_actualpackage->append_child( lr_el_child ).
            ENDIF.

            IF <ls_actualpack>-pcklevelcode IS NOT INITIAL.
              lr_el_child = lr_xml_doc->create_element( name = 'cbc:PackageLevelCode' ).
              lr_el_child->set_value( <ls_actualpack>-pcklevelcode ).
              lr_actualpackage->append_child( lr_el_child ).
            ENDIF.

            IF <ls_actualpack>-packtypecode IS NOT INITIAL.
              lr_el_child = lr_xml_doc->create_element( name = 'cbc:PackagingTypeCode' ).
              lr_el_child->set_value( <ls_actualpack>-packtypecode ).
              lr_actualpackage->append_child( lr_el_child ).
            ENDIF.

            lr_trhunit->append_child( lr_actualpackage ).
          ENDLOOP.
        ENDIF.
      ENDIF.

      rr_shipment->append_child( lr_trhunit ).
    ENDIF.

    IF ls_shipment-delivery-shipment IS NOT INITIAL.
      DATA ls_shipment2 TYPE /MLSFT/ed_s_shp.
      MOVE-CORRESPONDING ls_shipment-delivery-shipment TO ls_shipment2.

      DATA lr_shipment2 TYPE REF TO if_ixml_element.
      CLEAR lr_shipment2.

      prepare_shipment_node(
        EXPORTING is_shipment     = ls_shipment2
                  ir_xml_document = ir_xml_document
        RECEIVING rr_shipment     = lr_shipment2 ).

      IF lr_shipment2 IS BOUND.
        lr_delivery->append_child( lr_shipment2 ).
      ENDIF.
    ENDIF.

    IF ls_shipment-delivery IS NOT INITIAL.
      rr_shipment->append_child( lr_delivery ).
    ENDIF.

    which_step( ).
  ENDMETHOD.


  METHOD put_xml_in_file.
    download_file_cloud(
      iv_xml_size  = mv_xlen
**      it_xml_table = mt_xml_table
      iv_xstring   = mv_xsxml ).
    which_step( ).
  ENDMETHOD.


  METHOD which_step.
    " no-op (cloud-safe)
  ENDMETHOD.


  METHOD node_phys_address.
    DATA lr_el_address TYPE REF TO if_ixml_element.
    DATA lr_el_node TYPE REF TO if_ixml_element.
    DATA lv_value TYPE string.
    DATA lr_el_citysubdivisionname TYPE REF TO if_ixml_element.
    DATA lr_el_cityname TYPE REF TO if_ixml_element.
    DATA lr_el_country TYPE REF TO if_ixml_element.

    cr_physaddress =  cr_xml_doc->create_element( name = 'cac:PhysicalLocation' ).

    lr_el_node = cr_xml_doc->create_element( name = 'cbc:ID' ).
    lr_el_node->set_value( is_address-id ).
    cr_physaddress->append_child( lr_el_node ).

    IF is_address-address IS NOT INITIAL.
      lr_el_address =  cr_xml_doc->create_element( name = 'cac:Address' ).

      IF is_address-address-id IS NOT INITIAL.
        lr_el_node = cr_xml_doc->create_element( name = 'cbc:ID' ).
        lr_el_node->set_value( is_address-address-id ).
        lr_el_address->append_child( lr_el_node ).
      ENDIF.

      IF is_address-address-streetname IS NOT INITIAL.
        lr_el_node = cr_xml_doc->create_element( name = 'cbc:StreetName' ).
        lr_el_node->set_value( is_address-address-streetname ).
        lr_el_address->append_child( lr_el_node ).
      ENDIF.

      IF is_address-address-buildingnumber IS NOT INITIAL.
        lr_el_node = cr_xml_doc->create_element( name = 'cbc:BuildingNumber' ).
        lr_el_node->set_value( is_address-address-buildingnumber ).
        lr_el_address->append_child( lr_el_node ).
      ENDIF.

      IF is_address-address-csubdivisionname IS NOT INITIAL.
        lr_el_citysubdivisionname = cr_xml_doc->create_element( name = 'cbc:CitySubdivisionName' ).
        lr_el_citysubdivisionname->set_value( is_address-address-csubdivisionname ).
        lr_el_address->append_child( lr_el_citysubdivisionname ).
      ENDIF.

      IF is_address-address-cityname IS NOT INITIAL.
        lr_el_cityname = cr_xml_doc->create_element( name = 'cbc:CityName' ).
        lr_el_cityname->set_value( is_address-address-cityname ).
        lr_el_address->append_child( lr_el_cityname ).
      ENDIF.

      IF is_address-address-postalzone IS NOT INITIAL.
        lr_el_node = cr_xml_doc->create_element( name = 'cbc:PostalZone' ).
        lr_el_node->set_value( is_address-address-postalzone ).
        lr_el_address->append_child( lr_el_node ).
      ENDIF.

      IF is_address-address-region IS NOT INITIAL.
        lr_el_node = cr_xml_doc->create_element( name = 'cbc:Region' ).
        lr_el_node->set_value( is_address-address-region ).
        lr_el_address->append_child( lr_el_node ).
      ENDIF.

      IF is_address-address-district IS NOT INITIAL.
        lr_el_node = cr_xml_doc->create_element( name = 'cbc:District' ).
        lr_el_node->set_value( is_address-address-district ).
        lr_el_address->append_child( lr_el_node ).
      ENDIF.

      IF is_address-address-country-code IS NOT INITIAL.
        lr_el_country = cr_xml_doc->create_element( name = 'cac:Country' ).
        lr_el_node = cr_xml_doc->create_element( name = 'cbc:IdentificationCode' ).
        lr_el_node->set_value( is_address-address-country-code ).
        lr_el_country->append_child( lr_el_node ).
      ENDIF.

      IF is_address-address-country-name IS NOT INITIAL.
        lr_el_node =  cr_xml_doc->create_element( name = 'cbc:Name' ).
        lr_el_node->set_value( is_address-address-country-name ).
        lr_el_country->append_child( lr_el_node ).
        lr_el_address->append_child( lr_el_country ).
      ENDIF.
    ENDIF.

    IF lr_el_address IS BOUND.
      cr_physaddress->append_child( lr_el_address ).
    ENDIF.
  ENDMETHOD.


  METHOD download_file_cloud.
    DATA lo_http_client TYPE REF TO if_web_http_client.
    DATA lo_request     TYPE REF TO if_web_http_request.
    DATA lo_response    TYPE REF TO if_web_http_response.

    TRY.
        DATA(lo_dest) = cl_http_destination_provider=>create_by_cloud_destination(
                           i_name       = 'Z_DOC_API_DEST'
                           i_authn_mode = if_a4c_cp_service=>service_specific ).

        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).
        lo_request = lo_http_client->get_http_request( ).

        lo_request->set_header_fields( VALUE #( ( name = '~request_method' value = 'POST' )
                                                ( name = 'Content-Type'    value = 'application/xml' ) ) ).
        lo_request->set_binary( i_data = iv_xstring ).

        lo_response = lo_http_client->execute( i_method = if_web_http_client=>get ).


        DATA(lv_status) = lo_response->get_status( ).
        IF lv_status-code < 200 OR lv_status-code >= 300.
          DATA(lv_message)  = |HTTP { lv_status-code } { lv_status-reason }|.
          add_message_to_log( iv_priority = '2' ).
        ENDIF.

      CATCH cx_http_dest_provider_error
            cx_web_http_client_error
            cx_web_message_error INTO DATA(lx_cloud).
        lv_message = lx_cloud->get_text( ).
        add_message_to_log( iv_priority = '2' ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
