CLASS zcl_hamming DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS hamming_distance
      IMPORTING
        first_strand  TYPE string
        second_strand TYPE string
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.
ENDCLASS.

CLASS zcl_hamming IMPLEMENTATION.

  METHOD hamming_distance.
    IF strlen( first_strand ) <> strlen( second_strand ).
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    DATA(lv_length) = strlen( first_strand ).

    IF lv_length = 0.
      result = 0.
      RETURN.
    ENDIF.
    
    result = REDUCE i(
      INIT dist = 0
      FOR i = 0 UNTIL i = lv_length
      NEXT dist = dist + COND i( 
        WHEN first_strand+i(1) <> second_strand+i(1) THEN 1 
        ELSE 0 ) ).
        "zapis ...+i(1) pobiera jeden znak na pozycji i
  ENDMETHOD.

ENDCLASS.
