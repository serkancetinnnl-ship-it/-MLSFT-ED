CLASS /mlsft/cl_xml_document DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES /mlsft/if_xml_document.

    METHODS constructor.

    CLASS-METHODS class_constructor.
    CLASS-METHODS move_table
      IMPORTING it_src TYPE /mlsft/if_xml_document=>ty_xstringtab
      RETURNING VALUE(rt_dst) TYPE /mlsft/if_xml_document=>ty_xstringtab.
    CLASS-METHODS find
      IMPORTING iv_query TYPE string
      RETURNING VALUE(rt_ids) TYPE /mlsft/if_xml_document=>ty_stringtab.
    CLASS-METHODS call_navigator
      RETURNING VALUE(rv_ok) TYPE abap_bool.
    CLASS-METHODS delete_documents
      IMPORTING it_ids TYPE /mlsft/if_xml_document=>ty_stringtab
      RETURNING VALUE(rv_ok) TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mv_encoding     TYPE string.
    DATA mt_parse_errors TYPE /mlsft/if_xml_document=>ty_stringtab.
    " ST ile çalışmak için veri referansı tutuyoruz
    DATA mr_data         TYPE REF TO data.
ENDCLASS.



CLASS /MLSFT/CL_XML_DOCUMENT IMPLEMENTATION.


  METHOD constructor.
    mv_encoding = 'UTF-8'.
  ENDMETHOD.


  METHOD class_constructor.
  ENDMETHOD.


  METHOD move_table.
    rt_dst = it_src.
  ENDMETHOD.


  METHOD find.
    CLEAR rt_ids.
  ENDMETHOD.


  METHOD call_navigator.
    rv_ok = abap_false.
  ENDMETHOD.


  METHOD delete_documents.
    rv_ok = abap_false.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~is_initial.
    " CT yaklaşımında doküman durumunu, veri referansına göre değerlendiriyoruz
    rv_flag = xsdbool( mr_data IS INITIAL ).
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~set_data.
    " Dışarıdan verilen veri referansını saklarız (DDIC referansı olmalı)
    mr_data = ir_data.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_data.
    " İçeride tuttuğumuz veriyi dışarıya kopyalarız (tip uyumluysa)
    IF mr_data IS INITIAL OR ir_target IS INITIAL.
      RETURN.
    ENDIF.
    FIELD-SYMBOLS: <s> TYPE any, <t> TYPE any.
    ASSIGN mr_data->*   TO <s>.
    ASSIGN ir_target->* TO <t>.
    IF <s> IS ASSIGNED AND <t> IS ASSIGNED.
      TRY.
          <t> = <s>.
        CATCH cx_root.
      ENDTRY.
    ENDIF.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~insert_document_as_child.
    " iXML olmadan node-bazlı ekleme desteklenmiyor (imza korunur)
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_node_path.
    CLEAR rv_path.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_node_child.
    CLEAR ro_child.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_first_node.
    CLEAR ro_node.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_node_attribute.
    CLEAR rv_value.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_node_attr.
    CLEAR: ev_name, ev_value.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_child_document.
    CLEAR ro_doc.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_node_data.
    " iXML yok; ST ile doğrudan node->data yok
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_node_value.
    CLEAR rv_value.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_node_name.
    CLEAR rv_name.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_node_from_id.
    CLEAR ro_node.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~find_node_table.
    CLEAR rt_nodes.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~find_node.
    CLEAR ro_node.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~create_copy_from.
    " ST ile shallow copy — veri referansı yoksa kopya boş
    IF io_source IS BOUND.
      " Basitçe yeni nesne oluşturup source içeriğini string XML'e çevirip parse edebiliriz,
      " fakat burada sadece iskelet bırakıyoruz (ihtiyaçta genişletilir).
    ENDIF.
    CLEAR ro_copy.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~render_2_string.
    DATA(lv_x) = me->/mlsft/if_xml_document~render( ).
    TRY.
        rv_xml_string = cl_abap_conv_codepage=>create_in( )->convert( lv_x ).
      CATCH cx_root.
        CLEAR rv_xml_string.
    ENDTRY.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~render_2_xstring.
    rv_xml_xstring = me->/mlsft/if_xml_document~render( ).
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~render_2_table.
    DATA(lv_str) = me->/mlsft/if_xml_document~render_2_string( ).
    SPLIT lv_str AT cl_abap_char_utilities=>cr_lf INTO TABLE rt_xml_table.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~parse_string.
    TRY.
        DATA(lv_x) = cl_abap_conv_codepage=>create_out( )->convert( iv_xml_string ).
        me->/mlsft/if_xml_document~parse( lv_x ).
      CATCH cx_root INTO DATA(lx).
        APPEND lx->get_text( ) TO mt_parse_errors.
    ENDTRY.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~parse_xstring.
    me->/mlsft/if_xml_document~parse( iv_xml_xstring ).
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~parse_table.
    DATA(lv_str) = ``.
    IF lines( it_xml_table ) > 0.
      lv_str = CONV string( it_xml_table[ 1 ] ).
    ENDIF.
    LOOP AT it_xml_table INTO DATA(lv_line) FROM 2.
      lv_str = lv_str && cl_abap_char_utilities=>cr_lf && lv_line.
    ENDLOOP.
    me->/mlsft/if_xml_document~parse_string( lv_str ).
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~create_with_data.
    " DIKKAT: render/parse ST ile çalışır, önce veri referansını set edelim
    me->/mlsft/if_xml_document~set_data( ir_data ).
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~create_with_table.
    " Internal table referansını saklarız
    me->/mlsft/if_xml_document~set_data( ir_table ).
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~export_to_file.
    rv_ok = abap_false.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~import_from_file.
    rv_ok = abap_false.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~create_with_node.
    " iXML olmadığı için desteklenmiyor
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~create_empty_document.
    " ST yaklaşımında boş doküman kavramı yok; veri referansını sıfırlarız
    CLEAR mr_data.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~create_with_dom.
    " iXML DOM olmadan desteklenmiyor
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~find_attribute.
    CLEAR rv_attr_value.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~set_attribute.
    " ST ile tekil attribute set etmek doğrudan desteklenmez (transformasyon gerekir)
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~create_simple_element_pname.
    CLEAR ro_node.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~create_simple_element.
    CLEAR ro_node.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~find_simple_element.
    CLEAR rv_value.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~free.
    CLEAR: mr_data, mt_parse_errors.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~parse.
    CLEAR mt_parse_errors.

    IF mr_data IS INITIAL.
      APPEND `No data reference (SET_DATA) provided for parsing.` TO mt_parse_errors.
      RETURN.
    ENDIF.

    FIELD-SYMBOLS <d> TYPE any.
    ASSIGN mr_data->* TO <d>.
    IF <d> IS NOT ASSIGNED.
      APPEND `Data reference cannot be assigned.` TO mt_parse_errors.
      RETURN.
    ENDIF.

    TRY.
        CALL TRANSFORMATION id
          SOURCE XML iv_stream_xstr
          RESULT data = <d>.
      CATCH cx_transformation_error INTO DATA(lx_tr).
        APPEND lx_tr->get_text( ) TO mt_parse_errors.
      CATCH cx_root INTO DATA(lx_any).
        APPEND lx_any->get_text( ) TO mt_parse_errors.
    ENDTRY.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~render.
    CLEAR rv_stream_xstr.

    IF mr_data IS INITIAL.
      RETURN.
    ENDIF.

    FIELD-SYMBOLS <d> TYPE any.
    ASSIGN mr_data->* TO <d>.
    IF <d> IS NOT ASSIGNED.
      RETURN.
    ENDIF.

    TRY.
        CALL TRANSFORMATION id
          SOURCE data = <d>
          RESULT XML rv_stream_xstr.
      CATCH cx_transformation_error INTO DATA(lx_tr).
        APPEND lx_tr->get_text( ) TO mt_parse_errors.
      CATCH cx_root INTO DATA(lx_any).
        APPEND lx_any->get_text( ) TO mt_parse_errors.
    ENDTRY.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_namespace_def.
    CLEAR rt_ns.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~add_namespace_def.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~set_encoding.
    mv_encoding = iv_encoding.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_last_parse_error.
    rt_msgs = mt_parse_errors.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_as_table.
    " İmza korunur; içerik ST ile veri üzerinden üretilebilir (ihtiyaçta genişletilir)
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~set_as_table.
    " İmza korunur
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~set_parameter.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_parameter.
    CLEAR rv_value.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_object.
    CLEAR rv_object.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~set_object.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~get_doc_id.
    CLEAR rv_id.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~set_relation_to.
    rv_ok = abap_false.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~save.
    rv_ok = abap_false.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~load_from_id.
    rv_ok = abap_false.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~load.
    rv_ok = abap_false.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~delete.
    rv_ok = abap_false.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~display.
    rv_ok = abap_false.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~save_variant.
    rv_ok = abap_false.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~render_2_table_bin.
    DATA(lv_x) = me->/mlsft/if_xml_document~render( ).
    IF lv_x IS NOT INITIAL.
      APPEND lv_x TO rt_bin.
    ENDIF.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~parse_table_bin.
    DATA(lv_all) = CONV xstring( '' ).
    LOOP AT it_bin INTO DATA(lx).
      lv_all = lv_all && lx.
    ENDLOOP.
    me->/mlsft/if_xml_document~parse( lv_all ).
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~call_f4.
    rv_ok = abap_false.
  ENDMETHOD.


  METHOD /mlsft/if_xml_document~which_step.
    CLEAR rv_step.
  ENDMETHOD.
ENDCLASS.
