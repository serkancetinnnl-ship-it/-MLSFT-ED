@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Text help for Reftype from SEI_PARAM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity /MLSFT/I_ReftypeText
  as select from /mlsft/sei_param
{
  key value      as reftype,
      long_text  as reftype_text,
      type,
      active
}
