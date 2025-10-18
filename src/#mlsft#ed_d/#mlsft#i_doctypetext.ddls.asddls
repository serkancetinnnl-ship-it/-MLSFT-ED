@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Text help for Doctype from SEI_PARAM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /MLSFT/I_DoctypeText
  as select from /mlsft/sei_param
{
  key value      as doctype,
      long_text  as doctype_text,
      type,
      active
}
