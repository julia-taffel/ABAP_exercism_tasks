CLASS zcl_flower_field DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS annotate
        IMPORTING
          !input        TYPE string_table
        RETURNING
          VALUE(result) TYPE string_table.

    DATA: lv_new_row        TYPE string.
  
ENDCLASS.

CLASS zcl_flower_field IMPLEMENTATION.
  
  METHOD annotate.
    IF input IS INITIAL.
      EXIT.
    ENDIF.

    LOOP AT input ASSIGNING FIELD-SYMBOL(<row>).
      CLEAR lv_new_row.
      DATA(lv_row_num) = sy-tabix.
      DATA(lv_last_col) = strlen( <row> ).

      IF lv_last_col = 0.
        APPEND `` TO result.
        CONTINUE.
      ENDIF.

      DO lv_last_col TIMES.
        DATA(lv_col_num) = sy-index - 1.
        DATA(value) = <row>+lv_col_num(1).
        
        IF value = '*'.
          lv_new_row = lv_new_row && '*'.
          CONTINUE.
        ENDIF.
        
        DATA(lv_count) = 0.
        
        "delta row i delta column, czyli offsety
        DO 3 TIMES.
          DATA(dr) = sy-index - 2.
          DO 3 TIMES.
            DATA(dc) = sy-index - 2.
              
            IF dr = 0 AND dc = 0.
              CONTINUE.
            ENDIF.

            "neighbor row and neighbor column
            DATA(nr) = lv_row_num + dr.
            DATA(nc) = lv_col_num + dc.
                
            IF nr >= 1 AND nr <= lines( input ) AND
               nc >= 0 AND nc < strlen( input[ nr ] ).
                   
              DATA(lv_next_row) = input[ nr ].
              IF lv_next_row+nc(1) = '*'.
                lv_count += 1.
              ENDIF.
            ENDIF.
          ENDDO.
        ENDDO.
        
        IF lv_count > 0. 
          lv_new_row = lv_new_row && |{ lv_count }|.
        ELSE.
          lv_new_row = lv_new_row && value.
        ENDIF.
      ENDDO.
      
      APPEND lv_new_row TO result.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
