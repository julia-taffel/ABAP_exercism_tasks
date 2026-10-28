CLASS zcl_isbn_verifier DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS is_valid
      IMPORTING
        VALUE(isbn)   TYPE string
      RETURNING
        VALUE(result) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_isbn_verifier IMPLEMENTATION.
  METHOD is_valid.
    result = abap_false.
    DATA(lv_isbn) = replace( val  = isbn
                             sub  = `-`
                             with = ``
                             occ  = 0 ).

    IF strlen( lv_isbn ) <> 10 
       OR lv_isbn+0(9) CN `0123456789` 
       OR lv_isbn+9(1) CN `0123456789X`.
        RETURN.
    ENDIF.
    
    DATA(lv_sum) = 0.
    
    DO 10 TIMES.
      DATA(lv_pos) = sy-index - 1.
      DATA(lv_count) = 11 - sy-index.
      
      DATA(lv_num) = COND i( WHEN lv_isbn+lv_pos(1) = 'X' THEN 10 
                             ELSE CONV i( lv_isbn+lv_pos(1) ) ).
                            
      lv_sum += lv_num * lv_count. 
    ENDDO.
    
    result = xsdbool( lv_sum MOD 11 = 0 ).
  ENDMETHOD.


ENDCLASS.
