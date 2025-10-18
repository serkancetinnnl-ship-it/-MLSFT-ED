@EndUserText.label: 'E-Document Raw (Projection)'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@UI: {
  headerInfo: {
    typeName: 'E-Document Raw',
    typeNamePlural: 'E-Document Raws',
    title: { type: #STANDARD, value: 'docnum' }
  }
}
define view entity /MLSFT/C_EdRaw
  as projection on /MLSFT/I_EdRaw
{

      @EndUserText.label: 'E-Document Number'
      @UI.lineItem: [{ position: 10, label: 'Document Number' }]
      @UI.selectionField: [{ position: 10 }]
  key docnum,

//      _Head
_Head : redirected to parent /MLSFT/C_EdHead

}
