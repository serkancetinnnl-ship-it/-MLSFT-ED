@EndUserText.label: 'ED Loader Columns (Projection)'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity /MLSFT/C_ED_LOADER_COL
  as projection on /MLSFT/I_ED_LOADER_COL
{
  key LoaderUUID,
  key ColIndex,
      Header,
      SampleValue,
      _Run                //   “association/expose”  
}
