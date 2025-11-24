"======================================================================
" CLASS : /MLSFT/ED_CONSTANTS
" DESC  : Global Constants for MLSFT E-Document Layer (migrated from /MLSAG/)
"======================================================================

CLASS /MLSFT/ed_constants DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    CONSTANTS doc_created TYPE /mlsft/ed_status VALUE '01'. "#EC NOTEXT
    CONSTANTS doc_sended_to_cld TYPE /mlsft/ed_status VALUE '02'. "#EC NOTEXT
    CONSTANTS doc_waiting_process TYPE /mlsft/ed_status VALUE '03'. "#EC NOTEXT
    CONSTANTS doc_process_ended TYPE /mlsft/ed_status VALUE '04'. "#EC NOTEXT
    CONSTANTS doc_ended_with_error TYPE /mlsft/ed_status VALUE '05'. "#EC NOTEXT
    CONSTANTS doc_cancelled TYPE /mlsft/ed_status VALUE '09'. "#EC NOTEXT
    CONSTANTS doc_resended TYPE /mlsft/ed_status VALUE '06'. "#EC NOTEXT
    CONSTANTS doc_input_save_system TYPE /mlsft/ed_status VALUE '52'. "#EC NOTEXT
    CONSTANTS doc_input_replied TYPE /mlsft/ed_status VALUE '51'. "#EC NOTEXT
    CONSTANTS doc_input_created TYPE /mlsft/ed_status VALUE '50'. "#EC NOTEXT
    CONSTANTS doc_receipt_created TYPE /mlsft/ed_status VALUE '20'. "#EC NOTEXT
    CONSTANTS doc_receipt_sended TYPE /mlsft/ed_status VALUE '21'. "#EC NOTEXT
    CONSTANTS doc_transport_confirmed TYPE /mlsft/ed_status VALUE '26'. "#EC NOTEXT
    CONSTANTS doc_receipt_deleted TYPE /mlsft/ed_status VALUE '22'. "#EC NOTEXT
    CONSTANTS doc_out_replied TYPE /mlsft/ed_status VALUE '12'. "#EC NOTEXT
    CONSTANTS doc_send_to_vim TYPE /mlsft/ed_status VALUE '33'. "#EC NOTEXT
    CONSTANTS doc_send_to_dms TYPE /mlsft/ed_status VALUE '34'. "#EC NOTEXT
    CONSTANTS doc_send_to_readsoft TYPE /mlsft/ed_status VALUE '35'. "#EC NOTEXT
    CONSTANTS doc_send_to_kefron TYPE /mlsft/ed_status VALUE '36'. "#EC NOTEXT
    CONSTANTS doc_storno_cancel TYPE /mlsft/ed_status VALUE '37'. "#EC NOTEXT
    CONSTANTS doc_not_to_be_sent TYPE /mlsft/ed_status VALUE '38'. "#EC NOTEXT
    CONSTANTS doc_mark_as_handled TYPE /mlsft/ed_status VALUE '42'. "#EC NOTEXT
    CONSTANTS doc_unmark_as_handled TYPE /mlsft/ed_status VALUE '43'. "#EC NOTEXT
    CONSTANTS doc_concur_intercompany TYPE /mlsft/ed_status VALUE '61'. "#EC NOTEXT
    CONSTANTS doc_concur_payment_type TYPE /mlsft/ed_status VALUE '62'. "#EC NOTEXT
    CONSTANTS doc_vat_inconsistency TYPE /mlsft/ed_status VALUE '63'. "#EC NOTEXT
    CONSTANTS doc_master_data_error TYPE /mlsft/ed_status VALUE '64'. "#EC NOTEXT
    CONSTANTS abap_true TYPE /mlsft/ed_char1 VALUE 'X'.     "#EC NOTEXT
    CONSTANTS abap_false TYPE /mlsft/ed_char1 VALUE ''.     "#EC NOTEXT
    CONSTANTS basis_compname TYPE string VALUE 'SAP_BASIS'. "#EC NOTEXT
    CONSTANTS output TYPE /mlsft/ed_char1 VALUE 'O'.        "#EC NOTEXT
    CONSTANTS input TYPE /mlsft/ed_char1 VALUE 'I'.         "#EC NOTEXT
    CONSTANTS number_range TYPE /mlsft/ed_char2 VALUE '01'. "#EC NOTEXT
    CONSTANTS number_object TYPE /mlsft/ed_char10 VALUE '/MLSFT/ED1'. "#EC NOTEXT
    CONSTANTS number_obj_key TYPE /mlsft/ed_char10 VALUE '/MLSFT/EDK'. "#EC NOTEXT
    CONSTANTS number_rng_key TYPE /mlsft/ed_char2 VALUE '01'. "#EC NOTEXT
    CONSTANTS number_object_man TYPE /mlsft/ed_char10 VALUE '/MLSFT/EDG'. "#EC NOTEXT
    CONSTANTS vendor TYPE /mlsft/ed_char1 VALUE 'V'.        "#EC NOTEXT
    CONSTANTS customer TYPE /mlsft/ed_char1 VALUE 'C'.      "#EC NOTEXT
    CONSTANTS payeeparty TYPE /mlsft/ed_char2 VALUE 'PE'.   "#EC NOTEXT
    CONSTANTS deliverycustomerparty TYPE /mlsft/ed_char1 VALUE 'C'. "#EC NOTEXT
    CONSTANTS despatchsupplierparty TYPE /mlsft/ed_char1 VALUE 'D'. "#EC NOTEXT
    CONSTANTS buyercustomerparty TYPE /mlsft/ed_char1 VALUE 'B'. "#EC NOTEXT
    CONSTANTS sellersupplierparty TYPE /mlsft/ed_char1 VALUE 'S'. "#EC NOTEXT
    CONSTANTS orinatorcustomerparty TYPE /mlsft/ed_char1 VALUE 'O'. "#EC NOTEXT
    CONSTANTS despatchdocument TYPE /mlsft/ed_char1 VALUE 'R'. "#EC NOTEXT
    CONSTANTS doc_type_doc_in TYPE /mlsft/ed_direct VALUE 'ID'. "#EC NOTEXT
    CONSTANTS doc_type_doc_out TYPE /mlsft/ed_direct VALUE 'OD'. "#EC NOTEXT
    CONSTANTS doc_type_resp_in TYPE /mlsft/ed_direct VALUE 'IR'. "#EC NOTEXT
    CONSTANTS doc_type_resp_out TYPE /mlsft/ed_direct VALUE 'OR'. "#EC NOTEXT
    CONSTANTS out_movement_waybill TYPE /mlsft/ed_char1 VALUE 'R'. "#EC NOTEXT
    CONSTANTS out_manuel_waybill TYPE /mlsft/ed_char1 VALUE '2'. "#EC NOTEXT
    CONSTANTS purchase_order TYPE /mlsft/ed_char1 VALUE 'V' ."likp-vbtyp .     "#EC NOTEXT
    CONSTANTS out_delivery TYPE /mlsft/ed_char1 VALUE 'J'.  "#EC NOTEXT
    CONSTANTS in_delivery TYPE /mlsft/ed_char1 VALUE '7'.   "#EC NOTEXT
    CONSTANTS out_invoice TYPE /mlsft/ed_char1 VALUE 'M'.   "#EC NOTEXT
    CONSTANTS erpdoctype_goods_mov TYPE vbtyp VALUE 'R'.    "#EC NOTEXT
    CONSTANTS sign TYPE tvarv_opti VALUE 'I'.               "#EC NOTEXT
    CONSTANTS sign_exclude TYPE tvarv_opti VALUE 'E'.       "#EC NOTEXT
    CONSTANTS option_ne TYPE tvarv_opti VALUE 'NE'.         "#EC NOTEXT
    CONSTANTS option TYPE tvarv_opti VALUE 'EQ'.            "#EC NOTEXT
    CONSTANTS receipt_adv_type_sevk TYPE /mlsft/ed_char10 VALUE 'SEVK'. "#EC NOTEXT
    CONSTANTS ref_manuel_receipt TYPE /mlsft/ed_reftype VALUE '4'. "#EC NOTEXT
    CONSTANTS:
      BEGIN OF inc_despatch_status,
        doc_created   TYPE /MLSFT/ed_status VALUE '50',
        doc_replied   TYPE /MLSFT/ed_status VALUE '51',
        doc_processed TYPE /MLSFT/ed_status VALUE '52',
      END OF inc_despatch_status .
    CONSTANTS:
      BEGIN OF out_despatch_status ,
        doc_created          TYPE /MLSFT/ed_status VALUE '01', "#EC NOTEXT
        doc_sended_to_cld    TYPE /MLSFT/ed_status VALUE '02', "#EC NOTEXT
        doc_waiting_process  TYPE /MLSFT/ed_status VALUE '03', "#EC NOTEXT
        doc_process_ended    TYPE /MLSFT/ed_status VALUE '04', "#EC NOTEXT
        doc_ended_with_error TYPE /MLSFT/ed_status VALUE '05', "#EC NOTEXT
        doc_cancelled        TYPE /MLSFT/ed_status VALUE '09', "#EC NOTEXT
        doc_resended         TYPE /MLSFT/ed_status VALUE '06', "#EC NOTEXT
      END OF out_despatch_status .
    CONSTANTS objtyp_tcode TYPE /mlsft/ed_char2 VALUE 'I'.  "#EC NOTEXT
    CONSTANTS objtyp_table TYPE /mlsft/ed_char2 VALUE 'T'.  "#EC NOTEXT
    CONSTANTS mlsft_process TYPE /mlsft/ed_process VALUE 'ED'. "#EC NOTEXT
    CONSTANTS mail_doc_type_pdf TYPE /mlsft/ed_char4 VALUE 'PDF'. "#EC NOTEXT
    CONSTANTS mail_doc_type_ubl TYPE /mlsft/ed_char4 VALUE 'UBL'. "#EC NOTEXT
    CONSTANTS mail_doc_type_html TYPE /mlsft/ed_char4 VALUE 'HTML'. "#EC NOTEXT
    CONSTANTS mail_doc_type_full TYPE /mlsft/ed_char4 VALUE 'FULL'. "#EC NOTEXT
    CONSTANTS mail_doc_type_xml TYPE /mlsft/ed_char4 VALUE 'XML'. "#EC NOTEXT
    CONSTANTS auth_object_ed TYPE /mlsft/ed_char10 VALUE '/MLSFT/ED'. "#EC NOTEXT
    CONSTANTS auth_object_kz_inv TYPE /mlsft/ed_char10 VALUE '/MLSFT/KI'. "#EC NOTEXT
    CONSTANTS auth_object_kz_deliv TYPE /mlsft/ed_char10 VALUE '/MLSFT/KD'. "#EC NOTEXT
    CONSTANTS auth_object_kz_vw TYPE /mlsft/ed_char10 VALUE '/MLSFT/KV'. "#EC NOTEXT
    CONSTANTS auth_object_eur TYPE /mlsft/ed_char10 VALUE '/MLSFT/EUR'. "#EC NOTEXT
    CONSTANTS auth_object_glb_e_trans TYPE /mlsft/ed_char10 VALUE '/MLSFT/GLB'. "#EC NOTEXT
    CONSTANTS message_id TYPE sy-msgid VALUE '/MLSFT/ED'.   "#EC NOTEXT
    CONSTANTS auth_check_actvt_01 TYPE /mlsft/ed_char2 VALUE '01'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_03 TYPE /mlsft/ed_char2 VALUE '03'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_04 TYPE /mlsft/ed_char2 VALUE '04'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_05 TYPE /mlsft/ed_char2 VALUE '05'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_06 TYPE /mlsft/ed_char2 VALUE '06'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_07 TYPE /mlsft/ed_char2 VALUE '07'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_08 TYPE /mlsft/ed_char2 VALUE '08'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_09 TYPE /mlsft/ed_char2 VALUE '09'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_10 TYPE /mlsft/ed_char2 VALUE '10'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_11 TYPE /mlsft/ed_char2 VALUE '11'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_12 TYPE /mlsft/ed_char2 VALUE '12'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_13 TYPE /mlsft/ed_char2 VALUE '13'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_14 TYPE /mlsft/ed_char2 VALUE '14'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_15 TYPE /mlsft/ed_char2 VALUE '15'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_16 TYPE /mlsft/ed_char2 VALUE '16'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_19 TYPE /mlsft/ed_char2 VALUE '19'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_18 TYPE /mlsft/ed_char2 VALUE '18'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_26 TYPE /mlsft/ed_char2 VALUE '26'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_17 TYPE /mlsft/ed_char2 VALUE '17'. "#EC NOTEXT
    CONSTANTS copy_indicator_false TYPE /mlsft/ed_char10 VALUE 'false'. "#EC NOTEXT
    CONSTANTS copy_indicator_true TYPE /mlsft/ed_char10 VALUE 'true'. "#EC NOTEXT
    CONSTANTS document_version_0_9 TYPE /mlsft/ed_char10 VALUE '0.9'. "#EC NOTEXT
    CONSTANTS document_version_1_0 TYPE /mlsft/ed_char10 VALUE '1.0'. "#EC NOTEXT
    CONSTANTS auth_check_actvt_error TYPE /mlsft/ed_char12 VALUE 'Yetki Hatası'. "#EC NOTEXT
    CONSTANTS ubl_tag_id TYPE /mlsft/ed_char100 VALUE 'ID'. "#EC NOTEXT
    CONSTANTS ubl_tag_item TYPE /mlsft/ed_char100 VALUE 'Item'. "#EC NOTEXT
    CONSTANTS ubl_tag_name TYPE /mlsft/ed_char100 VALUE 'Name'. "#EC NOTEXT
    CONSTANTS ubl_tag_delquantity TYPE /mlsft/ed_char100 VALUE 'DeliveredQuantity'. "#EC NOTEXT
    CONSTANTS ubl_tag_sellerid TYPE /mlsft/ed_char100 VALUE 'SellersItemIdentification'. "#EC NOTEXT
    CONSTANTS ubl_tag_despatchline TYPE /mlsft/ed_char100 VALUE 'DespatchLine'. "#EC NOTEXT
    CONSTANTS program_output_kz TYPE /mlsft/ed_char40 VALUE '/MLSFT/ED_KZ_OUTPUT'. "#EC NOTEXT
    CONSTANTS program_output TYPE /mlsft/ed_char40 VALUE '/MLSFT/ED_OUTPUT'. "#EC NOTEXT
    CONSTANTS program_input TYPE /mlsft/ed_char40 VALUE '/MLSFT/ED_INPUT'. "#EC NOTEXT
    CONSTANTS folder_name_irsaliye TYPE string VALUE 'E-IRSALIYE'. "#EC NOTEXT
    CONSTANTS message_error TYPE symsgty VALUE 'E'.         "#EC NOTEXT
    CONSTANTS message_success TYPE symsgty VALUE 'S'.       "#EC NOTEXT
    CONSTANTS message_warning TYPE symsgty VALUE 'W'.       "#EC NOTEXT
    CONSTANTS message_information TYPE symsgty VALUE 'I'.   "#EC NOTEXT
    CONSTANTS schemeid_vkn TYPE /mlsft/ed_char10 VALUE 'VKN'. "#EC NOTEXT
    CONSTANTS act_delay TYPE /mlsft/ed_dparam VALUE 'ACT_DELAY'. "#EC NOTEXT
    CONSTANTS act_type TYPE /mlsft/ed_dparam VALUE 'ACT_TYPE'. "#EC NOTEXT
    CONSTANTS act_romania_paginate_endpoint TYPE /mlsft/ed_dparam VALUE 'ROMANIA_PAGINATE_ENDPOINT'. "#EC NOTEXT
    CONSTANTS act_irbm_pagesize TYPE /mlsft/ed_dparam VALUE 'IRBM_PAGESIZE'. "#EC NOTEXT
    CONSTANTS act_romania_send_to_vim TYPE /mlsft/ed_dparam VALUE 'ROMANIA_SEND_TO_VIM'. "#EC NOTEXT
    CONSTANTS shipment_complete TYPE icon_d VALUE '@01@'.   "#EC NOTEXT
    CONSTANTS shipment_incomplete TYPE icon_d VALUE '@02@'. "#EC NOTEXT
    CONSTANTS gib_out TYPE /mlsft/ed_dparam VALUE 'GIB_OUT'. "#EC NOTEXT
    CONSTANTS rotr_out TYPE /mlsft/ed_dparam VALUE 'ROTR_OUT'. "#EC NOTEXT
    CONSTANTS kz_stat_out1 TYPE /mlsft/ed_dparam VALUE 'KZ_SNT_CH1'. "#EC NOTEXT
    CONSTANTS kz_stat_out2 TYPE /mlsft/ed_dparam VALUE 'KZ_SNT_CH2'. "#EC NOTEXT
    CONSTANTS semicolon TYPE /mlsft/ed_char1 VALUE ';'.     "#EC NOTEXT
    CONSTANTS doc_type_kz_invoice TYPE /mlsft/ed_direct VALUE 'KI'. "#EC NOTEXT
    CONSTANTS doc_type_kz_waybill TYPE /mlsft/ed_direct VALUE 'KW'. "#EC NOTEXT
    CONSTANTS doc_type_kz_in_invoice TYPE /mlsft/ed_direct VALUE 'KM'. "#EC NOTEXT
    CONSTANTS doc_type_kz_in_waybill TYPE /mlsft/ed_direct VALUE 'KS'. "#EC NOTEXT
    CONSTANTS doc_type_kz_vw_balance_corr TYPE /mlsft/ed_direct VALUE 'BK'. "#EC NOTEXT
    CONSTANTS doc_type_kz_vw_balance TYPE /mlsft/ed_direct VALUE 'KB'. "#EC NOTEXT
    CONSTANTS doc_type_kz_vw_wrt_off TYPE /mlsft/ed_direct VALUE 'WO'. "#EC NOTEXT
    CONSTANTS doc_type_kz_vw_manu TYPE /mlsft/ed_direct VALUE 'MA'. "#EC NOTEXT
    CONSTANTS doc_type_kz_vw_mov TYPE /mlsft/ed_direct VALUE 'KU'. "#EC NOTEXT
    CONSTANTS doc_type_kz_waybill_328 TYPE /mlsft/ed_direct VALUE 'K3'. "#EC NOTEXT
    CONSTANTS doc_type_kz_vw_det TYPE /mlsft/ed_direct VALUE 'KD'. "#EC NOTEXT
    CONSTANTS doc_type_out_rstransport TYPE /mlsft/ed_direct VALUE 'S3'. "#EC NOTEXT
    CONSTANTS doc_type_out_rotransport TYPE /mlsft/ed_direct VALUE 'R3'. "#EC NOTEXT
    CONSTANTS doc_type_in_rstransport TYPE /mlsft/ed_direct VALUE 'S4'. "#EC NOTEXT
    CONSTANTS doc_type_in_rotransport TYPE /mlsft/ed_direct VALUE 'R4'. "#EC NOTEXT
    CONSTANTS xml_cls_kz_invoice TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZEI_CREATE_XML_INV'. "#EC NOTEXT
    CONSTANTS xml_cls_kz_delivery TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZED_CREATE_XML_DEL'. "#EC NOTEXT
    CONSTANTS xml_cls_ro_transport TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_ROTR_CREATE_XML_DEL'. "#EC NOTEXT
    CONSTANTS xml_cls_kz_delivery_328 TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZVW_CREATE_XML_328'. "#EC NOTEXT
    CONSTANTS xml_cls_kz_vw_balance TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZVW_CR_XML_BAL_CPY'. "#EC NOTEXT
    CONSTANTS xml_cls_kz_vw_balance_corr TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZVW_CR_XML_BAL_CORR'. "#EC NOTEXT
    CONSTANTS xml_cls_kz_vw_mov TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZVW_CR_XML_MOV_CPY'. "#EC NOTEXT
    CONSTANTS xml_cls_kz_vw_det TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZVW_CREATE_XML_DET'. "#EC NOTEXT
    CONSTANTS xml_cls_kz_vw_wrt_off TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZVW_CR_XML_WRT_CPY'. "#EC NOTEXT
    CONSTANTS xml_cls_kz_vw_manu TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZVW_CR_XML_MANU_CPY'. "#EC NOTEXT
    CONSTANTS mapping_cls_kz_invoice TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZEI_INV_MAPPING'. "#EC NOTEXT
    CONSTANTS mapping_cls_kz_delivery TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZED_DEL_MAPPING'. "#EC NOTEXT
    CONSTANTS mapping_cls_kz_sf_328 TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZED_DEL_MAPPING'. "#EC NOTEXT
    CONSTANTS mapping_cls_kz_vwbalance TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZVW_BLNC_MAPP'. "#EC NOTEXT
    CONSTANTS mapping_cls_kz_vwdet TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZVW_DET_MAPP'. "#EC NOTEXT
    CONSTANTS mapping_cls_kz_vwmov TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZVW_MOV_MAPP'. "#EC NOTEXT
    CONSTANTS mapping_cls_kz_vwwrt_off TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZVW_WRITEOFF_MAPP'. "#EC NOTEXT
    CONSTANTS kz_ei_doc_controller TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZEI_DOC_CTRL'. "#EC NOTEXT
    CONSTANTS kz_vw_doc_controller2 TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZ_VW_DOC_CTRL'. "#EC NOTEXT
    CONSTANTS kz_ed_doc_controller TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZED_DOC_CTRL'. "#EC NOTEXT
    CONSTANTS kz_vw_doc_controller TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZVW_DOC_CTRL'. "#EC NOTEXT
    CONSTANTS ro_transport_doc_controller TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_ROTR_DOC_CTRL'. "#EC NOTEXT
    CONSTANTS mapping_cls_rs_delivery TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_RS_DELIVERY_MAP_UBL'. "#EC NOTEXT
    CONSTANTS mapping_cls_tr_delivery TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_DELIVERY_LE_MAP_UBL'. "#EC NOTEXT
    CONSTANTS mapping_cls_ro_delivery TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_ROTR_DELV_MAPPING'. "#EC NOTEXT
    CONSTANTS kz_stat_esf_out1 TYPE /mlsft/ed_dparam VALUE 'KZ_ESF_CH1'. "#EC NOTEXT
    CONSTANTS kz_stat_esf_out2 TYPE /mlsft/ed_dparam VALUE 'KZ_ESF_CH2'. "#EC NOTEXT
    CONSTANTS kz_direction TYPE string VALUE 'INBOUND'.     "#EC NOTEXT
    CONSTANTS addon_turkey_einvoice TYPE /mlsft/ed_addont VALUE 'TE'. "#EC NOTEXT
    CONSTANTS addon_turkey_edelivery TYPE /mlsft/ed_addont VALUE 'TW'. "#EC NOTEXT
    CONSTANTS addon_kz_einvoice TYPE /mlsft/ed_addont VALUE 'KE'. "#EC NOTEXT
    CONSTANTS addon_kz_edelivery TYPE /mlsft/ed_addont VALUE 'KW'. "#EC NOTEXT
    CONSTANTS addon_kz_vstore TYPE /mlsft/ed_addont VALUE 'KV'. "#EC NOTEXT
    CONSTANTS addon_germany_xrechnung TYPE /mlsft/ed_addont VALUE 'GX'. "#EC NOTEXT
    CONSTANTS addon_norway_peppol TYPE /mlsft/ed_addont VALUE 'NO'. "#EC NOTEXT
    CONSTANTS addon_italy_einvoice TYPE /mlsft/ed_addont VALUE 'IE'. "#EC NOTEXT
    CONSTANTS mapping_cls_kz_vw_manufacture TYPE /mlsft/ed_char30 VALUE '/MLSFT/ED_KZVW_MANU_MAPP'. "#EC NOTEXT
    CONSTANTS vbrk  TYPE awtyp VALUE 'VBRK'.                  "#EC NOTEXT
    CONSTANTS bkpf  TYPE awtyp VALUE 'BKPF'.                  "#EC NOTEXT
    CONSTANTS rbkp  TYPE awtyp VALUE 'RBKP'.                  "#EC NOTEXT
    CONSTANTS pln   TYPE waers VALUE 'PLN'.                   "#EC NOTEXT
    CONSTANTS try   TYPE waers VALUE 'TRY'.                   "#EC NOTEXT
    CONSTANTS ron   TYPE waers VALUE 'RON'.                   "#EC NOTEXT
    CONSTANTS rsd   TYPE waers VALUE 'RSD'.                   "#EC NOTEXT
    CONSTANTS azm   TYPE waers VALUE 'AZM'.                   "#EC NOTEXT
    CONSTANTS eur   TYPE waers VALUE 'EUR'.                   "#EC NOTEXT
    CONSTANTS myr   TYPE waers VALUE 'MYR'.                   "#EC NOTEXT

    CONSTANTS type_v TYPE /mlsft/ed_char1 VALUE 'V'.        "#EC NOTEXT
    CONSTANTS type_r TYPE /mlsft/ed_char1 VALUE 'R'.        "#EC NOTEXT
    CONSTANTS type_f TYPE /mlsft/ed_char1 VALUE 'F'.        "#EC NOTEXT
    CONSTANTS type_m TYPE /mlsft/ed_char1 VALUE 'M'.        "#EC NOTEXT
    CONSTANTS type_x TYPE /mlsft/ed_char1 VALUE 'X'.        "#EC NOTEXT

    CONSTANTS schemeid_9948         TYPE /mlsft/ed_char20 VALUE '9948'. "#EC NOTEXT
    CONSTANTS mv_doctype_so         TYPE /mlsft/ed_direct VALUE 'SO'. "#EC NOTEXT
    CONSTANTS mv_doctype_si         TYPE /mlsft/ed_direct VALUE 'SI'. "#EC NOTEXT
    CONSTANTS mv_doctype_r1         TYPE /mlsft/ed_direct VALUE 'R1'. "#EC NOTEXT
    CONSTANTS mv_doctype_r2         TYPE /mlsft/ed_direct VALUE 'R2'. "#EC NOTEXT
    CONSTANTS mv_doctype_rotr_out   TYPE /mlsft/ed_direct VALUE 'R3'. "#EC NOTEXT
    CONSTANTS mv_doctype_rotr_in    TYPE /mlsft/ed_direct VALUE 'R4'. "#EC NOTEXT
    CONSTANTS mv_doctype_f1         TYPE /mlsft/ed_direct VALUE 'F1'. "#EC NOTEXT
    CONSTANTS mv_doctype_f2         TYPE /mlsft/ed_direct VALUE 'F2'. "#EC NOTEXT
    CONSTANTS mv_doctype_fs         TYPE /mlsft/ed_direct VALUE 'FS'. "#EC NOTEXT
    CONSTANTS mv_doctype_fi         TYPE /mlsft/ed_direct VALUE 'FI'. "#EC NOTEXT
    CONSTANTS mv_doctype_fo         TYPE /mlsft/ed_direct VALUE 'FO'. "#EC NOTEXT
    CONSTANTS mv_doctype_fz         TYPE /mlsft/ed_direct VALUE 'FZ'. "#EC NOTEXT
    CONSTANTS mv_doctype_fy         TYPE /mlsft/ed_direct VALUE 'FY'. "#EC NOTEXT
    CONSTANTS mv_doctype_a3         TYPE /mlsft/ed_direct VALUE 'A3'. "#EC NOTEXT
    CONSTANTS mv_doctype_a4         TYPE /mlsft/ed_direct VALUE 'A4'. "#EC NOTEXT
    CONSTANTS mv_doctype_e1         TYPE /mlsft/ed_direct VALUE 'E1'. "#EC NOTEXT
    CONSTANTS mv_doctype_e2         TYPE /mlsft/ed_direct VALUE 'E2'. "#EC NOTEXT

    CONSTANTS sales_draft        TYPE /mlsft/ed_europe_stat VALUE 'Draft'.      "#EC NOTEXT
    CONSTANTS sales_sent         TYPE /mlsft/ed_europe_stat VALUE 'Sent'.       "#EC NOTEXT
    CONSTANTS sales_cancelled    TYPE /mlsft/ed_europe_stat VALUE 'Cancelled'.  "#EC NOTEXT
    CONSTANTS sales_storno       TYPE /mlsft/ed_europe_stat VALUE 'Storno'.     "#EC NOTEXT
    CONSTANTS sales_approved     TYPE /mlsft/ed_europe_stat VALUE 'Approved'.   "#EC NOTEXT
    CONSTANTS sales_rejected     TYPE /mlsft/ed_europe_stat VALUE 'Rejected'.   "#EC NOTEXT
    CONSTANTS sales_sending      TYPE /mlsft/ed_europe_stat VALUE 'Sending'.    "#EC NOTEXT
    CONSTANTS sales_deleted      TYPE /mlsft/ed_europe_stat VALUE 'Deleted'.    "#EC NOTEXT
    CONSTANTS purchase_new       TYPE /mlsft/ed_europe_stat VALUE 'New'.        "#EC NOTEXT
    CONSTANTS purchase_seen      TYPE /mlsft/ed_europe_stat VALUE 'Seen'.       "#EC NOTEXT
    CONSTANTS purchase_reminded  TYPE /mlsft/ed_europe_stat VALUE 'Reminded'.   "#EC NOTEXT
    CONSTANTS purchase_cancelled TYPE /mlsft/ed_europe_stat VALUE 'Cancelled'.  "#EC NOTEXT
    CONSTANTS purchase_approved  TYPE /mlsft/ed_europe_stat VALUE 'Approved'.   "#EC NOTEXT
    CONSTANTS purchase_rejected  TYPE /mlsft/ed_europe_stat VALUE 'Rejected'.   "#EC NOTEXT
    CONSTANTS purchase_deleted   TYPE /mlsft/ed_europe_stat VALUE 'Deleted'.    "#EC NOTEXT
    CONSTANTS mapping_class TYPE /mlsft/ed_clstype VALUE 'MAPPING'. "#EC NOTEXT
    CONSTANTS mv_doctype_a1 TYPE /mlsft/ed_direct VALUE 'A1'. "#EC NOTEXT
    CONSTANTS mv_doctype_a2 TYPE /mlsft/ed_direct VALUE 'A2'. "#EC NOTEXT
    CONSTANTS mv_doctype_p1 TYPE /mlsft/ed_direct VALUE 'P1'. "#EC NOTEXT
    CONSTANTS mv_doctype_p2 TYPE /mlsft/ed_direct VALUE 'P2'. "#EC NOTEXT
    CONSTANTS mv_doctype_io TYPE /mlsft/ed_direct VALUE 'IO'. "#EC NOTEXT
    CONSTANTS mv_doctype_ii TYPE /mlsft/ed_direct VALUE 'II'. "#EC NOTEXT
    CONSTANTS mv_doctype_g1 TYPE /mlsft/ed_direct VALUE 'G1'. "#EC NOTEXT
    CONSTANTS mv_doctype_h3 TYPE /mlsft/ed_direct VALUE 'H3'. "#EC NOTEXT
    CONSTANTS mv_doctype_hs TYPE /mlsft/ed_direct VALUE 'HS'. "#EC NOTEXT
    CONSTANTS mv_doctype_h2 TYPE /mlsft/ed_direct VALUE 'H2'. "#EC NOTEXT
    CONSTANTS mv_cii         TYPE /mlsft/ed_xml_format_de VALUE 'CII'. "#EC NOTEXT
    CONSTANTS mv_ubl_zugferd TYPE /mlsft/ed_xml_format_de VALUE 'ZUGFeRD'. "#EC NOTEXT
    CONSTANTS mv_ubl_2_1    TYPE /mlsft/ed_xml_format_de VALUE 'UBL 2.1'. "#EC NOTEXT
    CONSTANTS mv_doctype_s6 TYPE /mlsft/ed_direct VALUE 'S6'. "#EC NOTEXT
    CONSTANTS mv_doctype_s5 TYPE /mlsft/ed_direct VALUE 'S5'. "#EC NOTEXT
    CONSTANTS mv_doctype_h1 TYPE /mlsft/ed_direct VALUE 'H1'. "#EC NOTEXT
    CONSTANTS mv_doctype_do TYPE /mlsft/ed_direct VALUE 'DO'. "#EC NOTEXT
    CONSTANTS mv_doctype_di TYPE /mlsft/ed_direct VALUE 'DI'. "#EC NOTEXT
    CONSTANTS mv_doctype_j1 TYPE /mlsft/ed_direct VALUE 'J1'. "#EC NOTEXT
    CONSTANTS mv_doctype_j2 TYPE /mlsft/ed_direct VALUE 'J2'. "#EC NOTEXT
    CONSTANTS mv_doctype_m1 TYPE /mlsft/ed_direct VALUE 'M1'. "#EC NOTEXT
    CONSTANTS mv_doctype_m2 TYPE /mlsft/ed_direct VALUE 'M2'. "#EC NOTEXT
    CONSTANTS mv_doctype_dz TYPE /mlsft/ed_direct VALUE 'DZ'. "#EC NOTEXT
    CONSTANTS mv_doctype_dy TYPE /mlsft/ed_direct VALUE 'DY'. "#EC NOTEXT
    CONSTANTS mv_doctype_kw TYPE /mlsft/ed_direct VALUE 'KW'. "#EC NOTEXT
    CONSTANTS mv_action_outbound_send           TYPE /mlsft/ed_de_action VALUE '01'. "#EC NOTEXT
    CONSTANTS mv_action_outbound_kor_roz        TYPE /mlsft/ed_de_action VALUE '14'. "#EC NOTEXT
    CONSTANTS mv_action_outbound_down_pdf       TYPE /mlsft/ed_de_action VALUE '09'. "#EC NOTEXT
    CONSTANTS mv_action_outbound_down_xml       TYPE /mlsft/ed_de_action VALUE '08'. "#EC NOTEXT
    CONSTANTS mv_action_outbound_check          TYPE /mlsft/ed_de_action VALUE '02'. "#EC NOTEXT
    CONSTANTS mv_action_outbound_cancel         TYPE /mlsft/ed_de_action VALUE '03'. "#EC NOTEXT
    CONSTANTS mv_action_outbound_storno_canc    TYPE /mlsft/ed_de_action VALUE '16'. "#EC NOTEXT
    CONSTANTS mv_action_outbound_show_pdf       TYPE /mlsft/ed_de_action VALUE '06'. "#EC NOTEXT
    CONSTANTS mv_action_outbound_send_mail      TYPE /mlsft/ed_de_action VALUE '10'. "#EC NOTEXT
    CONSTANTS mv_action_outbound_add_note       TYPE /mlsft/ed_de_action VALUE '11'. "#EC NOTEXT
    CONSTANTS mv_action_outbound_attach         TYPE /mlsft/ed_de_action VALUE '12'. "#EC NOTEXT
    CONSTANTS mv_action_outbound_company        TYPE /mlsft/ed_de_action VALUE '13'. "#EC NOTEXT
    CONSTANTS mv_action_inbound_accept          TYPE /mlsft/ed_de_action VALUE '21'. "#EC NOTEXT
    CONSTANTS mv_action_inbound_reject          TYPE /mlsft/ed_de_action VALUE '22'. "#EC NOTEXT
    CONSTANTS mv_action_inbound_check           TYPE /mlsft/ed_de_action VALUE '23'. "#EC NOTEXT
    CONSTANTS mv_action_inbound_show_pdf        TYPE /mlsft/ed_de_action VALUE '26'. "#EC NOTEXT
    CONSTANTS mv_action_inbound_down_xml        TYPE /mlsft/ed_de_action VALUE '28'. "#EC NOTEXT
    CONSTANTS mv_action_send_pdf_to_vim         TYPE /mlsft/ed_de_action VALUE '30'. "#EC NOTEXT
    CONSTANTS mv_action_save_mm_record          TYPE /mlsft/ed_de_action VALUE '32'. "#EC NOTEXT
    CONSTANTS mv_action_save_fi_record          TYPE /mlsft/ed_de_action VALUE '33'. "#EC NOTEXT
    CONSTANTS mv_action_inbound_send_mail       TYPE /mlsft/ed_de_action VALUE '31'. "#EC NOTEXT
    CONSTANTS mv_action_inbound_send_mail_on    TYPE /mlsft/ed_de_action VALUE '37'. "#EC NOTEXT
    CONSTANTS mv_action_inbound_attach          TYPE /mlsft/ed_de_action VALUE '34'. "#EC NOTEXT
    CONSTANTS mv_action_get_inbound_inv         TYPE /mlsft/ed_de_action VALUE '35'. "#EC NOTEXT
    CONSTANTS mv_action_get_inbound_inv_ids     TYPE /mlsft/ed_de_action VALUE '36'. "#EC NOTEXT
    CONSTANTS mv_action_mail_approved           TYPE /mlsft/ed_de_action VALUE '40'. "#EC NOTEXT
    CONSTANTS mv_action_mail_rejected           TYPE /mlsft/ed_de_action VALUE '41'. "#EC NOTEXT
    CONSTANTS mv_action_inbound_handle          TYPE /mlsft/ed_de_action VALUE '42'. "#EC NOTEXT
    CONSTANTS mv_action_azer_error_image        TYPE /mlsft/ed_de_action VALUE '43'. "#EC NOTEXT
    CONSTANTS mv_action_send_to_response_ml     TYPE /mlsft/ed_de_action VALUE '44'. "#EC NOTEXT
    CONSTANTS mv_action_rom_get_err_inv_lst     TYPE /mlsft/ed_de_action VALUE '46'. "#EC NOTEXT
    CONSTANTS mv_action_send_to_customer_ml     TYPE /mlsft/ed_de_action VALUE '45'. "#EC NOTEXT
    CONSTANTS mv_action_send_to_mail_v_port     TYPE /mlsft/ed_de_action VALUE '47'. "#EC NOTEXT
    CONSTANTS mv_action_concur_intercompany     TYPE /mlsft/ed_de_action VALUE '61'. "#EC NOTEXT
    CONSTANTS mv_action_concur_payment_type     TYPE /mlsft/ed_de_action VALUE '62'. "#EC NOTEXT
    CONSTANTS mv_action_get_bulk_pdf TYPE /mlsft/ed_de_action VALUE '63'. "#EC NOTEXT
    CONSTANTS mv_action_group_01 TYPE /mlsft/ed_type VALUE '01'. "#EC NOTEXT
    CONSTANTS mv_action_group_02 TYPE /mlsft/ed_type VALUE '02'. "#EC NOTEXT
    CONSTANTS mv_action_group_04 TYPE /mlsft/ed_type VALUE '04'. "#EC NOTEXT
    CONSTANTS mv_action_group_05 TYPE /mlsft/ed_type VALUE '05'. "#EC NOTEXT
    CONSTANTS mv_action_group_06 TYPE /mlsft/ed_type VALUE '06'. "#EC NOTEXT
    CONSTANTS mv_action_group_07 TYPE /mlsft/ed_type VALUE '07'. "#EC NOTEXT
    CONSTANTS mv_action_group_08 TYPE /mlsft/ed_type VALUE '08'. "#EC NOTEXT
    CONSTANTS mv_action_group_09 TYPE /mlsft/ed_type VALUE '09'. "#EC NOTEXT
    CONSTANTS mv_action_group_10 TYPE /mlsft/ed_type VALUE '10'. "#EC NOTEXT
    CONSTANTS mv_action_group_11 TYPE /mlsft/ed_type VALUE '11'. "#EC NOTEXT
    CONSTANTS mv_action_group_13 TYPE /mlsft/ed_type VALUE '13'. "#EC NOTEXT
    CONSTANTS mv_action_group_14 TYPE /mlsft/ed_type VALUE '14'. "#EC NOTEXT
    CONSTANTS mv_action_group_15 TYPE /mlsft/ed_type VALUE '15'. "#EC NOTEXT
    CONSTANTS mv_action_group_16 TYPE /mlsft/ed_type VALUE '16'. "#EC NOTEXT
    CONSTANTS mv_action_group_18 TYPE /mlsft/ed_type VALUE '18'. "#EC NOTEXT
    CONSTANTS mv_action_group_19 TYPE /mlsft/ed_type VALUE '19'. "#EC NOTEXT
    CONSTANTS mv_action_group_20 TYPE /mlsft/ed_type VALUE '20'. "#EC NOTEXT
    CONSTANTS mv_action_group_22 TYPE /mlsft/ed_type VALUE '22'. "#EC NOTEXT
    CONSTANTS mv_action_group_21 TYPE /mlsft/ed_type VALUE '21'. "#EC NOTEXT
    CONSTANTS mv_action_group_23 TYPE /mlsft/ed_type VALUE '23'. "#EC NOTEXT
    CONSTANTS folder_name_invoice        TYPE string VALUE 'E-INVOICE'. "#EC NOTEXT
    CONSTANTS mv_action_inbound_down_pdf TYPE /mlsft/ed_de_action VALUE '29'. "#EC NOTEXT
    CONSTANTS inv_profile_basic     TYPE /mlsft/edx_pid VALUE '1'. "#EC NOTEXT
    CONSTANTS inv_profile_export    TYPE /mlsft/edx_pid VALUE '4'. "#EC NOTEXT
    CONSTANTS inv_profile_380       TYPE /mlsft/edx_pid VALUE '8'. "#EC NOTEXT
    CONSTANTS inv_type_satis        TYPE /mlsft/edx_itypecode VALUE '1'. "#EC NOTEXT
    CONSTANTS inv_type_iade         TYPE /mlsft/edx_itypecode VALUE '2'. "#EC NOTEXT
    CONSTANTS inv_type_istisna      TYPE /mlsft/edx_itypecode VALUE '3'. "#EC NOTEXT
    CONSTANTS inv_type_tevkifat     TYPE /mlsft/edx_itypecode VALUE '4'. "#EC NOTEXT
    CONSTANTS inv_type_ozelmatrah   TYPE /mlsft/edx_itypecode VALUE '5'. "#EC NOTEXT
    CONSTANTS inv_type_ihrackayitli TYPE /mlsft/edx_itypecode VALUE '6'. "#EC NOTEXT
    CONSTANTS inv_type_hatali   TYPE /mlsft/edx_itypecode VALUE '7'. "#EC NOTEXT
    CONSTANTS inv_type_ihracat  TYPE /mlsft/edx_itypecode VALUE '8'. "#EC NOTEXT
    CONSTANTS typecode_vat      TYPE /mlsft/ed_char10 VALUE 'VAT'. "#EC NOTEXT
    CONSTANTS categorycode_s    TYPE /mlsft/ed_char10 VALUE 'S'. "#EC NOTEXT
    CONSTANTS categorycode_z    TYPE /mlsft/ed_char10 VALUE 'Z'. "#EC NOTEXT
    CONSTANTS categorycode_o    TYPE /mlsft/ed_char10 VALUE 'O'. "#EC NOTEXT
    CONSTANTS categorycode_ae   TYPE /mlsft/ed_char10 VALUE 'AE'. "#EC NOTEXT
    CONSTANTS categorycode_06   TYPE /mlsft/ed_char10 VALUE '06'. "#EC NOTEXT
    CONSTANTS categorycode_e    TYPE /mlsft/ed_char10 VALUE 'E'. "#EC NOTEXT
    CONSTANTS categorycode_g    TYPE /mlsft/ed_char10 VALUE 'G'. "#EC NOTEXT
    CONSTANTS categorycode_k    TYPE /mlsft/ed_char10 VALUE 'K'. "#EC NOTEXT
    CONSTANTS categorycode_l    TYPE /mlsft/ed_char10 VALUE 'L'. "#EC NOTEXT
    CONSTANTS categorycode_m    TYPE /mlsft/ed_char10 VALUE 'M'. "#EC NOTEXT
    CONSTANTS schemaid_0088     TYPE /mlsft/ed_char10 VALUE '0088'. "#EC NOTEXT
    CONSTANTS schemaid_0106     TYPE /mlsft/ed_char10 VALUE '0106'. "#EC NOTEXT
    CONSTANTS xml_class         TYPE /mlsft/ed_clstype VALUE 'XML'. "#EC NOTEXT
    CONSTANTS control_class     TYPE /mlsft/ed_clstype VALUE 'CONTROL'. "#EC NOTEXT
    CONSTANTS sms_class         TYPE /mlsft/ed_clstype VALUE 'SMS'. "#EC NOTEXT
    CONSTANTS supplier          TYPE /mlsft/ed_char1 VALUE 'S'. "#EC NOTEXT
    CONSTANTS buyer             TYPE /mlsft/ed_char1 VALUE 'A'. "#EC NOTEXT
    CONSTANTS taxrepresentative TYPE /mlsft/ed_char1 VALUE 'T'. "#EC NOTEXT
    CONSTANTS inv_send_mail     TYPE /mlsft/ed_char16 VALUE 'ELEKTRONIK'. "#EC NOTEXT
    CONSTANTS inv_send_paper    TYPE /mlsft/ed_char16 VALUE 'KAGIT'. "#EC NOTEXT
    CONSTANTS order_reference   TYPE /mlsft/edx_rtype VALUE 'O'. "#EC NOTEXT
    CONSTANTS buyer_reference   TYPE /mlsft/edx_rtype VALUE 'Y'. "#EC NOTEXT
    CONSTANTS despatch_reference TYPE /mlsft/edx_rtype VALUE 'D'. "#EC NOTEXT
    CONSTANTS receipt_reference TYPE /mlsft/edx_rtype VALUE 'R'. "#EC NOTEXT
    CONSTANTS add_reference     TYPE /mlsft/edx_rtype VALUE 'A'. "#EC NOTEXT
    CONSTANTS billingreference  TYPE /mlsft/edx_rtype VALUE 'B'. "#EC NOTEXT
    CONSTANTS vatrecord         TYPE /mlsft/edx_rtype VALUE 'V'. "#EC NOTEXT
    CONSTANTS originatordocumentreference TYPE /mlsft/edx_rtype VALUE '1'. "#EC NOTEXT
    CONSTANTS contractdocumentreference   TYPE /mlsft/edx_rtype VALUE '2'. "#EC NOTEXT
    CONSTANTS projectreference        TYPE /mlsft/edx_rtype VALUE '3'. "#EC NOTEXT
    CONSTANTS inv_t_sales             TYPE /mlsft/ed_char60 VALUE '380'. "#EC NOTEXT
    CONSTANTS inv_t_return            TYPE /mlsft/ed_char60 VALUE '326'. "#EC NOTEXT
    CONSTANTS inv_t_credit            TYPE /mlsft/ed_char60 VALUE '381'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_01 TYPE /mlsft/ed_char2 VALUE '01'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_02 TYPE /mlsft/ed_char2 VALUE '02'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_03 TYPE /mlsft/ed_char2 VALUE '03'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_04 TYPE /mlsft/ed_char2 VALUE '04'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_05 TYPE /mlsft/ed_char2 VALUE '05'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_06 TYPE /mlsft/ed_char2 VALUE '06'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_07 TYPE /mlsft/ed_char2 VALUE '07'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_08 TYPE /mlsft/ed_char2 VALUE '08'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_09 TYPE /mlsft/ed_char2 VALUE '09'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_10 TYPE /mlsft/ed_char2 VALUE '10'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_11 TYPE /mlsft/ed_char2 VALUE '11'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_12 TYPE /mlsft/ed_char2 VALUE '12'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_13 TYPE /mlsft/ed_char2 VALUE '13'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_14 TYPE /mlsft/ed_char2 VALUE '14'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_15 TYPE /mlsft/ed_char2 VALUE '15'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_16 TYPE /mlsft/ed_char2 VALUE '16'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_17 TYPE /mlsft/ed_char2 VALUE '17'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_18 TYPE /mlsft/ed_char2 VALUE '18'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_19 TYPE /mlsft/ed_char2 VALUE '19'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_20 TYPE /mlsft/ed_char2 VALUE '20'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_21 TYPE /mlsft/ed_char2 VALUE '21'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_22 TYPE /mlsft/ed_char2 VALUE '22'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_23 TYPE /mlsft/ed_char2 VALUE '23'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_24 TYPE /mlsft/ed_char2 VALUE '24'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_25 TYPE /mlsft/ed_char2 VALUE '25'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_26 TYPE /mlsft/ed_char2 VALUE '26'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_27 TYPE /mlsft/ed_char2 VALUE '27'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_28 TYPE /mlsft/ed_char2 VALUE '28'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_29 TYPE /mlsft/ed_char2 VALUE '29'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_30 TYPE /mlsft/ed_char2 VALUE '30'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_31 TYPE /mlsft/ed_char2 VALUE '31'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_32 TYPE /mlsft/ed_char2 VALUE '32'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_33 TYPE /mlsft/ed_char2 VALUE '33'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_34 TYPE /mlsft/ed_char2 VALUE '34'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_35 TYPE /mlsft/ed_char2 VALUE '35'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_37 TYPE /mlsft/ed_char2 VALUE '37'. "#EC NOTEXT
    CONSTANTS auth_check_eur_actvt_36 TYPE /mlsft/ed_char2 VALUE '36'. "#EC NOTEXT
    CONSTANTS doc_accepted TYPE /mlsft/ed_status VALUE '29'. "#EC NOTEXT
    CONSTANTS doc_rejected TYPE /mlsft/ed_status VALUE '30'. "#EC NOTEXT
    CONSTANTS doc_deleted TYPE /mlsft/ed_status VALUE '31'. "#EC NOTEXT
    CONSTANTS doc_in_cancelled TYPE /mlsft/ed_status VALUE '32'. "#EC NOTEXT
    CONSTANTS int_dtp TYPE /mlsft/ed_entg VALUE 'D'.        "#EC NOTEXT
    CONSTANTS int_super TYPE /mlsft/ed_entg VALUE 'P'.      "#EC NOTEXT
    CONSTANTS int_ice TYPE /mlsft/ed_entg VALUE 'T'.        "#EC NOTEXT
    CONSTANTS mc_land_ro TYPE land1 VALUE 'RO'.             "#EC NOTEXT
    CONSTANTS mc_bearer TYPE /mlsft/ed_char20 VALUE 'Bearer'. "#EC NOTEXT
    CONSTANTS mc_jwt TYPE /mlsft/ed_char20 VALUE 'Jwt'.     "#EC NOTEXT
    CONSTANTS mc_bearer_01 TYPE /mlsft/ed_char2 VALUE '01'. "#EC NOTEXT
    CONSTANTS mc_jwt_02 TYPE /mlsft/ed_char2 VALUE '02'.    "#EC NOTEXT
    CONSTANTS mc_controller TYPE /mlsft/ed_clstype VALUE 'CONTROLLER'. "#EC NOTEXT
    CONSTANTS mc_client_id TYPE string VALUE 'client_id'.   "#EC NOTEXT
    CONSTANTS mc_client_secret TYPE string VALUE 'client_secret'. "#EC NOTEXT
    CONSTANTS document_type_01 TYPE /mlsft/ed_de_dtype VALUE '01'. "#EC NOTEXT
    CONSTANTS document_type_02 TYPE /mlsft/ed_de_dtype VALUE '02'. "#EC NOTEXT
    CONSTANTS document_type_03 TYPE /mlsft/ed_de_dtype VALUE '03'. "#EC NOTEXT
    CONSTANTS document_type_04 TYPE /mlsft/ed_de_dtype VALUE '04'. "#EC NOTEXT
    CONSTANTS migo_dialog_action_a04 TYPE /mlsft/ed_char3 VALUE 'A04'. "#EC NOTEXT
    CONSTANTS migo_dialog_refdoc_r02 TYPE /mlsft/ed_char3 VALUE 'R02'. "#EC NOTEXT
    CONSTANTS ed_param_zsystem TYPE /mlsft/ed_dparam VALUE 'ZSYSTEM'. "#EC NOTEXT
    CONSTANTS mc_bill TYPE vbtyp VALUE 'M'.                 "#EC NOTEXT
    CONSTANTS mv_doctype_i1 TYPE /mlsft/ed_direct VALUE 'I1'. "#EC NOTEXT
    CONSTANTS mv_doctype_i2 TYPE /mlsft/ed_direct VALUE 'I2'. "#EC NOTEXT
    CONSTANTS mv_peppol_bis TYPE string VALUE 'PEPPOL_BIS'. "#EC NOTEXT
    CONSTANTS mv_germany_inv_xrechnung TYPE string VALUE 'XRECHNUNG'. "#EC NOTEXT
    CONSTANTS mv_germany_inv_zugferd TYPE string VALUE 'ZUGFERD'. "#EC NOTEXT
    CONSTANTS mv_message_header TYPE string VALUE 'Error Message'. "#EC NOTEXT
    CONSTANTS mv_grc_structure_name TYPE string VALUE '/MLSFT/ED_GRC_S_INVOICE'. "#EC NOTEXT
    CONSTANTS mv_structure_name_sau TYPE string VALUE '/MLSFT/ED_SAU_S_INVOICE'. "#EC NOTEXT
    CONSTANTS mv_structure_name_hrv TYPE string VALUE '/MLSFT/ED_HRV_S_INVOICE'. "#EC NOTEXT
    CONSTANTS mv_structure_name_bel TYPE string VALUE '/MLSFT/ED_BEL_S_INVOICE'. "#EC NOTEXT
    CONSTANTS mv_structure_name_fra TYPE string VALUE '/MLSFT/ED_FRA_S_INVOICE'. "#EC NOTEXT
    CONSTANTS mv_structure_name TYPE string VALUE '/MLSFT/ED_GER_S_INVOICE'. "#EC NOTEXT
    CONSTANTS mv_message_header_signxml TYPE string VALUE 'Signed XML'. "#EC NOTEXT
    CONSTANTS external_address TYPE string VALUE 'External Address'. "#EC NOTEXT
    CONSTANTS remote_mail_address TYPE string VALUE 'Remote Mail Address'. "#EC NOTEXT
    CONSTANTS sap_logon_name TYPE string VALUE 'SAP Logon Name'. "#EC NOTEXT
    CONSTANTS mv_doctype_b1 TYPE /mlsft/ed_direct VALUE 'B1'. "#EC NOTEXT
    CONSTANTS mv_doctype_bs TYPE /mlsft/ed_direct VALUE 'BS'. "#EC NOTEXT
    CONSTANTS mv_doctype_b2 TYPE /mlsft/ed_direct VALUE 'B2'. "#EC NOTEXT
    CONSTANTS mv_belgium_inv_xrechnung TYPE string VALUE 'XRECHNUNG'. "#EC NOTEXT
    CONSTANTS mv_doctype_ds TYPE /mlsft/ed_direct VALUE 'DS'. "#EC NOTEXT
    CONSTANTS mv_doctype_xml_pdf TYPE string VALUE 'XML-PDF'. "#EC NOTEXT
    CONSTANTS mv_doctype_json_pdf TYPE string VALUE 'JSON-PDF'. "#EC NOTEXT
    CONSTANTS mv_doctype_xml TYPE string VALUE 'XML'.       "#EC NOTEXT
    CONSTANTS mv_doctype_json TYPE string VALUE 'JSON'.     "#EC NOTEXT
    CONSTANTS mv_doctype_pdf TYPE string VALUE 'PDF'.       "#EC NOTEXT
    CONSTANTS partner_type_customer TYPE string VALUE 'CUSTOMER'. "#EC NOTEXT
    CONSTANTS partner_type_supplier TYPE string VALUE 'SUPPLIER'. "#EC NOTEXT
    CONSTANTS mv_doctype_zugferd_pdf TYPE string VALUE 'ZUGFERD_PDF'. "#EC NOTEXT
    CONSTANTS mv_doctype_company_invoice_ubl TYPE string VALUE 'XRECHNUNG'. "#EC NOTEXT
    CONSTANTS mv_doctype_domain TYPE string VALUE '/MLSFT/ED_D_DIRECT'. "#EC NOTEXT
    CONSTANTS mv_general_document TYPE string VALUE '/MLSFT/GNRL_DOC'. "#EC NOTEXT
    CONSTANTS mv_application_prog TYPE string VALUE 'Application Programs'. "#EC NOTEXT
    CONSTANTS mv_periodic_prog TYPE string VALUE 'Periodic Programs'. "#EC NOTEXT
    CONSTANTS mv_customizations TYPE string VALUE 'Customizations'. "#EC NOTEXT
    CONSTANTS mc_ro_credb2b TYPE /mlsft/ed_char10 VALUE 'RO_CREDB2B'. "#EC NOTEXT
    CONSTANTS mc_ro_credb2c TYPE /mlsft/ed_char10 VALUE 'RO_CREDB2C'. "#EC NOTEXT
    CONSTANTS mc_ro_credb2g TYPE /mlsft/ed_char10 VALUE 'RO_CREDB2G'. "#EC NOTEXT
    CONSTANTS mc_ro_invb2b TYPE /mlsft/ed_char10 VALUE 'RO_INVB2B'. "#EC NOTEXT
    CONSTANTS mc_ro_invb2c TYPE /mlsft/ed_char10 VALUE 'RO_INVB2C'. "#EC NOTEXT
    CONSTANTS mc_ro_invb2g TYPE /mlsft/ed_char10 VALUE 'RO_INVB2G'. "#EC NOTEXT
    CONSTANTS mc_ro_invic TYPE /mlsft/ed_char10 VALUE 'RO_INVIC'. "#EC NOTEXT
    CONSTANTS mc_ro_invsb TYPE /mlsft/ed_char10 VALUE 'RO_INVSB'. "#EC NOTEXT
    CONSTANTS mc_ro_trreg TYPE /mlsft/ed_char10 VALUE 'RO_TRREG'. "#EC NOTEXT
    CONSTANTS mv_einvoice_package TYPE /mlsft/gnrl_cust_package_name VALUE 'EI'. "#EC NOTEXT
    CONSTANTS mv_etransport_package TYPE /mlsft/gnrl_cust_package_name VALUE 'ET'. "#EC NOTEXT
    CONSTANTS mv_eledger_package TYPE /mlsft/gnrl_cust_package_name VALUE 'EL'. "#EC NOTEXT
    CONSTANTS mv_gekap_package TYPE /mlsft/gnrl_cust_package_name VALUE 'REC'. "#EC NOTEXT
    CONSTANTS mv_saft_package TYPE /mlsft/gnrl_cust_package_name VALUE 'SF'. "#EC NOTEXT
    CONSTANTS mv_inflation_package TYPE /mlsft/gnrl_cust_package_name VALUE 'INF'. "#EC NOTEXT
    CONSTANTS mv_package_of_tr TYPE /mlsft/gnrl_cust_package_name VALUE 'TR'. "#EC NOTEXT

