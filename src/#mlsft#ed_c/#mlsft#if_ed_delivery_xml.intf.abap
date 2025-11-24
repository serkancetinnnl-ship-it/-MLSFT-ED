INTERFACE /mlsft/if_ed_delivery_xml
  PUBLIC.

  METHODS node_head
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document.

  METHODS node_ublextensions
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_ublversionid
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_customizationid
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_profileid
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_id
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_copyindicator
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_uuid
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_issuedate
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_issuetime
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_despatchadvicetypecode
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_notes
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_orderreference
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_adddocrefrence
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_signature
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_despatchsupplierparty
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_deliverycustomerparty
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_shipment
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_despatchline
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_buyercustomerparty
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_sellersupplierparty
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS node_originatorcustomerparty
    IMPORTING
      !ir_xml_document TYPE REF TO if_ixml_document
      !ir_xml_element  TYPE REF TO if_ixml_element.

  METHODS close.

ENDINTERFACE.
