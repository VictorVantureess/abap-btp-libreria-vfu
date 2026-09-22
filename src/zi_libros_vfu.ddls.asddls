@AbapCatalog.sqlViewName: 'ZVFI_LIBROS_VFU'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Root - Listado y Detalle de Libros'

@Search.searchable: true

@UI.headerInfo: {
  typeName: 'Libro',
  typeNamePlural: 'Libros',
  title: { type: #STANDARD, value: 'Titulo' },
  description: { value: 'Autor' }
}

define root view ZI_LIBROS_VFU
  as select from ZI_LIB_VENTAS_VFU as Libro

  composition [0..*] of ZI_CLNTS_LIB_VFU as _ClientesLibro
  association [0..1] to ZI_CATEGO_VFU    as _Categoria on $projection.BiCateg = _Categoria.BiCateg
{
      @UI.facet: [
        {
          id: 'DetalleLibro',
          purpose: #STANDARD,
          type: #COLLECTION,
          label: 'Detalles del Libro',
          position: 10
        },
        {
          id: 'GeneralData',
          parentId: 'DetalleLibro',
          type: #FIELDGROUP_REFERENCE,
          label: 'Información General',
          targetQualifier: 'DatosGenerales',
          position: 10
        },
        {
          id: 'ClientesTab',
          purpose: #STANDARD,
          type: #LINEITEM_REFERENCE,
          label: 'Clientes que adquirieron el libro',
          targetElement: '_ClientesLibro',
          position: 20
        }
      ]

      @UI.lineItem: [{ position: 10, importance: #HIGH }]
      @UI.fieldGroup: [{ qualifier: 'DatosGenerales', position: 10 }]
  key Libro.IdLibro       as IdLibro,

      -- Punto 1: Búsqueda mediante 'selectionField' sobre 'titulo'
      @UI.selectionField: [{ position: 10 }]
      @UI.lineItem: [{ position: 20, importance: #HIGH }]
      @UI.fieldGroup: [{ qualifier: 'DatosGenerales', position: 20 }]
      Libro.Titulo        as Titulo,

      @UI.lineItem: [{ position: 30 }]
      @UI.fieldGroup: [{ qualifier: 'DatosGenerales', position: 30 }]
      Libro.Autor         as Autor,

      -- Punto 1: Búsqueda con 'Search.searchable' sobre 'editorial'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @UI.lineItem: [{ position: 40 }]
      @UI.fieldGroup: [{ qualifier: 'DatosGenerales', position: 40 }]
      Libro.Editorial     as Editorial,

      -- Punto 1: Value Help sobre 'categoria' conectando a ZI_CATEGO_VFU
      @UI.selectionField: [{ position: 20 }]
      @UI.lineItem: [{ position: 50 }]
      @UI.fieldGroup: [{ qualifier: 'DatosGenerales', position: 50 }]
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CATEGO_VFU', element: 'BiCateg' } }]
      @ObjectModel.text.association: '_Categoria'
      Libro.BiCateg       as BiCateg,

      @UI.lineItem: [{ position: 60 }]
      @UI.fieldGroup: [{ qualifier: 'DatosGenerales', position: 60 }]
      Libro.Precio        as Precio,

      @Semantics.currencyCode: true
      Libro.Moneda        as Moneda,

      @UI.lineItem: [{ position: 70 }]
      Libro.Formato       as Formato,

      Libro.Url           as Url,

      -- Punto 1: Criticidad evaluada sobre CantidadVentas (provenido de ZI_LIB_VENTAS_VFU)
      @UI.lineItem: [{ position: 80, criticality: 'VentasCriticality', criticalityRepresentation: #WITHOUT_ICON }]
      case 
        when Libro.CantidadVentas = 0 then 'Sin ventas'
        when Libro.CantidadVentas > 0 and Libro.CantidadVentas <= 2 then 'Pocas ventas'
        when Libro.CantidadVentas > 2 and Libro.CantidadVentas <= 5 then 'Ventas medias'
        else 'Ventas altas'
      end                 as EstadoVentas,

      case 
        when Libro.CantidadVentas = 0 then 1 
        when Libro.CantidadVentas > 0 and Libro.CantidadVentas <= 2 then 2 
        when Libro.CantidadVentas > 2 and Libro.CantidadVentas <= 5 then 3 
        else 0                                     
      end                 as VentasCriticality,

      /* Asociaciones */
      _ClientesLibro,
      _Categoria
}
