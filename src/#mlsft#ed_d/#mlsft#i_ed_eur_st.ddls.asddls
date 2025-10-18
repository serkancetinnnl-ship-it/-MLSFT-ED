@AbapCatalog.sqlViewName: '/MLSFT/V_EDEURST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ED Invoice Statu ( Interface )'
@Metadata.ignorePropagatedAnnotations: true
define view /MLSFT/I_ED_eur_st as select from /mlsft/ed_eur_st
{
    key land1 as Land1,
    key gibstat as Gibstat,
    key spras as Spras,
    gibdesc as Gibdesc
}
