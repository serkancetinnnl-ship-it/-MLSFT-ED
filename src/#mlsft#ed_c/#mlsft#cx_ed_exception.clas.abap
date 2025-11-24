"======================================================================
"  CLASS: /mlsft/cx_ed_exception
"  TYPE : Exception Class (ABAP Cloud uyumlu)
"======================================================================
CLASS /mlsft/cx_ed_exception DEFINITION
  PUBLIC
  INHERITING FROM cx_no_check
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_text TYPE string OPTIONAL.
    METHODS get_text REDEFINITION.

  PROTECTED SECTION.
    DATA mv_text TYPE string.
ENDCLASS.



CLASS /MLSFT/CX_ED_EXCEPTION IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( ).
    mv_text = iv_text.
  ENDMETHOD.


  METHOD get_text.
    IF mv_text IS NOT INITIAL.
      result = mv_text.
    ELSE.
      result = super->get_text( ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
