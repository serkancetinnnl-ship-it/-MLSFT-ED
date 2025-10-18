@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'E-Doc Raw XML (Interface)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /MLSFT/I_EdRaw
  as select from /mlsft/ed_raw

  association to parent /MLSFT/I_EdHead as _Head on $projection.docnum = _Head.docnum

{
  key docnum,
      binary,
      docs,

      _Head
}
