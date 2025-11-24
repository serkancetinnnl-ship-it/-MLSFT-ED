
CLASS /mlsft/ed_select DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES:
    tt_t_range_bukrs TYPE RANGE OF bukrs .
    TYPES:
      tt_t_addons TYPE TABLE OF /mlsft/ed_addon .
    TYPES:
      tt_t_tcodes TYPE TABLE OF /mlsft/ed_tcodei .
    TYPES:
      BEGIN OF tt_ts_vbeln,
        vbeln TYPE vbeln,
      END OF tt_ts_vbeln .
    TYPES:
      BEGIN OF tt_ts_mmdocs,
        mblnr TYPE /mlsft/ed_char10,
        mjahr TYPE /mlsft/ed_char4,
      END OF tt_ts_mmdocs .
    TYPES:
      tt_t_mmdocs TYPE SORTED TABLE OF tt_ts_mmdocs  WITH UNIQUE KEY  mblnr mjahr .
    TYPES:
      tt_t_vbeln TYPE SORTED TABLE OF tt_ts_vbeln  WITH UNIQUE KEY  vbeln .
    TYPES:
      tt_t_addon TYPE TABLE OF /mlsft/ed_addon .
    "-------------------- Sabitler / Alanlar ---------------------------
    CONSTANTS co_badi_archive TYPE REF TO /mlsft/if_ex_ei_b_arcv_c VALUE IS INITIAL. "placeholder
    DATA cv_bactive_arc TYPE /mlsft/ed_char1 READ-ONLY.

    CLASS-DATA mt_cust_vkorg TYPE /mlsft/ed_tt_vkorg.
    CLASS-DATA mt_cust_comp  TYPE /mlsft/ed_tt_tcomp.
    CLASS-DATA mt_units      TYPE /mlsft/ed_t_tunitc.
**    CLASS-DATA mt_t001       TYPE STANDARD TABLE OF I_CompanyCode WITH HEADER LINE." t001 WITH DEFAULT KEY.

    " Private buffer’lar (Cloud’da SELECT sayısını azaltmak için)
    CLASS-DATA ms_system     TYPE /mlsft/ed_system.
    CLASS-DATA mt_profileid  TYPE STANDARD TABLE OF /mlsft/ed_sd_pro WITH DEFAULT KEY.
    CLASS-DATA mv_quit_do_loop TYPE abap_bool.
    CLASS-DATA ms_profileid  TYPE /mlsft/ed_sd_pro.
    CLASS-DATA ms_ekko       TYPE /mlsft/ed_s_ekko.
**    CLASS-DATA mt_ekpo       TYPE I_PurchaseOrderItem."me_ekpo.
    CLASS-DATA mt_countries  TYPE I_CountryText."/mlsft/ed_t_t005t.
    CLASS-DATA mt_param      TYPE /mlsft/ed_tt_dparam.
**    CLASS-DATA mt_mseg       TYPE I_MaterialDocumentItem."mb_mseg.
**    CLASS-DATA mt_mkpf       TYPE I_MaterialDocument."mb_mkpf.
    CLASS-DATA mt_addon      TYPE /MLSFT/ED_tt_addon.
    CLASS-DATA mt_tcodes     TYPE /mlsft/ed_tt_tcodes." tt_t_tcodes.

    "-------------------- Metotlar (STATIK) ----------------------------
    CLASS-METHODS get_despatch_frm_uuid
      IMPORTING iv_uuid       TYPE /mlsft/ed_uuid
      RETURNING VALUE(rs_ref) TYPE /mlsft/ed_ref
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS get_company_info
      IMPORTING iv_bukrs        TYPE bukrs OPTIONAL
      RETURNING VALUE(re_value) TYPE /mlsft/ed_tcomp.

    CLASS-METHODS get_companies_t001
      IMPORTING iv_bukrs       TYPE bukrs
      RETURNING VALUE(rs_t001) TYPE xstring.
**      RETURNING VALUE(rs_t001) TYPE I_CompanyCode. FIXME
    CLASS-METHODS filter_sd_invoices
      CHANGING it_vbeln TYPE /mlsft/ed_tt_vbeln.

    CLASS-METHODS filter_sd_deliveries
      CHANGING it_vbeln TYPE /mlsft/ed_tt_vbeln.

    CLASS-METHODS filter_mm_deliveries
      CHANGING it_mmdocs TYPE /mlsft/ed_tt_mmdocs.

**    CLASS-METHODS get_despatch_frm_uuid
**      IMPORTING iv_uuid TYPE char40 "/mlsft/ed_uuid
**      RETURNING VALUE(rs_ref) TYPE /mlsft/ed_ref.

    CLASS-METHODS get_addon_usage
      IMPORTING iv_bukrs        TYPE bukrs
      RETURNING VALUE(rs_addon) TYPE /mlsft/ed_addon.

    CLASS-METHODS get_addon_comp_list.
**      IMPORTING it_range_bukrs TYPE tt_t_range_bukrs
**      EXPORTING et_addon TYPE tt_t_addons.

    CLASS-METHODS get_addon_details
      IMPORTING iv_bukrs TYPE bukrs
                iv_addon TYPE /mlsft/ED_CHAR2
      EXPORTING es_addon TYPE /mlsft/ed_addon.

    CLASS-METHODS get_org_settings
      IMPORTING iv_vkorg              TYPE /mlsft/ed_char4 "vkorg
                iv_lfart              TYPE /mlsft/ed_char4 "lfart
                iv_vstel              TYPE /mlsft/ed_char4 "/mlsft/ED_CHAR4
      RETURNING VALUE(rs_customising) TYPE /mlsft/ed_vkorg.

    CLASS-METHODS get_company_settings
      IMPORTING im_bukrs      TYPE bukrs OPTIONAL
      RETURNING VALUE(re_set) TYPE /mlsft/ed_tcset.

    CLASS-METHODS get_customer_fr_invoice
      IMPORTING im_enumber      TYPE /mlsft/ed_char12 OPTIONAL "/mlsft/ed_number OPTIONAL
                im_bukrs        TYPE bukrs OPTIONAL
      RETURNING VALUE(re_value) TYPE /mlsft/ed_tpartn.

    CLASS-METHODS get_old_delivery
      IMPORTING iv_vbelv       TYPE vbelv
                iv_vbtyp       TYPE vbtyp
      RETURNING VALUE(r_gibid) TYPE /mlsft/ed_char16."/mlsft/ed_gib_number.

    CLASS-METHODS get_invoice
      IMPORTING awkey TYPE awkey OPTIONAL
**      CHANGING  vbrk  TYPE I_BillingDocument OPTIONAL "vbrk OPTIONAL
                vbrp  TYPE /mlsft/ed_tt_vbrp OPTIONAL
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS get_invoice_f_keys
      IMPORTING im_enumber      TYPE /mlsft/ed_char12 OPTIONAL "/mlsft/ed_number OPTIONAL
                im_bukrs        TYPE bukrs          OPTIONAL
      RETURNING VALUE(re_value) TYPE /mlsft/ed_main.

    CLASS-METHODS get_partner_details
      IMPORTING im_partner  TYPE /mlsft/ed_dpartner
                im_ptype    TYPE /mlsft/ed_partnert
      CHANGING  ch_tpartner TYPE /mlsft/ed_tpartn OPTIONAL.
**                ch_kna1     TYPE I_Customer OPTIONAL "kna1
**                ch_lfa1     TYPE I_Supplier OPTIONAL."lfa1 OPTIONAL.

    CLASS-METHODS get_vkn_frm_partner_id
      IMPORTING im_partner TYPE /mlsft/ed_dpartner
                im_ptype   TYPE /mlsft/ed_partnert
                im_bukrs   TYPE bukrs OPTIONAL
      EXPORTING ev_taxid   TYPE stcd4
                ev_taxloc  TYPE stcd4.

    CLASS-METHODS get_partner_from_tax
      IMPORTING iv_taxid      TYPE stcd4
                iv_taxloc     TYPE stcd4
                iv_bukrs      TYPE bukrs OPTIONAL
                iv_xtax_check TYPE /mlsft/ed_char1  OPTIONAL
      EXPORTING ev_partner    TYPE /mlsft/ed_dpartner
                ev_ptype      TYPE /mlsft/ed_partnert.

    CLASS-METHODS get_vendor_from_tax
      IMPORTING iv_taxid      TYPE stcd4
                iv_taxloc     TYPE stcd4
                iv_bukrs      TYPE bukrs OPTIONAL
                iv_xtax_check TYPE /mlsft/ed_char1  OPTIONAL
      EXPORTING ev_partner    TYPE /mlsft/ed_dpartner
                ev_ptype      TYPE /mlsft/ed_partnert
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS get_vendor_from_tax_with_addon
      IMPORTING iv_taxid   TYPE any
                iv_bukrs   TYPE bukrs
                iv_addon   TYPE /mlsft/ED_CHAR2 "/mlsft/ed_addont
      EXPORTING ev_partner TYPE /mlsft/ed_dpartner
                ev_ptype   TYPE /mlsft/ed_partnert
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS get_cust_from_tax_with_addon
      IMPORTING iv_taxid   TYPE any
                iv_bukrs   TYPE bukrs
                iv_addon   TYPE /mlsft/ED_CHAR2 "/mlsft/ed_addont
      EXPORTING ev_partner TYPE /mlsft/ed_dpartner
                ev_ptype   TYPE /mlsft/ed_partnert
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS get_partn_from_tax_with_addon
      IMPORTING iv_taxid   TYPE any
                iv_bukrs   TYPE bukrs
                iv_addon   TYPE /mlsft/ED_CHAR2 "/mlsft/ed_addont
      EXPORTING ev_partner TYPE /mlsft/ed_dpartner
                ev_ptype   TYPE /mlsft/ed_partnert
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS get_customer_from_tax
      IMPORTING iv_taxid   TYPE stcd4
                iv_taxloc  TYPE stcd4
                iv_bukrs   TYPE bukrs OPTIONAL
      EXPORTING ev_partner TYPE /mlsft/ed_d_partner
                ev_ptype   TYPE /mlsft/ed_d_partnert
      RAISING   /mlsft/cx_ed_exception.

    CLASS-METHODS get_units
      RETURNING VALUE(rt_units) TYPE /mlsft/ed_t_tunitc.

    CLASS-METHODS get_company_from_tax
      IMPORTING iv_taxid   TYPE stcd4
                iv_taxloc  TYPE stcd4
      EXPORTING ev_partner TYPE /mlsft/ed_dpartner
                ev_ptype   TYPE /mlsft/ed_partnert.

    CLASS-METHODS get_docnum_with_uuid
      IMPORTING iv_uuid          TYPE /mlsft/ed_char40 "/mlsft/ed_uuid
                iv_doctype       TYPE /mlsft/ED_CHAR2 "/mlsft/ed_direct
      RETURNING VALUE(rv_docnum) TYPE /mlsft/ed_char32."/mlsft/ed_guid.

    CLASS-METHODS get_city_name_list
      IMPORTING iv_spras             TYPE spras
                iv_land1             TYPE land1
      RETURNING VALUE(re_bezei_list) TYPE /mlsft/ed_tt_cityname.

    CLASS-METHODS get_city_name
      IMPORTING iv_land1        TYPE land1
                iv_regio        TYPE regio
      RETURNING VALUE(rv_bezei) TYPE /mlsft/ED_CHAR20."bezei20.

    CLASS-METHODS get_system_settings
      IMPORTING im_bukrs        TYPE bukrs OPTIONAL
      RETURNING VALUE(re_value) TYPE /mlsft/ed_system.

    CLASS-METHODS select_tax_def
      IMPORTING im_taxtype      TYPE /mlsft/ed_char4 OPTIONAL "/mlsft/ed_taxtype OPTIONAL
      RETURNING VALUE(re_value) TYPE /mlsft/ed_char40 ."/mlsft/ed_sdesc.

    CLASS-METHODS get_documents_from_uui
      IMPORTING im_bukrs        TYPE bukrs
                im_reportno     TYPE /mlsft/ed_char32 "/mlsft/ed_guid.
      RETURNING VALUE(re_dmain) TYPE /mlsft/ed_main_tt.

    CLASS-METHODS get_document_from_ref
      IMPORTING im_reftype      TYPE /mlsft/ed_char1 OPTIONAL "/mlsft/ed_reftype OPTIONAL
                im_refdoc       TYPE /mlsft/ed_char10 OPTIONAL "/mlsft/ed_refdoc  OPTIONAL
      RETURNING VALUE(re_value) TYPE /mlsft/ed_head.

    CLASS-METHODS get_document_crtl_with_ref
      IMPORTING im_reftype        TYPE /mlsft/ed_char1 OPTIONAL "/mlsft/ed_reftype OPTIONAL
                im_refdoc         TYPE /mlsft/ed_char10 OPTIONAL "/mlsft/ed_refdoc  OPTIONAL
                im_jahr           TYPE /mlsft/ed_char4 OPTIONAL "mjahr OPTIONAL
      RETURNING VALUE(ro_docctrl) TYPE REF TO /mlsft/if_ed_doc_control
      RAISING   /mlsft/cx_ed_exception.

    "-------------------- Metotlar (INSTANCE) --------------------------
    METHODS get_search_field
      IMPORTING im_fieldname    TYPE /mlsft/ED_CHAR30 " dfies-fieldname
      RETURNING VALUE(re_value) TYPE /mlsft/ed_char132 " shvalue_d
      RAISING   /mlsft/cx_ed_exception.

    METHODS get_company_t001
      IMPORTING im_bukrs TYPE bukrs.
