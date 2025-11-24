CLASS /mlsft/ed_delivery DEFINITION
  PUBLIC
  INHERITING FROM /mlsft/ed_parent_delivery
  CREATE PUBLIC.

  PUBLIC SECTION.
*   TYPE-POOLS abap.  " (Cloud'da gerekmez)  "<<< ESKI
**    types: BEGIN OF lty_likp,
**           vbeln type vbeln,
**           vkorg type /mlsft/ED_CHAR4,
**                      vstel type /mlsft/ED_CHAR4,
**           kunnr type kunnr,
**           lfart type datum,
**           end of lty_likp.
**
    METHODS constructor
      IMPORTING
        VALUE(iv_vbeln)   TYPE vbeln OPTIONAL
        VALUE(iv_doctype) TYPE /mlsft/ed_direct OPTIONAL
      RAISING
        /mlsft/cx_ed_exception.

    METHODS select_head
**     RETURNING VALUE(r_value) TYPE xstring. "<<< ESKI
      RETURNING VALUE(r_value) TYPE lty_likp ."I_OutboundDelivery."likp

    METHODS select_items
      RETURNING VALUE(r_value) TYPE /mlsft/ed_tt_lips.

    METHODS get_print_data
**      IMPORTING
**        !is_print_data_to_read TYPE ledlv_print_data_to_read
**        !is_nast     TYPE nast
**      CHANGING
**        !cs_addr_key TYPE addr_key OPTIONAL
**        !cs_dlv_delnote        TYPE ledlv_delnote OPTIONAL
        RAISING   /mlsft/cx_ed_exception.

    METHODS create_edocument
      RETURNING VALUE(r_value) TYPE abap_bool
      RAISING   /mlsft/cx_ed_exception.

    METHODS get_dlv_delnote.
**      RETURNING VALUE(r_value) TYPE ledlv_delnote.

    METHODS get_data_structure
      RETURNING VALUE(rs_value) TYPE /mlsft/ed_s_main_wbill.

    METHODS set_data_structure
      IMPORTING !is_delivery TYPE /mlsft/ed_s_main_wbill.

    METHODS set_binary IMPORTING !iv_binary TYPE xstring.
    METHODS get_binary RETURNING VALUE(rv_binary) TYPE xstring.

    METHODS set_size   IMPORTING !iv_size TYPE int4.
    METHODS get_size   RETURNING VALUE(rv_size) TYPE int4.

    METHODS set_nast   .
**    IMPORTING VALUE(im_nast) TYPE nast OPTIONAL.

    METHODS add_customer_prog.
**      IMPORTING !im_nast TYPE nast.

*   methods /mlsag/if_ed_delivery~collect_data         redefinition.         "<<< ESKI
*   methods /mlsag/if_ed_delivery~collect_global_data  redefinition.         "<<< ESKI

    METHODS /mlsft/if_ed_delivery~collect_data         REDEFINITION.
    METHODS /mlsft/if_ed_delivery~collect_global_data  REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.

    "=== BU SINIFTA KULLANILAN EK ALANLAR ===
*     DATA ms_likp TYPE lty_likp.""I_DeliveryDocument."likp.  " Cloud gateway'den dolduruluyor

    METHODS set_document
      IMPORTING
        !iv_vbeln         TYPE vbeln
        VALUE(iv_doctype) TYPE /mlsft/ed_direct OPTIONAL.

    METHODS set_partner.
    METHODS creation_xml.  " XML binary oluşturma (eski yol yorumlu kalacak)

ENDCLASS.



CLASS /MLSFT/ED_DELIVERY IMPLEMENTATION.


  METHOD /mlsft/if_ed_delivery~collect_data.
*   "CALL METHOD SUPER->/MLSAG/IF_ED_DELIVERY~COLLECT_DATA ...                 "<<< ESKI

    DATA lx_error     TYPE REF TO /mlsft/cx_ed_exception.
    DATA lv_error_txt TYPE string.

    TRY.
        create_edocument( ).
      CATCH /mlsft/cx_ed_exception INTO lx_error.
        lv_error_txt = lx_error->get_text( ).
*       /mlsag/ed_runtime=>raise_exception( iv_error_txt = lv_error_txt ).     "<<< ESKI
        RAISE EXCEPTION lx_error.
    ENDTRY.

