CLASS zcl_darts DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        x             TYPE f
        y             TYPE f
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: lv_dist TYPE f,
          dx TYPE f,
          dy TYPE f.
ENDCLASS.


CLASS zcl_darts IMPLEMENTATION.
  METHOD score.
    dx = x - 0.
    dy = y - 0.
    lv_dist = sqrt( ( dx ** 2 ) + ( dy ** 2 ) ).
    
    result = COND #(
      WHEN lv_dist > 10
        THEN 0
      WHEN lv_dist > 5
        THEN 1
      WHEN lv_dist > 1
        THEN 5
      ELSE 10 ).
  ENDMETHOD.


ENDCLASS.
