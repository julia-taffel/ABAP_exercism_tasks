CLASS zcl_resistor_color_duo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS value
      IMPORTING
        colors       TYPE string_table
      RETURNING
        VALUE(result) TYPE i.
ENDCLASS.

CLASS zcl_resistor_color_duo IMPLEMENTATION.
  METHOD value.
    " COND przypisuje wartość na podstawie warunku
    DATA(val1) = COND i(
      WHEN line_exists( colors[ 1 ] )
      THEN SWITCH i( to_lower( colors[ 1 ] )
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
                      ELSE -1 )
      ELSE 0 ).
    
    DATA(val2) = COND i(
      WHEN line_exists( colors[ 2 ] )
      THEN SWITCH i( to_lower( colors[ 2 ] )
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
                      ELSE -1 )
      ELSE 0 ).

    result = COND i( 
      WHEN lines( colors ) >= 2 THEN ( val1 * 10 ) + val2
      WHEN lines( colors ) = 1 THEN val1
      ELSE 0 ).
      
  ENDMETHOD.
ENDCLASS.
