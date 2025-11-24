INTERFACE /mlsft/if_xml_node PUBLIC.

  TYPES ty_node_ref_tab TYPE STANDARD TABLE OF REF TO /mlsft/if_xml_node WITH DEFAULT KEY.

  METHODS get_name
    RETURNING VALUE(rv_name) TYPE string.

  METHODS get_value
    RETURNING VALUE(rv_value) TYPE string.

  METHODS set_value
    IMPORTING iv_value TYPE string.

  METHODS set_attribute
    IMPORTING iv_name  TYPE string
              iv_value TYPE string.

  METHODS get_attribute
    IMPORTING iv_name TYPE string
    RETURNING VALUE(rv_value) TYPE string.

  METHODS set_attribute_ns
    IMPORTING iv_prefix TYPE string
              iv_name   TYPE string
              iv_value  TYPE string
              iv_uri    TYPE string.

  METHODS append_child
    IMPORTING iv_name TYPE string
    RETURNING VALUE(ro_node) TYPE REF TO /mlsft/if_xml_node.

  METHODS append_child_ns
    IMPORTING iv_prefix TYPE string
              iv_name   TYPE string
              iv_uri    TYPE string
    RETURNING VALUE(ro_node) TYPE REF TO /mlsft/if_xml_node.

  METHODS get_first_child
    RETURNING VALUE(ro_node) TYPE REF TO /mlsft/if_xml_node.

  METHODS get_next_sibling
    RETURNING VALUE(ro_node) TYPE REF TO /mlsft/if_xml_node.

  METHODS get_parent
    RETURNING VALUE(ro_node) TYPE REF TO /mlsft/if_xml_node.

  METHODS get_child_by_name
    IMPORTING iv_name TYPE string
    RETURNING VALUE(ro_node) TYPE REF TO /mlsft/if_xml_node.

  METHODS find_all
    IMPORTING iv_name TYPE string
    RETURNING VALUE(rt_nodes) TYPE ty_node_ref_tab.

  METHODS create_text
    IMPORTING iv_text TYPE string
    RETURNING VALUE(ro_node) TYPE REF TO /mlsft/if_xml_node.

  METHODS create_comment
    IMPORTING iv_text TYPE string
    RETURNING VALUE(ro_node) TYPE REF TO /mlsft/if_xml_node.

  METHODS create_cdata
    IMPORTING iv_text TYPE string
    RETURNING VALUE(ro_node) TYPE REF TO /mlsft/if_xml_node.

  METHODS create_pi
    IMPORTING iv_target TYPE string
              iv_data   TYPE string
    RETURNING VALUE(ro_node) TYPE REF TO /mlsft/if_xml_node.

ENDINTERFACE.
