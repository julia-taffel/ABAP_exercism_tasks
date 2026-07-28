CLASS zcl_prime_factors DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS factors
      IMPORTING
        input         TYPE int8
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_prime_factors IMPLEMENTATION.
  METHOD factors.
    DATA(lv_remainder) = input.
    IF lv_remainder < 2.
      RETURN.
    ENDIF.
    
    WHILE lv_remainder MOD 2 = 0.
      APPEND 2 TO result.
      lv_remainder = lv_remainder / 2.
    ENDWHILE.

    DATA(lv_divisor) = CONV int8( 3 ). "CONV zmienia typ zmiennej.

    WHILE lv_divisor * lv_divisor <= lv_remainder.
      WHILE lv_remainder MOD lv_divisor = 0.
        APPEND lv_divisor TO result.
        lv_remainder = lv_remainder / lv_divisor.
      ENDWHILE.
      lv_divisor += 2.
    ENDWHILE.

    IF lv_remainder > 2.
      APPEND lv_remainder TO result.
    ENDIF.
  ENDMETHOD.


ENDCLASS.