**    DATA ls_print_data_to_read TYPE ledlv_print_data_to_read.
**    DATA ls_dlv_delnote        TYPE ledlv_delnote.
*   DATA lx_exception TYPE REF TO /mlsft/cx_ed_exception.                      "<<< ESKI
    DATA lr_mapping TYPE REF TO /mlsft/ed_delivery_le_map_ubl.
*   DATA lv_clsname TYPE vseoclass-clsname.                                    "<<< ESKI

    select_head( ).
    select_items( ).

*   DATA lv_objky TYPE nast-objky. lv_objky = mv_vbeln.                         "<<< ESKI
*   IF ms_nast IS INITIAL.                                                      "<<< ESKI
*     SELECT SINGLE * FROM nast INTO ms_nast WHERE objky = lv_objky.            "<<< ESKI (yasak)
*   ENDIF.                                                                      "<<< ESKI

*   ls_print_data_to_read = /mlsag/ed_util=>get_data_read_options( ).           "<<< ESKI
    " Public cloud: kendi helper’ından oku veya sabitleri doldur
**    CLEAR ls_print_data_to_read.

    TRY.
**        get_print_data(
**          EXPORTING
**            is_print_data_to_read = ls_print_data_to_read
**            is_nast               = ms_nast
**          CHANGING
**            cs_dlv_delnote        = ls_dlv_delnote ).
      CATCH /mlsft/cx_ed_exception INTO lx_error.
        " Opsiyonel: logla, süreci sürdür
    ENDTRY.

    CREATE OBJECT lr_mapping. " /MLSFT/ED_DELIVERY_LE_MAP_UBL

**    lr_mapping->init_params(
**      EXPORTING
**        is_nast  = ms_nast
**        is_print = ls_print_data_to_read
**        it_ledlv = ls_dlv_delnote
**        is_likp  = ms_likp
**        it_lips  = mt_lips
**         ).

    ms_delivery = lr_mapping->collect_data( ).
    ro_mapping  ?= lr_mapping.

  ENDMETHOD.


  METHOD /mlsft/if_ed_delivery~collect_global_data.
    DATA lx_error     TYPE REF TO /mlsft/cx_ed_exception.
    DATA lv_error_txt TYPE string.

    TRY.
        create_edocument( ).
      CATCH /mlsft/cx_ed_exception INTO lx_error.
        lv_error_txt = lx_error->get_text( ).
        RAISE EXCEPTION lx_error.
    ENDTRY.

**    DATA ls_print_data_to_read TYPE ledlv_print_data_to_read.
**    DATA ls_dlv_delnote        TYPE ledlv_delnote.
*   DATA lx_exception TYPE REF TO /mlsag/cx_ed_exception.                       "<<< ESKI
*   DATA lv_clsname TYPE vseoclass-clsname.                                     "<<< ESKI

    " Hatalı tip düzeltiliyor:
    DATA lr_mapping TYPE REF TO /mlsft/ed_delivery_le_map_ubl.

    select_head( ).
    select_items( ).

*   IF ms_nast IS INITIAL. SELECT SINGLE * FROM nast INTO ms_nast ... ENDIF.    "<<< ESKI (yasak)

**    CLEAR ls_print_data_to_read.

    TRY.
**        get_print_data(
**          EXPORTING
**            is_print_data_to_read = ls_print_data_to_read
**            is_nast               = ms_nast
**          CHANGING
**            cs_dlv_delnote        = ls_dlv_delnote ).
      CATCH /mlsft/cx_ed_exception INTO lx_error.
    ENDTRY.

*   CASE mv_doctype.                                                             "<<< ESKI seçim mantığı
*     WHEN /mlsag/ed_constants=>doc_type_kz_waybill.
*       lv_clsname = /mlsag/ed_constants=>mapping_cls_kz_delivery.
*     WHEN ''.
*       lv_clsname = /mlsag/ed_constants=>mapping_cls_tr_delivery.
*     WHEN /mlsag/ed_constants=>doc_type_out_rotransport.
*       lv_clsname = /mlsag/ed_constants=>mapping_cls_ro_delivery.
*   ENDCASE.
*   CREATE OBJECT lr_mapping TYPE (lv_clsname).                                  "<<< ESKI

    CREATE OBJECT lr_mapping. " Genelleştirilmiş mapping sınıfı

