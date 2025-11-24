" OLD (commented): class /MLSAG/ED_DELIVERY_LE_MAP_UBL definition
" public
" final
" create public .
"
"public section.
"
"  interfaces /MLSAG/IF_ED_DELIVERY_MAPPING .
"
"  methods CONSTRUCTOR .
"  methods INIT_PARAMS
"    importing
"      !IS_NAST type NAST
"      !IS_PRINT type LEDLV_PRINT_DATA_TO_READ
"      !IT_LEDLV type LEDLV_DELNOTE
"      !IS_LIKP type LIKP
"      !IT_LIPS type /MLSAG/ED_TT_LIPS .
"  methods COLLECT_DATA
"    returning
"      value(R_MAIN) type /MLSAG/ED_S_MAIN_WBILL .
"  protected section.
"private section.
"
"  aliases MS_MAIN
"    for /MLSAG/IF_ED_DELIVERY_MAPPING~MS_MAIN .
"  aliases GET_MAIN_STRUCTURE
"    for /MLSAG/IF_ED_DELIVERY_MAPPING~GET_MAIN_STRUCTURE .
"  aliases SET_MAIN_STRUCTURE
"    for /MLSAG/IF_ED_DELIVERY_MAPPING~SET_MAIN_STRUCTURE .
"
"  data MS_NAST type NAST .
"  data MS_PRINT type LEDLV_PRINT_DATA_TO_READ .
"  data MS_DLV type LEDLV_DELNOTE .
"  data MS_LIKP type LIKP .
"  data MT_LIPS type /MLSAG/ED_TT_LIPS .
"  data CS_SALES_ORG type TVKO .
"  data CS_COMPANY_CODE type BAPI0002_2 .
"  data CS_COMPANY_EINV type /MLSAG/ED_TCOMP .
"
"  type-pools SZADR .
"  methods GET_ADDRESS_COMPLETE
"    importing
"      !I_ADRNR type AD_ADDRNUM
"    returning
"      value(R_ADCOMP) type SZADR_ADDR1_COMPLETE .
"  methods MAP_UBL_00_BASICDATA .
"  methods MAP_UBL_01_12_DOCUMENT .
"  methods MAP_UBL_13_ORDERREFERENCE .
"  methods MAP_UBL_14_ADDDOCREFERENCE .
"  methods MAP_UBL_15_SIGNATURE .
"  methods MAP_UBL_16_DESPATCHPARTY .
"  methods MAP_UBL_17_CUSTOMERPARTY .
"  methods MAP_UBL_18_BUYERPARTY .
"  methods MAP_UBL_19_SELLERPARTY .
"  methods MAP_UBL_20_ORIGINATORPARTY .
"  methods MAP_UBL_21_SHIPMENT .
"  methods MAP_UBL_22_DESPATCHLINE .
"ENDCLASS.

" NEW:
CLASS /mlsft/ed_delivery_le_map_ubl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    " OLD (commented): interfaces /MLSAG/IF_ED_DELIVERY_MAPPING .
    INTERFACES /mlsft/if_ed_delivery_mapping.

    METHODS constructor.
    METHODS init_params
      IMPORTING
**        !is_nast  TYPE nast
**        !is_print TYPE ledlv_print_data_to_read
**        !it_ledlv TYPE ledlv_delnote
**        !is_likp  TYPE likp
        " OLD (commented): !IT_LIPS type /MLSAG/ED_TT_LIPS .
        !it_lips TYPE /mlsft/ed_tt_lips.

    METHODS collect_data
      RETURNING
        VALUE(r_main) TYPE /mlsft/ed_s_main_wbill.

  PROTECTED SECTION.
  PRIVATE SECTION.

    " OLD ALIASES (commented):
    " aliases MS_MAIN for /MLSAG/IF_ED_DELIVERY_MAPPING~MS_MAIN .
    " aliases GET_MAIN_STRUCTURE for /MLSAG/IF_ED_DELIVERY_MAPPING~GET_MAIN_STRUCTURE .
    " aliases SET_MAIN_STRUCTURE for /MLSAG/IF_ED_DELIVERY_MAPPING~SET_MAIN_STRUCTURE .

    ALIASES ms_main
      FOR /mlsft/if_ed_delivery_mapping~ms_main.
    ALIASES get_main_structure
      FOR /mlsft/if_ed_delivery_mapping~get_main_structure.
    ALIASES set_main_structure
      FOR /mlsft/if_ed_delivery_mapping~set_main_structure.

**    DATA ms_nast  TYPE nast.
**    DATA ms_print TYPE ledlv_print_data_to_read.
**    DATA ms_dlv   TYPE ledlv_delnote.
**    DATA ms_likp  TYPE likp.
    " OLD (commented): data MT_LIPS type /MLSAG/ED_TT_LIPS .
    DATA mt_lips  TYPE /mlsft/ed_tt_lips.

    " OLD (commented): data CS_SALES_ORG type TVKO .
    TYPES: BEGIN OF ty_sales_org_pubc,
