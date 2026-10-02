CLASS zcl_beer_song DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS recite
      IMPORTING
        !initial_bottles_count TYPE i
        !take_down_count       TYPE i
      RETURNING
        VALUE(result)          TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_beer_song IMPLEMENTATION.

  METHOD recite.
    DATA(lv_bottles) = initial_bottles_count.

    DO take_down_count TIMES.
      DATA(lv_left) = lv_bottles - 1.
      
      CASE lv_bottles.
        WHEN 0.
          APPEND |No more bottles of beer on the wall, no more bottles of beer.| TO result.
          APPEND |Go to the store and buy some more, 99 bottles of beer on the wall.| TO result.
          lv_bottles = 99.
          
        WHEN 1.
          APPEND |{ lv_bottles } bottle of beer on the wall, { lv_bottles } bottle of beer.| TO result.
          APPEND |Take it down and pass it around, no more bottles of beer on the wall.| TO result.
          lv_bottles = lv_left.

        WHEN OTHERS.
          APPEND |{ lv_bottles } bottles of beer on the wall, { lv_bottles } bottles of beer.| TO result.
          APPEND |Take one down and pass it around, { lv_left } { COND string( WHEN lv_left = 1 
                         THEN 'bottle'
                         ELSE 'bottles' ) } of beer on the wall.| TO result.
          lv_bottles = lv_left.
      ENDCASE.
      
      IF sy-index < take_down_count.
        APPEND || TO result.
      ENDIF.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
