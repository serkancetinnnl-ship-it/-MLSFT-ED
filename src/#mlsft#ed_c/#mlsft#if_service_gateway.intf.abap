INTERFACE /MLSFT/IF_SERVICE_GATEWAY PUBLIC.

  METHODS delivery_execute
    IMPORTING
      iv_action TYPE string
      iv_vbeln  TYPE vbeln OPTIONAL
      io_self   TYPE REF TO object OPTIONAL   " Çağıran (örn. /MLSFT/ED_DELIVERY)
    CHANGING
      co_any    TYPE REF TO data OPTIONAL     " Tekil dönüş (structure)
      ct_any    TYPE REF TO data OPTIONAL     " Tablo dönüşü
    RAISING
      /MLSFT/CX_ED_EXCEPTION.

ENDINTERFACE.