**      RETURNING VALUE(re_value) TYPE I_CompanyCode."t001

    METHODS get_adress
      IMPORTING im_addrnr TYPE /mlsft/ed_char10 OPTIONAL " adrnr OPTIONAL
**      RETURNING VALUE(re_adrc) TYPE I_BusinessPartnerAddress    "adrc.
      .
    METHODS change_system_inform
      CHANGING re_value TYPE /mlsft/ed_system.

    METHODS change_company_code
      IMPORTING iv_bukrs TYPE bukrs OPTIONAL
      CHANGING  re_value TYPE /mlsft/ed_tcomp.

    METHODS change_company_settings
      IMPORTING im_bukrs TYPE bukrs OPTIONAL
      CHANGING  re_set   TYPE /mlsft/ed_tcset.

    METHODS get_companycode_getdetail
      IMPORTING im_bukrs TYPE bukrs
      CHANGING  ch_party TYPE /mlsft/ed_s_party.

    METHODS get_partner_address
      IMPORTING im_partytpe TYPE /mlsft/ed_d_partnert
                im_partner  TYPE /mlsft/ed_d_partner
                im_bukrs    TYPE bukrs OPTIONAL.
**      CHANGING  ch_party    TYPE /mlsft/ed_sparty. "FIXME

    CLASS-METHODS get_parameter_table IMPORTING !im_parameter TYPE /MLSft/ED_DPARAM RETURNING VALUE(re_result) TYPE /MLSft/ED_PARAM .

    CLASS-METHODS determine_profileid
      IMPORTING im_fkart        TYPE fkart OPTIONAL
                im_vkorg        TYPE vkorg OPTIONAL
                im_vtweg        TYPE vtweg OPTIONAL
                im_spart        TYPE spart OPTIONAL
                im_vbtyp        TYPE /mlsft/ed_char4 OPTIONAL
      RETURNING VALUE(re_value) TYPE /mlsft/ed_pid.

    CLASS-METHODS determine_profileid_by_part
      IMPORTING im_bukrs        TYPE bukrs OPTIONAL
                im_ptype        TYPE /mlsft/ed_partnert OPTIONAL
                im_partner      TYPE /mlsft/ed_dpartner OPTIONAL
      RETURNING VALUE(re_value) TYPE /mlsft/ed_pid.

    CLASS-METHODS get_chartofaccount
      IMPORTING im_bukrs        TYPE bukrs
      RETURNING VALUE(re_value) TYPE ktopl.

    CLASS-METHODS get_tax_rate
      IMPORTING im_bukrs        TYPE bukrs
                im_mwskz        TYPE mwskz
                im_kbetr        TYPE /mlsft/ed_char1 OPTIONAL
      RETURNING VALUE(re_value) TYPE i.

    CLASS-METHODS get_deliveries_with_sel_params
      IMPORTING it_range_doctype TYPE /mlsft/ed_tt_general_range "/mlsft/ed_r_table_doctype
                it_range_delflag TYPE /mlsft/ed_tt_general_range OPTIONAL "/mlsft/ed_r_table_delflag OPTIONAL
                it_tab_range     TYPE /mlsft/ed_tt_rsparams
                iv_doctype       TYPE /mlsft/ed_direct OPTIONAL
      EXPORTING et_headers       TYPE /mlsft/ed_tt_head
                et_ref           TYPE /mlsft/ed_tt_ref
                et_list          TYPE /mlsft/ed_tt_list.

    CLASS-METHODS get_invoice_with_sel_params
      IMPORTING it_range_doctype     TYPE /mlsft/ed_tt_general_range "
                it_range_delflag     TYPE /mlsft/ed_tt_general_range OPTIONAL "/mlsft/ed_r_table_delflag OPTIONAL
                it_tab_range         TYPE /mlsft/ed_tt_rsparams
                iv_doctype           TYPE /mlsft/ed_direct OPTIONAL
                it_range_europe_stat TYPE /mlsft/ed_tt_general_range OPTIONAL " /mlsft/ed_r_table_europe_stat OPTIONAL
      EXPORTING et_headers           TYPE /mlsft/ed_tt_head
                et_ref               TYPE /mlsft/ed_tt_ref
                et_list              TYPE /mlsft/ed_tt_list.


**CLASS-METHODS get_kz_doc_with_sel_params
**  IMPORTING !it_range_doctype TYPE /mlsft/ed_r_table_doctype
**            !it_range_delflag TYPE /mlsft/ed_r_table_delflag OPTIONAL
**            !it_tab_range     TYPE /mlsft/ed_tt_rsparams
**            !iv_doctype       TYPE /mlsft/ed_direct OPTIONAL.



**    CLASS-METHODS get_kz_doc_with_sel_params
**      IMPORTING
**        it_range_doctype TYPE /mlsft/ed_r_table_doctype
**        it_range_delflag TYPE /mlsft/ed_r_table_delflag OPTIONAL
**        it_tab_range     TYPE /mlsft/ed_tt_rsparams
**        iv_doctype       TYPE /mlsft/ed_direct OPTIONAL
**      EXPORTING
**        et_headers TYPE /mlsft/ed_tt_head
**        et_ref     TYPE /mlsft/ed_tt_ref
**        et_list    TYPE /mlsft/ed_tt_list.

**    CLASS-METHODS get_rotr_doc_with_sel_params
**      IMPORTING
**        it_range_doctype TYPE /mlsft/ed_r_table_doctype
**        it_range_delflag TYPE /mlsft/ed_r_table_delflag OPTIONAL
**        it_tab_range     TYPE /mlsft/ed_tt_rsparams
**        iv_doctype       TYPE /mlsft/ed_direct OPTIONAL
**      EXPORTING
**        et_headers TYPE /mlsft/ed_tt_head
**        et_ref     TYPE /mlsft/ed_tt_ref
**        et_list    TYPE /mlsft/ed_rotr_tt_list.

    CLASS-METHODS create_ranges
      IMPORTING
        it_select    TYPE /mlsft/ed_tt_rsparams
        iv_selname   TYPE /mlsft/ED_CHAR8
        iv_fieldname TYPE /mlsft/ED_CHAR30
      CHANGING
        ct_range     TYPE any.

    CLASS-METHODS get_doc_details
      IMPORTING
        iv_docnum TYPE /mlsft/ed_guid
      EXPORTING
        es_header TYPE /mlsft/ed_head
        es_ref    TYPE /mlsft/ed_ref
        es_data   TYPE /mlsft/ed_raw
        et_rawall TYPE /mlsft/ed_rawall_tt
        es_json   TYPE /mlsft/ed_t_json
        et_raw_at TYPE /mlsft/ed_raw_at_tt.

    CLASS-METHODS get_gibid_customizing
      IMPORTING
        iv_bukrs           TYPE bukrs
        iv_werks           TYPE werks_d
        iv_/mlsft/ED_CHAR4 TYPE /mlsft/ED_CHAR4
        iv_doctype         TYPE /mlsft/ed_direct OPTIONAL
      RETURNING
        VALUE(rs_gibid)    TYPE /mlsft/ed_tgibid.

    CLASS-METHODS get_receipt_gib_customizing
      IMPORTING
        iv_bukrs        TYPE bukrs
        iv_doctype      TYPE /mlsft/ed_direct OPTIONAL
      RETURNING
        VALUE(rs_gibid) TYPE /mlsft/ed_trecid .

    CLASS-METHODS get_bukrs_from_werks
      IMPORTING
        iv_werks        TYPE werks_d
      RETURNING
        VALUE(rv_bukrs) TYPE bukrs.

    CLASS-METHODS get_transaction_code
      IMPORTING
        iv_process      TYPE /mlsft/ed_process
        iv_tcode        TYPE tcode OPTIONAL
      RETURNING
        VALUE(rt_custm) TYPE /mlsft/ed_tt_custm.

    CLASS-METHODS get_reply_docnum
      IMPORTING
        iv_docnum        TYPE /mlsft/ed_guid
      RETURNING
        VALUE(rv_docnum) TYPE /mlsft/ed_guid.

    CLASS-METHODS get_adrc_for_bukrs
      IMPORTING
        iv_bukrs TYPE bukrs.
