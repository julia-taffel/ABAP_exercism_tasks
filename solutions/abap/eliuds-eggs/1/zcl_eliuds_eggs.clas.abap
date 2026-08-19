CLASS zcl_eliuds_eggs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS egg_count IMPORTING number       TYPE i
                      RETURNING VALUE(count) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_eliuds_eggs IMPLEMENTATION.
  METHOD egg_count.
    IF number = 0.
      count = 0.
    ELSE.
      DATA(lv_num) = number.
      DATA(lv_binar) = ``.
      
      WHILE lv_num <> 0.
        lv_binar = |{ lv_num MOD 2 }{ lv_binar }|.
        lv_num = lv_num DIV 2.
      ENDWHILE.
      
      count = REDUCE i(
        INIT c = 0
        FOR i = 0 UNTIL i = strlen( lv_binar )
        NEXT c = COND i(
          WHEN substring( val = lv_binar off = i len = 1 ) = '1' THEN c + 1
          ELSE c + 0 ) ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
