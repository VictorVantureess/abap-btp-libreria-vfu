@AbapCatalog.sqlViewName: 'ZVFI_CLIB_VFU'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Clientes por Libro'

define view ZI_CLNTS_LIB_VFU
  as select from ztb_clnts_lib_vf as ClientesLibro

  -- Asociación al Libro (Vista padre)
  association to parent ZI_LIBROS_VFU as _Libro   on $projection.IdLibro = _Libro.IdLibro

  -- Asociación al Detalle del Cliente (Punto 3 - Navegación)
  association [1..1] to ZI_CLIENTES_VFU as _Cliente on $projection.IdCliente = _Cliente.IdCliente
{
      @UI.lineItem: [{ position: 10 }]
  key id_libro   as IdLibro,

      @UI.lineItem: [{ position: 20 }]
  key id_cliente as IdCliente,

      /* Asociaciones expuestas */
      _Libro,
      _Cliente
}
