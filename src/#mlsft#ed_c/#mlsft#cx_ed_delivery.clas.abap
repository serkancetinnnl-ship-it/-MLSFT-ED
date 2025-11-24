CLASS /MLSFT/CX_ED_DELIVERY DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_t100_message.

    CONSTANTS:
      BEGIN OF key_gen_error,
        msgid TYPE symsgid      VALUE '/MLSFT/ED',   " mesaj sınıfın
        msgno TYPE symsgno      VALUE '075',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF key_gen_error.

    CONSTANTS cx_uuid_error    TYPE scx_t100key VALUE /mlsft/cx_ed_delivery=>key_gen_error. " #EC NOTEXT
    CONSTANTS error            TYPE i           VALUE 1.  " #EC NOTEXT
    CONSTANTS mem_alloc_error  TYPE i           VALUE 2.  " #EC NOTEXT
    CONSTANTS typsize_error    TYPE i           VALUE 3.  " #EC NOTEXT

    DATA err_type TYPE i.
    DATA err_text TYPE string.

    METHODS constructor
      IMPORTING
        !textid    LIKE if_t100_message=>t100key OPTIONAL
        !previous  LIKE previous                 OPTIONAL
        !err_type  TYPE i                        OPTIONAL
        !err_text  TYPE string                   OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /MLSFT/CX_ED_DELIVERY IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).
    me->err_type = err_type.
    me->err_text = err_text.

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