**      RETURNING
**        VALUE(r_adrc) TYPE  I_Address.

    CLASS-METHODS get_color_codes
      IMPORTING
        im_bukrs         TYPE bukrs OPTIONAL
      RETURNING
        VALUE(re_alvclr) TYPE xstring."/mlsft/ed_alvclr_tt.

    CLASS-METHODS get_statu_log
      IMPORTING
        iv_docnum           TYPE /mlsft/ed_guid
      RETURNING
        VALUE(rt_statu_log) TYPE /mlsft/ed_statlg_tt.

    CLASS-METHODS get_po_data
      IMPORTING
        iv_ebeln TYPE ebeln.
**      EXPORTING
**        es_ekko TYPE /mlsft/ed_ekko_sc
**        et_ekpo TYPE /mlsft/me_ekpo.

    CLASS-METHODS get_adrc_for_werks
      IMPORTING
        iv_werks TYPE werks_d.
**      EXPORTING
**        es_adrc  TYPE I_Address.
**        es_t001w TYPE t001w.

    CLASS-METHODS get_partner_for_werks
      IMPORTING
        iv_werks   TYPE werks_d
      EXPORTING
        ev_ptype   TYPE /mlsft/ed_d_partnert
        ev_partner TYPE /mlsft/ed_d_partner.

    CLASS-METHODS get_releated_receipts
      IMPORTING
        iv_docnum      TYPE /mlsft/ed_guid
      RETURNING
        VALUE(rt_link) TYPE /mlsft/ed_tt_link.

    CLASS-METHODS get_receipt_doc_frm_despatch
      IMPORTING
        iv_docnum        TYPE /mlsft/ed_guid
      RETURNING
        VALUE(rv_docnum) TYPE /mlsft/ed_guid.

    CLASS-METHODS check_partner_is_virt
      IMPORTING
        iv_vkn            TYPE any OPTIONAL
        iv_issuedate      TYPE datum OPTIONAL
      RETURNING
        VALUE(rv_virtual) TYPE /mlsft/ed_char1.

    CLASS-METHODS get_country_name
      IMPORTING
        iv_land         TYPE land1
        iv_spras        TYPE spras DEFAULT 'T'
      RETURNING
        VALUE(rs_t005t) TYPE I_Country.

    CLASS-METHODS check_shipment
      IMPORTING
        is_shpmentstage  TYPE /mlsft/ed_s_shpstage
        is_carrierparty  TYPE /mlsft/ed_s_party
      RETURNING
        VALUE(rv_result) TYPE /mlsft/ed_char1.

    CLASS-METHODS get_erpcoc_details
      IMPORTING
        iv_docnum TYPE any
        iv_doctyp TYPE any
        iv_gjahr  TYPE gjahr OPTIONAL
      EXPORTING
        es_head   TYPE any
        et_items  TYPE any.

    CLASS-METHODS append_buffer_erpcocs
      IMPORTING
        iv_doctype TYPE any
        it_items   TYPE any
        it_header  TYPE any.

    CLASS-METHODS get_post_fi_tcode
      IMPORTING
        iv_bukrs TYPE bukrs.
**      RETURNING
**        VALUE(rv_tcode) TYPE sy-tcode.

    CLASS-METHODS get_mapp_class
      IMPORTING
        iv_clstype     TYPE /mlsft/ed_clstype OPTIONAL
        iv_doctype     TYPE /mlsft/ed_direct OPTIONAL
        iv_vbtyp       TYPE vbtyp OPTIONAL
      RETURNING
        VALUE(rs_mapp) TYPE /mlsft/ed_mapp.

    CLASS-METHODS get_service_action
      IMPORTING
        iv_land1         TYPE land1 OPTIONAL
        iv_doctype       TYPE /mlsft/ed_direct OPTIONAL
        iv_action        TYPE /mlsft/ed_de_action OPTIONAL
      RETURNING
        VALUE(rs_method) TYPE /mlsft/ed_action.

    CLASS-METHODS check_cust_param_delivery
      IMPORTING
        iv_country      TYPE land1 OPTIONAL
        iv_doctype      TYPE /mlsft/ed_direct OPTIONAL
        iv_type         TYPE /mlsft/ed_type OPTIONAL
        iv_value        TYPE /mlsft/ed_dparam_value OPTIONAL
      RETURNING
        VALUE(rt_param) TYPE /mlsft/param_del_tt.

    CLASS-METHODS check_cust_param
      IMPORTING
        iv_country      TYPE land1 OPTIONAL
        iv_doctype      TYPE /mlsft/ed_direct OPTIONAL
        iv_type         TYPE /mlsft/ed_type OPTIONAL
        iv_value        TYPE /mlsft/ed_dparam_value OPTIONAL
      RETURNING
        VALUE(rt_param) TYPE /mlsft/sei_param_tt.

    CLASS-METHODS get_oldint
      RETURNING
        VALUE(rs_oldint) TYPE /mlsft/ed_oldint.

    CLASS-METHODS get_bukrs_from_vbeln
      IMPORTING
        iv_vbeln        TYPE vbeln OPTIONAL
        iv_vbtyp        TYPE /mlsft/ED_CHAR1 OPTIONAL
        iv_werks        TYPE werks_d
      RETURNING
        VALUE(rv_bukrs) TYPE bukrs.

    CLASS-METHODS get_response_for_vat_mail
      IMPORTING
        iv_uname           TYPE SYuname OPTIONAL
        iv_stceg           TYPE /mlsft/ED_char20 OPTIONAL
      RETURNING
        VALUE(rt_response) TYPE /mlsft/ed_respon_tt.

    CLASS-METHODS get_distribution_list
      IMPORTING
        it_respon TYPE /mlsft/ed_respon_tt OPTIONAL.
**      EXPORTING
**        et_sodlienti1 TYPE /mlsft/ed_sodlienti1_tt.

    CLASS-METHODS get_other_tags
      RETURNING
        VALUE(ex_tags) TYPE /mlsft/ed_tt_tags.

    CLASS-METHODS get_invlog
      IMPORTING
        iv_docnum        TYPE /mlsft/ed_guid OPTIONAL
      RETURNING
        VALUE(rs_invlog) TYPE /mlsft/ed_invlog.

    CLASS-METHODS get_greece_info
      IMPORTING
        iv_docnum TYPE /mlsft/ed_guid
      EXPORTING
        es_greece TYPE /mlsft/ed_grc.

    CLASS-METHODS material_document
      IMPORTING
        iv_mblnr TYPE /mlsft/ed_char10.
**      EXPORTING
**        es_mkpf TYPE mkpf
**        et_mseg TYPE mseg_t.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS /MLSFT/ED_SELECT IMPLEMENTATION.


  METHOD get_parameter_table.


    READ TABLE /mlsft/ed_select=>mt_param INTO re_result
                                       WITH KEY param = im_parameter
                                                active = 'X'.

    IF sy-subrc IS NOT INITIAL.

      SELECT SINGLE * FROM /mlsft/ed_param
        WHERE param = @im_parameter AND active  = 'X'
         INTO @re_result.
      IF sy-subrc IS INITIAL.
        " add buffer
        APPEND re_result TO /mlsft/ed_select=>mt_param.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD get_despatch_frm_uuid.

    SELECT SINGLE *
      FROM /mlsft/ed_ref
      WHERE uuid = @iv_uuid
      INTO CORRESPONDING FIELDS OF @rs_ref.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = |UUID { iv_uuid } için kayıt bulunamadı.|
                                                  ).
    ENDIF.

  ENDMETHOD.


  METHOD get_company_info.
    IF /mlsft/ed_select=>mt_cust_comp IS INITIAL.
      SELECT * FROM /mlsft/ed_tcomp
        INTO TABLE @/mlsft/ed_select=>mt_cust_comp.
    ENDIF.
    READ TABLE /mlsft/ed_select=>mt_cust_comp
      INTO re_value WITH KEY bukrs = iv_bukrs.
  ENDMETHOD.


  METHOD get_companies_t001.
**    READ TABLE /mlsft/ed_select=>mt_t001 INTO rs_t001 "FIXME
**      WITH KEY bukrs = iv_bukrs.
    IF sy-subrc <> 0.
**      SELECT SINGLE * FROM t001 INTO rs_t001 WHERE bukrs = iv_bukrs. "FIXME
      IF sy-subrc = 0.
**        APPEND rs_t001 TO /mlsft/ed_select=>mt_t001."FIXME
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD filter_sd_invoices.
    DATA lt_vbelns TYPE /mlsft/ed_tt_vbeln.
    FIELD-SYMBOLS <ls_vbeln> TYPE LINE OF /mlsft/ed_tt_vbeln.
    IF it_vbeln IS NOT INITIAL.
**      SELECT vbeln FROM I_BillingDocument INTO TABLE @lt_vbelns
**        FOR ALL ENTRIES IN @it_vbeln
**        WHERE vbeln = @it_vbeln-vbeln
**          AND rfbsk = 'E'.
    ENDIF.
    LOOP AT lt_vbelns ASSIGNING <ls_vbeln>.
      DELETE it_vbeln WHERE vbeln = <ls_vbeln>-vbeln.
    ENDLOOP.
  ENDMETHOD.


  METHOD filter_sd_deliveries.
    DATA lt_vbelns TYPE /mlsft/ed_tt_vbeln.
    FIELD-SYMBOLS <ls_vbeln> TYPE LINE OF /mlsft/ed_tt_vbeln.
