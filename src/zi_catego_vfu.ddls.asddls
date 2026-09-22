@AbapCatalog.sqlViewName: 'ZVFI_CATEG_VFU'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Catego'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_CATEGO_VFU as select from ztb_catego_vfuen
{
    @ObjectModel.text.element: ['Descripcion']
  key bi_categ    as BiCateg,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'Descripción Categoría'
      descripcion as Descripcion
}