**             salesorganization TYPE i_salesorganization-salesorganization,
**             companycode       TYPE i_salesorganization-companycode,
             salesorganization TYPE /mlsft/ED_CHAR4,
             companycode       TYPE /mlsft/ED_CHAR4,
           END OF ty_sales_org_pubc.
    DATA cs_sales_org TYPE ty_sales_org_pubc.

    " OLD (commented): data CS_COMPANY_CODE type BAPI0002_2 .
    TYPES: BEGIN OF ty_company_code_pubc,
             companycode TYPE /mlsft/ED_CHAR4,
             addressid   TYPE /mlsft/ED_CHAR10 , " TYPE i_companycode-addressid,
           END OF ty_company_code_pubc.
    DATA cs_company_code TYPE ty_company_code_pubc.

    " OLD (commented): data CS_COMPANY_EINV type /MLSAG/ED_TCOMP .
    DATA cs_company_einv TYPE /mlsft/ed_tcomp.

    " OLD (commented): type-pools SZADR .
    " In Public Cloud, use I_Address_2 instead of ADDR_GET_COMPLETE structures.

    METHODS get_address_complete
      IMPORTING
        !i_adrnr        TYPE ad_addrnum
      RETURNING
        VALUE(r_adcomp) TYPE i_address_2.         " Public Cloud: released CDS view structure

    METHODS map_ubl_00_basicdata.
    METHODS map_ubl_01_12_document.
    METHODS map_ubl_13_orderreference.
    METHODS map_ubl_14_adddocreference.
    METHODS map_ubl_15_signature.
    METHODS map_ubl_16_despatchparty.
    METHODS map_ubl_17_customerparty.
    METHODS map_ubl_18_buyerparty.
    METHODS map_ubl_19_sellerparty.
    METHODS map_ubl_20_originatorparty.
    METHODS map_ubl_21_shipment.
    METHODS map_ubl_22_despatchline.

ENDCLASS.



CLASS /MLSFT/ED_DELIVERY_LE_MAP_UBL IMPLEMENTATION.


  METHOD /mlsft/if_ed_delivery_mapping~get_main_structure.
    rs_main = ms_main.
  ENDMETHOD.


  METHOD /mlsft/if_ed_delivery_mapping~set_main_structure.
    " intentionally empty
  ENDMETHOD.


  METHOD collect_data.
    map_ubl_00_basicdata( ).
    map_ubl_01_12_document( ).
    map_ubl_13_orderreference( ).
    map_ubl_14_adddocreference( ).
    map_ubl_15_signature( ).
    map_ubl_16_despatchparty( ).
    map_ubl_17_customerparty( ).
    map_ubl_18_buyerparty( ).
    map_ubl_19_sellerparty( ).
    map_ubl_20_originatorparty( ).
    map_ubl_21_shipment( ).
    map_ubl_22_despatchline( ).
    r_main = ms_main.
  ENDMETHOD.


  METHOD constructor.
    "SULEYMAN - Organizasyon verileri bulma

    " OLD (FORBIDDEN in Public Cloud, commented):
    "*  select single * from tvko into cs_sales_org where vkorg = ms_dlv-hd_org-salesorg.
    "*  if sy-subrc = 0.
    "*    ms_main-bukrs = cs_sales_org-bukrs.
    "*    ms_main-vkorg = cs_sales_org-vkorg.
    "*  else.
    "*  endif.
    "*
    "*  call function 'BAPI_COMPANYCODE_GETDETAIL'
    "*    exporting
    "*      companycodeid      = ms_main-bukrs
    "*    importing
    "*      companycode_detail = cs_company_code.

    " NEW (Public Cloud): I_SalesOrganization -> CompanyCode, then I_CompanyCode
**    SELECT SINGLE salesorganization, companycode
**      FROM i_salesorganization
**      WHERE salesorganization = @ms_dlv-hd_org-salesorg
**      INTO CORRESPONDING FIELDS OF @cs_sales_org.

    IF sy-subrc = 0.
      ms_main-bukrs = cs_sales_org-companycode.
      ms_main-vkorg = cs_sales_org-salesorganization.

**      SELECT SINGLE companycode, addressid
**        FROM i_companycode
**        WHERE companycode = @ms_main-bukrs
**        INTO CORRESPONDING FIELDS OF @cs_company_code.
    ENDIF.

  ENDMETHOD.


  METHOD get_address_complete.
    " OLD (FORBIDDEN in Public Cloud, commented):
    " data: ad_comp type szadr_addr1_complete.
    " call function 'ADDR_GET_COMPLETE' ... RECEIVING addr1_complete = ad_comp.
    " r_adcomp = ad_comp.

    " NEW (Public Cloud): fetch from released address view
    SELECT SINGLE *
      FROM i_address_2
      WHERE addressid = @i_adrnr
      INTO @r_adcomp.
  ENDMETHOD.


  METHOD init_params.
**    ms_likp  = is_likp.
    mt_lips  = it_lips.
**    ms_nast  = is_nast.
**    ms_print = is_print.
**    ms_dlv   = it_ledlv.
  ENDMETHOD.


  METHOD map_ubl_00_basicdata.

    " OLD (commented):
    "*  select single * from tvko into cs_sales_org where vkorg = ms_dlv-hd_org-salesorg.
    "*  if sy-subrc = 0.
    "*    ms_main-bukrs = cs_sales_org-bukrs.
    "*    ms_main-vkorg = cs_sales_org-vkorg.
    "*    call function 'BAPI_COMPANYCODE_GETDETAIL' ...
    "*    select single * from /mlsag/ed_tcomp into cs_company_einv where bukrs =  ms_main-bukrs.
    "*  endif.

    " NEW (Public Cloud):
    IF cs_sales_org-companycode IS INITIAL OR cs_company_code-addressid IS INITIAL.
      " Refresh if ctor not filled for any reason
