CLASS /mlsft/cl_xml_node DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES /mlsft/if_xml_node.
    METHODS constructor
      IMPORTING
        i_node TYPE REF TO object
        i_doc  TYPE REF TO object.
    METHODS get_ixml RETURNING VALUE(ro_node) TYPE REF TO object.
  PRIVATE SECTION.
    DATA mo_node TYPE REF TO object.
    DATA mo_doc  TYPE REF TO object.
ENDCLASS.



CLASS /MLSFT/CL_XML_NODE IMPLEMENTATION.


  METHOD constructor.
    mo_node = i_node.
    mo_doc  = i_doc.
  ENDMETHOD.


  METHOD get_ixml.
    ro_node = mo_node.
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~get_name.
    IF mo_node IS BOUND.
      CALL METHOD mo_node->('GET_NAME') RECEIVING name = rv_name.
    ENDIF.
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~get_value.
    IF mo_node IS BOUND.
      TRY.
          CALL METHOD mo_node->('GET_VALUE') RECEIVING value = rv_value.
        CATCH cx_root.
      ENDTRY.
    ENDIF.
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~set_value.
    IF mo_node IS INITIAL.
      RETURN.
    ENDIF.
    TRY.
        CALL METHOD mo_node->('SET_VALUE') EXPORTING value = iv_value.
        RETURN.
      CATCH cx_root.
    ENDTRY.
    DATA lo_el TYPE REF TO object.
    lo_el = mo_node.
    DATA lo_child TYPE REF TO object.
    CALL METHOD lo_el->('GET_FIRST_CHILD') RECEIVING node = lo_child.
    DATA lo_txt TYPE REF TO object.
    WHILE lo_child IS BOUND AND lo_txt IS INITIAL.
      TRY.
          DATA lv_dummy TYPE string.
          CALL METHOD lo_child->('GET_VALUE')
            RECEIVING
              value = lv_dummy.
          lo_txt = lo_child.
        CATCH cx_root.
          CALL METHOD lo_child->('GET_NEXT') RECEIVING node = lo_child.
      ENDTRY.
    ENDWHILE.
    IF lo_txt IS BOUND.
      TRY.
          CALL METHOD lo_txt->('SET_VALUE') EXPORTING value = iv_value.
        CATCH cx_root.
      ENDTRY.
    ELSE.
      TRY.
          DATA lo_text TYPE REF TO object.
          CALL METHOD mo_doc->('CREATE_TEXT') EXPORTING value = iv_value RECEIVING text = lo_text.
          CALL METHOD lo_el->('APPEND_CHILD') EXPORTING new_child = lo_text.
        CATCH cx_root.
      ENDTRY.
    ENDIF.
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~set_attribute.
    DATA lo_el TYPE REF TO object.
    lo_el = mo_node.
    CALL METHOD lo_el->('SET_ATTRIBUTE') EXPORTING name = iv_name value = iv_value.
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~get_attribute.
    DATA lo_el TYPE REF TO object.
    lo_el = mo_node.
    CALL METHOD lo_el->('GET_ATTRIBUTE') EXPORTING name = iv_name RECEIVING value = rv_value.
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~set_attribute_ns.
    DATA lo_el TYPE REF TO object.
    lo_el = mo_node.
    TRY.
        CALL METHOD lo_el->('SET_ATTRIBUTE_NS')
          EXPORTING
            prefix = iv_prefix
            name   = iv_name
            value  = iv_value
            uri    = iv_uri.
      CATCH cx_root.
        IF iv_prefix IS NOT INITIAL AND iv_uri IS NOT INITIAL.
          CALL METHOD lo_el->('SET_ATTRIBUTE') EXPORTING name = |xmlns:{ iv_prefix }| value = iv_uri.
        ENDIF.
        CALL METHOD lo_el->('SET_ATTRIBUTE') EXPORTING name = iv_name value = iv_value.
    ENDTRY.
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~append_child.
    DATA lo_el TYPE REF TO object.
    lo_el = mo_node.
    DATA lo_child TYPE REF TO object.
    CALL METHOD mo_doc->('CREATE_SIMPLE_ELEMENT')
      EXPORTING
        name    = iv_name
        parent  = lo_el
      RECEIVING
        element = lo_child.
    ro_node = NEW /mlsft/cl_xml_node( i_node = lo_child i_doc = mo_doc ).
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~append_child_ns.
    DATA lo_el TYPE REF TO object.
    lo_el = mo_node.
    TRY.
        DATA lo_child TYPE REF TO object.
        CALL METHOD mo_doc->('CREATE_ELEMENT_NS') EXPORTING name = iv_name uri = iv_uri RECEIVING element = lo_child.
        CALL METHOD lo_el->('APPEND_CHILD') EXPORTING new_child = lo_child.
        ro_node = NEW /mlsft/cl_xml_node( i_node = lo_child i_doc = mo_doc ).
        IF iv_prefix IS NOT INITIAL.
          CALL METHOD lo_child->('SET_ATTRIBUTE') EXPORTING name = |xmlns:{ iv_prefix }| value = iv_uri.
        ENDIF.
      CATCH cx_root.
        DATA lo_child2 TYPE REF TO object.
        CALL METHOD mo_doc->('CREATE_SIMPLE_ELEMENT') EXPORTING name = iv_name parent = lo_el RECEIVING element = lo_child2.
        IF iv_prefix IS NOT INITIAL AND iv_uri IS NOT INITIAL.
          CALL METHOD lo_child2->('SET_ATTRIBUTE') EXPORTING name = |xmlns:{ iv_prefix }| value = iv_uri.
        ENDIF.
        ro_node = NEW /mlsft/cl_xml_node( i_node = lo_child2 i_doc = mo_doc ).
    ENDTRY.
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~get_first_child.
    DATA lo_child TYPE REF TO object.
    CALL METHOD mo_node->('GET_FIRST_CHILD') RECEIVING node = lo_child.
    IF lo_child IS BOUND.
      ro_node = NEW /mlsft/cl_xml_node( i_node = lo_child i_doc = mo_doc ).
    ENDIF.
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~get_next_sibling.
    DATA lo_next TYPE REF TO object.
    CALL METHOD mo_node->('GET_NEXT') RECEIVING node = lo_next.
    IF lo_next IS BOUND.
      ro_node = NEW /mlsft/cl_xml_node( i_node = lo_next i_doc = mo_doc ).
    ENDIF.
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~get_parent.
    DATA lo_parent TYPE REF TO object.
    CALL METHOD mo_node->('GET_PARENT') RECEIVING parent = lo_parent.
    IF lo_parent IS BOUND.
      ro_node = NEW /mlsft/cl_xml_node( i_node = lo_parent i_doc = mo_doc ).
    ENDIF.
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~get_child_by_name.
    DATA lo_child TYPE REF TO object.
    CALL METHOD mo_node->('GET_FIRST_CHILD') RECEIVING node = lo_child.
    WHILE lo_child IS BOUND.
      DATA lv_name TYPE string.
      CALL METHOD lo_child->('GET_NAME') RECEIVING name = lv_name.
      IF lv_name = iv_name.
        ro_node = NEW /mlsft/cl_xml_node( i_node = lo_child i_doc = mo_doc ).
        RETURN.
      ENDIF.
      CALL METHOD lo_child->('GET_NEXT') RECEIVING node = lo_child.
    ENDWHILE.
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~find_all.
    CLEAR rt_nodes.
    DATA lo_child TYPE REF TO object.
    CALL METHOD mo_node->('GET_FIRST_CHILD') RECEIVING node = lo_child.
    WHILE lo_child IS BOUND.
      DATA lv_name TYPE string.
      CALL METHOD lo_child->('GET_NAME') RECEIVING name = lv_name.
      IF lv_name = iv_name.
        DATA lo_ref TYPE REF TO /mlsft/if_xml_node.
        lo_ref = NEW /mlsft/cl_xml_node( i_node = lo_child i_doc = mo_doc ).
        APPEND lo_ref TO rt_nodes.
      ENDIF.
      DATA lo_grand TYPE REF TO object.
      CALL METHOD lo_child->('GET_FIRST_CHILD') RECEIVING node = lo_grand.
      WHILE lo_grand IS BOUND.
        CALL METHOD lo_grand->('GET_NAME') RECEIVING name = lv_name.
        IF lv_name = iv_name.
          DATA lo_ref2 TYPE REF TO /mlsft/if_xml_node.
          lo_ref2 = NEW /mlsft/cl_xml_node( i_node = lo_grand i_doc = mo_doc ).
          APPEND lo_ref2 TO rt_nodes.
        ENDIF.
        CALL METHOD lo_grand->('GET_NEXT') RECEIVING node = lo_grand.
      ENDWHILE.
      CALL METHOD lo_child->('GET_NEXT') RECEIVING node = lo_child.
    ENDWHILE.
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~create_text.
    DATA lo_el TYPE REF TO object.
    lo_el = mo_node.
    DATA lo_text TYPE REF TO object.
    CALL METHOD mo_doc->('CREATE_TEXT') EXPORTING value = iv_text RECEIVING text = lo_text.
    CALL METHOD lo_el->('APPEND_CHILD') EXPORTING new_child = lo_text.
    ro_node = NEW /mlsft/cl_xml_node( i_node = lo_text i_doc = mo_doc ).
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~create_comment.
    DATA lo_el TYPE REF TO object.
    lo_el = mo_node.
    TRY.
        DATA lo_comment TYPE REF TO object.
        CALL METHOD mo_doc->('CREATE_COMMENT') EXPORTING value = iv_text RECEIVING comment = lo_comment.
        CALL METHOD lo_el->('APPEND_CHILD') EXPORTING new_child = lo_comment.
        ro_node = NEW /mlsft/cl_xml_node( i_node = lo_comment i_doc = mo_doc ).
      CATCH cx_root.
        ro_node = me->/mlsft/if_xml_node~create_text( iv_text ).
    ENDTRY.
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~create_cdata.
    DATA lo_el TYPE REF TO object.
    lo_el = mo_node.
    TRY.
        DATA lo_cdata TYPE REF TO object.
        CALL METHOD mo_doc->('CREATE_CDATA_SECTION') EXPORTING value = iv_text RECEIVING cdata = lo_cdata.
        CALL METHOD lo_el->('APPEND_CHILD') EXPORTING new_child = lo_cdata.
        ro_node = NEW /mlsft/cl_xml_node( i_node = lo_cdata i_doc = mo_doc ).
      CATCH cx_root.
        ro_node = me->/mlsft/if_xml_node~create_text( iv_text ).
    ENDTRY.
  ENDMETHOD.


  METHOD /mlsft/if_xml_node~create_pi.
    DATA lo_el TYPE REF TO object.
    lo_el = mo_node.
    DATA lo_pi TYPE REF TO object.
    CALL METHOD mo_doc->('CREATE_TEXT') EXPORTING value = |<?{ iv_target } { iv_data }?>| RECEIVING text = lo_pi.
    CALL METHOD lo_el->('APPEND_CHILD') EXPORTING new_child = lo_pi.
    ro_node = NEW /mlsft/cl_xml_node( i_node = lo_pi i_doc = mo_doc ).
  ENDMETHOD.
ENDCLASS.