**    lr_mapping->init_params(
**      EXPORTING
**        is_nast  = ms_nast
**        is_print = ls_print_data_to_read
**        it_ledlv = ls_dlv_delnote
**        is_likp  = ms_likp
**        it_lips  = mt_lips ).

**    lr_mapping->collect_data( ).
    ro_mapping ?= lr_mapping.
  ENDMETHOD.


  METHOD add_customer_prog.
*   DATA mr_dcntrl TYPE REF TO /mlsag/ed_delivery_ctrl.                          "<<< ESKI
*   DATA lo_prnt_delivery TYPE REF TO /mlsag/ed_parent_delivery.                 "<<< ESKI
*   DATA lo_delivery TYPE REF TO /mlsag/ed_delivery.                              "<<< ESKI
*   DATA lo_if_mapping TYPE REF TO /mlsag/if_ed_delivery_mapping.                "<<< ESKI

    DATA lo_prnt_delivery TYPE REF TO /mlsft/ed_parent_delivery.
    DATA lo_delivery      TYPE REF TO /mlsft/ed_delivery.
    DATA lo_if_mapping    TYPE REF TO /mlsft/if_ed_delivery_mapping.

    DATA lv_vbeln TYPE vbeln.
**    lv_vbeln = im_nast-objky.

    TRY.
        CREATE OBJECT lo_delivery
          EXPORTING
            iv_vbeln = lv_vbeln.

        lo_if_mapping ?= lo_delivery->collect_data( ).
      CATCH /mlsft/cx_ed_exception.
    ENDTRY.

    lo_prnt_delivery ?= lo_delivery.

*   DATA lo_document TYPE REF TO /mlsag/ed_cl_document.                           "<<< ESKI
*   mr_dcntrl = /mlsag/ed_delivery_ctrl=>factory( iv_vbeln = lv_vbeln ).         "<<< ESKI
*   TRY.
*       mr_dcntrl->create_document( io_delivery = lo_prnt_delivery
*                                   io_mapping  = lo_if_mapping
*                                   RECEIVING ro_document = lo_document ).
*     CATCH /mlsag/cx_ed_exception.
*   ENDTRY.
*   MESSAGE s005(/mlsag/ed) WITH lv_vbeln.                                       "<<< ESKI (MESSAGE yasak)

  ENDMETHOD.


  METHOD constructor.
    super->constructor( ).

    set_document(
      EXPORTING
        iv_vbeln   = iv_vbeln
        iv_doctype = iv_doctype ).

    select_head( ).
    select_items( ).
    set_partner( ).
  ENDMETHOD.


  METHOD create_edocument.
    DATA lx_error      TYPE REF TO /mlsft/cx_ed_exception.
    DATA lv_error_txt  TYPE string.
    DATA ls_cust_vkorg TYPE LINE OF /mlsft/ed_tt_vkorg.
    DATA ls_cust_comp  TYPE /mlsft/ed_tcomp.

**    DATA ls_lips       TYPE lips.
**    READ TABLE mt_lips INTO ls_lips INDEX 1.

    IF mv_doctype IS INITIAL.
      ms_header-doctype = /mlsft/ed_constants=>doc_type_doc_out.
    ELSE.
      ms_header-doctype = mv_doctype.
    ENDIF.

**    ms_header-reftype        = /MLSFT/ED_CONSTANTS=>out_delivery.
****   ms_header-refdoc         = ms_likp-vbeln.
**    ms_header-created_by     = sy-uname.
**    ms_header-creation_time  = sy-uzeit.
**    ms_header-creation_date  = sy-datum.
**    ms_header-changed_by     = sy-uname.
**    ms_header-change_date    = sy-datum.
**    ms_header-change_time    = sy-uzeit.
**    ms_header-jahr           = ms_likp-wadat_ist(4).
**    ms_header-lstatus        = /MLSFT/ED_CONSTANTS=>doc_created.
**
**    ms_ref-vbelv      = ms_likp-vbeln.
**    ms_ref-vbtyp      = ms_likp-vbtyp.
**    ms_ref-delv_num   = ms_likp-vbeln.
**    ms_ref-wadat_ist  = ms_likp-wadat_ist.