**      SELECT SINGLE salesorganization, companycode
**        FROM i_salesorganization
**        WHERE salesorganization = @ms_dlv-hd_org-salesorg
**        INTO CORRESPONDING FIELDS OF @cs_sales_org.
      IF sy-subrc = 0.
        ms_main-bukrs = cs_sales_org-companycode.
        ms_main-vkorg = cs_sales_org-salesorganization.
**        SELECT SINGLE companycode, addressid
**          FROM i_companycode
**          WHERE companycode = @ms_main-bukrs
**          INTO CORRESPONDING FIELDS OF @cs_company_code.
      ENDIF.
    ELSE.
      ms_main-bukrs = cs_sales_org-companycode.
      ms_main-vkorg = cs_sales_org-salesorganization.
    ENDIF.

    " Company e-invoicing params (custom table) — namespace change:
    " OLD (commented): select single * from /mlsag/ed_tcomp into cs_company_einv where bukrs = ms_main-bukrs.
    SELECT SINGLE *
      FROM /mlsft/ed_tcomp
      WHERE bukrs = @ms_main-bukrs
      INTO @cs_company_einv.

    " ---- Partner/address adjustments below kept as-is structurally (VBPA lookupları Public Cloud’da I_* CDS ile yapılmalı) ----
**    DATA: "is_hdr_adr  TYPE ledlv_hd_adr,
**          is_vbpa     TYPE vbpa,
**          is_ekop     TYPE /mlsft/ed_po_itm,   " OLD (commented type): /mlsag/ed_po_itm
**          is_des_adr  TYPE ledlv_hd_adr,
**          is_ref      TYPE LINE OF le_t_dlv_it_ref,
**          is_hdr_fin  TYPE ledlv_hd_fin,
**          is_hdr_add  TYPE ledlv_hd_part_add.

**    DATA: is_knvk TYPE knvk.

**    CLEAR is_des_adr.
**    READ TABLE ms_dlv-hd_adr INTO is_des_adr WITH KEY deliv_numb = ms_dlv-hd_gen-deliv_numb
**                                                     partn_role  = 'WE'. "Ship-To-Party

    IF sy-subrc = 0.

**      LOOP AT ms_dlv-it_ref INTO is_ref WHERE deliv_numb = ms_dlv-hd_gen-deliv_numb.
**        EXIT.
**      ENDLOOP.

**      CASE is_ref-ref_doc_type.
**        WHEN 'V'. "Reference Purchase Order
**          " OLD (commented):
**          " select * from /MLSAG/ED_PO_ITM into is_ekop where ebeln = ... .
**          " NEW:
**          SELECT SINGLE *
**            FROM /mlsft/ed_po_itm
**            WHERE ebeln = @is_ref-ref_doc
**              AND ebelp = @is_ref-ref_doc_it+1(5)
**            INTO @is_ekop.
**
**          IF sy-subrc = 0 AND is_ekop-bukrs <> ms_main-bukrs.
**            is_hdr_adr-deliv_numb   = ms_dlv-hd_gen-deliv_numb.
**            is_hdr_adr-partn_numb   = is_ekop-bukrs.
**            is_hdr_adr-partn_role   = 'RE'.
**            " OLD (commented): is_hdr_adr-addr_no = cs_company_code-addr_no.
**            is_hdr_adr-addr_no      = cs_company_code-addressid.
**            INSERT is_hdr_adr INTO TABLE ms_dlv-hd_adr.
**          ENDIF.
**
**          IF is_ekop-reswk IS NOT INITIAL.
**            is_hdr_adr-deliv_numb   = ms_dlv-hd_gen-deliv_numb.
**            is_hdr_adr-partn_numb   = is_ekop-bukrs.
**            is_hdr_adr-partn_role   = 'RE'.
**            is_hdr_adr-addr_no      = cs_company_code-addressid.
**            INSERT is_hdr_adr INTO TABLE ms_dlv-hd_adr.
**          ENDIF.
**
**        WHEN 'C'. "Reference Sales Order
**          " OLD (direct VBPA, commented):
**          " select * from vbpa into is_vbpa where vbeln = is_ref-ref_doc and posnr = space and ( parvw = 'RE' or parvw = 'RG' ).
**          " NEW (Public Cloud hint): use I_SalesOrderPartner (example)
**          SELECT *
**            FROM i_salesorderpartner
**            WHERE salesorder = @is_ref-ref_doc
**              AND salesorderitem = '000000'
**              AND partnerfunction IN ( 'RE', 'RG' )
**            INTO @DATA(ls_sopart).
**
**          IF sy-subrc = 0.
**            IF is_des_adr-partn_numb <> ls_sopart-businesspartner.
**              is_hdr_adr-deliv_numb = ms_dlv-hd_gen-deliv_numb.
**              is_hdr_adr-partn_numb = ls_sopart-businesspartner.
**              is_hdr_adr-partn_role = ls_sopart-partnerfunction.
**              is_hdr_adr-addr_no    = ls_sopart-addressid.
**              INSERT is_hdr_adr INTO TABLE ms_dlv-hd_adr.
**            ENDIF.
**          ENDIF.
**      ENDCASE.
    ENDIF.

  ENDMETHOD.


  METHOD map_ubl_01_12_document.

    DATA: ls_notes TYPE LINE OF  /mlsft/ed_tt_string.      " OLD type commented: /mlsag/ed_tt_string
