CLASS zcl_secret_handshake DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_commands
      IMPORTING code            TYPE i
      RETURNING VALUE(commands) TYPE string_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: bin_code TYPE string_table.
ENDCLASS.



CLASS zcl_secret_handshake IMPLEMENTATION.

  METHOD get_commands.
    DATA(lv_temp) = code.
    WHILE lv_temp > 0.
      APPEND VALUE #( lv_temp MOD 2 ) TO bin_code.
      lv_temp = lv_temp DIV 2.
    ENDWHILE.

    DATA(is_reverse) = abap_false.
    LOOP AT bin_code INTO DATA(lv_val) STEP -1.
      IF lv_val = 1.
        CASE sy-tabix.
          WHEN 1.
            APPEND |wink| TO commands.
          WHEN 2.
            APPEND |double blink| TO commands.
          WHEN 3.
            APPEND |close your eyes| TO commands.
          WHEN 4.
            APPEND |jump| TO commands.
          WHEN 5. 
            is_reverse = abap_true.
        ENDCASE.
      ENDIF.
    ENDLOOP.

    IF is_reverse = abap_true AND commands IS NOT INITIAL.
      commands = VALUE string_table( FOR i = lines( commands ) THEN i - 1 UNTIL i = 0 ( commands[ i ] ) ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.
