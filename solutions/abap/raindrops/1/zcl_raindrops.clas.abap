CLASS zcl_raindrops DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS raindrops
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_raindrops IMPLEMENTATION.

  METHOD raindrops.
    DATA(lv_text) = REDUCE string(
      INIT text = ``
      FOR lv_div = 3 THEN lv_div + 2 UNTIL lv_div > 7
      NEXT text = text && COND string(
        WHEN input MOD lv_div = 0 THEN 
          SWITCH string( lv_div
            WHEN 3 THEN 'Pling'
            WHEN 5 THEN 'Plang'
            WHEN 7 THEN 'Plong'
          )
        ELSE '' ) ).

    result = COND #(
      WHEN lv_text IS INITIAL THEN |{ input }| 
      ELSE lv_text
    ).
  ENDMETHOD.

ENDCLASS.