**    " --- Document lifecycle (status) ---
**    CONSTANTS doc_created              TYPE /MLSFT/ed_status      VALUE '01'. "#EC NOTEXT
**    CONSTANTS doc_sended_to_cld        TYPE /MLSFT/ed_status      VALUE '02'. "#EC NOTEXT
**    CONSTANTS doc_waiting_process      TYPE /MLSFT/ed_status      VALUE '03'. "#EC NOTEXT
**    CONSTANTS doc_process_ended        TYPE /MLSFT/ed_status      VALUE '04'. "#EC NOTEXT
**    CONSTANTS doc_ended_with_error     TYPE /MLSFT/ed_status      VALUE '05'. "#EC NOTEXT
**    CONSTANTS doc_cancelled            TYPE /MLSFT/ed_status      VALUE '09'. "#EC NOTEXT
**    CONSTANTS doc_resended             TYPE /MLSFT/ed_status      VALUE '06'. "#EC NOTEXT
**    CONSTANTS doc_input_save_system    TYPE /MLSFT/ed_status      VALUE '52'. "#EC NOTEXT
**    CONSTANTS doc_input_replied        TYPE /MLSFT/ed_status      VALUE '51'. "#EC NOTEXT
**    CONSTANTS doc_input_created        TYPE /MLSFT/ed_status      VALUE '50'. "#EC NOTEXT
**    CONSTANTS doc_receipt_created      TYPE /MLSFT/ed_status      VALUE '20'. "#EC NOTEXT
**    CONSTANTS doc_receipt_sended       TYPE /MLSFT/ed_status      VALUE '21'. "#EC NOTEXT
**    CONSTANTS doc_transport_confirmed  TYPE /MLSFT/ed_status      VALUE '26'. "#EC NOTEXT
**    CONSTANTS doc_receipt_deleted      TYPE /MLSFT/ed_status      VALUE '22'. "#EC NOTEXT
**    CONSTANTS doc_out_replied          TYPE /MLSFT/ed_status      VALUE '12'. "#EC NOTEXT
**    CONSTANTS doc_send_to_vim          TYPE /MLSFT/ed_status      VALUE '33'. "#EC NOTEXT
**    CONSTANTS doc_send_to_dms          TYPE /MLSFT/ed_status      VALUE '34'. "#EC NOTEXT
**    CONSTANTS doc_send_to_readsoft     TYPE /MLSFT/ed_status      VALUE '35'. "#EC NOTEXT
**    CONSTANTS doc_send_to_kefron       TYPE /MLSFT/ed_status      VALUE '36'. "#EC NOTEXT
**    CONSTANTS doc_storno_cancel        TYPE /MLSFT/ed_status      VALUE '37'. "#EC NOTEXT
**    CONSTANTS doc_not_to_be_sent       TYPE /MLSFT/ed_status      VALUE '38'. "#EC NOTEXT
**    CONSTANTS doc_mark_as_handled      TYPE /MLSFT/ed_status      VALUE '42'. "#EC NOTEXT
**    CONSTANTS doc_unmark_as_handled    TYPE /MLSFT/ed_status      VALUE '43'. "#EC NOTEXT
**    CONSTANTS doc_concur_intercompany   TYPE /MLSFT/ed_status      VALUE '61'. "#EC NOTEXT
**    CONSTANTS doc_concur_payment_type   TYPE /MLSFT/ed_status      VALUE '62'. "#EC NOTEXT
**    CONSTANTS doc_vat_inconsistency     TYPE /MLSFT/ed_status      VALUE '63'. "#EC NOTEXT
**    CONSTANTS doc_master_data_error     TYPE /MLSFT/ed_status      VALUE '64'. "#EC NOTEXT
**
**    " --- Booleans ---
**    CONSTANTS abap_true   TYPE /MLSFT/ed_char1  VALUE 'X'. "#EC NOTEXT
**    CONSTANTS abap_false  TYPE /MLSFT/ed_char1  VALUE ''.  "#EC NOTEXT
**
**    " --- Technical / number range ---
**    CONSTANTS basis_compname  TYPE /MLSFT/ED_CHAR30 VALUE 'SAP_BASIS'.       "#EC NOTEXT
**    CONSTANTS output          TYPE /MLSFT/ed_char1   VALUE 'O'.              "#EC NOTEXT
**    CONSTANTS input           TYPE /MLSFT/ed_char1   VALUE 'I'.              "#EC NOTEXT
**    CONSTANTS number_range    TYPE /MLSFT/ED_CHAR2   VALUE '01'.             "#EC NOTEXT
**    CONSTANTS number_object   TYPE /MLSFT/ed_char10  VALUE '/MLSFT/ED1'.     "#EC NOTEXT
**    CONSTANTS number_obj_key  TYPE /MLSFT/ed_char10  VALUE '/MLSFT/EDK'.     "#EC NOTEXT
**    CONSTANTS number_rng_key  TYPE /MLSFT/ED_CHAR2   VALUE '01'.             "#EC NOTEXT
**    CONSTANTS number_object_man TYPE /MLSFT/ed_char10 VALUE '/MLSFT/EDG'.    "#EC NOTEXT
**
**    " --- Roles / parties ---
**    CONSTANTS vendor                    TYPE /MLSFT/ed_char1 VALUE 'V'. "#EC NOTEXT
**    CONSTANTS customer                  TYPE /MLSFT/ed_char1 VALUE 'C'. "#EC NOTEXT
**    CONSTANTS payeeparty                TYPE /MLSFT/ED_CHAR2 VALUE 'PE'. "#EC NOTEXT
**    CONSTANTS deliverycustomerparty     TYPE /MLSFT/ed_char1 VALUE 'C'. "#EC NOTEXT
**    CONSTANTS despatchsupplierparty     TYPE /MLSFT/ed_char1 VALUE 'D'. "#EC NOTEXT
**    CONSTANTS buyercustomerparty        TYPE /MLSFT/ed_char1 VALUE 'B'. "#EC NOTEXT
**    CONSTANTS sellersupplierparty       TYPE /MLSFT/ed_char1 VALUE 'S'. "#EC NOTEXT
**    CONSTANTS orinatorcustomerparty     TYPE /MLSFT/ed_char1 VALUE 'O'. "#EC NOTEXT
**    CONSTANTS despatchdocument          TYPE /MLSFT/ed_char1 VALUE 'R'. "#EC NOTEXT
**
**    " --- Doc direct types ---
**    CONSTANTS doc_type_doc_in   TYPE /MLSFT/ed_direct VALUE 'ID'. "#EC NOTEXT
**    CONSTANTS doc_type_doc_out  TYPE /MLSFT/ed_direct VALUE 'OD'. "#EC NOTEXT
**    CONSTANTS doc_type_resp_in  TYPE /MLSFT/ed_direct VALUE 'IR'. "#EC NOTEXT
**    CONSTANTS doc_type_resp_out TYPE /MLSFT/ed_direct VALUE 'OR'. "#EC NOTEXT
**
**    " --- Movement / delivery / invoice codes ---
**    CONSTANTS out_movement_waybill TYPE /MLSFT/ed_char1 VALUE 'R'. "#EC NOTEXT
**    CONSTANTS out_manuel_waybill   TYPE /MLSFT/ed_char1 VALUE '2'. "#EC NOTEXT
**    CONSTANTS purchase_order       TYPE /MLSFT/ed_char1 VALUE 'V'. "#EC NOTEXT
**    CONSTANTS out_delivery         TYPE /MLSFT/ed_char1 VALUE 'J'. "#EC NOTEXT
**    CONSTANTS in_delivery          TYPE /MLSFT/ed_char1 VALUE '7'. "#EC NOTEXT
**    CONSTANTS out_invoice          TYPE /MLSFT/ed_char1 VALUE 'M'. "#EC NOTEXT
**    CONSTANTS erpdoctype_goods_mov TYPE vbtyp             VALUE 'R'. "#EC NOTEXT
**
**    " --- Select-options helpers ---
**    CONSTANTS sign          TYPE tvarv_opti VALUE 'I'.  "#EC NOTEXT
**    CONSTANTS sign_exclude  TYPE tvarv_opti VALUE 'E'.  "#EC NOTEXT
**    CONSTANTS option_ne     TYPE tvarv_opti VALUE 'NE'. "#EC NOTEXT
**    CONSTANTS option        TYPE tvarv_opti VALUE 'EQ'. "#EC NOTEXT
**
**    " --- Receipt / reference ---
**    CONSTANTS receipt_adv_type_sevk TYPE /MLSFT/ed_char10 VALUE 'SEVK'. "#EC NOTEXT
**    CONSTANTS ref_manuel_receipt    TYPE /MLSFT/ed_reftype VALUE '4'.   "#EC NOTEXT
**
**    " --- Incoming despatch status group ---
**    CONSTANTS:
**      BEGIN OF inc_despatch_status,
**        doc_created   TYPE /MLSFT/ed_status VALUE '50',
**        doc_replied   TYPE /MLSFT/ed_status VALUE '51',
**        doc_processed TYPE /MLSFT/ed_status VALUE '52',
**      END OF inc_despatch_status.
**
**    " --- Outgoing despatch status group ---
**    CONSTANTS:
**      BEGIN OF out_despatch_status,
**        doc_created          TYPE /MLSFT/ed_status VALUE '01', "#EC NOTEXT
**        doc_sended_to_cld    TYPE /MLSFT/ed_status VALUE '02', "#EC NOTEXT
**        doc_waiting_process  TYPE /MLSFT/ed_status VALUE '03', "#EC NOTEXT
**        doc_process_ended    TYPE /MLSFT/ed_status VALUE '04', "#EC NOTEXT
**        doc_ended_with_error TYPE /MLSFT/ed_status VALUE '05', "#EC NOTEXT
**        doc_cancelled        TYPE /MLSFT/ed_status VALUE '09', "#EC NOTEXT
**        doc_resended         TYPE /MLSFT/ed_status VALUE '06', "#EC NOTEXT
**      END OF out_despatch_status.
**
**    " --- Object type flags ---
**    CONSTANTS objtyp_tcode TYPE /MLSFT/ED_CHAR2 VALUE 'I'. "#EC NOTEXT
**    CONSTANTS objtyp_table TYPE /MLSFT/ED_CHAR2 VALUE 'T'. "#EC NOTEXT
**
**    " --- Process code ---
**    CONSTANTS MLSFT_process TYPE /MLSFT/ED_PROCESS VALUE 'ED'. "#EC NOTEXT
**
**    " --- Mail doc types ---
**    CONSTANTS mail_doc_type_pdf  TYPE /MLSFT/ed_/MLSFT/ED_CHAR4 VALUE 'PDF'.  "#EC NOTEXT
**    CONSTANTS mail_doc_type_ubl  TYPE /MLSFT/ed_/MLSFT/ED_CHAR4 VALUE 'UBL'.  "#EC NOTEXT
**    CONSTANTS mail_doc_type_html TYPE /MLSFT/ed_/MLSFT/ED_CHAR4 VALUE 'HTML'. "#EC NOTEXT
**    CONSTANTS mail_doc_type_full TYPE /MLSFT/ed_/MLSFT/ED_CHAR4 VALUE 'FULL'. "#EC NOTEXT
**    CONSTANTS mail_doc_type_xml  TYPE /MLSFT/ed_/MLSFT/ED_CHAR4 VALUE 'XML'.  "#EC NOTEXT
**
**    " --- Authorization objects ---
**    CONSTANTS auth_object_ed          TYPE /MLSFT/ED_CHAR10 VALUE '/MLSFT/ED'.   "#EC NOTEXT
**    CONSTANTS auth_object_kz_inv      TYPE /MLSFT/ED_CHAR10 VALUE '/MLSFT/KI'.   "#EC NOTEXT
**    CONSTANTS auth_object_kz_deliv    TYPE /MLSFT/ED_CHAR10 VALUE '/MLSFT/KD'.   "#EC NOTEXT
**    CONSTANTS auth_object_kz_vw       TYPE /MLSFT/ED_CHAR10 VALUE '/MLSFT/KV'.   "#EC NOTEXT
**    CONSTANTS auth_object_eur         TYPE /MLSFT/ED_CHAR10 VALUE '/MLSFT/EUR'.  "#EC NOTEXT
**    CONSTANTS auth_object_glb_e_trans TYPE /MLSFT/ED_CHAR10 VALUE '/MLSFT/GLB'.  "#EC NOTEXT
**
**    " --- Message ID ---
**    CONSTANTS message_id TYPE sy-msgid VALUE '/MLSFT/ED'. "#EC NOTEXT
**
**    " --- Auth activity codes ---
**    CONSTANTS auth_check_actvt_01 TYPE /MLSFT/ED_CHAR2 VALUE '01'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_03 TYPE /MLSFT/ED_CHAR2 VALUE '03'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_04 TYPE /MLSFT/ED_CHAR2 VALUE '04'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_05 TYPE /MLSFT/ED_CHAR2 VALUE '05'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_06 TYPE /MLSFT/ED_CHAR2 VALUE '06'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_07 TYPE /MLSFT/ED_CHAR2 VALUE '07'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_08 TYPE /MLSFT/ED_CHAR2 VALUE '08'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_09 TYPE /MLSFT/ED_CHAR2 VALUE '09'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_10 TYPE /MLSFT/ED_CHAR2 VALUE '10'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_11 TYPE /MLSFT/ED_CHAR2 VALUE '11'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_12 TYPE /MLSFT/ED_CHAR2 VALUE '12'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_13 TYPE /MLSFT/ED_CHAR2 VALUE '13'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_14 TYPE /MLSFT/ED_CHAR2 VALUE '14'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_15 TYPE /MLSFT/ED_CHAR2 VALUE '15'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_16 TYPE /MLSFT/ED_CHAR2 VALUE '16'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_19 TYPE /MLSFT/ED_CHAR2 VALUE '19'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_18 TYPE /MLSFT/ED_CHAR2 VALUE '18'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_26 TYPE /MLSFT/ED_CHAR2 VALUE '26'. "#EC NOTEXT
**    CONSTANTS auth_check_actvt_17 TYPE /MLSFT/ED_CHAR2 VALUE '17'. "#EC NOTEXT
**
**    " --- Copy indicators ---
**    CONSTANTS copy_indicator_false TYPE /MLSFT/ed_char10 VALUE 'false'. "#EC NOTEXT
**    CONSTANTS copy_indicator_true  TYPE /MLSFT/ed_char10 VALUE 'true'.  "#EC NOTEXT
**
**    " --- Document version ---
**    CONSTANTS document_version_0_9 TYPE /MLSFT/ed_char10 VALUE '0.9'. "#EC NOTEXT
**    CONSTANTS document_version_1_0 TYPE /MLSFT/ed_char10 VALUE '1.0'. "#EC NOTEXT
**
**    " --- Auth error text ---
**    CONSTANTS auth_check_actvt_error TYPE /MLSFT/ed_char12 VALUE 'Yetki Hatası'. "#EC NOTEXT
**
**    " --- UBL tags ---
**    CONSTANTS ubl_tag_id           TYPE /MLSFT/ED_CHAR100 VALUE 'ID'.                  "#EC NOTEXT
**    CONSTANTS ubl_tag_item         TYPE /MLSFT/ED_CHAR100 VALUE 'Item'.                "#EC NOTEXT
**    CONSTANTS ubl_tag_name         TYPE /MLSFT/ED_CHAR100 VALUE 'Name'.                "#EC NOTEXT
**    CONSTANTS ubl_tag_delquantity  TYPE /MLSFT/ED_CHAR100 VALUE 'DeliveredQuantity'.   "#EC NOTEXT
**    CONSTANTS ubl_tag_sellerid     TYPE /MLSFT/ED_CHAR100 VALUE 'SellersItemIdentification'. "#EC NOTEXT
**    CONSTANTS ubl_tag_despatchline TYPE /MLSFT/ED_CHAR100 VALUE 'DespatchLine'.        "#EC NOTEXT
**
**    " --- Program names ---
**    CONSTANTS program_output_kz TYPE /MLSFT/ED_CHAR40 VALUE '/MLSFT/ED_KZ_OUTPUT'. "#EC NOTEXT
**    CONSTANTS program_output    TYPE /MLSFT/ED_CHAR40 VALUE '/MLSFT/ED_OUTPUT'.    "#EC NOTEXT
**    CONSTANTS program_input     TYPE /MLSFT/ED_CHAR40 VALUE '/MLSFT/ED_INPUT'.     "#EC NOTEXT
**
**    " --- Folders ---
**    CONSTANTS folder_name_delivery TYPE string VALUE 'E-Delivery'. "#EC NOTEXT
**    CONSTANTS folder_name_irsaliye TYPE string VALUE 'E-IRSALIYE'. "#EC NOTEXT
**    CONSTANTS folder_name_invoice  TYPE string VALUE 'E-INVOICE'.  "#EC NOTEXT
**
**    " --- Message types ---
**    CONSTANTS message_error       TYPE symsgty VALUE 'E'. "#EC NOTEXT
**    CONSTANTS message_success     TYPE symsgty VALUE 'S'. "#EC NOTEXT
**    CONSTANTS message_warning     TYPE symsgty VALUE 'W'. "#EC NOTEXT
**    CONSTANTS message_information TYPE symsgty VALUE 'I'. "#EC NOTEXT
**
**    " --- Scheme/Category codes ---
**    CONSTANTS schemeid_vkn    TYPE /MLSFT/ED_CHAR10 VALUE 'VKN'. "#EC NOTEXT
**    CONSTANTS typecode_vat    TYPE /MLSFT/ED_CHAR10 VALUE 'VAT'. "#EC NOTEXT
**    CONSTANTS categorycode_s  TYPE /MLSFT/ED_CHAR10 VALUE 'S'.   "#EC NOTEXT
**    CONSTANTS categorycode_z  TYPE /MLSFT/ED_CHAR10 VALUE 'Z'.   "#EC NOTEXT
**    CONSTANTS categorycode_o  TYPE /MLSFT/ED_CHAR10 VALUE 'O'.   "#EC NOTEXT
**    CONSTANTS categorycode_ae TYPE /MLSFT/ED_CHAR10 VALUE 'AE'.  "#EC NOTEXT
**    CONSTANTS categorycode_06 TYPE /MLSFT/ED_CHAR10 VALUE '06'.  "#EC NOTEXT
**    CONSTANTS categorycode_e  TYPE /MLSFT/ED_CHAR10 VALUE 'E'.   "#EC NOTEXT
**    CONSTANTS categorycode_g  TYPE /MLSFT/ED_CHAR10 VALUE 'G'.   "#EC NOTEXT
**    CONSTANTS categorycode_k  TYPE /MLSFT/ED_CHAR10 VALUE 'K'.   "#EC NOTEXT
**    CONSTANTS categorycode_l  TYPE /MLSFT/ED_CHAR10 VALUE 'L'.   "#EC NOTEXT
**    CONSTANTS categorycode_m  TYPE /MLSFT/ED_CHAR10 VALUE 'M'.   "#EC NOTEXT
**    CONSTANTS schemaid_0088   TYPE /MLSFT/ED_CHAR10 VALUE '0088'. "#EC NOTEXT
**    CONSTANTS schemaid_0106   TYPE /MLSFT/ED_CHAR10 VALUE '0106'. "#EC NOTEXT
**
**    " --- Parameters / Actions (legacy param keys) ---
**    CONSTANTS act_delay                         TYPE /MLSFT/ed_dparam VALUE 'ACT_DELAY'. "#EC NOTEXT
**    CONSTANTS act_type                          TYPE /MLSFT/ed_dparam VALUE 'ACT_TYPE'. "#EC NOTEXT
**    CONSTANTS act_romania_paginate_endpoint     TYPE /MLSFT/ed_dparam VALUE 'ROMANIA_PAGINATE_ENDPOINT'. "#EC NOTEXT
**    CONSTANTS act_irbm_pagesize                 TYPE /MLSFT/ed_dparam VALUE 'IRBM_PAGESIZE'. "#EC NOTEXT
**    CONSTANTS act_romania_send_to_vim           TYPE /MLSFT/ed_dparam VALUE 'ROMANIA_SEND_TO_VIM'. "#EC NOTEXT
**    CONSTANTS gib_out                           TYPE /MLSFT/ed_dparam VALUE 'GIB_OUT'. "#EC NOTEXT
**    CONSTANTS rotr_out                          TYPE /MLSFT/ed_dparam VALUE 'ROTR_OUT'. "#EC NOTEXT
**    CONSTANTS kz_stat_out1                      TYPE /MLSFT/ed_dparam VALUE 'KZ_SNT_CH1'. "#EC NOTEXT
**    CONSTANTS kz_stat_out2                      TYPE /MLSFT/ed_dparam VALUE 'KZ_SNT_CH2'. "#EC NOTEXT
**    CONSTANTS kz_stat_esf_out1                  TYPE /MLSFT/ed_dparam VALUE 'KZ_ESF_CH1'. "#EC NOTEXT
**    CONSTANTS kz_stat_esf_out2                  TYPE /MLSFT/ed_dparam VALUE 'KZ_ESF_CH2'. "#EC NOTEXT
**
**    " --- Icons / misc ---
**    CONSTANTS shipment_complete   TYPE icon_d          VALUE '@01@'. "#EC NOTEXT
**    CONSTANTS shipment_incomplete TYPE icon_d          VALUE '@02@'. "#EC NOTEXT
**    CONSTANTS semicolon           TYPE /MLSFT/ed_char1 VALUE ';'.    "#EC NOTEXT
**
**    " --- KZ direct doc types ---
**    CONSTANTS doc_type_kz_invoice         TYPE /MLSFT/ed_direct VALUE 'KI'. "#EC NOTEXT
**    CONSTANTS doc_type_kz_waybill         TYPE /MLSFT/ed_direct VALUE 'KW'. "#EC NOTEXT
**    CONSTANTS doc_type_kz_in_invoice      TYPE /MLSFT/ed_direct VALUE 'KM'. "#EC NOTEXT
**    CONSTANTS doc_type_kz_in_waybill      TYPE /MLSFT/ed_direct VALUE 'KS'. "#EC NOTEXT
**    CONSTANTS doc_type_kz_vw_balance_corr TYPE /MLSFT/ed_direct VALUE 'BK'. "#EC NOTEXT
**    CONSTANTS doc_type_kz_vw_balance      TYPE /MLSFT/ed_direct VALUE 'KB'. "#EC NOTEXT
**    CONSTANTS doc_type_kz_vw_wrt_off      TYPE /MLSFT/ed_direct VALUE 'WO'. "#EC NOTEXT
**    CONSTANTS doc_type_kz_vw_manu         TYPE /MLSFT/ed_direct VALUE 'MA'. "#EC NOTEXT
**    CONSTANTS doc_type_kz_vw_mov          TYPE /MLSFT/ed_direct VALUE 'KU'. "#EC NOTEXT
**    CONSTANTS doc_type_kz_waybill_328     TYPE /MLSFT/ed_direct VALUE 'K3'. "#EC NOTEXT
**    CONSTANTS doc_type_kz_vw_det          TYPE /MLSFT/ed_direct VALUE 'KD'. "#EC NOTEXT
**    CONSTANTS doc_type_in_rsreceipts      TYPE /MLSFT/ed_direct VALUE 'S2'. "#EC NOTEXT
**    CONSTANTS doc_type_out_rsreceipts     TYPE /MLSFT/ed_direct VALUE 'S1'. "#EC NOTEXT
**    CONSTANTS doc_type_out_rstransport    TYPE /MLSFT/ed_direct VALUE 'S3'. "#EC NOTEXT
**    CONSTANTS doc_type_out_rotransport    TYPE /MLSFT/ed_direct VALUE 'R3'. "#EC NOTEXT
**    CONSTANTS doc_type_in_rstransport     TYPE /MLSFT/ed_direct VALUE 'S4'. "#EC NOTEXT
**    CONSTANTS doc_type_in_rotransport     TYPE /MLSFT/ed_direct VALUE 'R4'. "#EC NOTEXT
**
**    " --- XML/MAPPING class names ---
**    CONSTANTS xml_cls_kz_invoice         TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZEI_CREATE_XML_INV'. "#EC NOTEXT
**    CONSTANTS xml_cls_kz_delivery        TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZED_CREATE_XML_DEL'. "#EC NOTEXT
**    CONSTANTS xml_cls_ro_transport       TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_ROTR_CREATE_XML_DEL'. "#EC NOTEXT
**    CONSTANTS xml_cls_kz_delivery_328    TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZVW_CREATE_XML_328'. "#EC NOTEXT
**    CONSTANTS xml_cls_kz_vw_balance      TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZVW_CR_XML_BAL_CPY'. "#EC NOTEXT
**    CONSTANTS xml_cls_kz_vw_balance_corr TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZVW_CR_XML_BAL_CORR'. "#EC NOTEXT
**    CONSTANTS xml_cls_kz_vw_mov          TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZVW_CR_XML_MOV_CPY'. "#EC NOTEXT
**    CONSTANTS xml_cls_kz_vw_det          TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZVW_CREATE_XML_DET'. "#EC NOTEXT
**    CONSTANTS xml_cls_kz_vw_wrt_off      TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZVW_CR_XML_WRT_CPY'. "#EC NOTEXT
**    CONSTANTS xml_cls_kz_vw_manu         TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZVW_MANU_MAPP'.      "#EC NOTEXT
**
**    CONSTANTS mapping_cls_kz_invoice     TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZEI_INV_MAPPING'. "#EC NOTEXT
**    CONSTANTS mapping_cls_kz_delivery    TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZED_DEL_MAPPING'. "#EC NOTEXT
**    CONSTANTS mapping_cls_kz_sf_328      TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZED_DEL_MAPPING'. "#EC NOTEXT
**    CONSTANTS mapping_cls_kz_vwbalance   TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZVW_BLNC_MAPP'.    "#EC NOTEXT
**    CONSTANTS mapping_cls_kz_vwdet       TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZVW_DET_MAPP'.     "#EC NOTEXT
**    CONSTANTS mapping_cls_kz_vwmov       TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZVW_MOV_MAPP'.     "#EC NOTEXT
**    CONSTANTS mapping_cls_kz_vwwrt_off   TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZVW_WRITEOFF_MAPP'."#EC NOTEXT
**
**    " --- Controllers ---
**    CONSTANTS kz_ei_doc_controller        TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZEI_DOC_CTRL'. "#EC NOTEXT
**    CONSTANTS kz_vw_doc_controller2       TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZ_VW_DOC_CTRL'. "#EC NOTEXT
**    CONSTANTS kz_ed_doc_controller        TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZED_DOC_CTRL'.  "#EC NOTEXT
**    CONSTANTS kz_vw_doc_controller        TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZVW_DOC_CTRL'.  "#EC NOTEXT
**    CONSTANTS ro_transport_doc_controller TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_ROTR_DOC_CTRL'.  "#EC NOTEXT
**
**    CONSTANTS mapping_cls_rs_delivery     TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_RS_DELIVERY_MAP_UBL'. "#EC NOTEXT
**    CONSTANTS mapping_cls_tr_delivery     TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_DELIVERY_LE_MAP_UBL'. "#EC NOTEXT
**    CONSTANTS mapping_cls_ro_delivery     TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_ROTR_DELV_MAPPING'.    "#EC NOTEXT
**
**    " --- Direction text ---
**    CONSTANTS kz_direction TYPE string VALUE 'INBOUND'. "#EC NOTEXT
**
**    " --- Addons ---
**    CONSTANTS addon_turkey_einvoice   TYPE /MLSFT/ED_ADDONT VALUE 'TE'.  "#EC NOTEXT
**    CONSTANTS addon_turkey_edelivery  TYPE /MLSFT/ed_addont VALUE 'TW'.  "#EC NOTEXT
**    CONSTANTS addon_kz_einvoice       TYPE /MLSFT/ed_addont VALUE 'KE'.  "#EC NOTEXT
**    CONSTANTS addon_kz_edelivery      TYPE /MLSFT/ed_addont VALUE 'KW'.  "#EC NOTEXT
**    CONSTANTS addon_kz_vstore         TYPE /MLSFT/ed_addont VALUE 'KV'.  "#EC NOTEXT
**    CONSTANTS addon_germany_xrechnung TYPE /MLSFT/ed_addont VALUE 'GX'.  "#EC NOTEXT
**    CONSTANTS addon_norway_peppol     TYPE /MLSFT/ed_addont VALUE 'NO'.  "#EC NOTEXT
**    CONSTANTS addon_italy_einvoice    TYPE /MLSFT/ed_addont VALUE 'IE'.  "#EC NOTEXT
**
**    " --- Standard object types / currencies ---
**    CONSTANTS vbrk TYPE awtyp VALUE 'VBRK'. "#EC NOTEXT
**    CONSTANTS bkpf TYPE awtyp VALUE 'BKPF'. "#EC NOTEXT
**    CONSTANTS rbkp TYPE awtyp VALUE 'RBKP'. "#EC NOTEXT
**
**    CONSTANTS pln  TYPE waers VALUE 'PLN'. "#EC NOTEXT
**    CONSTANTS try  TYPE waers VALUE 'TRY'. "#EC NOTEXT
**    CONSTANTS ron  TYPE waers VALUE 'RON'. "#EC NOTEXT
**    CONSTANTS rsd  TYPE waers VALUE 'RSD'. "#EC NOTEXT
**    CONSTANTS azm  TYPE waers VALUE 'AZM'. "#EC NOTEXT
**    CONSTANTS eur  TYPE waers VALUE 'EUR'. "#EC NOTEXT
**    CONSTANTS myr  TYPE waers VALUE 'MYR'. "#EC NOTEXT
**
**    " --- TYPE_* flags ---
**    CONSTANTS type_v TYPE /MLSFT/ed_char1 VALUE 'V'. "#EC NOTEXT
**    CONSTANTS type_r TYPE /MLSFT/ed_char1 VALUE 'R'. "#EC NOTEXT
**    CONSTANTS type_f TYPE /MLSFT/ed_char1 VALUE 'F'. "#EC NOTEXT
**    CONSTANTS type_m TYPE /MLSFT/ed_char1 VALUE 'M'. "#EC NOTEXT
**    CONSTANTS type_x TYPE /MLSFT/ed_char1 VALUE 'X'. "#EC NOTEXT
**
**    " --- Scheme IDs / misc ---
**    CONSTANTS schemeid_9948 TYPE /MLSFT/ED_CHAR20 VALUE '9948'. "#EC NOTEXT
**
**    " --- Doctypes (various) ---
**    CONSTANTS mv_doctype_so       TYPE /MLSFT/ed_direct VALUE 'SO'. "#EC NOTEXT
**    CONSTANTS mv_doctype_si       TYPE /MLSFT/ed_direct VALUE 'SI'. "#EC NOTEXT
**    CONSTANTS mv_doctype_r1       TYPE /MLSFT/ed_direct VALUE 'R1'. "#EC NOTEXT
**    CONSTANTS mv_doctype_r2       TYPE /MLSFT/ed_direct VALUE 'R2'. "#EC NOTEXT
**    CONSTANTS mv_doctype_rstr_out TYPE /MLSFT/ed_direct VALUE 'S3'. "#EC NOTEXT
**    CONSTANTS mv_doctype_rotr_out TYPE /MLSFT/ed_direct VALUE 'R3'. "#EC NOTEXT
**    CONSTANTS mv_doctype_rstr_in  TYPE /MLSFT/ed_direct VALUE 'S4'. "#EC NOTEXT
**    CONSTANTS mv_doctype_rotr_in  TYPE /MLSFT/ed_direct VALUE 'R4'. "#EC NOTEXT
**    CONSTANTS mv_doctype_f1       TYPE /MLSFT/ed_direct VALUE 'F1'. "#EC NOTEXT
**    CONSTANTS mv_doctype_d1       TYPE /MLSFT/ed_direct VALUE 'D1'. "#EC NOTEXT
**    CONSTANTS mv_doctype_d2       TYPE /MLSFT/ed_direct VALUE 'D2'. "#EC NOTEXT
**    CONSTANTS mv_doctype_d3       TYPE /MLSFT/ed_direct VALUE 'D3'. "#EC NOTEXT
**    CONSTANTS mv_doctype_d4       TYPE /MLSFT/ed_direct VALUE 'D4'. "#EC NOTEXT
**    CONSTANTS mv_doctype_f2       TYPE /MLSFT/ed_direct VALUE 'F2'. "#EC NOTEXT
**    CONSTANTS mv_doctype_fs       TYPE /MLSFT/ed_direct VALUE 'FS'. "#EC NOTEXT
**    CONSTANTS mv_doctype_fi       TYPE /MLSFT/ed_direct VALUE 'FI'. "#EC NOTEXT
**    CONSTANTS mv_doctype_fo       TYPE /MLSFT/ed_direct VALUE 'FO'. "#EC NOTEXT
**    CONSTANTS mv_doctype_fz       TYPE /MLSFT/ed_direct VALUE 'FZ'. "#EC NOTEXT
**    CONSTANTS mv_doctype_fy       TYPE /MLSFT/ed_direct VALUE 'FY'. "#EC NOTEXT
**    CONSTANTS mv_doctype_a3       TYPE /MLSFT/ed_direct VALUE 'A3'. "#EC NOTEXT
**    CONSTANTS mv_doctype_a4       TYPE /MLSFT/ed_direct VALUE 'A4'. "#EC NOTEXT
**    CONSTANTS mv_doctype_e1       TYPE /MLSFT/ed_direct VALUE 'E1'. "#EC NOTEXT
**    CONSTANTS mv_doctype_e2       TYPE /MLSFT/ed_direct VALUE 'E2'. "#EC NOTEXT
**    CONSTANTS mv_doctype_s6       TYPE /MLSFT/ed_direct VALUE 'S6'. "#EC NOTEXT
**    CONSTANTS mv_doctype_s5       TYPE /MLSFT/ed_direct VALUE 'S5'. "#EC NOTEXT
**    CONSTANTS mv_doctype_h1       TYPE /MLSFT/ed_direct VALUE 'H1'. "#EC NOTEXT
**    CONSTANTS mv_doctype_do       TYPE /MLSFT/ed_direct VALUE 'DO'. "#EC NOTEXT
**    CONSTANTS mv_doctype_di       TYPE /MLSFT/ed_direct VALUE 'DI'. "#EC NOTEXT
**    CONSTANTS mv_doctype_j1       TYPE /MLSFT/ed_direct VALUE 'J1'. "#EC NOTEXT
**    CONSTANTS mv_doctype_j2       TYPE /MLSFT/ed_direct VALUE 'J2'. "#EC NOTEXT
**    CONSTANTS mv_doctype_m1       TYPE /MLSFT/ed_direct VALUE 'M1'. "#EC NOTEXT
**    CONSTANTS mv_doctype_m2       TYPE /MLSFT/ed_direct VALUE 'M2'. "#EC NOTEXT
**    CONSTANTS mv_doctype_dz       TYPE /MLSFT/ed_direct VALUE 'DZ'. "#EC NOTEXT
**    CONSTANTS mv_doctype_dy       TYPE /MLSFT/ed_direct VALUE 'DY'. "#EC NOTEXT
**    CONSTANTS mv_doctype_kw       TYPE /MLSFT/ed_direct VALUE 'KW'. "#EC NOTEXT
**    CONSTANTS mv_doctype_a1       TYPE /MLSFT/ed_direct VALUE 'A1'. "#EC NOTEXT
**    CONSTANTS mv_doctype_a2       TYPE /MLSFT/ed_direct VALUE 'A2'. "#EC NOTEXT
**    CONSTANTS mv_doctype_p1       TYPE /MLSFT/ed_direct VALUE 'P1'. "#EC NOTEXT
**    CONSTANTS mv_doctype_p2       TYPE /MLSFT/ed_direct VALUE 'P2'. "#EC NOTEXT
**    CONSTANTS mv_doctype_io       TYPE /MLSFT/ed_direct VALUE 'IO'. "#EC NOTEXT
**    CONSTANTS mv_doctype_ii       TYPE /MLSFT/ed_direct VALUE 'II'. "#EC NOTEXT
**    CONSTANTS mv_doctype_g1       TYPE /MLSFT/ed_direct VALUE 'G1'. "#EC NOTEXT
**    CONSTANTS mv_doctype_h3       TYPE /MLSFT/ed_direct VALUE 'H3'. "#EC NOTEXT
**    CONSTANTS mv_doctype_hs       TYPE /MLSFT/ed_direct VALUE 'HS'. "#EC NOTEXT
**    CONSTANTS mv_doctype_h2       TYPE /MLSFT/ed_direct VALUE 'H2'. "#EC NOTEXT
**
**    " --- XML format (DE) ---
**    CONSTANTS mv_cii            TYPE /MLSFT/ed_xml_format_de VALUE 'CII'.      "#EC NOTEXT
**    CONSTANTS mv_ubl_zugferd    TYPE /MLSFT/ed_xml_format_de VALUE 'ZUGFeRD'.  "#EC NOTEXT
**    CONSTANTS mv_ubl_2_1        TYPE /MLSFT/ed_xml_format_de VALUE 'UBL 2.1'.  "#EC NOTEXT
**
**    " --- Sales/Purchase Europe status text ---
**    CONSTANTS sales_draft      TYPE /MLSFT/ed_europe_stat VALUE 'Draft'.    "#EC NOTEXT
**    CONSTANTS sales_sent       TYPE /MLSFT/ed_europe_stat VALUE 'Sent'.     "#EC NOTEXT
**    CONSTANTS sales_cancelled  TYPE /MLSFT/ed_europe_stat VALUE 'Cancelled'."#EC NOTEXT
**    CONSTANTS sales_storno     TYPE /MLSFT/ed_europe_stat VALUE 'Storno'.   "#EC NOTEXT
**    CONSTANTS sales_approved   TYPE /MLSFT/ed_europe_stat VALUE 'Approved'. "#EC NOTEXT
**    CONSTANTS sales_rejected   TYPE /MLSFT/ed_europe_stat VALUE 'Rejected'. "#EC NOTEXT
**    CONSTANTS sales_sending    TYPE /MLSFT/ed_europe_stat VALUE 'Sending'.  "#EC NOTEXT
**    CONSTANTS sales_deleted    TYPE /MLSFT/ed_europe_stat VALUE 'Deleted'.  "#EC NOTEXT
**
**    CONSTANTS purchase_new       TYPE /MLSFT/ed_europe_stat VALUE 'New'.      "#EC NOTEXT
**    CONSTANTS purchase_seen      TYPE /MLSFT/ed_europe_stat VALUE 'Seen'.     "#EC NOTEXT
**    CONSTANTS purchase_reminded  TYPE /MLSFT/ed_europe_stat VALUE 'Reminded'. "#EC NOTEXT
**    CONSTANTS purchase_cancelled TYPE /MLSFT/ed_europe_stat VALUE 'Cancelled'."#EC NOTEXT
**    CONSTANTS purchase_approved  TYPE /MLSFT/ed_europe_stat VALUE 'Approved'. "#EC NOTEXT
**    CONSTANTS purchase_rejected  TYPE /MLSFT/ed_europe_stat VALUE 'Rejected'. "#EC NOTEXT
**    CONSTANTS purchase_deleted   TYPE /MLSFT/ed_europe_stat VALUE 'Deleted'.  "#EC NOTEXT
**
**    " --- Class type tags ---
**    CONSTANTS mapping_class TYPE /MLSFT/ed_clstype VALUE 'MAPPING'.    "#EC NOTEXT
**    CONSTANTS xml_class     TYPE /MLSFT/ed_clstype VALUE 'XML'.        "#EC NOTEXT
**    CONSTANTS control_class TYPE /MLSFT/ed_clstype VALUE 'CONTROL'.    "#EC NOTEXT
**    CONSTANTS sms_class     TYPE /MLSFT/ed_clstype VALUE 'SMS'.        "#EC NOTEXT
**    CONSTANTS mc_controller TYPE /MLSFT/ed_clstype VALUE 'CONTROLLER'. "#EC NOTEXT
**
**    " --- Buyer/Supplier roles (single char) ---
**    CONSTANTS supplier          TYPE /MLSFT/ed_char1 VALUE 'S'. "#EC NOTEXT
**    CONSTANTS buyer             TYPE /MLSFT/ed_char1 VALUE 'A'. "#EC NOTEXT
**    CONSTANTS taxrepresentative TYPE /MLSFT/ed_char1 VALUE 'T'. "#EC NOTEXT
**
**    " --- Invoice send types ---
**    CONSTANTS inv_send_mail  TYPE /MLSFT/ed_char16 VALUE 'ELEKTRONIK'. "#EC NOTEXT
**    CONSTANTS inv_send_paper TYPE /MLSFT/ed_char16 VALUE 'KAGIT'.      "#EC NOTEXT
**
**    " --- Reference types ---
**    CONSTANTS order_reference             TYPE /MLSFT/edx_rtype VALUE 'O'. "#EC NOTEXT
**    CONSTANTS buyer_reference             TYPE /MLSFT/edx_rtype VALUE 'Y'. "#EC NOTEXT
**    CONSTANTS despatch_reference          TYPE /MLSFT/edx_rtype VALUE 'D'. "#EC NOTEXT
**    CONSTANTS receipt_reference           TYPE /MLSFT/edx_rtype VALUE 'R'. "#EC NOTEXT
**    CONSTANTS add_reference               TYPE /MLSFT/edx_rtype VALUE 'A'. "#EC NOTEXT
**    CONSTANTS billingreference            TYPE /MLSFT/edx_rtype VALUE 'B'. "#EC NOTEXT
**    CONSTANTS originatordocumentreference TYPE /MLSFT/edx_rtype VALUE '1'. "#EC NOTEXT
**    CONSTANTS contractdocumentreference   TYPE /MLSFT/edx_rtype VALUE '2'. "#EC NOTEXT
**    CONSTANTS projectreference            TYPE /MLSFT/edx_rtype VALUE '3'. "#EC NOTEXT
**
**    " --- Invoice type/profile codes ---
**    CONSTANTS inv_profile_basic  TYPE /MLSFT/edx_pid      VALUE '1'. "#EC NOTEXT
**    CONSTANTS inv_profile_export TYPE /MLSFT/edx_pid      VALUE '4'. "#EC NOTEXT
**    CONSTANTS inv_profile_380    TYPE /MLSFT/edx_pid      VALUE '8'. "#EC NOTEXT
**
**    CONSTANTS inv_type_satis         TYPE /MLSFT/edx_itypecode VALUE '1'. "#EC NOTEXT
**    CONSTANTS inv_type_iade          TYPE /MLSFT/edx_itypecode VALUE '2'. "#EC NOTEXT
**    CONSTANTS inv_type_istisna       TYPE /MLSFT/edx_itypecode VALUE '3'. "#EC NOTEXT
**    CONSTANTS inv_type_tevkifat      TYPE /MLSFT/edx_itypecode VALUE '4'. "#EC NOTEXT
**    CONSTANTS inv_type_ozelmatrah    TYPE /MLSFT/edx_itypecode VALUE '5'. "#EC NOTEXT
**    CONSTANTS inv_type_ihrackayitli  TYPE /MLSFT/edx_itypecode VALUE '6'. "#EC NOTEXT
**    CONSTANTS inv_type_hatali        TYPE /MLSFT/edx_itypecode VALUE '7'. "#EC NOTEXT
**    CONSTANTS inv_type_ihracat       TYPE /MLSFT/edx_itypecode VALUE '8'. "#EC NOTEXT
**
**    " --- PEPPOL strings ---
**    CONSTANTS peppol_accepted    TYPE string VALUE 'Accepted'.      "#EC NOTEXT
**    CONSTANTS peppol_acceptance  TYPE string VALUE 'ACCEPTANCE'.    "#EC NOTEXT
**    CONSTANTS peppol_acknowledge TYPE string VALUE 'ACKNOWLEDGING'. "#EC NOTEXT
**    CONSTANTS peppol_rejection   TYPE string VALUE 'REJECTION'.     "#EC NOTEXT
**
**    " --- Inbound download action (existing) ---
**    CONSTANTS mv_action_inbound_down_pdf TYPE /MLSFT/ED_DE_ACTION VALUE '29'. "#EC NOTEXT
**
**    " --- Authorization (EUR) activities ---
**    CONSTANTS auth_check_eur_actvt_01 TYPE /MLSFT/ED_CHAR2 VALUE '01'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_02 TYPE /MLSFT/ED_CHAR2 VALUE '02'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_03 TYPE /MLSFT/ED_CHAR2 VALUE '03'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_04 TYPE /MLSFT/ED_CHAR2 VALUE '04'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_05 TYPE /MLSFT/ED_CHAR2 VALUE '05'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_06 TYPE /MLSFT/ED_CHAR2 VALUE '06'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_07 TYPE /MLSFT/ED_CHAR2 VALUE '07'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_08 TYPE /MLSFT/ED_CHAR2 VALUE '08'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_09 TYPE /MLSFT/ED_CHAR2 VALUE '09'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_10 TYPE /MLSFT/ED_CHAR2 VALUE '10'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_11 TYPE /MLSFT/ED_CHAR2 VALUE '11'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_12 TYPE /MLSFT/ED_CHAR2 VALUE '12'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_13 TYPE /MLSFT/ED_CHAR2 VALUE '13'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_14 TYPE /MLSFT/ED_CHAR2 VALUE '14'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_15 TYPE /MLSFT/ED_CHAR2 VALUE '15'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_16 TYPE /MLSFT/ED_CHAR2 VALUE '16'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_17 TYPE /MLSFT/ED_CHAR2 VALUE '17'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_18 TYPE /MLSFT/ED_CHAR2 VALUE '18'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_19 TYPE /MLSFT/ED_CHAR2 VALUE '19'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_20 TYPE /MLSFT/ED_CHAR2 VALUE '20'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_21 TYPE /MLSFT/ED_CHAR2 VALUE '21'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_22 TYPE /MLSFT/ED_CHAR2 VALUE '22'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_23 TYPE /MLSFT/ED_CHAR2 VALUE '23'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_24 TYPE /MLSFT/ED_CHAR2 VALUE '24'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_25 TYPE /MLSFT/ED_CHAR2 VALUE '25'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_26 TYPE /MLSFT/ED_CHAR2 VALUE '26'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_27 TYPE /MLSFT/ED_CHAR2 VALUE '27'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_28 TYPE /MLSFT/ED_CHAR2 VALUE '28'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_29 TYPE /MLSFT/ED_CHAR2 VALUE '29'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_30 TYPE /MLSFT/ED_CHAR2 VALUE '30'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_31 TYPE /MLSFT/ED_CHAR2 VALUE '31'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_32 TYPE /MLSFT/ED_CHAR2 VALUE '32'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_33 TYPE /MLSFT/ED_CHAR2 VALUE '33'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_34 TYPE /MLSFT/ED_CHAR2 VALUE '34'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_35 TYPE /MLSFT/ED_CHAR2 VALUE '35'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_37 TYPE /MLSFT/ED_CHAR2 VALUE '37'. "#EC NOTEXT
**    CONSTANTS auth_check_eur_actvt_36 TYPE /MLSFT/ED_CHAR2 VALUE '36'. "#EC NOTEXT
**
**    " --- Acknowledged / fulfilled / decision statuses ---
**    CONSTANTS doc_acknowledged TYPE /MLSFT/ed_status VALUE '66'. "#EC NOTEXT
**    CONSTANTS doc_fullfilled   TYPE /MLSFT/ed_status VALUE '69'. "#EC NOTEXT
**    CONSTANTS doc_accepted     TYPE /MLSFT/ed_status VALUE '29'. "#EC NOTEXT
**    CONSTANTS doc_rejected     TYPE /MLSFT/ed_status VALUE '30'. "#EC NOTEXT
**    CONSTANTS doc_deleted      TYPE /MLSFT/ed_status VALUE '31'. "#EC NOTEXT
**    CONSTANTS doc_in_cancelled TYPE /MLSFT/ed_status VALUE '32'. "#EC NOTEXT
**
**    " --- Entities ---
**    CONSTANTS int_dtp   TYPE /MLSFT/ed_entg VALUE 'D'. "#EC NOTEXT
**    CONSTANTS int_super TYPE /MLSFT/ed_entg VALUE 'P'. "#EC NOTEXT
**    CONSTANTS int_ice   TYPE /MLSFT/ed_entg VALUE 'T'. "#EC NOTEXT
**
**    " --- Country / bearer/JWT ---
**    CONSTANTS mc_land_ro   TYPE land1           VALUE 'RO'.     "#EC NOTEXT
**    CONSTANTS mc_bearer    TYPE /MLSFT/ED_CHAR20          VALUE 'Bearer'. "#EC NOTEXT
**    CONSTANTS mc_jwt       TYPE /MLSFT/ED_CHAR20          VALUE 'Jwt'.    "#EC NOTEXT
**    CONSTANTS mc_bearer_01 TYPE /MLSFT/ED_CHAR2 VALUE '01'.     "#EC NOTEXT
**    CONSTANTS mc_jwt_02    TYPE /MLSFT/ED_CHAR2 VALUE '02'.     "#EC NOTEXT
**
**    " --- OAuth params (keys) ---
**    CONSTANTS mc_client_id     TYPE string VALUE 'client_id'.     "#EC NOTEXT
**    CONSTANTS mc_client_secret TYPE string VALUE 'client_secret'. "#EC NOTEXT
**
**    " --- Document types (DE) ---
**    CONSTANTS document_type_01 TYPE /MLSFT/ED_DE_DTYPE VALUE '01'. "#EC NOTEXT
**    CONSTANTS document_type_02 TYPE /MLSFT/ed_de_dtype VALUE '02'. "#EC NOTEXT
**    CONSTANTS document_type_03 TYPE /MLSFT/ed_de_dtype VALUE '03'. "#EC NOTEXT
**    CONSTANTS document_type_04 TYPE /MLSFT/ed_de_dtype VALUE '04'. "#EC NOTEXT
**
**    " --- MIGO consts ---
**    CONSTANTS migo_dialog_action_a04 TYPE /MLSFT/ED_CHAR3 VALUE 'A04'. "#EC NOTEXT
**    CONSTANTS migo_dialog_refdoc_r02 TYPE /MLSFT/ED_CHAR3 VALUE 'R02'. "#EC NOTEXT
**
**    " --- Params ---
**    CONSTANTS ed_param_zsystem TYPE /MLSFT/ed_dparam VALUE 'ZSYSTEM'. "#EC NOTEXT
**
**    " --- Billing type ---
**    CONSTANTS mc_bill TYPE vbtyp VALUE 'M'. "#EC NOTEXT
**
**    " --- Doctypes (I1/I2 etc.) ---
**    CONSTANTS mv_doctype_i1 TYPE /MLSFT/ed_direct VALUE 'I1'. "#EC NOTEXT
**    CONSTANTS mv_doctype_i2 TYPE /MLSFT/ed_direct VALUE 'I2'. "#EC NOTEXT
**
**    " --- Labels / formats / headers ---
**    CONSTANTS mv_peppol_bis            TYPE string VALUE 'PEPPOL_BIS'. "#EC NOTEXT
**    CONSTANTS mv_germany_inv_xrechnung TYPE string VALUE 'XRECHNUNG'.  "#EC NOTEXT
**    CONSTANTS mv_germany_inv_zugferd   TYPE string VALUE 'ZUGFERD'.    "#EC NOTEXT
**    CONSTANTS mv_message_header        TYPE string VALUE 'Error Message'. "#EC NOTEXT
**
**    CONSTANTS mapping_cls_kz_vw_manufacture TYPE /MLSFT/ed_char30 VALUE '/MLSFT/ED_KZVW_MANU_MAPP'. "#EC NOTEXT
**
**    " --- Structure names as string (namespace switched to /MLSFT/) ---
**    CONSTANTS mv_grc_structure_name TYPE string VALUE '/MLSFT/ED_GRC_S_INVOICE'. "#EC NOTEXT
**    CONSTANTS mv_structure_name_sau TYPE string VALUE '/MLSFT/ED_SAU_S_INVOICE'. "#EC NOTEXT
**    CONSTANTS mv_structure_name_hrv TYPE string VALUE '/MLSFT/ED_HRV_S_INVOICE'. "#EC NOTEXT
**    CONSTANTS mv_structure_name_bel TYPE string VALUE '/MLSFT/ED_BEL_S_INVOICE'. "#EC NOTEXT
**    CONSTANTS mv_structure_name     TYPE string VALUE '/MLSFT/ED_GER_S_INVOICE'. "#EC NOTEXT
**    CONSTANTS mv_structure_name_dnk TYPE string VALUE '/MLSFT/ED_DNK_S_INVOICE'. "#EC NOTEXT
**
**    CONSTANTS mv_message_header_signxml TYPE string VALUE 'Signed XML'.        "#EC NOTEXT
**    CONSTANTS external_address          TYPE string VALUE 'External Address'.   "#EC NOTEXT
**    CONSTANTS remote_mail_address       TYPE string VALUE 'Remote Mail Address'."#EC NOTEXT
**    CONSTANTS sap_logon_name            TYPE string VALUE 'SAP Logon Name'.     "#EC NOTEXT
**
**    " --- More doctypes / formats ---
**    CONSTANTS mv_doctype_b1 TYPE /MLSFT/ed_direct VALUE 'B1'. "#EC NOTEXT
**    CONSTANTS mv_doctype_bs TYPE /MLSFT/ed_direct VALUE 'BS'. "#EC NOTEXT
**    CONSTANTS mv_doctype_b2 TYPE /MLSFT/ed_direct VALUE 'B2'. "#EC NOTEXT
**
**    CONSTANTS mv_belgium_inv_xrechnung        TYPE string VALUE 'XRECHNUNG'. "#EC NOTEXT
**    CONSTANTS mv_doctype_ds                   TYPE /MLSFT/ed_direct VALUE 'DS'. "#EC NOTEXT
**    CONSTANTS mv_doctype_xml_pdf              TYPE string VALUE 'XML-PDF'. "#EC NOTEXT
**    CONSTANTS mv_doctype_json_pdf             TYPE string VALUE 'JSON-PDF'. "#EC NOTEXT
**    CONSTANTS mv_doctype_xml                  TYPE string VALUE 'XML'. "#EC NOTEXT
**    CONSTANTS mv_doctype_json                 TYPE string VALUE 'JSON'. "#EC NOTEXT
**    CONSTANTS mv_doctype_pdf                  TYPE string VALUE 'PDF'. "#EC NOTEXT
**    CONSTANTS partner_type_customer           TYPE string VALUE 'CUSTOMER'. "#EC NOTEXT
**    CONSTANTS partner_type_supplier           TYPE string VALUE 'SUPPLIER'. "#EC NOTEXT
**    CONSTANTS mv_doctype_zugferd_pdf          TYPE string VALUE 'ZUGFERD_PDF'. "#EC NOTEXT
**    CONSTANTS mv_doctype_company_invoice_ubl  TYPE string VALUE 'XRECHNUNG'. "#EC NOTEXT
**    CONSTANTS mv_doctype_domain               TYPE string VALUE '/MLSFT/ED_D_DIRECT'. "#EC NOTEXT
**    CONSTANTS mv_general_document             TYPE string VALUE '/MLSFT/GNRL_DOC'. "#EC NOTEXT
**    CONSTANTS mv_application_prog             TYPE string VALUE 'Application Programs'. "#EC NOTEXT
**    CONSTANTS mv_periodic_prog                TYPE string VALUE 'Periodic Programs'. "#EC NOTEXT
**    CONSTANTS mv_customizations               TYPE string VALUE 'Customizations'. "#EC NOTEXT
**
**    " --- RO e-Document types ---
**    CONSTANTS mc_ro_credb2b TYPE /MLSFT/ED_CHAR10 VALUE 'RO_CREDB2B'. "#EC NOTEXT
**    CONSTANTS mc_ro_credb2c TYPE /MLSFT/ED_CHAR10 VALUE 'RO_CREDB2C'. "#EC NOTEXT
**    CONSTANTS mc_ro_credb2g TYPE /MLSFT/ED_CHAR10 VALUE 'RO_CREDB2G'. "#EC NOTEXT
**    CONSTANTS mc_ro_invb2b  TYPE /MLSFT/ED_CHAR10 VALUE 'RO_INVB2B'.  "#EC NOTEXT
**    CONSTANTS mc_ro_invb2c  TYPE /MLSFT/ED_CHAR10 VALUE 'RO_INVB2C'.  "#EC NOTEXT
**    CONSTANTS mc_ro_invb2g  TYPE /MLSFT/ED_CHAR10 VALUE 'RO_INVB2G'.  "#EC NOTEXT
**    CONSTANTS mc_ro_invic   TYPE /MLSFT/ED_CHAR10 VALUE 'RO_INVIC'.   "#EC NOTEXT
**    CONSTANTS mc_ro_invsb   TYPE /MLSFT/ED_CHAR10 VALUE 'RO_INVSB'.   "#EC NOTEXT
**    CONSTANTS mc_ro_trreg   TYPE /MLSFT/ED_CHAR10 VALUE 'RO_TRREG'.   "#EC NOTEXT
**
**    " --- Action Groups ---
**    CONSTANTS mv_action_group_01 TYPE /MLSFT/ED_TYPE VALUE '01'. "#EC NOTEXT
**    CONSTANTS mv_action_group_02 TYPE /MLSFT/ED_TYPE VALUE '02'. "#EC NOTEXT
**    CONSTANTS mv_action_group_04 TYPE /MLSFT/ED_TYPE VALUE '04'. "#EC NOTEXT
**    CONSTANTS mv_action_group_05 TYPE /MLSFT/ED_TYPE VALUE '05'. "#EC NOTEXT
**    CONSTANTS mv_action_group_06 TYPE /MLSFT/ED_TYPE VALUE '06'. "#EC NOTEXT
**    CONSTANTS mv_action_group_07 TYPE /MLSFT/ED_TYPE VALUE '07'. "#EC NOTEXT
**    CONSTANTS mv_action_group_08 TYPE /MLSFT/ED_TYPE VALUE '08'. "#EC NOTEXT
**    CONSTANTS mv_action_group_09 TYPE /MLSFT/ED_TYPE VALUE '09'. "#EC NOTEXT
**    CONSTANTS mv_action_group_10 TYPE /MLSFT/ED_TYPE VALUE '10'. "#EC NOTEXT
**    CONSTANTS mv_action_group_11 TYPE /MLSFT/ED_TYPE VALUE '11'. "#EC NOTEXT
**    CONSTANTS mv_action_group_13 TYPE /MLSFT/ED_TYPE VALUE '13'. "#EC NOTEXT
**    CONSTANTS mv_action_group_14 TYPE /MLSFT/ED_TYPE VALUE '14'. "#EC NOTEXT
**    CONSTANTS mv_action_group_15 TYPE /MLSFT/ED_TYPE VALUE '15'. "#EC NOTEXT
**    CONSTANTS mv_action_group_16 TYPE /MLSFT/ED_TYPE VALUE '16'. "#EC NOTEXT
**    CONSTANTS mv_action_group_18 TYPE /MLSFT/ED_TYPE VALUE '18'. "#EC NOTEXT
**    CONSTANTS mv_action_group_19 TYPE /MLSFT/ED_TYPE VALUE '19'. "#EC NOTEXT
**    CONSTANTS mv_action_group_20 TYPE /MLSFT/ED_TYPE VALUE '20'. "#EC NOTEXT
**    CONSTANTS mv_action_group_22 TYPE /MLSFT/ED_TYPE VALUE '22'. "#EC NOTEXT
**    CONSTANTS mv_action_group_21 TYPE /MLSFT/ED_TYPE VALUE '21'. "#EC NOTEXT
**    CONSTANTS mv_action_group_23 TYPE /MLSFT/ED_TYPE VALUE '23'. "#EC NOTEXT
**
**    " --- Package names ---
**    CONSTANTS mv_einvoice_package   TYPE /MLSFT/GNRL_CUST_PACKAGE_NAME VALUE 'EI'.  "#EC NOTEXT
**    CONSTANTS mv_etransport_package TYPE /MLSFT/gnrl_cust_package_name  VALUE 'ET'.  "#EC NOTEXT
**    CONSTANTS mv_eledger_package    TYPE /MLSFT/gnrl_cust_package_name  VALUE 'EL'.  "#EC NOTEXT
**    CONSTANTS mv_gekap_package      TYPE /MLSFT/gnrl_cust_package_name  VALUE 'REC'. "#EC NOTEXT
**    CONSTANTS mv_saft_package       TYPE /MLSFT/gnrl_cust_package_name  VALUE 'SF'.  "#EC NOTEXT
**    CONSTANTS mv_inflation_package  TYPE /MLSFT/gnrl_cust_package_name  VALUE 'INF'. "#EC NOTEXT
**    CONSTANTS mv_package_of_tr      TYPE /MLSFT/gnrl_cust_package_name  VALUE 'TR'.  "#EC NOTEXT
**
**    " ========================= NEW: Action IDs =========================
**    " Public Cloud uyumlu controller çağrıları için Action kodları
**
**    " --- Inbound Actions ---
**    CONSTANTS mv_action_inbound_handle       TYPE /MLSFT/ED_DE_ACTION VALUE '24'. "#EC NOTEXT
**    CONSTANTS mv_action_inbound_parse        TYPE /MLSFT/ED_DE_ACTION VALUE '25'. "#EC NOTEXT
**    CONSTANTS mv_action_inbound_validate     TYPE /MLSFT/ED_DE_ACTION VALUE '26'. "#EC NOTEXT
**    CONSTANTS mv_action_inbound_store        TYPE /MLSFT/ED_DE_ACTION VALUE '27'. "#EC NOTEXT
**    CONSTANTS mv_action_inbound_show_pdf     TYPE /MLSFT/ED_DE_ACTION VALUE '28'. "#EC NOTEXT
***    CONSTANTS mv_action_inbound_down_pdf     TYPE /MLSFT/ED_DE_ACTION VALUE '29'. "#EC NOTEXT  " (mevcut)
**    CONSTANTS mv_action_inbound_acknowledge  TYPE /MLSFT/ED_DE_ACTION VALUE '30'. "#EC NOTEXT
**
**    " --- Outbound Actions ---
**    CONSTANTS mv_action_outbound_add_note     TYPE /MLSFT/ED_DE_ACTION VALUE '91'. "#EC NOTEXT
***    CONSTANTS mv_action_outbound_add_sei_note TYPE /MLSFT/ED_DE_ACTION VALUE '92'. "#EC NOTEXT
***    CONSTANTS mv_action_outbound_add_ger_note TYPE /MLSFT/ED_DE_ACTION VALUE '93'. "#EC NOTEXT
**    CONSTANTS mv_action_outbound_show_pdf     TYPE /MLSFT/ED_DE_ACTION VALUE '94'. "#EC NOTEXT
**    CONSTANTS mv_action_outbound_send_api     TYPE /MLSFT/ED_DE_ACTION VALUE '95'. "#EC NOTEXT

ENDCLASS.



CLASS /MLSFT/ED_CONSTANTS IMPLEMENTATION.
ENDCLASS.