**    IF it_vbeln IS NOT INITIAL.
**      SELECT vbeln FROM I_OutboundDelivery
**        FOR ALL ENTRIES IN @it_vbeln
**        WHERE vbeln = @it_vbeln-vbeln
**INTO TABLE @lt_vbelns
**    ENDIF.
    LOOP AT it_vbeln ASSIGNING <ls_vbeln>.
      READ TABLE lt_vbelns TRANSPORTING NO FIELDS
        WITH KEY vbeln = <ls_vbeln>-vbeln BINARY SEARCH.
      IF sy-subrc <> 0.
        CLEAR <ls_vbeln>.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD filter_mm_deliveries.
    TYPES: BEGIN OF ts_mseg_key,
             mblnr TYPE /mlsft/ed_char10, "mblnr,
             mjahr TYPE /mlsft/ed_char4, "mjahr,
             zeile TYPE /mlsft/ed_char4, "mblpo,
           END OF ts_mseg_key.
    DATA lt_mseg_key TYPE TABLE OF ts_mseg_key.
    FIELD-SYMBOLS <ls_mseg_key> TYPE ts_mseg_key.
    CHECK it_mmdocs IS NOT INITIAL.
**     SELECT mblnr mjahr zeile
**       FROM I_MaterialDocumentItem INTO TABLE lt_mseg_key
**       FOR ALL ENTRIES IN it_mmdocs
**       WHERE mblnr = it_mmdocs-mblnr
**         AND mjahr = it_mmdocs-mjahr
**         AND smbln <> ''
**         AND smblp <> ''.
    LOOP AT lt_mseg_key ASSIGNING <ls_mseg_key>.
      DELETE it_mmdocs WHERE mblnr = <ls_mseg_key>-mblnr
                         AND mjahr = <ls_mseg_key>-mjahr.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_addon_usage.
    READ TABLE mt_addon INTO rs_addon WITH KEY bukrs = iv_bukrs.
    IF sy-subrc <> 0.
      SELECT * FROM /mlsft/ed_addon INTO TABLE @mt_addon.
      READ TABLE mt_addon INTO rs_addon WITH KEY bukrs = iv_bukrs.
    ENDIF.
  ENDMETHOD.


  METHOD get_addon_comp_list.
**    SELECT * FROM /mlsft/ed_addon
**      INTO TABLE @et_addon.
**      WHERE bukrs IN @it_range_bukrs.
  ENDMETHOD.


  METHOD get_addon_details.
    READ TABLE mt_addon INTO es_addon
      WITH KEY bukrs = iv_bukrs addon = iv_addon.
    IF sy-subrc <> 0.
**      SELECT * FROM /mlsft/ed_addon INTO TABLE mt_addon.
      READ TABLE mt_addon INTO es_addon
        WITH KEY bukrs = iv_bukrs addon = iv_addon.
    ENDIF.
  ENDMETHOD.


  METHOD get_org_settings.
    IF /mlsft/ed_select=>mt_cust_vkorg IS INITIAL.
      SELECT * FROM /mlsft/ed_vkorg INTO TABLE @/mlsft/ed_select=>mt_cust_vkorg.
    ENDIF.
    READ TABLE /mlsft/ed_select=>mt_cust_vkorg INTO rs_customising
      WITH KEY vkorg = iv_vkorg lfart = iv_lfart
       vstel = iv_VSTEL.
    IF sy-subrc <> 0.
      READ TABLE /mlsft/ed_select=>mt_cust_vkorg INTO rs_customising
        WITH KEY vkorg = iv_vkorg lfart = iv_lfart vstel = '*'.
      IF sy-subrc <> 0.
        READ TABLE /mlsft/ed_select=>mt_cust_vkorg INTO rs_customising
          WITH KEY vkorg = iv_vkorg lfart = '*' vstel = '*'.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD get_company_settings.
    CLEAR re_set.
**    SELECT SINGLE * FROM /mlsft/ed_tcset INTO @re_set WHERE bukrs = @im_bukrs.
  ENDMETHOD.


  METHOD get_customer_fr_invoice.
    " Orijinal kaynak boş; mevcut imzayı koruyoruz
  ENDMETHOD.


  METHOD get_old_delivery.
**    SELECT SINGLE a~gibid
**      FROM /mlsft/ed_ref AS a
**      INNER JOIN /mlsft/ed_head AS b
**        ON a~docnum = b~docnum
**      INTO @r_gibid
**      WHERE b~refdoc  = @iv_vbelv
**        AND b~reftype = @iv_vbtyp.
**        AND ( b~lstatus = @/mlsft/ed_constants=>doc_created
**           OR b~lstatus = @/mlsft/ed_constants=>doc_cancelled )
**        AND a~gibid <> @/mlsft/ed_constants=>abap_false.
  ENDMETHOD.


  METHOD get_invoice.
    DATA iv_vbeln TYPE /mlsft/ed_char10."vbrk-vbeln.
    iv_vbeln = awkey.
    " ALPHA IN (FM yerine söz dizimi ile)
    iv_vbeln = |{ iv_vbeln ALPHA = IN }|.
**    SELECT SINGLE * FROM I_BillingDocument WHERE vbeln = iv_vbeln INTO vbrk .
**    SELECT * FROM vbrp WHERE vbeln = iv_vbeln INTO TABLE I_BillingDocumentItem .
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Invoice not found' ).
    ENDIF.
  ENDMETHOD.


  METHOD get_invoice_f_keys.
    CLEAR re_value.
    SELECT SINGLE * FROM /mlsft/ed_main
      WHERE enumber = @im_enumber
        AND bukrs   = @im_bukrs
              INTO @re_value.
  ENDMETHOD.


  METHOD get_partner_details.
    CHECK im_partner IS NOT INITIAL.

    DATA ls_bp TYPE I_BusinessPartner.
**  DATA ls_lfa1 TYPE I_Supplier.
**  DATA ls_kna1 TYPE I_Customer.

    FIELD-SYMBOLS: <ls_any>  TYPE any,
                   <f_taxid> TYPE any.

    " Sistem ayarlarından vergi no alan adını al
    DATA ms_system_l TYPE /mlsft/ed_system.
    DATA comp_taxid  TYPE /mlsft/ed_char50.

    ms_system_l = /mlsft/ed_select=>get_system_settings( ).

    " Partner tipine göre kaynak yapıyı belirle
    CASE im_ptype.
      WHEN 'V' OR 'C'.  " Vendor
        SELECT SINGLE * FROM I_BusinessPartner
          WHERE BusinessPartner = @im_partner
                 INTO @ls_bp.
        comp_taxid = ms_system_l-vtaxidfield.
        ASSIGN ls_bp TO <ls_any>.

      WHEN 'V'.  " Vendor
**     SELECT SINGLE * FROM I_Supplier
**       WHERE Supplier = @im_partner.
**      comp_taxid = ms_system_l-vtaxidfield.
**      ASSIGN ls_lfa1 TO <ls_any>
**       INTO @ls_lfa1.

      WHEN 'C'.  " Customer
**     SELECT SINGLE * FROM I_Customer
**       WHERE Customer = @im_partner.
**      comp_taxid = ms_system_l-ctaxidfield.
**      ASSIGN ls_kna1 TO <ls_any>
**       INTO @ls_kna1.

      WHEN OTHERS.
        RETURN.
    ENDCASE.

    " Kaynak yapı yoksa ya da alan adı boşsa çık
    IF <ls_any> IS NOT ASSIGNED OR comp_taxid IS INITIAL.
      RETURN.
    ENDIF.

    " Dinamik bileşen ataması (Cloud-uyumlu)
    ASSIGN COMPONENT comp_taxid OF STRUCTURE <ls_any> TO <f_taxid>.
    IF <f_taxid> IS NOT ASSIGNED.
      RETURN.
    ENDIF.

    " Vergi numarası boşsa işlem yapma
    IF <f_taxid> IS INITIAL.
      RETURN.
    ENDIF.

    " İlerde VKN tablosundan detay okumak istersen:
* DATA ls_vkn TYPE /mlsft/ed_sc_vkn.
* SELECT SINGLE *
*   FROM /mlsft/ed_vkn
*   INTO @ls_vkn
*  WHERE tax_id_or_personal_id = @<f_taxid>.

    " Gerekirse burada ch_* değişkenlerini veya çıkış parametrelerini doldurabilirsin

  ENDMETHOD.


  METHOD get_vkn_frm_partner_id.
    DATA ms_system_l TYPE /mlsft/ed_system.
    DATA ls_bp TYPE I_BusinessPartner.
**  DATA ls_lfa1 TYPE I_Supplier.
**  DATA ls_kna1 TYPE I_Customer.
    FIELD-SYMBOLS: <ls_any>  TYPE any,
                   <f_taxid> TYPE any,
                   <f_taxlc> TYPE any.

    DATA comp_taxid  TYPE /mlsft/ed_char50.
    DATA comp_taxloc TYPE /mlsft/ed_char50.

    " ---------------------------------------------------------------
    " Sistem konfigürasyonundan (ayarlardan) ilgili alan adlarını al
    " ---------------------------------------------------------------
    ms_system_l = /mlsft/ed_select=>get_system_settings( im_bukrs = im_bukrs ).


    CASE im_ptype.

      WHEN 'V' OR 'C'. " Supplier or " Customer

        SELECT SINGLE * FROM I_BusinessPartner
        WHERE BusinessPartner = @im_partner
           INTO @ls_bp.
        comp_taxid  = ms_system_l-vtaxidfield.
        comp_taxloc = ms_system_l-taxloc.
      WHEN 'V'.
        " Cloud ortamda SELECT yasak, ama ileride kullanılmak üzere yorumda bırakıldı
*     SELECT SINGLE * FROM I_Supplier
*       WHERE Supplier = @im_partner
*       INTO data(@ls_lfa1).

        " Dinamik alan adları
        comp_taxid  = ms_system_l-vtaxidfield.
        comp_taxloc = ms_system_l-taxloc.
**      ASSIGN ls_lfa1 TO <ls_any>.

      WHEN 'C'. " Customer
*     SELECT SINGLE * FROM I_Customer
*       INTO data(@ls_kna1)
*       WHERE Customer = @im_partner.

        comp_taxid  = ms_system_l-ctaxidfield.
        comp_taxloc = ms_system_l-taxloc.
