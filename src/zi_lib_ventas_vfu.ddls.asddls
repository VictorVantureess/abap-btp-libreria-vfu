@AbapCatalog.sqlViewName: 'ZVFI_LIBVNT_VFU'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Base - Conteo de Ventas'

define view ZI_LIB_VENTAS_VFU
  as select from ztb_libros_vfuen as Libro
  left outer join ztb_clnts_lib_vf as Ventas on Libro.id_libro = Ventas.id_libro
{
  key Libro.id_libro                      as IdLibro,
      Libro.titulo                        as Titulo,
      Libro.autor                         as Autor,
      Libro.editorial                     as Editorial,
      Libro.bi_categ                      as BiCateg,
      Libro.precio                        as Precio,
      Libro.moneda                        as Moneda,
      Libro.formato                       as Formato,
      Libro.url                           as Url,
      count( distinct Ventas.id_cliente ) as CantidadVentas
}
group by
  Libro.id_libro,
  Libro.titulo,
  Libro.autor,
  Libro.editorial,
  Libro.bi_categ,
  Libro.precio,
  Libro.moneda,
  Libro.formato,
  Libro.url
