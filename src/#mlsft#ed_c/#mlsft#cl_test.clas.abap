CLASS /mlsft/cl_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.  "Console'dan çalıştırabilmek için
ENDCLASS.



CLASS /MLSFT/CL_TEST IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
" 📌 Rapor: ZLOAD_ED_PARAM
" Amaç: /MLSFT/ED_PARAM tablosuna toplu veri yüklemek
" Client: sy-mandt, SID: sy-sysid

DATA: lt_data TYPE STANDARD TABLE OF /mlsft/ed_param WITH DEFAULT KEY.

" Verileri ekle
APPEND VALUE #( client = sy-mandt param = 'ACT_DELAY' value = '' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ACT_TYPE' value = '3600' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ADD_ALLOW' value = '' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ADD_NOTE' value = '' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'AUTHENTICATE_REST_API' value = 'AUTHENTICATE_REST_API' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'AUTO_APRVL' value = 'AUTO APPROVAL' active = '' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'BALANCEID' value = 'KZ_CURRENT_BALANCE_ID' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'DLV_PARTY' value = '123' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'DOC_TYPE' value = 'SO' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'EXCHANGESERVICE_PORT' value = 'LP_DOCUMI_ITA_EXC_SRV' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'FI_INV' value = 'DR;KG;KR;DZ;RV' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'FI_INV_FI' value = 'RV' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'FI_INV_IT' value = 'RV' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'FI_INV_PL' value = 'KG;KR;DZ' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'FI_INV_RO' value = 'DR' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'FORMSF328' value = 'X' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'GOV_CURR' value = 'RSD' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'INB_ARSIVT' value = '' active = '' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'INVOICESSERVICE_PORT' value = 'LP_DOCUMI_ITA_INV_SRV' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'IN_DOC_TY' value = 'P2' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'IRBM_PAGESIZE' value = '50' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ISR_REQ_FORMAT' value = 'JSON' active = '' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ITEM_ALLOW' value = '' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ITEM_TAX' value = '' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'KZ_BATCH_C' value = 'KZ_PROD_ID_IN_STORE' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'KZ_CLASSID' value = 'BATCHCLASS023_A' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'KZ_DECL_NU' value = 'KZ_DECL_NUM' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'KZ_ESF_CH2' value = '60;61;62;63;67;03' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'KZ_ESF_DEL' value = '01;02;05' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'KZ_PK_ACT' value = 'X' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'KZ_PROD_NU' value = 'KZ_PROD_NUM_IN_DECL' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'KZ_SNT_CH1' value = '03;20;21;22;23;24;25' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'KZ_SNT_DEL' value = '01;02;05' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'KZ_WAITSGN' value = '7' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'MC_DOC_FORMAT_DYNAMICALLY' value = 'PDFASSOSOFTWARE' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ONAY_LOCAL' value = 'X' active = '' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ORIGINCODE' value = 'KZ_PROD_PHYS_MARK' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'OUT_DOC_TY' value = 'P1' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'PMEANS' value = '' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'PRT_ALL' value = 'LP01' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'PRT_COPY' value = 'X' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'READSOFT' value = 'SEND TO READSOFT' active = '' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'RESENTPROC' value = 'RD00' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ROMANIA_DT' value = '60' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ROMANIA_MESSAGE_LIST' value = 'E;R' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ROMANIA_PAGINATE_ENDPOINT' value = 'CALL PAGINATE ENDPOINT' active = '' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ROTR_MAIL_SUBJECT' value = 'E-TRANSPORT SYSTEM' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ROTR_OUT' value = '26' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ROTR_SMS_KEY' value = 'A8BA3DC4' active = '' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ROTR_SMS_SECRET' value = 'EAL3LKYITE7FCXRY' active = '' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ROT_PK_ACT' value = 'X' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'RSTR_WAITSGN' value = '7' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'SEND_MAIL' value = 'SERKAN.CETIN@MELASOFT.COM' active = '' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'SEND_MAIL_TO_CUSTOMER_OUT' value = '' active = '' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'SEND_MAIL_TO_RESPONSE_INBOUND' value = '' active = '' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'SEND_MAIL_TO_RESPONSE_INBOUND_PDF' value = 'X' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'SEND_MAIL_TO_RESPONSE_INBOUND_XML' value = '' active = '' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'SHOW_ATTAC' value = 'X' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'SYSTM_VRSN' value = '730' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'SYST_SYSID' value = 'MRP' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'S_VIM_PDF' value = '' active = '' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'S_VIM_XML' value = '' active = '' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'UPD_SIGNATURE' value = '1300' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'VIM_LOCAL' value = '' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'WAITSIGN_EGY' value = '30' active = 'X' ) TO lt_data.
APPEND VALUE #( client = sy-mandt param = 'ZSYSTEM' value = 'S4H' active = 'X' ) TO lt_data.