**      ASSIGN ls_kna1 TO <ls_any>.

      WHEN OTHERS.
        CLEAR: ev_taxid, ev_taxloc.
        RETURN.

    ENDCASE.

    " ---------------------------------------------------------------
    " Dinamik bileşen ataması (Cloud uyumlu)
    " ---------------------------------------------------------------
    IF <ls_any> IS ASSIGNED.
      IF comp_taxid IS NOT INITIAL.
        ASSIGN COMPONENT comp_taxid OF STRUCTURE <ls_any> TO <f_taxid>.
        IF <f_taxid> IS ASSIGNED.
          ev_taxid = <f_taxid>.
          CONDENSE ev_taxid NO-GAPS.
        ENDIF.
      ENDIF.

      IF comp_taxloc IS NOT INITIAL.
        ASSIGN COMPONENT comp_taxloc OF STRUCTURE <ls_any> TO <f_taxlc>.
        IF <f_taxlc> IS ASSIGNED.
          ev_taxloc = <f_taxlc>.
          CONDENSE ev_taxloc NO-GAPS.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD get_partner_from_tax.
    " Önce vendor
    /mlsft/ed_select=>get_vendor_from_tax(
      EXPORTING iv_taxid      = iv_taxid
                iv_taxloc     = iv_taxloc
                iv_bukrs      = iv_bukrs
                iv_xtax_check = iv_xtax_check
      IMPORTING ev_partner    = ev_partner
                ev_ptype      = ev_ptype ).
    IF ev_partner IS NOT INITIAL.
      RETURN.
    ENDIF.
    " Sonra customer
    /mlsft/ed_select=>get_customer_from_tax(
      EXPORTING iv_taxid   = iv_taxid
                iv_taxloc  = iv_taxloc
                iv_bukrs   = iv_bukrs
      IMPORTING ev_partner = ev_partner
                ev_ptype   = ev_ptype ).
    IF ev_partner IS NOT INITIAL.
      RETURN.
    ENDIF.
    " Son olarak şirket (intercompany)
    /mlsft/ed_select=>get_company_from_tax(
      EXPORTING iv_taxid   = iv_taxid
                iv_taxloc  = iv_taxloc
      IMPORTING ev_partner = ev_partner
                ev_ptype   = ev_ptype ).
  ENDMETHOD.


  METHOD get_vendor_from_tax.
    " ABAP Cloud: dinamik WHERE (lt_options) kullanımı ve alan adıyla compare yasak.
    " İmza korunur, açıklayıcı istisna fırlatılır.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Not supported in ABAP Cloud: dynamic WHERE on LFA1 (use released APIs or CDS views).'
                                                ).
  ENDMETHOD.


  METHOD get_vendor_from_tax_with_addon.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Not supported in ABAP Cloud: dynamic WHERE with addon on LFA1.'
                                                ).
  ENDMETHOD.


  METHOD get_cust_from_tax_with_addon.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Not supported in ABAP Cloud: dynamic WHERE with addon on KNA1.'
                                                ).
  ENDMETHOD.


  METHOD get_partn_from_tax_with_addon.
    CHECK iv_taxid IS NOT INITIAL.
    " Önce vendor dene
    /mlsft/ed_select=>get_vendor_from_tax_with_addon(
      EXPORTING iv_taxid = iv_taxid iv_bukrs = iv_bukrs iv_addon = iv_addon
      IMPORTING ev_partner = ev_partner ev_ptype = ev_ptype ).
    IF ev_partner IS NOT INITIAL.
      RETURN.
    ENDIF.
    " Sonra customer dene
    /mlsft/ed_select=>get_cust_from_tax_with_addon(
      EXPORTING iv_taxid = iv_taxid iv_bukrs = iv_bukrs iv_addon = iv_addon
      IMPORTING ev_partner = ev_partner ev_ptype = ev_ptype ).
  ENDMETHOD.


  METHOD get_customer_from_tax.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Not supported in ABAP Cloud: dynamic WHERE on KNA1 (use released APIs or CDS views).'
                                                ).
  ENDMETHOD.


  METHOD get_units.
    IF /mlsft/ed_select=>mt_units IS INITIAL.
      SELECT * FROM /mlsft/ed_tunitc
        INTO TABLE @/mlsft/ed_select=>mt_units.
    ENDIF.
    rt_units = /mlsft/ed_select=>mt_units.
  ENDMETHOD.


  METHOD get_company_from_tax.
**    DATA ls_t001 TYPE I_CompanyCode.
**    DATA lv_stceg TYPE I_CompanyCode-stceg.
**    lv_stceg = iv_taxid.
**    SELECT SINGLE * FROM I_CompanyCode INTO ls_t001 WHERE stceg = lv_stceg.
    IF sy-subrc = 0.
**      ev_partner = ls_t001-bukrs.
      ev_ptype   = 'W'.
    ENDIF.
  ENDMETHOD.


  METHOD get_docnum_with_uuid.
**    SELECT SINGLE /mlsft/ed_ref~docnum
**      FROM /mlsft/ed_ref
**      INNER JOIN /mlsft/ed_head
**        ON /mlsft/ed_ref~docnum = /mlsft/ed_head~docnum
**      INTO @rv_docnum
**      WHERE /mlsft/ed_ref~uuid    = @iv_uuid
**        AND /mlsft/ed_head~doctype = @iv_doctype.
  ENDMETHOD.


  METHOD get_city_name_list.
**    SELECT bland bezei FROM t005u
**      INTO TABLE re_bezei_list
**      WHERE land1 = iv_land1
**        AND spras = iv_spras.
  ENDMETHOD.


  METHOD get_city_name.
**    SELECT SINGLE bezei FROM t005u INTO rv_bezei
**      WHERE spras = 'TR' AND land1 = iv_land1 AND bland = iv_regio.
  ENDMETHOD.


  METHOD get_system_settings.
    IF /mlsft/ed_select=>ms_system IS INITIAL.
      IF im_bukrs IS NOT INITIAL.
        SELECT SINGLE * FROM /mlsft/ed_system
          WHERE sysid = @sy-sysid AND bukrs = @im_bukrs INTO @re_value.
        IF sy-subrc <> 0.
          SELECT SINGLE * FROM /mlsft/ed_system
            WHERE sysid = @sy-sysid  INTO @re_value.
        ENDIF.
      ELSE.
        SELECT SINGLE * FROM /mlsft/ed_system
          WHERE sysid = @sy-sysid AND bukrs = '' INTO @re_value.
      ENDIF.
    ELSE.
      re_value = /mlsft/ed_select=>ms_system.
    ENDIF.
  ENDMETHOD.


  METHOD select_tax_def.
    SELECT SINGLE sdesc FROM /mlsft/ed_ttax
      WHERE taxtypecode = @im_taxtype INTO @re_value .
  ENDMETHOD.


  METHOD get_documents_from_uui.
    " Orijinal kaynak boş; imza korunur
  ENDMETHOD.


  METHOD get_document_from_ref.
    CLEAR re_value.
**    SELECT SINGLE * FROM /mlsft/ed_head INTO re_value
**      WHERE reftype = im_reftype
**        AND refdoc  = im_refdoc
**        AND lstatus <> /mlsft/ed_constants=>doc_cancelled.
  ENDMETHOD.


  METHOD get_document_crtl_with_ref.
    DATA ls_head TYPE /mlsft/ed_head.
    IF im_jahr IS NOT INITIAL.
      SELECT SINGLE * FROM /mlsft/ed_head
        WHERE reftype = @im_reftype
          AND refdoc  = @im_refdoc
          AND jahr    = @im_jahr
          AND delflag <> 'X'
            INTO @ls_head.
    ELSE.
      SELECT SINGLE * FROM /mlsft/ed_head
        WHERE reftype = @im_reftype
          AND refdoc  = @im_refdoc
          AND delflag <> 'X' INTO @ls_head.
    ENDIF.
    IF ls_head IS NOT INITIAL.
      TRY.
**          ro_docctrl = /mlsft/ed_document_ctrl=>global_factory( iv_docnum = @ls_head-docnum ).
        CATCH /mlsft/cx_ed_exception INTO DATA(lx).
          RAISE EXCEPTION lx.
      ENDTRY.
    ENDIF.
  ENDMETHOD.


  METHOD determine_profileid.
    " Kaynakta dolgu kalıpları var; burada sadece buffer’ı dolduruyoruz.
    SELECT * FROM /mlsft/ed_sd_pro INTO TABLE @mt_profileid.
    " Arama stratejisi kaynakta yorumlu: burada ilk kaydı döndürüyoruz.
    READ TABLE mt_profileid INTO ms_profileid INDEX 1.
    IF sy-subrc = 0.
      re_value = ms_profileid-profileid.
    ENDIF.
  ENDMETHOD.


  METHOD determine_profileid_by_part.
    " Orijinalde SELECT yorumlu; imzayı koruyoruz.
  ENDMETHOD.


  METHOD get_chartofaccount.
**    SELECT SINGLE ktopl FROM I_CompanyCode INTO @re_value WHERE bukrs = im_bukrs.
  ENDMETHOD.


  METHOD get_tax_rate.