**          t_stxh   TYPE TABLE OF stxh,                     " Legacy TEXT - will be commented
**          s_stxh   TYPE          stxh,
**          t_tline  TYPE TABLE OF tline,
**          s_tline  TYPE          tline.

    " 2 - UBLVersionID
    ms_main-ublversionid = '2.1'.

    " 3 - CustomizationID
    ms_main-cid          = 'TR1.2.1'.

    " 4 - ProfileID
    ms_main-profileid    = 'TEMELIRSALIYE'.

    " 5 - ID
    ms_main-id           = ''.

    " 6 - CopyIndicator
    ms_main-copyindicator = 'false'.

    " 7 - UUID
    " OLD (commented): ms_main-uuid  =  /mlsag/ed_util=>get_uuid( ).
    ms_main-uuid  =  /mlsft/ed_util=>get_uuid( ).

    " 8/9 - IssueDate/IssueTime
**    IF ms_likp-wadat_ist IS NOT INITIAL.
**      ms_main-issuedate = ms_likp-wadat_ist.
**    ELSE.
**      ms_main-issuedate = ms_likp-bldat.
**    ENDIF.
**    ms_main-issuetime = ms_likp-erzet.

    " 10 - TypeCode
    ms_main-datypecode = 'SEVK'.

    " 11 - Notes
    " OLD (FORBIDDEN FM READ_TEXT; commented legacy block):
    " SELECT * FROM stxh INTO TABLE t_stxh
    "  WHERE tdobject = 'VBBK' AND tdname = ms_dlv-hd_gen-deliv_numb.
    " LOOP AT t_stxh INTO s_stxh.
    "   CALL FUNCTION 'READ_TEXT' ...
    "   APPEND ls_notes TO ms_main-notes.
    " ENDLOOP.

    " NEW (Public Cloud): try read notes from released text CDS (example name; adjust per system)
    " If I_DeliveryDocumentText is unavailable in your tenant, replace with appropriate released API.
**    SELECT *
**      FROM i_deliverydocumenttext
**      WHERE deliverydocument = @ms_dlv-hd_gen-deliv_numb
**        AND language         = @sy-langu
**      INTO TABLE @DATA(lt_dlvtext).
**
**    LOOP AT lt_dlvtext ASSIGNING FIELD-SYMBOL(<ls_text>).
**      CLEAR ls_notes.
**      ls_notes-languaid = sy-langu.
**      ls_notes-text     = <ls_text>-text.
**      APPEND ls_notes TO ms_main-notes.
**    ENDLOOP.

    " 12 - LineCountNumeric
**    ms_main-linecountnumeric = lines( ms_dlv-it_gen ).

  ENDMETHOD.


  METHOD map_ubl_13_orderreference.
    DATA ls_orefrence TYPE /mlsft/ed_s_orderref.  " OLD: /mlsag/ed_s_orderref
    DATA ls_docrefrence TYPE /mlsft/ed_s_docref.  " OLD: /mlsag/ed_s_docref

**    ls_orefrence-id            = ms_dlv-hd_ref-ref_doc.
**    ls_orefrence-salesorderid  = ms_dlv-hd_ref-purch_no.
**    ls_orefrence-issuedate     = ms_dlv-hd_ref-purch_date.
**    ls_orefrence-ordertypecode = ms_dlv-hd_ref-po_method.
**
**    APPEND ls_orefrence TO ms_main-orderref.
  ENDMETHOD.


  METHOD map_ubl_14_adddocreference.

    DATA: ls_adddocref TYPE LINE OF /mlsft/ed_tt_docref,  " OLD: /mlsag/ed_tt_docref
          ls_note      TYPE LINE OF /mlsft/ed_tt_string.  " OLD: /mlsag/ed_tt_string

    DATA: ls_tcomp TYPE /mlsft/ed_tcomp.                  " OLD: /mlsag/ed_tcomp

    CLEAR ls_adddocref.
**    ls_adddocref-id        = ms_likp-vbeln.
**    ls_adddocref-issuedate = sy-datum.
**    ls_adddocref-dtypecode = 'DELIVERY'.
**    ls_adddocref-dtype     = 'Teslimat'.

    CLEAR ls_note.
**    ls_note-languaid = 'TR'.
**    ls_note-text     = 'Teslimat Belgesi'.
**    APPEND ls_note TO ls_adddocref-ddesc.

    APPEND ls_adddocref TO ms_main-adddocref.

    CLEAR ls_tcomp.
    " OLD (commented): SELECT SINGLE * FROM /mlsag/ed_tcomp ...
    SELECT SINGLE *
      FROM /mlsft/ed_tcomp
      WHERE bukrs = @ms_main-bukrs
      INTO @ls_tcomp.

    IF ls_tcomp-mersisno IS NOT INITIAL.
      CLEAR ls_adddocref.
**      ls_adddocref-id        = ls_tcomp-mersisno.
**      ls_adddocref-issuedate = sy-datum.
**      ls_adddocref-dtype     = 'MERSIS'.
**      ls_adddocref-dtypecode = 'Mersis No:'.
      APPEND ls_adddocref TO ms_main-adddocref.
    ENDIF.

    IF ls_tcomp-sicilno IS NOT INITIAL.
      CLEAR ls_adddocref.
