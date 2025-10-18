@AbapCatalog.sqlViewName: '/MLSFT/V_EDACTIN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'E-Document Actions( Interface )'
@Metadata.ignorePropagatedAnnotations: true
define view /MLSFT/I_ED_ACTION
  as select from /mlsft/ed_action
{
  key land1       as Land1,
  key doctype     as Doctype,
  key action      as Action,
//      doctypetext as Doctypetext,
//      actiontext  as Actiontext,
      class       as Class,
      method      as Method,
      function    as Function
}