**    DATA ls_a003 TYPE a003.
**    DATA ls_konp TYPE konp.
**    SELECT SINGLE * FROM a003 INTO ls_a003
**      WHERE kappl = 'TX'
**        AND aland = 'TR'
**        AND mwskz = im_mwskz
**        AND kschl LIKE 'MW%'.
**    SELECT SINGLE * FROM konp INTO ls_konp WHERE knumh = ls_a003-knumh.
**    IF im_kbetr IS INITIAL.
**      re_value = ls_konp-kbetr / 10.
**    ELSE.
**      re_value = ls_konp-kbetr.
**    ENDIF.
  ENDMETHOD.


  METHOD get_deliveries_with_sel_params.
    " Seçim parametrelerinden range setlerini üret ve listeyi getir
    DATA: lt_range_docnum          TYPE RANGE OF /mlsft/ed_guid,
          ls_range_docnum          LIKE LINE OF lt_range_docnum,
          lv_bukrs                 TYPE bukrs,
          lt_range_vbeln           TYPE RANGE OF /mlsft/ed_s_list-delv_num,
          ls_range_vbeln           LIKE LINE OF lt_range_vbeln,
          lt_range_lfart           TYPE RANGE OF /mlsft/ed_s_list-lfart,
          ls_range_lfart           LIKE LINE OF lt_range_lfart,
          lt_range_vkorg           TYPE RANGE OF /mlsft/ed_s_list-vkorg,
          ls_range_vkorg           LIKE LINE OF lt_range_vkorg,
          lt_range_/mlsft/ED_CHAR4 TYPE RANGE OF /mlsft/ed_s_list-vstel,
          ls_range_/mlsft/ED_CHAR4 LIKE LINE OF lt_range_/mlsft/ED_CHAR4,
          lt_range_werks           TYPE RANGE OF /mlsft/ed_s_list-werks,
          ls_range_werks           LIKE LINE OF lt_range_werks,
          lt_range_lgort           TYPE RANGE OF /mlsft/ed_s_list-lgort,
          ls_range_lgort           LIKE LINE OF lt_range_lgort,
          lt_range_wadat           TYPE RANGE OF /mlsft/ed_s_list-wadat_ist,
          ls_range_wadat           LIKE LINE OF lt_range_wadat,
          lt_range_gibid           TYPE RANGE OF /mlsft/ed_s_list-gibid,
          ls_range_gibid           LIKE LINE OF lt_range_gibid,
          lt_range_reftyp          TYPE RANGE OF /mlsft/ed_s_list-reftype,
          ls_range_reftype         LIKE LINE OF lt_range_reftyp,
          lt_range_refdoc          TYPE RANGE OF /mlsft/ed_s_list-refdoc,
          ls_range_refdoc          LIKE LINE OF lt_range_refdoc,
          lt_range_refgrp          TYPE RANGE OF /mlsft/ed_s_list-refgrup,
          ls_range_refgrp          LIKE LINE OF lt_range_refgrp,
          lt_range_ptype           TYPE RANGE OF /mlsft/ed_s_list-ptype,
          ls_range_ptype           LIKE LINE OF lt_range_ptype,
          lt_range_prtn            TYPE RANGE OF /mlsft/ed_s_list-partner,
          ls_range_prtn            LIKE LINE OF lt_range_prtn,
          lt_range_status          TYPE RANGE OF /mlsft/ed_s_list-lstatus,
          ls_range_status          LIKE LINE OF lt_range_status,
          lt_range_cby             TYPE RANGE OF /mlsft/ed_s_list-created_by,
          ls_range_cby             LIKE LINE OF lt_range_cby,
          lt_range_ctime           TYPE RANGE OF /mlsft/ed_s_list-creation_time,
          ls_range_ctime           LIKE LINE OF lt_range_ctime,
          lt_range_lsdate          TYPE RANGE OF /mlsft/ed_s_list-change_date,
          ls_range_lsdate          LIKE LINE OF lt_range_lsdate,
          lt_range_cdate           TYPE RANGE OF /mlsft/ed_s_list-creation_date,
          ls_range_cdate           LIKE LINE OF lt_range_cdate,
          lt_range_lstime          TYPE RANGE OF /mlsft/ed_s_list-change_time,
          ls_range_lstime          LIKE LINE OF lt_range_lstime,
          lt_range_ref_no          TYPE RANGE OF /mlsft/ed_s_list-ref_no,
          ls_range_ref_no          LIKE LINE OF lt_range_gibid.

    DATA ls_tab_range LIKE LINE OF it_tab_range.
    LOOP AT it_tab_range INTO ls_tab_range.
**      CHECK ls_tab_range-low IS NOT INITIAL OR ls_tab_range-high IS NOT INITIAL.
**      CASE ls_tab_range-selname.
**        WHEN 'P_BUKRS'.  lv_bukrs = ls_tab_range-low.
**        WHEN 'S_VBELN'.  MOVE-CORRESPONDING ls_tab_range TO ls_range_vbeln.  APPEND ls_range_vbeln  TO lt_range_vbeln.
**        WHEN 'S_LFART'.  MOVE-CORRESPONDING ls_tab_range TO ls_range_lfart.  APPEND ls_range_lfart  TO lt_range_lfart.
**        WHEN 'S_VKORG'.  MOVE-CORRESPONDING ls_tab_range TO ls_range_vkorg.  APPEND ls_range_vkorg  TO lt_range_vkorg.
**        WHEN 'S_/mlsft/ED_CHAR4'.  MOVE-CORRESPONDING ls_tab_range TO ls_range_/mlsft/ED_CHAR4.  APPEND ls_range_/mlsft/ED_CHAR4  TO lt_range_/mlsft/ED_CHAR4.
**        WHEN 'S_WERKS'.  MOVE-CORRESPONDING ls_tab_range TO ls_range_werks.  APPEND ls_range_werks  TO lt_range_werks.
**        WHEN 'S_LGORT'.  MOVE-CORRESPONDING ls_tab_range TO ls_range_lgort.  APPEND ls_range_lgort  TO lt_range_lgort.
**        WHEN 'S_WADAT'.  MOVE-CORRESPONDING ls_tab_range TO ls_range_wadat.  APPEND ls_range_wadat  TO lt_range_wadat.
**        WHEN 'S_DOCNUM'. MOVE-CORRESPONDING ls_tab_range TO ls_range_docnum. APPEND ls_range_docnum TO lt_range_docnum.
**        WHEN 'S_GIBID'.  MOVE-CORRESPONDING ls_tab_range TO ls_range_gibid.  APPEND ls_range_gibid  TO lt_range_gibid.
**        WHEN 'S_REF_NO'. MOVE-CORRESPONDING ls_tab_range TO ls_range_ref_no. APPEND ls_range_ref_no TO lt_range_ref_no.
**        WHEN 'S_REFTYP'. MOVE-CORRESPONDING ls_tab_range TO ls_range_reftype. APPEND ls_range_reftype TO lt_range_reftyp.
**        WHEN 'S_REFDOC'. MOVE-CORRESPONDING ls_tab_range TO ls_range_refdoc.  APPEND ls_range_refdoc  TO lt_range_refdoc.
**        WHEN 'S_REFGRP'. MOVE-CORRESPONDING ls_tab_range TO ls_range_refgrp.  APPEND ls_range_refgrp  TO lt_range_refgrp.
**        WHEN 'P_PRTNY'.
**          MOVE-CORRESPONDING ls_tab_range TO ls_range_ptype.
**          ls_range_ptype-sign   = /mlsft/ed_constants=>sign.
**          ls_range_ptype-option = /mlsft/ed_constants=>option.
**          APPEND ls_range_ptype TO lt_range_ptype.
**        WHEN 'S_PRTN'.   MOVE-CORRESPONDING ls_tab_range TO ls_range_prtn.   APPEND ls_range_prtn   TO lt_range_prtn.
**        WHEN 'S_STATUS'. MOVE-CORRESPONDING ls_tab_range TO ls_range_status. APPEND ls_range_status TO lt_range_status.
**        WHEN 'S_CBY'.    MOVE-CORRESPONDING ls_tab_range TO ls_range_cby.    APPEND ls_range_cby    TO lt_range_cby.
**        WHEN 'S_CTIME'.  MOVE-CORRESPONDING ls_tab_range TO ls_range_ctime.  APPEND ls_range_ctime  TO lt_range_ctime.
**        WHEN 'S_CDATE'.  MOVE-CORRESPONDING ls_tab_range TO ls_range_cdate.  APPEND ls_range_cdate  TO lt_range_cdate.
**        WHEN 'S_LSDATE'. MOVE-CORRESPONDING ls_tab_range TO ls_range_lsdate. APPEND ls_range_lsdate TO lt_range_lsdate.
**        WHEN 'S_LSTIME'. MOVE-CORRESPONDING ls_tab_range TO ls_range_lstime. APPEND ls_range_lstime TO lt_range_lstime.
**      ENDCASE.
    ENDLOOP.

**    SELECT * FROM /mlsft/ed_head AS h
**      INNER JOIN /mlsft/ed_ref AS r
**        ON h~docnum = r~docnum
**      INTO CORRESPONDING FIELDS OF TABLE @et_list
**      WHERE h~docnum        IN @lt_range_docnum
**        AND h~reftype       IN @lt_range_reftyp
**        AND h~refdoc        IN @lt_range_refdoc
**        AND h~refgrup       IN @lt_range_refgrp
**        AND h~lstatus       IN @lt_range_status
**        AND r~bukrs         =  @lv_bukrs
**        AND r~delv_num      IN @lt_range_vbeln
**        AND r~lfart         IN @lt_range_lfart
**        AND r~vkorg         IN @lt_range_vkorg
**        AND r~/mlsft/ED_CHAR4         IN @lt_range_/mlsft/ED_CHAR4
****        AND r~werks         IN @lt_range_werks
**        AND r~lgort         IN @lt_range_lgort
**        AND r~wadat_ist     IN @lt_range_wadat
**        AND r~gibid         IN @lt_range_gibid
**        AND r~ref_no        IN @lt_range_ref_no
**        AND r~partner       IN @lt_range_prtn
**        AND r~ptype         IN @lt_range_ptype
**        AND h~created_by    IN @lt_range_cby
**        AND h~doctype       =  @iv_doctype
**        AND h~doctype       IN @it_range_doctype
**        AND h~creation_time IN @lt_range_ctime
**        AND h~creation_date IN @lt_range_cdate
**        AND h~change_date   IN @lt_range_lsdate
**        AND h~change_time   IN @lt_range_lstime
**        AND h~delflag       IN @it_range_delflag.
  ENDMETHOD.


  METHOD get_invoice_with_sel_params.
    " Detaylar kaynağın devamında; aynı kalıp ile uygulanabilir
    CLEAR: et_headers, et_ref, et_list.
  ENDMETHOD.


  METHOD get_search_field.
    RAISE EXCEPTION NEW /mlsft/cx_ed_exception( iv_text = 'Not supported in ABAP Cloud: GUI search help FMs (F4IF_*).'
                                                ).
  ENDMETHOD.


  METHOD get_company_t001.
**    SELECT SINGLE * FROM I_CompanyCode INTO re_value WHERE bukrs = im_bukrs.
  ENDMETHOD.


  METHOD get_adress.
    IF im_addrnr IS NOT INITIAL.