" 📤 Verileri tabloya yaz
TRY.
    INSERT /mlsft/ed_param FROM TABLE @lt_data.
    COMMIT WORK.
    out->write( |Toplam { lines( lt_data ) } kayıt başarıyla eklendi.| ).
  CATCH cx_sy_open_sql_db INTO DATA(lx).
    ROLLBACK WORK.
    out->write( |❌ SQL Hatası: { lx->get_text( ) }| ).
ENDTRY.

*  TYPES: BEGIN OF ty_ed_action,
*         mandt     TYPE mandt,          " ABAP otomatik doldurur
*         land1     TYPE land1,
*         doctype   TYPE c LENGTH 2,
*         action    TYPE c LENGTH 2,
*         class     TYPE c LENGTH 30,
*         method    TYPE c LENGTH 61,
*         function  TYPE c LENGTH 50,
*       END OF ty_ed_action.

*DATA: lt_data TYPE STANDARD TABLE OF /mlsft/ed_system WITH DEFAULT KEY.
* DELETE FROM /mlsft/ed_system.
*
*" 📥 Verileri ekle
*APPEND VALUE #( mandt = sy-mandt sysid = sy-sysid bukrs = 'AZER' istest = 'X' edespatch = '' edxmlarc = '' ctaxidfield = 'STCD1' vtaxidfield = 'STCD2' xtaxidfield = 'STCD3' taxloc = 'STCD1' logactive = 'X' ) TO lt_data.
*APPEND VALUE #( mandt = sy-mandt sysid = sy-sysid bukrs = 'BE01' istest = 'X' edespatch = '' edxmlarc = '' ctaxidfield = 'STCD2' vtaxidfield = 'STCD2' xtaxidfield = 'STCD2' taxloc = 'STCD2' logactive = 'X' ) TO lt_data.
*APPEND VALUE #( mandt = sy-mandt sysid = sy-sysid bukrs = 'DK01' istest = 'X' edespatch = '' edxmlarc = '' ctaxidfield = 'STCD2' vtaxidfield = 'STCD2' xtaxidfield = 'STCD2' taxloc = 'STCD2' logactive = 'X' ) TO lt_data.
*APPEND VALUE #( mandt = sy-mandt sysid = sy-sysid bukrs = 'EG01' istest = 'X' edespatch = '' edxmlarc = '' ctaxidfield = 'STCD2' vtaxidfield = 'STCD2' xtaxidfield = 'STCD2' taxloc = 'STCD1' logactive = 'X' ) TO lt_data.
*APPEND VALUE #( mandt = sy-mandt sysid = sy-sysid bukrs = 'FRC1' istest = 'X' edespatch = '' edxmlarc = '' ctaxidfield = 'STCD3' vtaxidfield = 'STCD2' xtaxidfield = 'STCD3' taxloc = 'STCD2' logactive = 'X' ) TO lt_data.
*APPEND VALUE #( mandt = sy-mandt sysid = sy-sysid bukrs = 'GER1' istest = 'X' edespatch = '' edxmlarc = '' ctaxidfield = 'STCEG' vtaxidfield = 'STCEG' xtaxidfield = 'STCEG' taxloc = 'STCD1' logactive = 'X' ) TO lt_data.
*APPEND VALUE #( mandt = sy-mandt sysid = sy-sysid bukrs = 'HR01' istest = 'X' edespatch = '' edxmlarc = '' ctaxidfield = 'STCD2' vtaxidfield = 'STCD2' xtaxidfield = 'STCD2' taxloc = 'STCD2' logactive = 'X' ) TO lt_data.
*APPEND VALUE #( mandt = sy-mandt sysid = sy-sysid bukrs = 'IT01' istest = 'X' edespatch = '' edxmlarc = '' ctaxidfield = 'STCD2' vtaxidfield = 'STCD2' xtaxidfield = 'STCD2' taxloc = 'STCD2' logactive = 'X' ) TO lt_data.
*APPEND VALUE #( mandt = sy-mandt sysid = sy-sysid bukrs = 'JRDN' istest = 'X' edespatch = '' edxmlarc = '' ctaxidfield = 'STCD1' vtaxidfield = 'STCD1' xtaxidfield = 'STCD1' taxloc = 'STCD1' logactive = 'X' ) TO lt_data.
*APPEND VALUE #( mandt = sy-mandt sysid = sy-sysid bukrs = 'P100' istest = ''  edespatch = '' edxmlarc = '' ctaxidfield = 'STCD2' vtaxidfield = 'STCD2' xtaxidfield = 'STCD2' taxloc = 'STCD2' logactive = 'X' ) TO lt_data.
*APPEND VALUE #( mandt = sy-mandt sysid = sy-sysid bukrs = 'RO01' istest = 'X' edespatch = '' edxmlarc = '' ctaxidfield = 'STCD1' vtaxidfield = 'STCD2' xtaxidfield = 'STCD2' taxloc = 'STCD2' logactive = 'X' ) TO lt_data.
*APPEND VALUE #( mandt = sy-mandt sysid = sy-sysid bukrs = 'ROMN' istest = ''  edespatch = '' edxmlarc = '' ctaxidfield = 'STCD1' vtaxidfield = 'STCD2' xtaxidfield = 'STCD2' taxloc = 'STCD1' logactive = 'X' ) TO lt_data.
*APPEND VALUE #( mandt = sy-mandt sysid = sy-sysid bukrs = 'SA01' istest = 'X' edespatch = '' edxmlarc = '' ctaxidfield = 'STCD2' vtaxidfield = 'STCD2' xtaxidfield = 'STCD2' taxloc = 'STCD1' logactive = 'X' ) TO lt_data.
*APPEND VALUE #( mandt = sy-mandt sysid = sy-sysid bukrs = 'SC01' istest = 'X' edespatch = '' edxmlarc = '' ctaxidfield = 'STCD2' vtaxidfield = 'STCD2' xtaxidfield = 'STCD2' taxloc = 'STCD1' logactive = 'X' ) TO lt_data.
*APPEND VALUE #( mandt = sy-mandt sysid = sy-sysid bukrs = 'TR01' istest = 'X' edespatch = '' edxmlarc = '' ctaxidfield = 'STCD2' vtaxidfield = 'STCD2' xtaxidfield = 'STCD2' taxloc = 'STCD2' logactive = 'X' ) TO lt_data.
*APPEND VALUE #( mandt = sy-mandt sysid = sy-sysid bukrs = '1000' istest = '' edespatch = '' edxmlarc = '' ctaxidfield = 'STCD1' vtaxidfield = 'STCD2' xtaxidfield = 'STCD3' taxloc = 'STCD2' logactive = 'X' ) TO lt_data.
*
*" 📤 Verileri tabloya yaz
*TRY.
*    INSERT /mlsft/ed_system FROM TABLE @lt_data.
*    COMMIT WORK.
*    out->write( |Toplam { lines( lt_data ) } kayıt başarıyla eklendi.| ).
*  CATCH cx_sy_open_sql_db INTO DATA(lx).
*    ROLLBACK WORK.
*    out->write( |❌ SQL Hatası: { lx->get_text( ) }| ).
*ENDTRY.

