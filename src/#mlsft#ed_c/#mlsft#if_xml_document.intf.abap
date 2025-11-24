INTERFACE /mlsft/if_xml_document PUBLIC.

  TYPES: ty_stringtab  TYPE STANDARD TABLE OF string  WITH DEFAULT KEY,
         ty_xstringtab TYPE STANDARD TABLE OF xstring WITH DEFAULT KEY,
         ty_node_ref_tab TYPE STANDARD TABLE OF REF TO /mlsft/if_xml_node WITH DEFAULT KEY.

  METHODS is_initial
    RETURNING VALUE(rv_flag) TYPE abap_bool.

  METHODS set_data
    IMPORTING ir_data TYPE REF TO data.

  METHODS get_data
    IMPORTING ir_target TYPE REF TO data.

  METHODS insert_document_as_child
    IMPORTING io_parent         TYPE REF TO /mlsft/if_xml_node
              io_child_document TYPE REF TO /mlsft/if_xml_document.

  METHODS get_node_path
    IMPORTING io_node TYPE REF TO /mlsft/if_xml_node
    RETURNING VALUE(rv_path) TYPE string.

  METHODS get_node_child
    IMPORTING io_node TYPE REF TO /mlsft/if_xml_node
              iv_index TYPE i
    RETURNING VALUE(ro_child) TYPE REF TO /mlsft/if_xml_node.

  METHODS get_first_node
    RETURNING VALUE(ro_node) TYPE REF TO /mlsft/if_xml_node.

  METHODS get_node_attribute
    IMPORTING io_node TYPE REF TO /mlsft/if_xml_node
              iv_name TYPE string
    RETURNING VALUE(rv_value) TYPE string.

  METHODS get_node_attr
    IMPORTING io_node TYPE REF TO /mlsft/if_xml_node
              iv_index TYPE i
    EXPORTING ev_name  TYPE string
              ev_value TYPE string.

  METHODS get_child_document
    IMPORTING io_node TYPE REF TO /mlsft/if_xml_node
    RETURNING VALUE(ro_doc) TYPE REF TO /mlsft/if_xml_document.

  METHODS get_node_data
    IMPORTING io_node   TYPE REF TO /mlsft/if_xml_node
              ir_target TYPE REF TO data.

  METHODS get_node_value
    IMPORTING io_node TYPE REF TO /mlsft/if_xml_node
    RETURNING VALUE(rv_value) TYPE string.

  METHODS get_node_name
    IMPORTING io_node TYPE REF TO /mlsft/if_xml_node
    RETURNING VALUE(rv_name) TYPE string.

  METHODS get_node_from_id
    IMPORTING iv_id TYPE string
    RETURNING VALUE(ro_node) TYPE REF TO /mlsft/if_xml_node.

  METHODS find_node_table
    IMPORTING iv_table_name TYPE string
    RETURNING VALUE(rt_nodes) TYPE ty_node_ref_tab.

  METHODS find_node
    IMPORTING iv_name_or_path TYPE string
    RETURNING VALUE(ro_node) TYPE REF TO /mlsft/if_xml_node.

  METHODS create_copy_from
    IMPORTING io_source TYPE REF TO /mlsft/if_xml_document
    RETURNING VALUE(ro_copy) TYPE REF TO /mlsft/if_xml_document.

  METHODS render_2_string
    RETURNING VALUE(rv_xml_string) TYPE string.

  METHODS render_2_xstring
    RETURNING VALUE(rv_xml_xstring) TYPE xstring.

  METHODS render_2_table
    RETURNING VALUE(rt_xml_table) TYPE ty_stringtab.

  METHODS parse_string
    IMPORTING iv_xml_string TYPE string.

  METHODS parse_xstring
    IMPORTING iv_xml_xstring TYPE xstring.

  METHODS parse_table
    IMPORTING it_xml_table TYPE ty_stringtab.

  METHODS create_with_data
    IMPORTING ir_data TYPE REF TO data.

  METHODS create_with_table
    IMPORTING ir_table TYPE REF TO data.

  METHODS export_to_file
    IMPORTING iv_filename TYPE string
              iv_mime     TYPE string OPTIONAL
    RETURNING VALUE(rv_ok) TYPE abap_bool.

  METHODS import_from_file
    IMPORTING iv_filename TYPE string
    RETURNING VALUE(rv_ok) TYPE abap_bool.

  METHODS create_with_node
    IMPORTING io_node TYPE REF TO /mlsft/if_xml_node.

  METHODS create_empty_document.

  METHODS create_with_dom
    IMPORTING io_dom TYPE REF TO /mlsft/if_xml_document.

  METHODS find_attribute
    IMPORTING iv_path      TYPE string
              iv_attr_name TYPE string
    RETURNING VALUE(rv_attr_value) TYPE string.

  METHODS set_attribute
    IMPORTING iv_path  TYPE string
              iv_name  TYPE string
              iv_value TYPE string.

  METHODS create_simple_element_pname
    IMPORTING iv_parent_name TYPE string
              iv_name        TYPE string
              iv_value       TYPE string OPTIONAL
    RETURNING VALUE(ro_node) TYPE REF TO /mlsft/if_xml_node.

  METHODS create_simple_element
    IMPORTING iv_parent_path TYPE string
              iv_name        TYPE string
              iv_value       TYPE string OPTIONAL
    RETURNING VALUE(ro_node) TYPE REF TO /mlsft/if_xml_node.

  METHODS find_simple_element
    IMPORTING iv_path TYPE string
    RETURNING VALUE(rv_value) TYPE string.

  METHODS free.

  METHODS parse
    IMPORTING iv_stream_xstr TYPE xstring.

  METHODS render
    RETURNING VALUE(rv_stream_xstr) TYPE xstring.

  METHODS get_namespace_def
    RETURNING VALUE(rt_ns) TYPE ty_stringtab.

  METHODS add_namespace_def
    IMPORTING iv_prefix TYPE string
              iv_uri    TYPE string.

  METHODS set_encoding
    IMPORTING iv_encoding TYPE string.

  METHODS get_last_parse_error
    RETURNING VALUE(rt_msgs) TYPE ty_stringtab.

  METHODS get_as_table
    IMPORTING ir_table TYPE REF TO data.

  METHODS set_as_table
    IMPORTING ir_table TYPE REF TO data.

  METHODS set_parameter
    IMPORTING iv_name  TYPE string
              iv_value TYPE string.

  METHODS get_parameter
    IMPORTING iv_name TYPE string
    RETURNING VALUE(rv_value) TYPE string.

  METHODS get_object
    RETURNING VALUE(rv_object) TYPE string.

  METHODS set_object
    IMPORTING iv_object TYPE string.

  METHODS get_doc_id
    RETURNING VALUE(rv_id) TYPE string.

  METHODS set_relation_to
    IMPORTING iv_other_id TYPE string
    RETURNING VALUE(rv_ok) TYPE abap_bool.

  METHODS save
    RETURNING VALUE(rv_ok) TYPE abap_bool.

  METHODS load_from_id
    IMPORTING iv_doc_id TYPE string
    RETURNING VALUE(rv_ok) TYPE abap_bool.

  METHODS load
    RETURNING VALUE(rv_ok) TYPE abap_bool.

  METHODS delete
    RETURNING VALUE(rv_ok) TYPE abap_bool.

  METHODS display
    RETURNING VALUE(rv_ok) TYPE abap_bool.

  METHODS save_variant
    IMPORTING iv_variant TYPE string
    RETURNING VALUE(rv_ok) TYPE abap_bool.

  METHODS render_2_table_bin
    RETURNING VALUE(rt_bin) TYPE ty_xstringtab.

  METHODS parse_table_bin
    IMPORTING it_bin TYPE ty_xstringtab.

  METHODS call_f4
    RETURNING VALUE(rv_ok) TYPE abap_bool.

  METHODS which_step
    RETURNING VALUE(rv_step) TYPE string.

ENDINTERFACE.
