@EndUserText.label: 'E-Doc Head (Interface)'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity /MLSFT/I_EdHead
  as select from /mlsft/ed_head
  composition [0..1] of /MLSFT/I_EdRef as _Ref
  composition [0..1] of /MLSFT/I_EdRaw as _Raw

  association [0..1] to /MLSFT/I_DoctypeText as _DoctypeText on
    _DoctypeText.doctype = $projection.doctype
    and _DoctypeText.type = 'DTYP'
    and _DoctypeText.active = 'X'

  association [0..1] to /MLSFT/I_ReftypeText as _ReftypeText on
    _ReftypeText.reftype = $projection.reftype
    and _ReftypeText.type = 'RFTP'
    and _ReftypeText.active = 'X'

  association [0..1] to /MLSFT/I_EDALVCLR as _Color on
    _Color.SystemStatus = $projection.lstatus

  association [0..1] to /MLSFT/I_ED_eur_st as _EURStatus on
    _EURStatus.Gibstat = $projection.lstatus
    and _EURStatus.Spras = $session.system_language
    and (_EURStatus.Land1 = 'NL' or _EURStatus.Land1 = 'RO')
// and _EURStatus.Land1   = _CompanyCode.Country  FIXME
  
  // Standart referanslar (kullanıma göre aktif et)
//  association [0..1] to I_CompanyCode as _CompanyCode on
//    _CompanyCode.CompanyCode = _Ref.bukrs
//
//  association [0..1] to I_Supplier as _Supplier on
//    _Supplier.BusinessPartner = _Ref.partner
//
//  association [0..1] to I_Customer as _Customer on
//    _Customer.Customer = _Ref.partner

{
  @UI.dataPoint: { qualifier: 'RowHL', criticality: 'RowCriticality' }
  key docnum,

  doctype,
  reftype,
  refdoc,
  refgrup,
  jahr,
  created_by,
  creation_date,
  creation_time,
  changed_by,
  change_date,
  change_time,
  lstatus,
  sstatus,
  delflag,
  receipt,
  virtual,
  archieved,
  kzstat,

  _DoctypeText,
  _ReftypeText,
  _Ref,
  _Raw,
  _Color,
  _EURStatus,
//  _CompanyCode,
//  _Supplier,
//  _Customer,

  @EndUserText.label: 'Row Criticality'
  cast(
    case _Color.AlvColor
      when 'R' then 1
      when 'Y' then 2
      when 'G' then 3
      else 0
    end as abap.int4
  ) as RowCriticality
}
