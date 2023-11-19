CLASS zcl_products_handler DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES ty_product_type TYPE zproducts000-product_type.
    CONSTANTS: BEGIN OF product_types,
                 t1 TYPE ty_product_type VALUE 001,
                 t2 TYPE ty_product_type VALUE 002,
                 t3 TYPE ty_product_type VALUE 003,
                 t4 TYPE ty_product_type VALUE 004,
               END OF product_types,
               BEGIN OF currencies,
                 eur TYPE zproducts000-curr VALUE 'EUR',
                 usd TYPE zproducts000-curr VALUE 'USD',

               END OF currencies.
    INTERFACES: if_oo_adt_classrun.
    CLASS-METHODS:
      clear_products,
      generate_products IMPORTING size TYPE i.
  PROTECTED SECTION.
*    METHODS:
*      GET_RANDOM IMPORTING TYPE
  PRIVATE SECTION.
    METHODS:
      factory RETURNING VALUE(r_instance) TYPE REF TO zcl_products_handler.
ENDCLASS.

CLASS zcl_products_handler IMPLEMENTATION.
  METHOD clear_products.
    DELETE FROM zproducts000.
    IF sy-subrc = 0.
      COMMIT WORK AND WAIT.
    ENDIF.
  ENDMETHOD.

  METHOD generate_products.
    DATA lt_products TYPE TABLE OF zproducts000.
    DATA lv_component TYPE i.
    FIELD-SYMBOLS: <fs_type> TYPE ty_product_type.
    DO size TIMES.
      APPEND INITIAL LINE TO lt_products ASSIGNING FIELD-SYMBOL(<fs_product>).
      <fs_product>-productid = sy-index.
      lv_component = sy-index MOD 4.
      ASSIGN COMPONENT lv_component OF STRUCTURE product_types TO <fs_type>.
      <fs_product>-product_type = <fs_type>.
      <fs_product>-price = '1000.00'.
      <fs_product>-curr = currencies-eur.
      <fs_product>-product_name = |Product{ sy-index }|.
    ENDDO.

    MODIFY zproducts000 FROM TABLE @lt_products.


  ENDMETHOD.

  METHOD factory.
    r_instance = NEW zcl_products_handler(  ).
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    zcl_products_handler=>clear_products( ).
    zcl_products_handler=>generate_products( 200 ).
    out->write( '200 Entries generated!' ).
  ENDMETHOD.

ENDCLASS.