**      ls_adddocref-id        = ls_tcomp-sicilno.
**      ls_adddocref-issuedate = sy-datum.
**      ls_adddocref-dtype     = 'SICILNO'.
**      ls_adddocref-dtypecode = 'Sicil No:'.
      APPEND ls_adddocref TO ms_main-adddocref.
    ENDIF.

  ENDMETHOD.


  METHOD map_ubl_15_signature.
    " İmza içeriği dış servis/entegrasyonla beslenecekse burada doldurun.
  ENDMETHOD.


  METHOD map_ubl_16_despatchparty.

    DATA: ad_comp         TYPE i_address_2,               " NEW Address container
          ad_addr         TYPE i_address_2,               " reuse same structure

          ls_party        TYPE /mlsft/ed_s_dsparty,      " OLD: /mlsag/ed_s_dsparty
          ls_partyidentif TYPE /mlsft/ed_s_partyidentif, " OLD: /mlsag/ed_s_partyidentif
          ls_address      TYPE /mlsft/ed_s_address,      " OLD: /mlsag/ed_s_address
          ls_country      TYPE /mlsft/ed_s_idencode.     " OLD: /mlsag/ed_s_idencode

    " Company address via I_CompanyCode.AddressID
    ad_comp = get_address_complete( i_adrnr = cs_company_code-addressid ).

    ls_party-partytype = 'D'. " Despatch
    ls_party-party-id  = cs_company_code-companycode.

    " partyidentification
    ls_partyidentif-schemeid = cs_company_einv-resp_note_textid. " VKN/TCKN tip kodu gibi
    ls_partyidentif-id       = cs_company_einv-company_tax_no_2. " Vergi no
**    APPEND ls_partyidentif TO ls_party-party-partyidentif.

    " name compose
**    CONCATENATE ad_comp-name1 ad_comp-name2 ad_comp-name3 ad_comp-name4
**      INTO ls_party-party-partyname SEPARATED BY space.

    " postal address mapping from I_Address_2
    CLEAR ls_address.
    ls_address-id               = ad_comp-addressid.
**    ls_address-postbox          = ad_comp-po_box.
**    CONCATENATE ad_comp-floor ad_comp-room_number
**      INTO ls_address-room SEPARATED BY ' - '.
    ls_address-streetname       = ad_comp-streetname.
**    ls_address-blockname        = ad_comp-house_number_supplement.
    ls_address-buildingname     = ad_comp-building.
**    ls_address-buildingnumber   = ad_comp-house_number.
    ls_address-csubdivisionname = ad_comp-cityname.
**    ls_address-postalzone       = ad_comp-post_code.
    ls_address-region           = ad_comp-region.
**    ls_address-district         = ad_comp-street_suffix.
    ls_address-country-code     = ad_comp-country.

    " Country name via I_Country (released)
**    SELECT SINGLE countryname
**      FROM i_country
**      WHERE country = @ad_comp-country
**      AND   language = @sy-langu
**      INTO @ls_address-country-name.

    MOVE-CORRESPONDING ls_address TO ls_party-party-postaladdress.

    " Tax office name (if any custom)
    ls_party-party-partytaxscheme-name = cs_company_einv-company_tax_no_1.

    " Contact (no direct TEL/FAX tables in public cloud; use AddressCommData if available)
    " Placeholder: populate email if available on address (I_AddressEmailAddress)
**    SELECT SINGLE emailaddress
**      FROM i_addressemailaddress
**      WHERE addressid = @ad_comp-addressid
**      INTO @ls_party-party-contact-mail.

**    SELECT SINGLE telephonenumber
**      FROM i_addresstelephone
**      WHERE addressid = @ad_comp-addressid
**      INTO @ls_party-party-contact-tel.

    " physical location: shipping point address
**    IF ms_dlv-hd_org-ship_point_adr IS NOT INITIAL.
**      DATA(ad_ship) = get_address_complete( i_adrnr = ms_dlv-hd_org-ship_point_adr ).
**      ls_party-party-physicalloc-id = ms_dlv-hd_org_descript-shipping_pt_descr.
**      CLEAR ls_address.
**      ls_address-id               = ad_ship-addressid.
**      ls_address-postbox          = ad_ship-po_box.
**      CONCATENATE ad_ship-floor ad_ship-room_number INTO ls_address-room SEPARATED BY ' - '.
**      ls_address-streetname       = ad_ship-streetname.
**      ls_address-blockname        = ad_ship-house_number_supplement.
**      ls_address-buildingname     = ad_ship-building.
**      ls_address-buildingnumber   = ad_ship-house_number.
**      ls_address-csubdivisionname = ad_ship-cityname.
**      ls_address-postalzone       = ad_ship-post_code.
**      ls_address-region           = ad_ship-region.
**      ls_address-district         = ad_ship-street_suffix.
**      ls_address-country-code     = ad_ship-country.
**
**      SELECT SINGLE countryname
**        FROM i_country
**        WHERE country = @ad_ship-country
**          AND language = @sy-langu
**        INTO @ls_address-country-name.
**
**      MOVE-CORRESPONDING ls_address TO ls_party-party-physicalloc-address.
**    ENDIF.

**    APPEND ls_party TO ms_main-parties.

  ENDMETHOD.


  METHOD map_ubl_17_customerparty.

    DATA: ad_comp         TYPE i_address_2,
          ls_party        TYPE /mlsft/ed_s_dsparty,
          ls_partyidentif TYPE /mlsft/ed_s_partyidentif,
          ls_address      TYPE /mlsft/ed_s_address.

