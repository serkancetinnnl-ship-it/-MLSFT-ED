@EndUserText.label: 'ED Loader (Projection)'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity /MLSFT/C_ED_LOADER
  as projection on /MLSFT/I_ED_LOADER
{
  key LoaderUUID,
      TableName,
      Status,
      CreatedTime,
      CreatedBy
}
