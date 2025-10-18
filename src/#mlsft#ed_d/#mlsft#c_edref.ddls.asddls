@EndUserText.label: 'E-Document Ref (Projection)'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@UI: {
  headerInfo: {
    typeName: 'E-Document Ref',
    typeNamePlural: 'E-Document Refs',
    title: { type: #STANDARD, value: 'docnum' }
  }
}
define view entity /MLSFT/C_EdRef
  as projection on /MLSFT/I_EdRef
{

  @EndUserText.label: 'E-Document Number'
  @UI.lineItem: [{ position: 10, label: 'Document Number' }]
  @UI.selectionField: [{ position: 10 }]
  key docnum,

//  _Head
_Head : redirected to parent /MLSFT/C_EdHead

}