*" 🧱 Kayıtlar
*" Format: land1, doctype, action, class, method, function(optional)
*DELETE FROM /mlsft/ed_action.
*
*APPEND VALUE #( land1 = 'AZ' doctype = 'A3' action = '1'  class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'OUT_SEND_INVOICE' )            TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A3' action = '2'  class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'OUT_CHECK_INVOICE' )           TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A3' action = '3'  class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'OUT_CANCEL_INVOICE' )          TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A3' action = '6'  class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'OUT_SHOW_PDF_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A3' action = '7'  class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'OUT_DOWNLOAD_HTML_INVOICE' )   TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A3' action = '8'  class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'OUT_DOWNLOAD_XML_INVOICE' )    TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A3' action = '9'  class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'OUT_DOWNLOAD_PDF_INVOICE' )    TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A3' action = '10' class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'OUT_SEND_ATTACHMENT_MAIL' )    TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A3' action = '11' class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'OUT_ADD_NOTE' )                TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A3' action = '12' class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'OUT_ATTACH_TO_DOCUMENT' )      TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A3' action = '43' class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'ACTION_AZER_ERROR_IMAGE' )     TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A4' action = '23' class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'IN_CHECK_INVOICE' )            TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A4' action = '26' class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'IN_SHOW_PDF_INVOICE' )         TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A4' action = '27' class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'IN_DOWNLOAD_HTML_INVOICE' )    TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A4' action = '28' class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'IN_DOWNLOAD_XML_INVOICE' )     TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A4' action = '29' class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'IN_DOWNLOAD_PDF_INVOICE' )     TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A4' action = '31' class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'IN_SEND_ATTACHMENT_MAIL' )     TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A4' action = '32' class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'IN_SAVE_MM_RECORD' )           TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A4' action = '33' class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'IN_SAVE_FI_RECORD' )           TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A4' action = '34' class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'IN_SHOW_ATTACH_DOCUMENT' )     TO lt_data.
*APPEND VALUE #( land1 = 'AZ' doctype = 'A4' action = '36' class = '/MLSFT/ED_AZR_SERVICE_LAYER' method = 'IN_GET_INVOICE_LISTE' )        TO lt_data.
*
*APPEND VALUE #( land1 = 'BE' doctype = ''   action = '63' class = '/MLSFT/ED_ROMANIA_GAAS_SRV_LYR' method = 'GET_BULK_PDF' )            TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B1' action = '1'  class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'OUT_SEND_INVOICE' )         TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B1' action = '2'  class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'OUT_CHECK_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B1' action = '6'  class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'OUT_SHOW_PDF_INVOICE' )     TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B1' action = '7'  class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'OUT_DOWNLOAD_HTML_INVOICE') TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B1' action = '8'  class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'OUT_DOWNLOAD_XML_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B1' action = '9'  class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'OUT_DOWNLOAD_PDF_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B1' action = '10' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'OUT_SEND_ATTACHMENT_MAIL' ) TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B1' action = '11' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'OUT_ADD_NOTE' )             TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B1' action = '12' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'OUT_ATTACH_TO_DOCUMENT' )   TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B2' action = '21' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_ACCEPT_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B2' action = '22' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_REJECT_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B2' action = '23' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_CHECK_INVOICE' )         TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B2' action = '26' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_SHOW_PDF_INVOICE' )      TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B2' action = '27' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_DOWNLOAD_HTML_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B2' action = '28' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_DOWNLOAD_XML_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B2' action = '29' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_DOWNLOAD_PDF_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B2' action = '31' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_SEND_ATTACHMENT_MAIL' )  TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B2' action = '32' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_SAVE_MM_RECORD' )        TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B2' action = '33' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_SAVE_FI_RECORD' )        TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B2' action = '34' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_SHOW_ATTACH_DOCUMENT' )  TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B2' action = '36' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_GET_INVOICE_LISTE' )     TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'B2' action = '42' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_MARK_AS_HANDLED' )       TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'BS' action = '21' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_ACCEPT_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'BS' action = '22' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_REJECT_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'BS' action = '23' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_CHECK_INVOICE' )         TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'BS' action = '26' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_SHOW_PDF_INVOICE' )      TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'BS' action = '27' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_DOWNLOAD_HTML_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'BS' action = '28' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_DOWNLOAD_XML_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'BS' action = '29' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_DOWNLOAD_PDF_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'BS' action = '31' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_SEND_ATTACHMENT_MAIL' )  TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'BS' action = '32' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_SAVE_MM_RECORD' )        TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'BS' action = '33' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_SAVE_FI_RECORD' )        TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'BS' action = '34' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_SHOW_ATTACH_DOCUMENT' )  TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'BS' action = '36' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_GET_INVOICE_LISTE' )     TO lt_data.
*APPEND VALUE #( land1 = 'BE' doctype = 'BS' action = '42' class = '/MLSFT/ED_BELGIUM_SERVICE_LYR' method = 'IN_MARK_AS_HANDLED' )       TO lt_data.
*
*" (Devam: DE, DK, EG, FI, FR, HR, IL, IT, JO, MY, PL, RO, SA, TR ...)
*" --- Almanya (DE) ---
*APPEND VALUE #( land1 = 'DE' doctype = 'DI' action = '21' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_ACCEPT_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DI' action = '22' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_REJECT_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DI' action = '23' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_CHECK_INVOICE' )         TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DI' action = '26' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_SHOW_PDF_INVOICE' )      TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DI' action = '27' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_DOWNLOAD_HTML_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DI' action = '28' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_DOWNLOAD_XML_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DI' action = '29' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_DOWNLOAD_PDF_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DI' action = '31' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_SEND_ATTACHMENT_MAIL' )  TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DI' action = '32' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_SAVE_MM_RECORD' )        TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DI' action = '33' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_SAVE_FI_RECORD' )        TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DI' action = '34' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_SHOW_ATTACH_DOCUMENT' )  TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DI' action = '36' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_GET_INVOICE_LISTE' )     TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DI' action = '42' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_MARK_AS_HANDLED' )       TO lt_data.
*
*APPEND VALUE #( land1 = 'DE' doctype = 'DO' action = '1'  class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_SEND_INVOICE' )         TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DO' action = '2'  class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_CHECK_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DO' action = '6'  class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_SHOW_PDF_INVOICE' )     TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DO' action = '7'  class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_DOWNLOAD_HTML_INVOICE') TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DO' action = '8'  class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_DOWNLOAD_XML_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DO' action = '9'  class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_DOWNLOAD_PDF_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DO' action = '10' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_SEND_ATTACHMENT_MAIL' ) TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DO' action = '11' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_ADD_NOTE' )             TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DO' action = '12' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_ATTACH_TO_DOCUMENT' )   TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DO' action = '47' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_SEND_MAIL_VIA_PORTAL' ) TO lt_data.
*
*APPEND VALUE #( land1 = 'DE' doctype = 'DS' action = '23' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_CHECK_INVOICE' )         TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DS' action = '26' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_SHOW_PDF_INVOICE' )      TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DS' action = '28' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_DOWNLOAD_XML_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DS' action = '29' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_DOWNLOAD_PDF_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DS' action = '31' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_SEND_ATTACHMENT_MAIL' )  TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DS' action = '32' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_SAVE_MM_RECORD' )        TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DS' action = '33' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_SAVE_FI_RECORD' )        TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DS' action = '34' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_SHOW_ATTACH_DOCUMENT' )  TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DS' action = '36' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_GET_INVOICE_LISTE' )     TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DS' action = '42' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_MARK_AS_HANDLED' )       TO lt_data.
*
*APPEND VALUE #( land1 = 'DE' doctype = 'DY' action = '23' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_CHECK_INVOICE' )         TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DY' action = '26' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_SHOW_PDF_INVOICE' )      TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DY' action = '27' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_DOWNLOAD_HTML_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DY' action = '28' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_DOWNLOAD_XML_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DY' action = '29' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_DOWNLOAD_PDF_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DY' action = '31' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_SEND_ATTACHMENT_MAIL' )  TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DY' action = '32' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_SAVE_MM_RECORD' )        TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DY' action = '33' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_SAVE_FI_RECORD' )        TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DY' action = '34' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_SHOW_ATTACH_DOCUMENT' )  TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DY' action = '36' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_GET_INVOICE_LISTE' )     TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DY' action = '42' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'IN_MARK_AS_HANDLED' )       TO lt_data.
*
*APPEND VALUE #( land1 = 'DE' doctype = 'DZ' action = '1'  class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_SEND_INVOICE' )         TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DZ' action = '2'  class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_CHECK_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DZ' action = '6'  class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_SHOW_PDF_INVOICE' )     TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DZ' action = '7'  class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_DOWNLOAD_HTML_INVOICE') TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DZ' action = '8'  class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_DOWNLOAD_XML_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DZ' action = '9'  class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_DOWNLOAD_PDF_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DZ' action = '10' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_SEND_ATTACHMENT_MAIL' ) TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DZ' action = '11' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_ADD_NOTE' )             TO lt_data.
*APPEND VALUE #( land1 = 'DE' doctype = 'DZ' action = '12' class = '/MLSFT/ED_GERMANY_SERVICE_LYR' method = 'OUT_ATTACH_TO_DOCUMENT' )   TO lt_data.
*
*" --- Danimarka (DK) ---
*APPEND VALUE #( land1 = 'DK' doctype = 'BS' action = '21' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_ACCEPT_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'BS' action = '22' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_REJECT_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'BS' action = '23' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_CHECK_INVOICE' )         TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'BS' action = '26' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_SHOW_PDF_INVOICE' )      TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'BS' action = '27' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_DOWNLOAD_HTML_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'BS' action = '28' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_DOWNLOAD_XML_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'BS' action = '29' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_DOWNLOAD_PDF_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'BS' action = '31' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_SEND_ATTACHMENT_MAIL' )  TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'BS' action = '32' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_SAVE_MM_RECORD' )        TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'BS' action = '33' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_SAVE_FI_RECORD' )        TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'BS' action = '34' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_SHOW_ATTACH_DOCUMENT' )  TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'BS' action = '36' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_GET_INVOICE_LISTE' )     TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'BS' action = '42' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_MARK_AS_HANDLED' )       TO lt_data.
*
*APPEND VALUE #( land1 = 'DK' doctype = 'D1' action = '1'  class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'OUT_SEND_INVOICE' )         TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D1' action = '2'  class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'OUT_CHECK_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D1' action = '6'  class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'OUT_SHOW_PDF_INVOICE' )     TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D1' action = '7'  class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'OUT_DOWNLOAD_HTML_INVOICE') TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D1' action = '8'  class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'OUT_DOWNLOAD_XML_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D1' action = '9'  class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'OUT_DOWNLOAD_PDF_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D1' action = '10' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'OUT_SEND_ATTACHMENT_MAIL' ) TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D1' action = '11' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'OUT_ADD_NOTE' )             TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D1' action = '12' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'OUT_ATTACH_TO_DOCUMENT' )   TO lt_data.
*
*APPEND VALUE #( land1 = 'DK' doctype = 'D2' action = '21' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_ACCEPT_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D2' action = '22' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_REJECT_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D2' action = '23' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_CHECK_INVOICE' )         TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D2' action = '26' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_SHOW_PDF_INVOICE' )      TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D2' action = '27' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_DOWNLOAD_HTML_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D2' action = '28' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_DOWNLOAD_XML_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D2' action = '29' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_DOWNLOAD_PDF_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D2' action = '31' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_SEND_ATTACHMENT_MAIL' )  TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D2' action = '32' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_SAVE_MM_RECORD' )        TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D2' action = '33' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_SAVE_FI_RECORD' )        TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D2' action = '34' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_SHOW_ATTACH_DOCUMENT' )  TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D2' action = '36' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_GET_INVOICE_LISTE' )     TO lt_data.
*APPEND VALUE #( land1 = 'DK' doctype = 'D2' action = '42' class = '/MLSFT/ED_DENMARK_SERVICE_LYR' method = 'IN_MARK_AS_HANDLED' )       TO lt_data.
*
*" --- Mısır (EG) ---
*APPEND VALUE #( land1 = 'EG' doctype = 'E1' action = '1'  class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'OUT_SEND_INVOICE' )          TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E1' action = '2'  class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'OUT_CHECK_INVOICE' )         TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E1' action = '3'  class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'OUT_CANCEL_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E1' action = '6'  class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'OUT_SHOW_PDF_INVOICE' )      TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E1' action = '7'  class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'OUT_DOWNLOAD_HTML_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E1' action = '8'  class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'OUT_DOWNLOAD_XML_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E1' action = '9'  class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'OUT_DOWNLOAD_PDF_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E1' action = '10' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'OUT_SEND_ATTACHMENT_MAIL' )  TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E1' action = '11' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'OUT_ADD_NOTE' )              TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E1' action = '12' class = '/MLSFT/ED_SERBIA_GOV_SERV_LYR'  method = 'OUT_ATTACH_TO_DOCUMENT' )  TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E1' action = '13' class = '/MLSFT/ED_SERBIA_SERVICE_LAYER' method = 'GET_ALLCOMPANIES' )        TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E1' action = '15' class = '/MLSFT/ED_SERBIA_GOV_SERV_LYR'  method = 'CHECK_COMPANY_REGIS_ONEFAKTURA' ) TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E1' action = '16' class = '/MLSFT/ED_SERBIA_GOV_SERV_LYR'  method = 'OUT_STORNO_CANCEL' )       TO lt_data.
*
*APPEND VALUE #( land1 = 'EG' doctype = 'E2' action = '21' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'IN_ACCEPT_INVOICE' )         TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E2' action = '22' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'IN_REJECT_INVOICE' )         TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E2' action = '23' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'IN_CHECK_INVOICE' )          TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E2' action = '26' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'IN_SHOW_PDF_INVOICE' )       TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E2' action = '27' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'IN_DOWNLOAD_HTML_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E2' action = '28' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'IN_DOWNLOAD_XML_INVOICE' )   TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E2' action = '29' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'IN_DOWNLOAD_PDF_INVOICE' )   TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E2' action = '30' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'IN_SEND_PDF_TO_VIM_INVOICE') TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E2' action = '31' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'IN_SEND_ATTACHMENT_MAIL' )   TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E2' action = '32' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'IN_SAVE_MM_RECORD' )         TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E2' action = '33' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'IN_SAVE_FI_RECORD' )         TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E2' action = '34' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'IN_SHOW_ATTACH_DOCUMENT' )   TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E2' action = '35' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'IN_GET_INVOICE' )            TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E2' action = '36' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'IN_SEARCH_DOCUMENTS' )       TO lt_data.
*APPEND VALUE #( land1 = 'EG' doctype = 'E2' action = '37' class = '/MLSFT/ED_EGYPT_GOV_SERV_LYR' method = 'IN_SEND_ATTACHMENT_MAIL_ONAY' ) TO lt_data.
*
*" --- Finlandiya (FI) ---
*APPEND VALUE #( land1 = 'FI' doctype = 'F1' action = '1'  class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'OUT_SEND_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F1' action = '2'  class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'OUT_CHECK_INVOICE' )       TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F1' action = '6'  class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'OUT_SHOW_PDF_INVOICE' )    TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F1' action = '7'  class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'OUT_DOWNLOAD_HTML_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F1' action = '8'  class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'OUT_DOWNLOAD_XML_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F1' action = '9'  class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'OUT_DOWNLOAD_PDF_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F1' action = '10' class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'OUT_SEND_ATTACHMENT_MAIL' ) TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F1' action = '11' class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'OUT_ADD_NOTE' )            TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F1' action = '12' class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'OUT_ATTACH_TO_DOCUMENT' )  TO lt_data.
*
*APPEND VALUE #( land1 = 'FI' doctype = 'F2' action = '23' class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'IN_CHECK_INVOICE' )        TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F2' action = '26' class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'IN_SHOW_PDF_INVOICE' )     TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F2' action = '27' class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'IN_DOWNLOAD_HTML_INVOICE') TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F2' action = '28' class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'IN_DOWNLOAD_XML_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F2' action = '29' class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'IN_DOWNLOAD_PDF_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F2' action = '31' class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'IN_SEND_ATTACHMENT_MAIL' ) TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F2' action = '32' class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'IN_SAVE_MM_RECORD' )       TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F2' action = '33' class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'IN_SAVE_FI_RECORD' )       TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F2' action = '34' class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'IN_SHOW_ATTACH_DOCUMENT' ) TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F2' action = '36' class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'IN_GET_INVOICE_LISTE' )    TO lt_data.
*APPEND VALUE #( land1 = 'FI' doctype = 'F2' action = '42' class = '/MLSFT/ED_FIN_MAVENTA_SERV_LYR' method = 'IN_MARK_AS_HANDLED' )      TO lt_data.
*
*" --- Fransa (FR) (kısaltıldı: tüm girdiler eklenecek) ---
*APPEND VALUE #( land1 = 'FR' doctype = 'FI' action = '23' class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'IN_CHECK_INVOICE' )          TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FI' action = '26' class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'IN_SHOW_PDF_INVOICE' )       TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FI' action = '27' class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'IN_DOWNLOAD_HTML_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FI' action = '28' class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'IN_DOWNLOAD_XML_INVOICE' )   TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FI' action = '29' class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'IN_DOWNLOAD_PDF_INVOICE' )   TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FI' action = '31' class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'IN_SEND_ATTACHMENT_MAIL' )   TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FI' action = '32' class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'IN_SAVE_MM_RECORD' )         TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FI' action = '33' class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'IN_SAVE_FI_RECORD' )         TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FI' action = '34' class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'IN_SHOW_ATTACH_DOCUMENT' )   TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FI' action = '36' class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'IN_GET_INVOICE_LISTE' )      TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FI' action = '42' class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'IN_MARK_AS_HANDLED' )        TO lt_data.
*
*APPEND VALUE #( land1 = 'FR' doctype = 'FO' action = '1'  class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'OUT_SEND_INVOICE' )          TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FO' action = '2'  class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'OUT_CHECK_INVOICE' )         TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FO' action = '6'  class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'OUT_SHOW_PDF_INVOICE' )      TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FO' action = '7'  class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'OUT_DOWNLOAD_HTML_INVOICE' ) TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FO' action = '8'  class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'OUT_DOWNLOAD_XML_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FO' action = '9'  class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'OUT_DOWNLOAD_PDF_INVOICE' )  TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FO' action = '10' class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'OUT_SEND_ATTACHMENT_MAIL' )  TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FO' action = '11' class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'OUT_ADD_NOTE' )              TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FO' action = '12' class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'OUT_ATTACH_TO_DOCUMENT' )    TO lt_data.
*APPEND VALUE #( land1 = 'FR' doctype = 'FO' action = '47' class = '/MLSFT/ED_FRANCE_SERVICE_LYR' method = 'OUT_SEND_MAIL_VIA_PORTAL' )  TO lt_data.
*
*" (Fransa FY, FZ ve diğer ülkelerin tamamı eklenebilir; yer kısıtından ötürü parçalı eklendi.)
*
*" 📥 Verileri tabloya yaz
*TRY.
*    INSERT /mlsft/ed_action FROM TABLE @lt_data.
*    COMMIT WORK.
*    out->write( |Veriler başarıyla eklendi: { lines( lt_data ) } kayıt.| ).
*  CATCH cx_sy_open_sql_db INTO DATA(lx).
*    ROLLBACK WORK.
*    out->write( |SQL Hatası:: { lines( lt_data ) } kayıt.| ).
*ENDTRY.

