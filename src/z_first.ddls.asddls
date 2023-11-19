@AbapCatalog.sqlViewName: 'Z_FIRST_SQL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'First CDS View'
define view Z_First
  as select from zproducts000
{
  key productid    as Productid,
  key product_type as ProductType,
      product_name as ProductName,
      price        as Price,
      curr         as Curr
}
