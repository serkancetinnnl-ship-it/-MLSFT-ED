@AbapCatalog.sqlViewName: '/MLSFT/C_EDACTIN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'E-Document Actions( Consumption)'
@Metadata.ignorePropagatedAnnotations: true
define view /MLSFT/C_ED_ACTION as select from /MLSFT/I_ED_ACTION
{
    key Land1,
    key Doctype,
    key Action,
//    Doctypetext,
//    Actiontext,
    Class,
    Method,
    Function
}
