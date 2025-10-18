@EndUserText.label: 'ED Loader Columns'
@Metadata.allowExtensions: true
define view entity /MLSFT/I_ED_LOADER_COL
  as select from /mlsft/edlruncol
  association to parent /MLSFT/I_ED_LOADER as _Run
    on $projection.LoaderUUID = _Run.LoaderUUID
{
  key loader_uuid  as LoaderUUID,
  key col_idx      as ColIndex,
      header       as Header,
      sample_value as SampleValue,
      _Run
}