**      SELECT SINGLE * FROM adrc INTO re_adrc WHERE addrnumber = im_addrnr.
    ENDIF.
  ENDMETHOD.


  METHOD change_system_inform.
    re_value = /mlsft/ed_select=>get_system_settings( ).
  ENDMETHOD.


  METHOD change_company_code.
    re_value = /mlsft/ed_select=>get_company_info( iv_bukrs = iv_bukrs ).
  ENDMETHOD.


  METHOD change_company_settings.
    re_set = /mlsft/ed_select=>get_company_settings( im_bukrs = im_bukrs ).
  ENDMETHOD.


  METHOD get_companycode_getdetail.
    " BAPI_COMPANYCODE_GETDETAIL Cloud’da yok; temel alanları T001/TADIR/ADRC ile
  ENDMETHOD.


  METHOD get_partner_address.
    DATA: ""ls_kna1 TYPE I_Customer,
      ""ls_lfa1 TYPE I_Supplier,
      ""ls_adrc TYPE adrc,
      "" ls_t001w TYPE t001w,
      "" ls_adr6 TYPE adr6,
      ls_company  TYPE /mlsft/ed_tcomp,
      lv_leng     TYPE i,
      lv_taxid    TYPE stcd4,
      lv_taxloc   TYPE stcd4,
      lv_partytpe TYPE /mlsft/ed_d_partnert,
      lv_werks    TYPE werks_d.

    lv_partytpe = im_partytpe.
    IF im_partytpe IS INITIAL.
      lv_partytpe = 'V'.
    ENDIF.

    /mlsft/ed_select=>get_vkn_frm_partner_id(
      EXPORTING im_partner = im_partner
                im_ptype   = lv_partytpe
      IMPORTING ev_taxid   = lv_taxid
                ev_taxloc  = lv_taxloc ).

**    ch_party-partytaxscheme-name = lv_taxloc.
**    ch_party-idcode = lv_taxid.

    IF lv_partytpe = 'C'.
**      SELECT SINGLE * FROM I_Customer INTO ls_kna1 WHERE kunnr = im_partner.
**      SELECT SINGLE * FROM I_BusinessPartnerAddress INTO ls_adrc WHERE addrnumber = ls_kna1-adrnr.
**      SELECT SINGLE * FROM I_AddressEmailAddress INTO ls_adr6 WHERE addrnumber = ls_kna1-adrnr.
**      IF ch_party-idcode IS INITIAL.
**        ch_party-idcode = COND #( WHEN ls_kna1-stcd2 IS NOT INITIAL THEN ls_kna1-stcd2 ELSE ls_kna1-stcd1 ).
**      ENDIF.
**      lv_leng = strlen( ch_party-idcode ).
**      ch_party-idtype = COND #( WHEN lv_leng = 10 THEN 'VKN' WHEN lv_leng = 11 THEN 'TCKN' ELSE ch_party-idtype ).
    ELSEIF lv_partytpe = 'V'.
**      SELECT SINGLE * FROM I_Supplier INTO ls_lfa1 WHERE lifnr = im_partner.
**      SELECT SINGLE * FROM I_BusinessPartnerAddress INTO ls_adrc WHERE addrnumber = ls_lfa1-adrnr.
**      SELECT SINGLE * FROM I_AddressEmailAddress INTO ls_adr6 WHERE addrnumber = ls_lfa1-adrnr.
**      IF ch_party-idcode IS INITIAL.
**        ch_party-idcode = COND #( WHEN ls_lfa1-stcd2 IS NOT INITIAL THEN ls_lfa1-stcd2 ELSE ls_lfa1-stcd1 ).
**      ENDIF.
**      ch_party-partytpe = 'V'.
**      lv_leng = strlen( ch_party-idcode ).
**      ch_party-idtype = COND #( WHEN lv_leng = 10 THEN 'VKN' WHEN lv_leng = 11 THEN 'TCKN' ELSE ch_party-idtype ).
    ELSEIF lv_partytpe = 'W'.
      DATA lv_partner TYPE werks_d.
      lv_partner = |{ im_partner ALPHA = OUT }|.
**      SELECT SINGLE * FROM I_StorageLocation INTO ls_t001w WHERE werks = lv_partner."T001W
**      SELECT SINGLE * FROM I_BusinessPartnerAddress  INTO ls_adrc  WHERE addrnumber = ls_t001w-adrnr.
**      SELECT SINGLE * FROM I_AddressEmailAddress  INTO ls_adr6  WHERE addrnumber = ls_t001w-adrnr.
**      SELECT SINGLE * FROM /MLSFT/ED_TCOMP INTO @ls_company WHERE bukrs = @im_bukrs.
**      ch_party-partytpe = 'W'.
**      lv_leng = strlen( ls_company-company_tax_no_2 ).
**      ch_party-idtype = COND #( WHEN lv_leng = 10 THEN 'VKN' WHEN lv_leng = 11 THEN 'TCKN' ELSE ch_party-idtype ).
**      ch_party-partytaxscheme-name = ls_company-company_tax_no_1.
**      ch_party-idcode              = ls_company-company_tax_no_2.
    ENDIF.

**    CONCATENATE ls_adrc-name1 ls_adrc-name2 INTO ch_party-partname SEPARATED BY space.
**    ch_party-postaladdress-adressid      = ls_adrc-addrnumber.
**    ch_party-postaladdress-cityname      = ls_adrc-city1.
**    ch_party-postaladdress-citysubdiv    = ls_adrc-city2.
**    ch_party-postaladdress-streetname    = ls_adrc-street.
**    ch_party-postaladdress-buildingname  = ls_adrc-building.
**    ch_party-postaladdress-buildingnumber= ls_adrc-str_suppl1.
**    ch_party-postaladdress-room          = ls_adrc-roomnumber.
**    CONCATENATE ls_adrc-str_suppl1 ls_adrc-str_suppl2 ls_adrc-str_suppl3
**      INTO ch_party-postaladdress-cname.
**    ch_party-contact-telephone           = ls_adrc-tel_number.
**    ch_party-contact-telefax             = ls_adrc-fax_number.
**    ch_party-postaladdress-ccode         = ls_adrc-country.
**    ch_party-postaladdress-region        = ls_adrc-region.
**    ch_party-postaladdress-postbox       = COALESCE( ls_adrc-post_code1, ls_adrc-po_box ).
**    ch_party-contact-electronicmail      = ls_adr6-smtp_addr.
  ENDMETHOD.


  METHOD create_ranges.
    " TODO: Implement logic to generate dynamic range tables from select-options
  ENDMETHOD.


  METHOD get_doc_details.
    IF es_header IS REQUESTED.
      SELECT SINGLE * FROM /mlsft/ed_head WHERE docnum = @iv_docnum INTO @es_header .
    ENDIF.
    IF es_ref IS REQUESTED.
      SELECT SINGLE * FROM /mlsft/ed_ref WHERE docnum = @iv_docnum INTO @es_ref  .
    ENDIF.
    IF es_data IS REQUESTED.
      SELECT SINGLE * FROM /mlsft/ed_raw  WHERE docnum = @iv_docnum INTO @es_data .
    ENDIF.
    IF es_json IS REQUESTED.
      SELECT SINGLE * FROM /mlsft/ed_t_json  WHERE docnum = @iv_docnum INTO @es_json .
    ENDIF.
    IF et_rawall IS REQUESTED.
**      SELECT * FROM /mlsft/ed_rawall  WHERE docnum = @iv_docnum INTO TABLE @et_rawall .
    ENDIF.

    IF et_raw_at IS REQUESTED.
**      SELECT * FROM /mlsft/ed_raw_at  WHERE docnum = @iv_docnum INTO TABLE @et_raw_at .
    ENDIF.


  ENDMETHOD.


  METHOD get_gibid_customizing.
    DATA lv_doctype TYPE /mlsFT/ed_direct.
    DATA lt_gibid TYPE TABLE OF /mlsFT/ed_tgibid.
    DATA ls_gibd TYPE /mlsFT/ed_tgibid.
    IF iv_doctype IS INITIAL .
      lv_doctype = /mlsFT/ed_constants=>doc_type_doc_out.
    ELSE.
      lv_doctype = iv_doctype.
    ENDIF.

    SELECT * FROM /mlsFT/ed_tgibid
                  WHERE bukrs = @iv_bukrs
                  AND   doctype = @lv_doctype INTO TABLE @lt_gibid.

    READ TABLE lt_gibid INTO ls_gibd WITH KEY werks = iv_werks.
**                                              vstel = iv_vstel.

    IF sy-subrc IS NOT INITIAL  OR ( iv_werks IS NOT INITIAL ) ."AND
**    iv_vstel IS NOT INITIAL ).
      READ TABLE lt_gibid INTO ls_gibd WITH KEY werks = iv_werks.
      IF sy-subrc IS NOT INITIAL OR iv_werks IS INITIAL.
        READ TABLE lt_gibid INTO ls_gibd WITH KEY bukrs = iv_bukrs.
      ENDIF.
    ENDIF.


    rs_gibid = ls_gibd.
  ENDMETHOD.


  METHOD get_receipt_gib_customizing.
    SELECT SINGLE * FROM  /mlsFT/ed_trecid
         WHERE bukrs = @iv_bukrs
          AND doctype = @iv_doctype       INTO @rs_gibid.
  ENDMETHOD.


  METHOD get_bukrs_from_werks.
**     select single  bukrs  from t001k into rv_bukrs where bwkey = iv_werks .


  ENDMETHOD.


  METHOD get_transaction_code.
**    if rt_custm is initial.
**
**      select  * from /mlsft/ed_custm
**         into table rt_custm.
**
**    endif.
  ENDMETHOD.


  METHOD get_reply_docnum.
    " TODO: Implement logic to find reply document number for given input
  ENDMETHOD.


  METHOD get_adrc_for_bukrs.
**      data :ls_t001 type t001.

**    clear ls_t001.
**    select single * from t001 into ls_t001 where bukrs = iv_bukrs.

**    check ls_t001 is not initial.
**    select single * from adrc into r_adrc where addrnumber = ls_t001-adrnr .
  ENDMETHOD.


  METHOD get_color_codes.
**    select * from /mlsft/ed_alvclr into table @re_alvclr.
  ENDMETHOD.


  METHOD get_statu_log.
**    select * from /mlsFT/ed_statlg
**     where docnum eq iv_docnum into table @rt_statu_log.
  ENDMETHOD.


  METHOD get_po_data.
    IF /mlsFT/ed_select=>ms_ekko IS INITIAL.

**      select single * from ekko into /mlsFT/ed_select=>ms_ekko where ebeln eq @iv_ebeln.

      IF sy-subrc EQ 0.

**        select * from ekpo
**          where ebeln eq @iv_ebeln
**          into corresponding fields of table /mlsft/ed_select=>mt_ekpo.

      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD get_adrc_for_werks.
**    data: ls_t001w type t001w.
**
**
**    select single * from t001w where werks = @iv_werks  into @es_t001w.
**
**    check es_t001w is not initial.
**    select single * from adrc where addrnumber = @es_t001w-adrnr into @es_adrc .
  ENDMETHOD.


  METHOD get_partner_for_werks.