" Mevcut kayıtları sil
*DELETE FROM /mlsft/ed_alvclr.
*
*    DATA lt_data TYPE STANDARD TABLE OF /mlsft/ed_alvclr WITH EMPTY KEY.
*
*    " 🟡 Bekleyen veya oluşturulan durumlar
*    APPEND VALUE #( status = '01' alvtext = `SAP'de Oluşturuldu`              alvcol = 'Y' ) TO lt_data.
*    APPEND VALUE #( status = '02' alvtext = `Entegratör Gönderildi`           alvcol = 'Y' ) TO lt_data.
*    APPEND VALUE #( status = '03' alvtext = `İşlem Bekliyor`                  alvcol = 'Y' ) TO lt_data.
*    APPEND VALUE #( status = '06' alvtext = `Yeniden Gönderim`               alvcol = 'Y' ) TO lt_data.
*    APPEND VALUE #( status = '20' alvtext = `Receipt oluşturuldu`            alvcol = 'Y' ) TO lt_data.
*    APPEND VALUE #( status = '21' alvtext = `Receipt gönderildi`             alvcol = 'Y' ) TO lt_data.
*    APPEND VALUE #( status = '23' alvtext = `SNT Oluşturuldu`                alvcol = 'Y' ) TO lt_data.
*    APPEND VALUE #( status = '33' alvtext = `VIM'e gönderildi`               alvcol = 'Y' ) TO lt_data.
*
*    " 🟢 Başarılı veya onaylı durumlar
*    APPEND VALUE #( status = '04' alvtext = `İşlem Sonlandı`                  alvcol = 'G' ) TO lt_data.
*    APPEND VALUE #( status = '12' alvtext = `Yanıt Alındı`                    alvcol = 'G' ) TO lt_data.
*    APPEND VALUE #( status = '26' alvtext = `SNT Onaylandı`                  alvcol = 'G' ) TO lt_data.
*    APPEND VALUE #( status = '29' alvtext = `Onaylandı`                      alvcol = 'G' ) TO lt_data.
*    APPEND VALUE #( status = '65' alvtext = `Autofactura`                    alvcol = 'G' ) TO lt_data.
*
*    " 🔴 Hatalı / iptal edilmiş durumlar
*    APPEND VALUE #( status = '05' alvtext = `Hatalı`                          alvcol = 'R' ) TO lt_data.
*    APPEND VALUE #( status = '09' alvtext = `İptal`                           alvcol = 'R' ) TO lt_data.
*    APPEND VALUE #( status = '22' alvtext = `Receipt silindi`                alvcol = 'R' ) TO lt_data.
*    APPEND VALUE #( status = '30' alvtext = `Rededildi`                      alvcol = 'R' ) TO lt_data.
*    APPEND VALUE #( status = '31' alvtext = `Silindi`                         alvcol = 'R' ) TO lt_data.
*    APPEND VALUE #( status = '63' alvtext = `Bloke Edildi (Vergi)`           alvcol = 'R' ) TO lt_data.
*
*    " 📥 Verileri tabloya yaz
*    INSERT /mlsft/ed_alvclr FROM TABLE @lt_data.
*
*    out->write( |Toplam { lines( lt_data ) } kayıt başarıyla eklendi.| ).
*    DELETE FROM /mlsft/ed_alvclr.
*
*    " Örnek veriler
*    DATA lt_data TYPE STANDARD TABLE OF /mlsft/ed_alvclr WITH EMPTY KEY.
*
*    APPEND VALUE #( status = 'NEW'   alvcol = 'Y' ) TO lt_data.
*    APPEND VALUE #( status = 'ERROR' alvcol = 'R' ) TO lt_data.
*    APPEND VALUE #( status = 'OK'    alvcol = 'G' ) TO lt_data.
*    APPEND VALUE #( status = 'INFO'  alvcol = 'B' ) TO lt_data.
*
*    " Verileri ekle
*    INSERT /mlsft/ed_alvclr FROM TABLE @lt_data.

