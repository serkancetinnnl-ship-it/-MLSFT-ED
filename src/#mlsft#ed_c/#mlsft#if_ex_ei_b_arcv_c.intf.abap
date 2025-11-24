INTERFACE /mlsft/if_ex_ei_b_arcv_c PUBLIC.

  " XSLT değiştir
  METHODS xslt_change_archive
    IMPORTING
      im_awtyp TYPE awtyp        " Referans işlem
      im_awkey TYPE awkey        " Referans anahtar
      im_kschl TYPE kschl        " Koşul türü
    CHANGING
      ch_xslt  TYPE char40 .     "cxsltdesc  XSLT tanımı/açıklaması

  " e-arşiv kullanıcısı mı?
  METHODS check_partner_type
    IMPORTING
      im_partype TYPE char1      " partner tipi  (/MLSAG/* yerine sade tip)
      im_partner TYPE char10     " muhatap      (/MLSAG/* yerine sade tip)
      im_fkdat   TYPE fkdat           " faturalama tarihi vb.
    CHANGING
      re_type    TYPE char1.     " tek basamaklı gösterge

ENDINTERFACE.
