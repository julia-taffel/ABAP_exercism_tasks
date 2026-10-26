CLASS zcl_armstrong_numbers DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS is_armstrong_number IMPORTING num           TYPE i
                                RETURNING VALUE(result) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_armstrong_numbers IMPLEMENTATION.
  METHOD is_armstrong_number.
    DATA(lv_num) = CONV string( num ).
    DATA(lv_len) = strlen( lv_num ) - 1.
    
    DATA(lv_sum) = REDUCE i(
      INIT sum = 0
      FOR i = 0 WHILE i < lv_len
      NEXT sum = sum + CONV i( substring( val = lv_num off = i len = 1 ) ) ** lv_len ).
           
    result = xsdbool( lv_sum = num ).
  ENDMETHOD.
ENDCLASS.

