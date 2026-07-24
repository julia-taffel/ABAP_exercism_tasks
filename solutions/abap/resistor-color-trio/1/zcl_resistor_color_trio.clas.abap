CLASS zcl_resistor_color_trio DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS label
      IMPORTING
        colors        TYPE string_table
      RETURNING
        VALUE(result) TYPE string.
    METHODS color_code
      IMPORTING
        color         TYPE string
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_resistor_color_trio IMPLEMENTATION.
  METHOD color_code.
    result = SWITCH i( to_lower( color )
                      WHEN `black`  THEN 0
                      WHEN `brown`  THEN 1
                      WHEN `red`    THEN 2
                      WHEN `orange` THEN 3
                      WHEN `yellow` THEN 4
                      WHEN `green`  THEN 5
                      WHEN `blue`   THEN 6
                      WHEN `violet` THEN 7
                      WHEN `grey`   THEN 8
                      WHEN `white`  THEN 9
                      ELSE 0 ).
  ENDMETHOD.
  METHOD label.
    DATA(val1) = COND i( 
      WHEN line_exists( colors[ 1 ] )
      THEN color_code( colors[ 1 ] )      
      ELSE 0 ).

    DATA(val2) = COND i( 
      WHEN line_exists( colors[ 2 ] )
      THEN color_code( colors[ 2 ] )   
      ELSE 0 ).

    DATA(val3) = COND i( 
      WHEN line_exists( colors[ 3 ] )
      THEN color_code( colors[ 3 ] )
      ELSE 0 ).

      DATA(full_val) = CONV int8( ( val1 * 10 + val2 ) * ( 10 ** val3 ) ).

      result = COND string(                      " MOD reszta z dzielenia 
        WHEN full_val >= 1000000000 AND full_val MOD 1000000000 = 0 
          THEN |{ full_val / 1000000000 } gigaohms|
    
        WHEN full_val >= 1000000 AND full_val MOD 1000000 = 0 
          THEN |{ full_val / 1000000 } megaohms|
    
        WHEN full_val >= 1000 AND full_val MOD 1000 = 0 
          THEN |{ full_val / 1000 } kiloohms|
          
        ELSE 
          |{ full_val } ohms| 
      ).
  ENDMETHOD.
ENDCLASS.
