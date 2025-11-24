CLASS /MLSFT/ED_PARTNER DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_partno TYPE char10
        iv_type   TYPE char1.

    METHODS ewaybill_partner
      RETURNING VALUE(rv_value) TYPE char1.

    METHODS fill_bobf_node_info
      CHANGING
        cs_customer TYPE REF TO /mlsft/ed_d_customer.

  PROTECTED SECTION.
  PRIVATE SECTION.

*   " On-Prem alanlar (ESKİ) ------------------------------
*   DATA ms_adrc      TYPE adrc.
*   DATA ms_kna1      TYPE kna1.
*   DATA ms_lfa1      TYPE lfa1.
*   DATA mv_addrnumber TYPE adrnr.
*   " -----------------------------------------------------

    " Public Cloud veri tamponları
**    DATA mv_bp                TYPE bu_partner.               " Business Partner ID
**    DATA ms_bp_addr           TYPE I_BusinessPartnerAddress. " Varsayılan/ilk adres
    DATA mv_is_customer       TYPE abap_bool.
    DATA mv_is_supplier       TYPE abap_bool.

ENDCLASS.



CLASS /MLSFT/ED_PARTNER IMPLEMENTATION.


  METHOD constructor.

**    CLEAR: mv_bp, ms_bp_addr, mv_is_customer, mv_is_supplier.
    mv_is_customer = abap_false.
    mv_is_supplier = abap_false.

    " Partner türünü eski sabitlerle eşle
*   CASE iv_type.
*     WHEN /mlsag/ed_constants=>customer.
*       SELECT SINGLE * FROM kna1 INTO ms_kna1 WHERE kunnr = iv_partno.
*       mv_addrnumber = ms_kna1-adrnr.
*     WHEN /mlsag/ed_constants=>vendor.
*       SELECT SINGLE * FROM lfa1 INTO ms_lfa1 WHERE lifnr = iv_partno.
*       mv_addrnumber = ms_lfa1-adrnr.
*   ENDCASE.
*   SELECT SINGLE * FROM adrc INTO ms_adrc WHERE addrnumber = mv_addrnumber.

    " ↪ Public Cloud: I_Customer / I_Supplier üzerinden BP’yi bul
    IF iv_type = /mlsft/ed_constants=>customer.
**      SELECT SINGLE BusinessPartner
**        FROM I_Customer
**        WHERE Customer = @iv_partno
**        INTO @mv_bp.
      IF sy-subrc = 0.
        mv_is_customer = abap_true.
      ENDIF.
    ELSEIF iv_type = /mlsft/ed_constants=>vendor.
**      SELECT SINGLE BusinessPartner
**        FROM I_Supplier
**        WHERE Supplier = @iv_partno
**        INTO @mv_bp.
      IF sy-subrc = 0.
        mv_is_supplier = abap_true.
      ENDIF.
    ENDIF.

    " Varsayılan (standart) adresi al; yoksa ilk adres
**    IF mv_bp IS NOT INITIAL.
      " Önce standart adresi dene
**      SELECT SINGLE *
**        FROM I_BusinessPartnerAddress
**        WHERE BusinessPartner           = @mv_bp
**          AND StandardAddressIndicator  = @abap_true
**        INTO @ms_bp_addr.

      IF sy-subrc <> 0.
        " Standart yoksa ilk adres kaydını al
**        SELECT SINGLE *
**          FROM I_BusinessPartnerAddress
**          WHERE BusinessPartner = @mv_bp
**          INTO @ms_bp_addr.
      ENDIF.
**    ENDIF.

  ENDMETHOD.


  METHOD ewaybill_partner.
    " Test/varsayılan: tüm partnerlar e-irsaliyeye dahildir
    rv_value = 'X'.
  ENDMETHOD.


  METHOD fill_bobf_node_info.

    " Eski mantık (on-prem) — YORUMDA TUTULDU