**    DATA: is_hdr_adr TYPE ledlv_hd_adr,
**          is_hdr_fin TYPE ledlv_hd_fin,
**          is_hdr_add TYPE ledlv_hd_part_add.

**    READ TABLE ms_dlv-hd_adr INTO is_hdr_adr WITH KEY deliv_numb = ms_dlv-hd_gen-deliv_numb
**                                                     partn_role  = 'WE'. " Malı Teslim Alan.
**
**    LOOP AT ms_dlv-hd_fin INTO is_hdr_fin WHERE deliv_numb = ms_dlv-hd_gen-deliv_numb AND stcd1_we <> space.
**    ENDLOOP.
**
**    ad_comp = get_address_complete( i_adrnr = is_hdr_adr-addr_no ).
**
**    ls_party-partytype = 'C'.
**    ls_party-party-id  = is_hdr_adr-partn_numb.
**
**    CLEAR ls_partyidentif.
**    ls_partyidentif-id = is_hdr_fin-stcd2_we.
    DATA(lv_len) = strlen( ls_partyidentif-id ).
    CASE lv_len.
      WHEN 9 OR 10.  ls_partyidentif-schemeid = 'VKN'.
      WHEN 11.       ls_partyidentif-schemeid = 'TCKN'.
      WHEN OTHERS.   ls_partyidentif-schemeid = ''.
    ENDCASE.
**    APPEND ls_partyidentif TO ls_party-party-partyidentif.

    CLEAR ls_partyidentif.
    ls_partyidentif-schemeid = 'MUSTERINO'.
**    ls_partyidentif-id       = is_hdr_adr-partn_numb.
**    APPEND ls_partyidentif TO ls_party-party-partyidentif.

**    CONCATENATE ad_comp-name1 ad_comp-name2 ad_comp-name3 ad_comp-name4
**      INTO ls_party-party-partyname SEPARATED BY space.

    CLEAR ls_address.
    ls_address-id               = ad_comp-addressid.
**    ls_address-postbox          = ad_comp-po_box.
**    CONCATENATE ad_comp-floor ad_comp-room_number INTO ls_address-room SEPARATED BY ' - '.
    ls_address-streetname       = ad_comp-streetname.
**    ls_address-blockname        = ad_comp-house_number_supplement.
    ls_address-buildingname     = ad_comp-building.
**    ls_address-buildingnumber   = ad_comp-house_number.
    ls_address-csubdivisionname = ad_comp-cityname.
**    ls_address-postalzone       = ad_comp-post_code.
    ls_address-region           = ad_comp-region.
**    ls_address-district         = ad_comp-street_suffix.
    ls_address-country-code     = ad_comp-country.
**    SELECT SINGLE countryname
**      FROM i_country
**      WHERE country = @ad_comp-country
**        AND language = @sy-langu
**      INTO @ls_address-country-name.
**    MOVE-CORRESPONDING ls_address TO ls_party-party-postaladdress.

**    ls_party-party-partytaxscheme-name = is_hdr_fin-stcd1_we.

    " Contact via released comm views
**    SELECT SINGLE telephonenumber
**      FROM i_addresstelephone
**      WHERE addressid = @ad_comp-addressid
**      INTO @ls_party-party-contact-tel.

**    SELECT SINGLE emailaddress
**      FROM i_addressemailaddress
**      WHERE addressid = @ad_comp-addressid
**      INTO @ls_party-party-contact-mail.

**    ls_party-party-physicalloc-id = ms_dlv-hd_org-unload_pt.

**    APPEND ls_party TO ms_main-parties.

  ENDMETHOD.


  METHOD map_ubl_18_buyerparty.

    DATA: ad_comp         TYPE i_address_2,
          ls_party        TYPE /mlsft/ed_s_dsparty,
          ls_partyidentif TYPE /mlsft/ed_s_partyidentif,
          ls_address      TYPE /mlsft/ed_s_address.

**    DATA: is_hdr_adr TYPE ledlv_hd_adr,
**          is_hdr_adw TYPE ledlv_hd_adr.

**    READ TABLE ms_dlv-hd_adr INTO is_hdr_adw WITH KEY deliv_numb = ms_dlv-hd_gen-deliv_numb partn_role = 'WE'.
**    READ TABLE ms_dlv-hd_adr INTO is_hdr_adr WITH KEY deliv_numb = ms_dlv-hd_gen-deliv_numb partn_role = 'RE'.
**
**    IF sy-subrc <> 0 OR ( is_hdr_adw-partn_numb = is_hdr_adr-partn_numb ).
**      RETURN.
**    ENDIF.
**
**    ad_comp = get_address_complete( i_adrnr = is_hdr_adr-addr_no ).

    ls_party-partytype = 'B'.
**    ls_party-party-id  = is_hdr_adr-partn_numb.

    CLEAR ls_partyidentif.
    ls_partyidentif-schemeid = 'VKN'.  " heuristic
    " OLD (commented): ls_partyidentif-id = is_hdr_fin-stcd2_we.
**    ls_partyidentif-id = is_hdr_adr-partn_numb.
**    APPEND ls_partyidentif TO ls_party-party-partyidentif.

    CLEAR ls_partyidentif.
    ls_partyidentif-schemeid = 'MUSTERINO'.
