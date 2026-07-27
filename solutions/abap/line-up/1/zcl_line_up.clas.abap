CLASS zcl_line_up DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS format IMPORTING name          TYPE string
                             number        TYPE i
                   RETURNING VALUE(result) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_line_up IMPLEMENTATION.
  METHOD format.
  "abs() oblicza wartość bezwględną.
    DATA(mod_100) = abs( number ) MOD 100.
    DATA(mod_10)  = abs( number ) MOD 10.
  
    DATA(suffix) = COND string(
      WHEN mod_100 >= 11 AND mod_100 <= 13 THEN 'th'
      WHEN mod_10 = 1 THEN 'st'
      WHEN mod_10 = 2 THEN 'nd'
      WHEN mod_10 = 3 THEN 'rd'
      ELSE 'th' ).

    result = |{ name }, you are the { number }{ suffix } customer we serve today. Thank you!|.
  ENDMETHOD.
ENDCLASS.