*   cs_customer->adrnr = ms_adrc-addrnumber.
*
*   IF  ms_kna1 IS NOT INITIAL.
*     cs_customer->partner = ms_kna1-kunnr.
*     cs_customer->type    = /mlsag/ed_constants=>customer.
*     cs_customer->land1   = ms_kna1-land1.
*     cs_customer->ort01   = ms_kna1-ort01.
*     cs_customer->pstlz   = ms_kna1-pstlz.
*     cs_customer->stras   = ms_kna1-stras.
*     cs_customer->regio   = ms_kna1-regio.
*     cs_customer->sortl   = ms_kna1-sortl.
*     cs_customer->telf1   = ms_kna1-telf1.
*     cs_customer->telfx   = ms_kna1-telfx.
*     cs_customer->xcpdk   = ms_kna1-xcpdk.
*   ELSEIF ms_lfa1 IS NOT INITIAL.
*     cs_customer->partner = ms_lfa1-lifnr.
*     cs_customer->type    = /mlsag/ed_constants=>vendor.
*     cs_customer->land1   = ms_lfa1-land1.
*     cs_customer->ort01   = ms_lfa1-ort01.
*     cs_customer->pstlz   = ms_lfa1-pstlz.
*     cs_customer->stras   = ms_lfa1-stras.
*     cs_customer->regio   = ms_lfa1-regio.
*     cs_customer->sortl   = ms_lfa1-sortl.
*     cs_customer->telf1   = ms_lfa1-telf1.
*     cs_customer->telfx   = ms_lfa1-telfx.
*     cs_customer->xcpdk   = ms_lfa1-xcpdk.
*   ENDIF.
*   cs_customer->name1 = ms_adrc-name1.
*   cs_customer->name2 = ms_adrc-name2.

    " ↪ Public Cloud karşılığı (I_* CDS’leri üzerinden)
    " Not: cs_customer alan adları mevcut DDIC yapına göre uyarlanmıştır.

    IF cs_customer IS NOT BOUND.
      RETURN.
    ENDIF.

    " Partner numarasını, çağrıdaki partno’dan türet (mümkün olduğunca)
    " Customer/Supplier numarasını dışarıdan set etmiyorsak BP üzerinden doldurabiliriz.
    IF mv_is_customer = abap_true.
      cs_customer->type = /mlsft/ed_constants=>customer.
      " İmkan varsa cs_customer->partner alanına KUNNR set edilmeli.
      " KUNNR’a doğrudan erişim yoksa BP’yi yazabilirsin ya da çağıran sınıf set ediyordur.
    ELSEIF mv_is_supplier = abap_true.
      cs_customer->type = /mlsft/ed_constants=>vendor.
    ENDIF.

    " Adres alanları — I_BusinessPartnerAddress
**    IF ms_bp_addr IS NOT INITIAL.
**      cs_customer->land1 = ms_bp_addr-Country.
**      cs_customer->ort01 = ms_bp_addr-CityName.
**      cs_customer->pstlz = ms_bp_addr-PostalCode.
**      cs_customer->stras = ms_bp_addr-StreetName.
**      cs_customer->regio = ms_bp_addr-Region;

      " İsim alanları (name1/name2) — adres kaydında ad-soyad/şirket adı olabilir
**      cs_customer->name1 = COND string(
**                             WHEN ms_bp_addr-OrganizationName IS NOT INITIAL
**                             THEN ms_bp_addr-OrganizationName
**                             ELSE ms_bp_addr-FirstName && | | && ms_bp_addr-LastName ).
**      cs_customer->name2 = ms_bp_addr-AdditionalStreetPrefixName.

      " Telefon/Faks: bazı sistemlerde I_BusinessPartnerAddress içinde bulunur
      " (alternatif: I_AddressPhoneNumber / I_AddressFaxNumber)
**      cs_customer->telf1 = ms_bp_addr-PhoneNumber; " varsa
**      cs_customer->telfx = ms_bp_addr-FaxNumber;   " varsa
**    ENDIF.

    " ADRNR muadili yok; gerekliyse AddressID yazılabilir
**    cs_customer->adrnr = ms_bp_addr-AddressID.

  ENDMETHOD.
ENDCLASS.
