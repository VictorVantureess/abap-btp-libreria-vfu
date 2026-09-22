@AbapCatalog.sqlViewName: 'ZVFI_CLNTS_VFU'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Clientes'
@UI.headerInfo: {
  typeName: 'Cliente',
  typeNamePlural: 'Clientes',
  title: { type: #STANDARD, value: 'Nombre' },
  description: { value: 'Apellidos' }
}
define view ZI_CLIENTES_VFU as select from ztb_clientes_vfu
{
@UI.facet: [
        {
          id: 'DatosCliente',
          purpose: #STANDARD,
          type: #IDENTIFICATION_REFERENCE,
          label: 'Información del Cliente',
          position: 10
        }
      ]

      @UI.lineItem: [{ position: 10 }]
      @UI.identification: [{ position: 10 }]
  key id_cliente  as IdCliente,

      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
      nombre      as Nombre,

      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 30 }]
      apellidos   as Apellidos,

      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 40 }]
      email       as Email,

      @UI.identification: [{ position: 50 }]
      tipo_acceso as TipoAcceso,

      url         as Url
}
