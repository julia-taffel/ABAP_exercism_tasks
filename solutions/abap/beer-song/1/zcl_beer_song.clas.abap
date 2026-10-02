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
    DATA(lv_count) = take_down_count.

    DO take_down_count TIMES.
      DATA(lv_left) = lv_bottles - 1.
      
      IF lv_bottles = 0.
        APPEND VALUE #( 'No more bottles of beer on the wall, no more bottles of beer.' ) TO result.
        APPEND VALUE #( 'Go to the store and buy some more, 99 bottles of beer on the wall.' ) TO result.
      ENDIF.
  
      IF lv_bottles = 1.
        APPEND VALUE #( |{ lv_bottles } bottle of beer on the wall, { lv_bottles } bottle of beer.| ) TO result.
        APPEND VALUE #( |Take it down and pass it around, no more bottles of beer on the wall.| ) TO result.

        lv_bottles = lv_left.
      ENDIF.
  
      IF lv_bottles > 1.
        APPEND VALUE #( |{ lv_bottles } bottles of beer on the wall, { lv_bottles } bottles of beer.| ) TO result.
          
        IF lv_left = 1.
          APPEND VALUE #( |Take one down and pass it around, { lv_left } bottle of beer on the wall.| ) TO result.
        ELSE.
          APPEND VALUE #( |Take one down and pass it around, { lv_left } bottles of beer on the wall.| ) TO result.
        ENDIF.
        lv_bottles = lv_left.
      ENDIF.

      IF lv_count > 1.
        APPEND VALUE #( || ) TO result.
        lv_count = lv_count - 1.
      ENDIF.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