**    ms_ref-bukrs = /MLSFT/ED_SELECT=>get_bukrs_from_werks( ls_lips-werks ).     " (Cloud helper)

    ms_ref-uuid  = /mlsft/ed_util=>get_uuid( ).

**    READ TABLE mt_lips INTO ls_lips INDEX 1.
**    IF sy-subrc IS INITIAL.
**      ms_ref-werks  = ls_lips-werks.
**      ms_ref-lgort  = ls_lips-lgort.
**    ENDIF.

*   CALL METHOD /mlsag/ed_select=>get_org_settings ...                            "<<< ESKI
    /mlsft/ed_select=>get_org_settings(
      EXPORTING
        iv_vkorg       = ms_likp-vkorg
        iv_lfart       = ms_likp-lfart
        iv_vstel       = ms_likp-vstel
      RECEIVING
        rs_customising = ls_cust_vkorg ).

    " Güvenli alan okuma (bazı sistemlerde alan adları farklı olabilir)
    DATA lv_despatchtype  TYPE string.
    DATA lv_profileid     TYPE string.
    FIELD-SYMBOLS <f> TYPE any.
    ASSIGN COMPONENT 'DESPATCHTYPE' OF STRUCTURE ls_cust_vkorg TO <f>.
    IF sy-subrc = 0 AND <f> IS ASSIGNED. lv_despatchtype = <f>. ENDIF.
    ASSIGN COMPONENT 'PROFILEID' OF STRUCTURE ls_cust_vkorg TO <f>.
    IF sy-subrc = 0 AND <f> IS ASSIGNED. lv_profileid = <f>. ENDIF.

    IF lv_despatchtype IS NOT INITIAL OR lv_profileid IS NOT INITIAL.
      IF lv_despatchtype IS NOT INITIAL.
        ms_ref-despatchtype = lv_despatchtype.
      ENDIF.
      IF lv_profileid IS NOT INITIAL.
        ms_ref-profileid    = lv_profileid.
      ENDIF.
    ELSE.
      ls_cust_comp = /mlsft/ed_select=>get_company_info( ms_ref-bukrs ).
      " ls_cust_comp içinde alanlar mevcutsa ata (güvenli)
      ASSIGN COMPONENT 'DESPATCHTYPE' OF STRUCTURE ls_cust_comp TO <f>.
      IF sy-subrc = 0 AND <f> IS ASSIGNED. ms_ref-despatchtype = <f>. ENDIF.
      ASSIGN COMPONENT 'PROFILEID' OF STRUCTURE ls_cust_comp TO <f>.
      IF sy-subrc = 0 AND <f> IS ASSIGNED. ms_ref-profileid    = <f>. ENDIF.
    ENDIF.

    ms_ref-sales_org = ms_likp-vkorg.
    ms_ref-vstel     = ms_likp-vstel.
    ms_ref-vkorg     = ms_likp-vkorg.
    ms_ref-lfart     = ms_likp-lfart.

    IF ms_likp-kunnr IS NOT INITIAL.
      ms_ref-partner = ms_likp-kunnr.
      ms_ref-ptype   = /mlsft/ed_constants=>customer.
    ELSE.
      ms_ref-partner = ms_likp-lifnr .
      ms_ref-ptype   = /mlsft/ed_constants=>vendor.
    ENDIF.

    ms_data-docs   = mv_size.
    ms_data-binary = mv_binary.

    r_value = abap_true.
  ENDMETHOD.


  METHOD creation_xml.
*   CREATE OBJECT mr_xml EXPORTING is_wbill = ms_delivery.                        "<<< ESKI
*   set_binary( iv_binary = mr_xml->get_binary( ) ).                             "<<< ESKI
  ENDMETHOD.


  METHOD get_binary.
    rv_binary = mv_binary.
  ENDMETHOD.


  METHOD get_data_structure.
    rs_value = ms_delivery.
  ENDMETHOD.


  METHOD get_dlv_delnote.
**    r_value = ms_dlv_delnote.
  ENDMETHOD.


  METHOD get_print_data.
