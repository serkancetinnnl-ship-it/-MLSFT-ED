@AbapCatalog.sqlViewName: '/MLSFT/V_EALVCLR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'State Color Codes ( Interface )'
@Metadata.ignorePropagatedAnnotations: true
define view /MLSFT/I_EDALVCLR as select from /mlsft/ed_alvclr
{
  key client as Client,
  key status as SystemStatus,
      alvtext as alvtext,
      alvcol  as AlvColor,
      alvint  as AlvIntensified,
      alvinv  as AlvInverse,
      lcolor  as LColorCode
}
