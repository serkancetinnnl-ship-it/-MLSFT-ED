@EndUserText.label: 'E-Doc Head (Projection with Ref fields)'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@UI: {
  headerInfo: {
    typeName: 'E-Document',
    typeNamePlural: 'E-Documents',
    title: { type: #STANDARD, value: 'docnum' }
  }
}
define root view entity /MLSFT/C_EdHead
  as projection on /MLSFT/I_EdHead
{
      /* === KEY & Head alanları === */
      //  @EndUserText.label: 'Document Number'
      //  @UI.lineItem:       [{ position: 10,  label: 'Document Number' }]
      //  @UI.selectionField: [{ position: 10 }]
      //  key docnum,
      @EndUserText.label: 'Document Number'
      @UI.lineItem: [ { position: 10, label: 'Document Number', criticality: 'RowCriticality' } ]
      @UI.selectionField: [ { position: 10 } ]
  key docnum,

      @UI.hidden: true
      RowCriticality,

      @EndUserText.label: 'E-Document Type'
      @UI.lineItem:       [{ position: 20,  label: 'E-Document Type' }]
      @UI.selectionField: [{ position: 20 }]
      doctype,

      @EndUserText.label: 'Reference Type'
      @UI.lineItem:       [{ position: 30,  label: 'Reference Type' }]
      @UI.selectionField: [{ position: 30 }]
      reftype,

      @EndUserText.label: 'Reference Document'
      @UI.lineItem:       [{ position: 40,  label: 'Reference Document' }]
      @UI.selectionField: [{ position: 40 }]
      refdoc,

      @EndUserText.label: 'Reference Group'
      @UI.lineItem:       [{ position: 50,  label: 'Reference Group' }]
      @UI.selectionField: [{ position: 50 }]
      refgrup,

      @EndUserText.label: 'Fiscal Year'
      @UI.lineItem:       [{ position: 60,  label: 'Fiscal Year' }]
      @UI.selectionField: [{ position: 60 }]
      jahr,

      @EndUserText.label: 'Logical Status'
      @UI.lineItem:       [{ position: 70,  label: 'Logical Status' }]
      @UI.selectionField: [{ position: 70 }]
      lstatus,

      @EndUserText.label: 'System Status'
      @UI.lineItem:       [{ position: 80,  label: 'System Status' }]
      @UI.selectionField: [{ position: 80 }]
      sstatus,

      @EndUserText.label: 'Deleted'
      @UI.lineItem:       [{ position: 90,  label: 'Deleted' }]
      @UI.selectionField: [{ position: 90 }]
      delflag,

      @EndUserText.label: 'Created By'
      @UI.lineItem:       [{ position: 100, label: 'Created By' }]
      @UI.selectionField: [{ position: 100 }]
      created_by,

      @EndUserText.label: 'Creation Date'
      @UI.lineItem:       [{ position: 110, label: 'Creation Date' }]
      @UI.selectionField: [{ position: 110 }]
      creation_date,

      @EndUserText.label: 'Creation Time'
      @UI.lineItem:       [{ position: 120, label: 'Creation Time' }]
      @UI.selectionField: [{ position: 120 }]
      creation_time,

      @EndUserText.label: 'Change Date'
      @UI.lineItem:       [{ position: 130, label: 'Change Date' }]
      @UI.selectionField: [{ position: 130 }]
      change_date,

      @EndUserText.label: 'Change Time'
      @UI.lineItem:       [{ position: 140, label: 'Change Time' }]
      @UI.selectionField: [{ position: 140 }]
      change_time,

      /* === _Ref alanlarını to-one path ile dahil et (JOIN otomatik) === */
      @EndUserText.label: 'Company Code'
      @UI.lineItem:       [{ position: 200, label: 'Company Code' }]
      @UI.selectionField: [{ position: 200 }]
      _Ref.bukrs       as bukrs,

      @EndUserText.label: 'Delivery'
      @UI.lineItem:       [{ position: 210, label: 'Delivery' }]
      @UI.selectionField: [{ position: 210 }]
      _Ref.delv_num    as delv_num,

      @EndUserText.label: 'Delivery Type'
      @UI.lineItem:       [{ position: 220, label: 'Delivery Type' }]
      @UI.selectionField: [{ position: 220 }]
      _Ref.lfart       as lfart,

      @EndUserText.label: 'Sales Org.'
      @UI.lineItem:       [{ position: 230, label: 'Sales Org.' }]
      @UI.selectionField: [{ position: 230 }]
      _Ref.vkorg       as vkorg,

      @EndUserText.label: 'Shipping Point'
      @UI.lineItem:       [{ position: 240, label: 'Shipping Point' }]
      @UI.selectionField: [{ position: 240 }]
      _Ref.vstel       as vstel,

      //  @EndUserText.label: 'Plant'
      //  @UI.lineItem:       [{ position: 250, label: 'Plant' }]
      //  @UI.selectionField: [{ position: 250 }]
      //  _Ref.werks    as werks,

      @EndUserText.label: 'Storage Location'
      @UI.lineItem:       [{ position: 260, label: 'Storage Location' }]
      @UI.selectionField: [{ position: 260 }]
      _Ref.lgort       as lgort,

      @EndUserText.label: 'GI Date'
      @UI.lineItem:       [{ position: 270, label: 'GI Date' }]
      @UI.selectionField: [{ position: 270 }]
      _Ref.wadat_ist   as wadat_ist,

      @EndUserText.label: 'GIB Number'
      @UI.lineItem:       [{ position: 280, label: 'GIB Number' }]
      @UI.selectionField: [{ position: 280 }]
      _Ref.gibid       as gibid,

      @EndUserText.label: 'Reference No'
      @UI.lineItem:       [{ position: 290, label: 'Reference No' }]
      @UI.selectionField: [{ position: 290 }]
      _Ref.ref_no      as ref_no,

      @EndUserText.label: 'KSeF Ref.'
      @UI.lineItem:       [{ position: 300, label: 'KSeF Ref.' }]
      @UI.selectionField: [{ position: 300 }]
      _Ref.pol_inv     as pol_inv,

      @EndUserText.label: 'External Invoice'
      @UI.lineItem:       [{ position: 310, label: 'External Invoice' }]
      @UI.selectionField: [{ position: 310 }]
      _Ref.ext_inv     as ext_inv,

      @EndUserText.label: 'Partner'
      @UI.lineItem:       [{ position: 320, label: 'Partner' }]
      @UI.selectionField: [{ position: 320 }]
      _Ref.partner     as partner,

      @EndUserText.label: 'Partner Type'
      @UI.lineItem:       [{ position: 330, label: 'Partner Type' }]
      @UI.selectionField: [{ position: 330 }]
      _Ref.ptype       as ptype,

      @EndUserText.label: 'Sender Tax No.'
      @UI.lineItem:       [{ position: 340, label: 'Sender Tax No.' }]
      @UI.selectionField: [{ position: 340 }]
      _Ref.sendertax   as sendertax,

      @EndUserText.label: 'Due Date'
      @UI.lineItem:       [{ position: 350, label: 'Due Date' }]
      @UI.selectionField: [{ position: 350 }]
      _Ref.duedate     as duedate,

      @EndUserText.label: 'Customer PO (ZORDER)'
      @UI.lineItem:       [{ position: 360, label: 'Customer PO (ZORDER)' }]
      @UI.selectionField: [{ position: 360 }]
      _Ref.zorder      as zorder,

      @EndUserText.label: 'Europe Status'
      @UI.lineItem:       [{ position: 370, label: 'Europe Status' }]
      @UI.selectionField: [{ position: 370 }]
      _Ref.europe_stat as europe_stat,

      @EndUserText.label: 'Billing Type'
      @UI.lineItem:       [{ position: 380, label: 'Billing Type' }]
      @UI.selectionField: [{ position: 380 }]
      _Ref.bill_type   as bill_type,

      /* === Navigasyonlar (opsiyonel, Object Page sekmeleri için) === */
      _Ref : redirected to composition child /MLSFT/C_EdRef,
      _Raw : redirected to composition child /MLSFT/C_EdRaw
}