**    ls_partyidentif-id       = is_hdr_adr-partn_numb.
**    APPEND ls_partyidentif TO ls_party-party-partyidentif.

**    CONCATENATE ad_comp-name1 ad_comp-name2 ad_comp-name3 ad_comp-name4
**      INTO ls_party-party-partyname SEPARATED BY space.

    CLEAR ls_address.
    ls_address-id               = ad_comp-addressid.
**    ls_address-postbox          = ad_comp-po_box.
**    CONCATENATE ad_comp-floor ad_comp-room_number INTO ls_address-room SEPARATED BY ' - '.
    ls_address-streetname       = ad_comp-streetname.
**    ls_address-blockname        = ad_comp-house_number_supplement.
    ls_address-buildingname     = ad_comp-building.
**    ls_address-buildingnumber   = ad_comp-house_number.
    ls_address-csubdivisionname = ad_comp-cityname.
**    ls_address-postalzone       = ad_comp-post_code.
    ls_address-region           = ad_comp-region.
**    ls_address-district         = ad_comp-street_suffix.
**    ls_address-country-code     = ad_comp-country.
*    SELECT SINGLE countryname
*      FROM i_country
*      WHERE country = @ad_comp-country
*        AND language = @sy-langu
*      INTO @ls_address-country-name.
    MOVE-CORRESPONDING ls_address TO ls_party-party-postaladdress.

    " Contact (if available)
**    SELECT SINGLE telephonenumber
**      FROM i_addresstelephone
**      WHERE addressid = @ad_comp-addressid
**      INTO @ls_party-party-contact-tel.
**    SELECT SINGLE emailaddress
**      FROM i_addressemailaddress
**      WHERE addressid = @ad_comp-addressid
**      INTO @ls_party-party-contact-mail.

**    APPEND ls_party TO ms_main-parties.

  ENDMETHOD.


  METHOD map_ubl_19_sellerparty.
    " İhtiyaç halinde /mlsft/ed_tcomp ve şirket adresi ile doldurulabilir (benzer 16. method).
  ENDMETHOD.


  METHOD map_ubl_20_originatorparty.

    DATA: ad_comp         TYPE i_address_2,
          ls_party        TYPE /mlsft/ed_s_dsparty,
          ls_partyidentif TYPE /mlsft/ed_s_partyidentif,
          ls_address      TYPE /mlsft/ed_s_address.

**    DATA: is_hdr_adr TYPE ledlv_hd_adr,
**          is_hdr_adb TYPE ledlv_hd_adr.

**    IF ms_likp-kunag IS NOT INITIAL AND ms_likp-kunag = ms_likp-kunnr.
**      RETURN.
**    ENDIF.
**
**    READ TABLE ms_dlv-hd_adr INTO is_hdr_adb WITH KEY deliv_numb = ms_dlv-hd_gen-deliv_numb partn_role = 'RE'.
**    IF NOT ( sy-subrc = 0 AND ( is_hdr_adb-partn_numb <> ms_likp-kunag ) ).
**      RETURN.
**    ENDIF.
**
**    READ TABLE ms_dlv-hd_adr INTO is_hdr_adr WITH KEY deliv_numb = ms_dlv-hd_gen-deliv_numb partn_role = 'AG'.
**
**    ad_comp = get_address_complete( i_adrnr = is_hdr_adr-addr_no ).
**
**    ls_party-partytype = 'O'.
**    ls_party-party-id  = is_hdr_adr-partn_numb.

    CLEAR ls_partyidentif.
    ls_partyidentif-schemeid = 'VKN'.
**    ls_partyidentif-id       = is_hdr_adr-partn_numb.
**    APPEND ls_partyidentif TO ls_party-party-partyidentif.

    CLEAR ls_partyidentif.
    ls_partyidentif-schemeid = 'MUSTERINO'.
**    ls_partyidentif-id       = is_hdr_adr-partn_numb.
**    APPEND ls_partyidentif TO ls_party-party-partyidentif.

**    CONCATENATE ad_comp-name1 ad_comp-name2 ad_comp-name3 ad_comp-name4
**      INTO ls_party-party-partyname SEPARATED BY space.

    CLEAR ls_address.
    ls_address-id               = ad_comp-addressid.
**    ls_address-postbox          = ad_comp-po_box.
**    CONCATENATE ad_comp-floor ad_comp-room_number INTO ls_address-room SEPARATED BY ' - '.
    ls_address-streetname       = ad_comp-streetname.
**    ls_address-blockname        = ad_comp-house_number_supplement.
    ls_address-buildingname     = ad_comp-building.
**    ls_address-buildingnumber   = ad_comp-house_number.
    ls_address-csubdivisionname = ad_comp-cityname.
**    ls_address-postalzone       = ad_comp-post_code.
    ls_address-region           = ad_comp-region.
**    ls_address-district         = ad_comp-street_suffix.
    ls_address-country-code     = ad_comp-country.
**    SELECT SINGLE countryname
**      FROM i_country
**      WHERE country = @ad_comp-country
**        AND language = @sy-langu
**      INTO @ls_address-country-name.
    MOVE-CORRESPONDING ls_address TO ls_party-party-postaladdress.

    " Contact
**    SELECT SINGLE telephonenumber
**      FROM i_addresstelephone
**      WHERE addressid = @ad_comp-addressid
**      INTO @ls_party-party-contact-tel.
**    SELECT SINGLE emailaddress
**      FROM i_addressemailaddress
**      WHERE addressid = @ad_comp-addressid
**      INTO @ls_party-party-contact-mail.