*    out->write( |Veriler başarıyla eklendi: { lines( lt_data ) } kayıt.| ).
*    DATA: ls_raw    TYPE /mlsft/ed_raw,
*          lv_hex    TYPE string,
*          lv_bin    TYPE xstring,
*          len       TYPE i,
*          pos       TYPE i,
*          c1        TYPE c LENGTH 1,
*          c2        TYPE c LENGTH 1,
*          n1        TYPE i,
*          n2        TYPE i,
*          bval      TYPE i,
*          lv_byte   TYPE x LENGTH 1,
*          lv_docs_s TYPE string.
*
*    ls_raw-client = sy-mandt.
*    ls_raw-docnum = 'EEEB07FDF8F6FDF1B421AC473E2DB24F'.
*
*    lv_hex = '3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574662D38223F3E0A3C655472616E73706F727420786D6C6E733D226D66703A616E'.
*
*    ls_raw-binary = '3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574662D38223F3E0A3C655472616E73706F727420786D6C6E733D226D66703A616E6166'.
*
*    lv_docs_s = '1.785'.
*
*    INSERT /mlsft/ed_raw FROM @ls_raw.
*    COMMIT WORK.
*DATA ls_ref TYPE /mlsft/ed_ref.
*
*ls_ref-client = sy-mandt.
*ls_ref-docnum = 'EEEB07FDF8F6FDF1B421AC473E2DB24F'.
*
*ls_ref-vbelv     = '80000525'.
*ls_ref-vbtyp     = 'J'.
*ls_ref-delv_num  = '80000525'.
*ls_ref-gibid     = '5W9L3N4J3N5X7D21'.
*ls_ref-bukrs     = 'ROMN'.
*ls_ref-uuid      = 'AC473E2D-B24F-1EEE-BAE0-FFBF1EDF9421'.
*ls_ref-partner   = '5009622171'.
*ls_ref-ptype     = 'C'.
*
*ls_ref-waers = 'EUR'.
*
*ls_ref-lineextensionamount = '0'.
*ls_ref-taxexclusiveamount  = '0'.
*ls_ref-taxinclusiveamount  = '0'.
*ls_ref-payableamount       = '0'.
*ls_ref-exciseamount        = '0'.
*ls_ref-taxamount           = '0'.
*
*INSERT /mlsft/ed_ref FROM @ls_ref.
*    COMMIT WORK.

*    " /mlsft/ed_head: tek kayıt ekle/güncelle (upsert)
*    DATA ls_head TYPE /mlsft/ed_head.
*
*    " --- ZORUNLU ANAHTARLAR ---
*    ls_head-client = sy-mandt.
*    ls_head-docnum = 'EEEB07FDF8F6FDF1B421AC473E2DB24F'.
*    ls_head-doctype       = 'J'.
*    ls_head-refdoc        = '80000525'.
*    ls_head-reftype       = '1'.
*    ls_head-refgrup       = 'ROM1'.
*    ls_head-jahr          = sy-datum(4). " yıl
*    ls_head-created_by    = sy-uname.
*    ls_head-creation_date = sy-datum.
*    ls_head-creation_time = sy-uzeit.
*    ls_head-lstatus = 'LF'.
*    ls_head-sstatus = 'R001'.
*
*    INSERT /mlsft/ed_head FROM @ls_head.
*    COMMIT WORK.


  ENDMETHOD.
ENDCLASS.
