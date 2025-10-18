@EndUserText.label: 'ED Loader Run'
 @Metadata.allowExtensions: true
 
define root view entity /MLSFT/I_ED_LOADER
  as select from /mlsft/edloadrun
  
   association to /MLSFT/I_ED_LOADER_COL as _Columns
    on $projection.LoaderUUID = _Columns.LoaderUUID
{
  key loader_uuid  as LoaderUUID,
      table_name   as TableName,
      status       as Status,
//      created_on   as CreatedOn,
      created_time as CreatedTime,
      created_by   as CreatedBy
}