**    APPEND ls_party TO ms_main-parties.

  ENDMETHOD.


  METHOD map_ubl_21_shipment.

    DATA: ls_shipment     TYPE /mlsft/ed_s_shp,        " OLD: /mlsag/ed_s_shp
          ls_delivery     TYPE /mlsft/ed_s_del,        " OLD: /mlsag/ed_s_del
          ls_partyidentif TYPE /mlsft/ed_s_partyidentif,
          ls_address      TYPE /mlsft/ed_s_address,
**          ls_driver       TYPE /mlsft/ed_s_driver,
          is_lips         TYPE LINE OF /mlsft/ed_tt_lips.

**    ls_shipment-ids = ms_dlv-hd_gen-deliv_numb.
**
**    ls_shipment-gwmeasure-amount   = ms_dlv-hd_gen-brt_weight.
**    ls_shipment-gwmeasure-unitcode = ms_dlv-hd_gen-unit_of_weight.
**
**    ls_shipment-nwmeasure-amount   = ms_dlv-hd_gen-net_weight.
**    ls_shipment-nwmeasure-unitcode = ms_dlv-hd_gen-unit_of_weight.
**
**    ls_shipment-gvmeasure-amount   = ms_dlv-hd_gen-volume.
**    ls_shipment-gvmeasure-unitcode = ms_dlv-hd_gen-volumeunit.
**
**    ls_shipment-nvmeasure-amount   = ms_dlv-hd_gen-volume.
**    ls_shipment-nvmeasure-unitcode = ms_dlv-hd_gen-volumeunit.
**
**    LOOP AT mt_lips INTO is_lips WHERE lfimg <> 0.
**      ADD is_lips-lfimg TO ls_shipment-tgitmquan-amount.
    IF ls_shipment-tgitmquan-unitcode IS INITIAL.
**        ls_shipment-tgitmquan-unitcode = is_lips-vrkme.
    ENDIF.
**    ENDLOOP.
**
**    ls_shipment-tthhuquan-amount   = ms_dlv-hd_gen-noshpunits.
**    ls_shipment-tthhuquan-unitcode = 'PAK'.  " TODO: unit code mapping

**    ls_delivery-despatch-addate = sy-datum.
**    ls_delivery-despatch-adtime = sy-uzeit.
**    ls_shipment-delivery        = ls_delivery.

**    MOVE ls_shipment TO ms_main-shipment.

  ENDMETHOD.


  METHOD map_ubl_22_despatchline.

**    DATA: ls_gen   TYPE LINE OF le_t_dlv_it_gen,
**          ls_ref   TYPE LINE OF le_t_dlv_it_ref,
**          ls_pur   TYPE LINE OF le_t_dlv_it_refpurord,
**
**          ls_line  TYPE LINE OF /mlsft/ed_tt_line,     " OLD: /mlsag/ed_tt_line
**          ls_olrf  TYPE        /mlsft/ed_s_orderlineref, " OLD: /mlsag/ed_s_orderlineref
**          ls_actualpack TYPE   /mlsft/ed_s_actpc.        " OLD: /mlsag/ed_s_actpc
**
**    LOOP AT ms_dlv-it_gen INTO ls_gen.
**      ADD 1 TO ls_line-id.
**
**      ls_line-dquantity-amount   = ls_gen-dlv_qty.
**      ls_line-dquantity-unitcode = ls_gen-sales_unit.
**
**      ls_line-item-name      = ls_gen-short_text.
**      ls_line-item-sitmident = ls_gen-material.
**      ls_line-item-bitmident = ls_gen-cust_mat.
**
**      CLEAR ls_olrf.
**      READ TABLE ms_dlv-it_ref INTO ls_ref WITH KEY deliv_numb = ls_gen-deliv_numb
**                                                  itm_number  = ls_gen-itm_number.
**      CASE ls_ref-ref_doc_type.
**        WHEN 'V' OR 'C'.
**          ls_olrf-lineid = ls_ref-ref_doc_it.
**          READ TABLE ms_dlv-it_refpurord INTO ls_pur WITH KEY deliv_numb = ls_gen-deliv_numb
**                                                             itm_number  = ls_gen-itm_number.
**          IF sy-subrc = 0.
**            ls_olrf-salesorderlineid             = ls_pur-po_itm_no.
**            ls_olrf-orderreference-id            = ls_ref-ref_doc.
**            ls_olrf-orderreference-salesorderid  = ls_pur-purch_no_c.
**            ls_olrf-orderreference-issuedate     = ls_pur-po_dat_s.
**            ls_olrf-orderreference-ordertypecode = ls_pur-po_meth_s.
**          ENDIF.
**        WHEN OTHERS.
**          " no-op
**      ENDCASE.
**      ls_line-olineref = ls_olrf.
**
**      CLEAR: ls_actualpack, ls_line-shipment-delivery-shipment-thunit-actualpack.
**      ls_actualpack-id            = ls_line-id.
**      ls_actualpack-quan-amount   = ls_gen-dlv_qty.
**      ls_actualpack-quan-unitcode = 'KG'. " TODO: unit derivation
**      APPEND ls_actualpack TO ls_line-shipment-delivery-shipment-thunit-actualpack.
**
**      APPEND ls_line TO ms_main-despatchl.
**      CLEAR ls_line.
**    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