*   " On-Prem:
*   DATA ls_delivery_key TYPE leshp_delivery_key.                                 "<<< ESKI
*   ls_delivery_key-vbeln = mv_vbeln.                                             "<<< ESKI
*   CALL FUNCTION 'LE_SHP_DLV_OUTP_READ_PRTDATA' ...                              "<<< ESKI (FM yasak)

    " Cloud uyumlu: gateway'den doldur
**    DATA ls_note TYPE ledlv_delnote.
    DATA lr_any  TYPE REF TO data.
**    GET REFERENCE OF ls_note INTO lr_any.

    TRY.
**        /MLSFT/CL_SERVICE_GATEWAY=>delivery_execute(
**          iv_action = 'GET_PRINT_DATA'
**          iv_vbeln  = mv_vbeln
**          io_self   = me
**          CHANGING  co_any   = lr_any ).
      CATCH /mlsft/cx_ed_exception INTO DATA(lx).
        RAISE EXCEPTION lx.
    ENDTRY.

**    ms_dlv_delnote  = ls_note.
**    cs_dlv_delnote  = ms_dlv_delnote.
    " cs_addr_key opsiyonel; ihtiyac varsa gateway doldurabilir
  ENDMETHOD.


  METHOD get_size.
    rv_size = mv_size.
  ENDMETHOD.


  METHOD set_binary.
    mv_binary = iv_binary.
  ENDMETHOD.


  METHOD set_data_structure.
    ms_delivery = is_delivery.
  ENDMETHOD.


  METHOD set_document.
    mv_vbeln   = iv_vbeln.
    mv_doctype = iv_doctype.
  ENDMETHOD.


  METHOD set_nast.
**    ms_nast = im_nast.
  ENDMETHOD.


  METHOD set_partner.
    IF ms_likp-kunnr IS NOT INITIAL.
*     CREATE OBJECT ms_partner EXPORTING iv_partno = ms_likp-kunnr
*                                         iv_type   = /mlsag/ed_constants=>customer. "<<< ESKI
      CREATE OBJECT ms_partner
        EXPORTING
          iv_partno = ms_likp-kunnr
          iv_type   = /mlsft/ed_constants=>customer.
    ELSE.
      CREATE OBJECT ms_partner
        EXPORTING
          iv_partno = ms_likp-lifnr
          iv_type   = /mlsft/ed_constants=>vendor.
    ENDIF.
  ENDMETHOD.


  METHOD set_size.
    mv_size = iv_size.
  ENDMETHOD.


  METHOD select_head.
   IF ms_likp IS INITIAL.
**     SELECT SINGLE * FROM I_OutboundDelivery INTO ms_likp WHERE vbeln = mv_vbeln.              "<<< ESKI (yasak)
   ENDIF.

  DATA ls_likp TYPE lty_likp.        " senin tipin (veya LIKP/ty_likp_cloud)
  DATA(lr_any) = REF #( ls_likp ).   " << eski GET REFERENCE OF yerine

    TRY.
**        /mlsft/cl_service_gateway=>delivery_execute(
**          iv_action = 'SELECT_HEADER'
**          iv_vbeln  = mv_vbeln
**          io_self   = me
**          CHANGING  co_any = lr_any ).
      CATCH /mlsft/cx_ed_exception.
        CLEAR ls_likp.
    ENDTRY.

    ms_likp = ls_likp.
    r_value = ms_likp.
  ENDMETHOD.


  METHOD select_items.
*   IF mt_lips IS INITIAL.
*     SELECT * FROM lips INTO TABLE mt_lips WHERE vbeln = mv_vbeln.               "<<< ESKI (yasak)
*   ENDIF.

  DATA lt_lips TYPE /mlsft/ed_tt_lips.
  DATA(lr_tab) = REF #( lt_lips ).  " << eski GET REFERENCE OF yerine

    TRY.
**        /mlsft/cl_service_gateway=>delivery_execute(
**          iv_action = 'SELECT_ITEMS'
**          iv_vbeln  = mv_vbeln
**          io_self   = me
**          CHANGING  ct_any = lr_tab ).
      CATCH /mlsft/cx_ed_exception.
        CLEAR lt_lips.
    ENDTRY.

**    mt_lips = lt_lips.
**    r_value = mt_lips.
  ENDMETHOD.
ENDCLASS.