**    data: ls_t001w type t001w.
**
**    select single * from t001w where werks = @iv_werks  into @ls_t001w .
**
**    if ls_t001w-kunnr is  not initial.
**
**      ev_partner = ls_t001w-kunnr .
**      ev_ptype = /mlsft/ed_constants=>customer.
**
**    elseif ls_t001w-lifnr is not initial.
**
**      ev_partner = ls_t001w-lifnr .
**      ev_ptype = /mlsft/ed_constants=>vendor.
**
**    endif.

  ENDMETHOD.


  METHOD get_releated_receipts.
**    SELECT * FROM /mlsFT/ed_link
**                             WHERE  parentdoc = @iv_docnum
**                                AND parenttype =  @/mlsFT/ed_constants=>doc_type_doc_in
**                                AND subtype = @/mlsFT/ed_constants=>doc_type_resp_out
**                                                        INTO TABLE @rt_link.
  ENDMETHOD.


  METHOD get_receipt_doc_frm_despatch.
    select single subdoc  from /mlsFT/ed_link
                             where  parentdoc = @iv_docnum
                                and deleted = '' into @rv_docnum.
  ENDMETHOD.


  METHOD check_partner_is_virt.
     data lv_stcd type stcd4.
    data ls_partner type /mlsFT/ed_vkn.
    data lv_register_date type datum.
    " old system casting


    select single * from /mlsFT/ed_vkn  where tax_id_or_personal_id = @iv_vkn into @ls_partner .
    if sy-subrc is not initial.
      rv_virtual = 'X'.
    else.
      if ls_partner-register_time_d gt iv_issuedate.
        rv_virtual = 'X'.
      endif.
    endif.

  ENDMETHOD.


  METHOD get_country_name.
**    read table /mlsFT/ed_select=>mt_countries into rs_t005t
**             with key land1 =  iv_land.

    if sy-subrc is not initial.
**      select single * from t005t  where land1 = @iv_land and
**                                                     SPRAS = 'TR' into @rs_t005t.
      if sy-subrc is not initial.
**        append rs_t005t to /mlsFT/ed_select=>mt_countries.
      endif.
    endif.
  ENDMETHOD.


  METHOD check_shipment.
    data: ls_driver type /mlsft/ed_s_driver.
    data: ls_tax type /mlsft/ed_s_partyidentif.

    if is_shpmentstage-drivers is not initial.
**      read table is_shpmentstage-drivers into ls_driver index 1.
      if ls_driver-fname is not initial and ls_driver-lname is not initial and ls_driver-nid is not initial and
        is_shpmentstage-tmeancode-lplateid-taxtypecode = 'PLAKA' and is_shpmentstage-tmeancode-lplateid-name is not initial.
**        rv_result = /mlsft/ed_constants=>shipment_complete.
      endif.
    endif.

    if is_carrierparty is not initial.
**      read table is_carrierparty-partyidentif into ls_tax index 1.
      if ls_tax-id is not initial and ls_tax-schemeid is not initial and is_carrierparty-partyname is not initial.
**        rv_result = /mlsft/ed_constants=>shipment_complete.
      endif.
    endif.

    if rv_result is initial.
**      rv_result = /mlsft/ed_constants=>shipment_incomplete.
    endif.
  ENDMETHOD.


  METHOD get_erpcoc_details.
**    case iv_doctyp.
**
**      when /mlsag/ed_constants=>erpdoctype_goods_mov.
**
**        material_document(
**        exporting
**          iv_gjahr  = iv_gjahr
**          iv_docnum = iv_docnum
**        importing
**          et_items = et_items
**          es_head  = es_head ).

**    endcase.

  ENDMETHOD.


  METHOD append_buffer_erpcocs.
**    data: lt_mseg type mb_mseg,
**          lt_mkpf type mb_mkpf.
**
**    case iv_doctype.
**      when /mlsag/ed_constants=>erpdoctype_goods_mov.
**        lt_mseg = it_items.
**        lt_mkpf = it_header.
**        append lines of lt_mseg to mt_mseg.
**        append lines of lt_mkpf to mt_mkpf.
**
**
**    endcase.
  ENDMETHOD.


  METHOD get_post_fi_tcode.
**    field-symbols <lstcode> like line of mt_tcodes.
**    if mt_tcodes is initial.
**      select * from /mlsag/ed_tcodei into table mt_tcodes.
**    endif.
**    read table mt_tcodes assigning <lstcode> with key bukrs = iv_bukrs
**                                                      uname = sy-uname.
**    if sy-subrc is  initial.
**      read table mt_tcodes assigning <lstcode> with key bukrs = iv_bukrs.
**    endif.
**
**
**    if <lstcode> is assigned and  <lstcode>-fb60 = abap_true.
**      rv_tcode = 'FB60'.
**    else.
**      rv_tcode = 'FV60'.
**    endif.

  ENDMETHOD.


  METHOD get_mapp_class.

**    CLEAR rs_mapp.
**
**    IF iv_vbtyp IS NOT INITIAL.
**      SELECT SINGLE * FROM /mlsag/ed_mapp
**        INTO CORRESPONDING FIELDS OF rs_mapp
**        WHERE doctype EQ iv_doctype
**          AND vbtyp EQ iv_vbtyp
**          AND clstype EQ iv_clstype.
**
**    ELSE.
**      SELECT SINGLE * FROM /mlsag/ed_mapp
**        INTO CORRESPONDING FIELDS OF rs_mapp
**        WHERE doctype EQ iv_doctype
**          AND clstype EQ iv_clstype.
**    ENDIF.

  ENDMETHOD.


  METHOD get_service_action.
    CLEAR: rs_method.
    SELECT SINGLE * FROM /mlsFT/ed_action
      WHERE land1 EQ @iv_land1
        AND doctype EQ @iv_doctype
        AND action EQ @iv_action       INTO @rs_method.
  ENDMETHOD.


  METHOD check_cust_param_delivery.
**      CLEAR: rt_param.
**
**    IF iv_doctype IS INITIAL.
**      SELECT * FROM /mlsag/param_del
**        INTO CORRESPONDING FIELDS OF TABLE rt_param
**        WHERE country = iv_country
***              AND doctype = iv_doctype
**          AND type = iv_type
***              AND value = iv_value
**          AND active = abap_true.
**    ELSE.
**
**      SELECT * FROM /mlsag/param_del
**        INTO CORRESPONDING FIELDS OF TABLE rt_param
**        WHERE country = iv_country
**          AND doctype = iv_doctype
**          AND type = iv_type
***        AND value = iv_value
**          AND active = abap_true.
**    ENDIF.
  ENDMETHOD.


  METHOD check_cust_param.
**    CLEAR: rt_param.
**
**    IF iv_doctype IS INITIAL.
**      SELECT * FROM /mlsag/sei_param
**        INTO CORRESPONDING FIELDS OF TABLE rt_param
**        WHERE country = iv_country
***              AND doctype = iv_doctype
**          AND type = iv_type
***              AND value = iv_value
**          AND active = abap_true.
**    ELSE.
**
**      SELECT * FROM /mlsag/sei_param
**        INTO CORRESPONDING FIELDS OF TABLE rt_param
**        WHERE country = iv_country
**          AND doctype = iv_doctype
**          AND type = iv_type
***        AND value = iv_value
**          AND active = abap_true.
**    ENDIF.

  ENDMETHOD.


  METHOD get_oldint.
**clear rs_oldint.
**    SELECT SINGLE * FROM /MLSAG/ED_OLDINT into rs_oldint.
  ENDMETHOD.


  METHOD get_bukrs_from_vbeln.
**    CASE iv_vbtyp .
**
**      WHEN /mlsag/ed_constants=>out_delivery.
**
**        rv_bukrs =  /mlsag/ed_select=>get_bukrs_from_werks(  iv_werks ).
**
**      WHEN /mlsag/ed_constants=>in_delivery.
**        SELECT SINGLE ekko~bukrs INTO rv_bukrs
**        FROM likp
**        INNER JOIN lips ON likp~vbeln = lips~vbeln
**        INNER JOIN ekpo ON lips~vgbel = ekpo~ebeln
**        INNER JOIN ekko ON ekpo~ebeln = ekko~ebeln
**        WHERE likp~vbeln = iv_vbeln.
**
**      WHEN /mlsag/ed_constants=>purchase_order.
**        rv_bukrs =  /mlsag/ed_select=>get_bukrs_from_werks(  iv_werks ).
**
**    ENDCASE.

  ENDMETHOD.


  METHOD get_response_for_vat_mail.

**    REFRESH rt_response.
**    IF iv_stceg IS NOT INITIAL.
**
**      SELECT * FROM /mlsag/ed_respon
**        INTO CORRESPONDING FIELDS OF TABLE rt_response
**        WHERE stceg EQ iv_stceg.
**
**    ENDIF.

  ENDMETHOD.


  METHOD get_distribution_list.
    " TODO: Implement logic to build and return distribution list
  ENDMETHOD.


  METHOD get_other_tags.
**  SELECT * FROM /MLSFT/GED_TAGS INTO TABLE @EX_TAGS.
  ENDMETHOD.


  METHOD get_invlog.
**    CLEAR: rs_invlog.
**    CHECK iv_docnum IS NOT INITIAL.
**    SELECT SINGLE * FROM /mlsag/ed_invlog
**      INTO CORRESPONDING FIELDS OF rs_invlog
**      WHERE docnum EQ iv_docnum.

  ENDMETHOD.


  METHOD get_greece_info.
**    SELECT SINGLE * FROM /mlsFT/ed_grc
**      INTO es_greece
**      WHERE docnum EQ iv_docnum
  ENDMETHOD.


  METHOD material_document.

**    field-symbols <ls_mseg> type mseg.
**    read table mt_mkpf into es_head with key mblnr = iv_docnum
**                                 mjahr = iv_gjahr.
**    if sy-subrc is not initial.
**      select single * from mkpf into es_head
**                                        where mblnr = iv_docnum
**                                          and mjahr = iv_gjahr.
**
**      append es_head to mt_mkpf.
**
**    endif.
**
**    data lt_items type table of mseg.
**    loop at mt_mseg assigning <ls_mseg> where mblnr = iv_docnum
**                                            and mjahr = iv_gjahr.
**
**      append <ls_mseg> to lt_items.
**    endloop.
**
**    if lt_items is initial.
**      select * from mseg into table lt_items
**                where mblnr = iv_docnum
**                  and mjahr = iv_gjahr.
**
**      append lines of lt_items to mt_mseg.
**    endif.
**    et_items = lt_items.
  ENDMETHOD.
ENDCLASS.
