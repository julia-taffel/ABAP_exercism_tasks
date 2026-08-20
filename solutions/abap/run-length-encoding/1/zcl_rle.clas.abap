CLASS zcl_rle DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS encode IMPORTING input         TYPE string
                   RETURNING VALUE(result) TYPE string.

    METHODS decode IMPORTING input         TYPE string
                   RETURNING VALUE(result) TYPE string.

  PRIVATE SECTION.
    DATA: lv_result TYPE string,
          lv_count  TYPE i.
ENDCLASS.


CLASS zcl_rle IMPLEMENTATION.

  METHOD encode.
    IF input IS INITIAL. 
      RETURN.
    ENDIF.

    lv_count = 0.
    DATA(lv_char) = substring( val = input off = 0 len = 1 ).
    
    DO strlen( input ) TIMES.
      DATA(lv_current) = substring( val = input off = sy-index - 1 len = 1 ).

      IF lv_current = lv_char.
        lv_count += 1.
      ELSE.
        IF lv_count > 1.
          result = result && |{ lv_count }| && lv_char.
        ELSE.
          result = result && lv_char.
        ENDIF.
        
        lv_char = lv_current.
        lv_count = 1.
      ENDIF.
    ENDDO.

    IF lv_count > 1.
      result = result && |{ lv_count }| && lv_char.
    ELSE.
      result = result && lv_char.
    ENDIF.
  ENDMETHOD.


  METHOD decode.
    IF input IS INITIAL.
      RETURN.
    ENDIF.
    
    lv_count = 0.
    DATA(lv_multiplier) = ``.

    DO strlen( input ) TIMES.
      DATA(lv_char) = substring( val = input off = sy-index - 1 len = 1 ).
      
      IF lv_char CO '0123456789'.
        lv_multiplier = lv_multiplier && lv_char.
      ELSE.
        DATA(lv_occ) = COND i( WHEN lv_multiplier IS INITIAL THEN 1
                               ELSE CONV i( lv_multiplier ) ).

        result = result && repeat( val = lv_char occ = lv_occ ).

        CLEAR lv_multiplier.
      ENDIF.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
