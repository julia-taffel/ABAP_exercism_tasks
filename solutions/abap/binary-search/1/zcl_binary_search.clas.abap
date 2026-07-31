CLASS zcl_binary_search DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS binary_search
      IMPORTING
        val           TYPE i
        table         TYPE integertab
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_sy_itab_line_not_found.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA lv_mid TYPE i.
ENDCLASS.

CLASS zcl_binary_search IMPLEMENTATION.

  METHOD binary_search.
    DATA(lv_left) = 1.
    DATA(lv_right) = lines( table ).
    
    WHILE lv_left <= lv_right.
      lv_mid = lv_left + ( ( lv_right - lv_left ) DIV 2 ).
      DATA(lv_current_val) = table[ lv_mid ].

      IF lv_current_val = val.
        result = lv_mid.
        RETURN.
      ELSEIF lv_current_val < val.
        lv_left = lv_mid + 1.
      ELSE.
        lv_right = lv_mid - 1.
      ENDIF.
    ENDWHILE.
      
    RAISE EXCEPTION TYPE cx_sy_itab_line_not_found.
    
  ENDMETHOD.
ENDCLASS.
