CLASS zcl_anagram DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS anagram
      IMPORTING
        input         TYPE string
        candidates    TYPE string_table
      RETURNING
        VALUE(result) TYPE string_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_anagram IMPLEMENTATION.
  METHOD anagram.
    DATA(lv_word) = to_upper( input ).
    DATA(lt_chars) = VALUE string_table(
      FOR i = 0 UNTIL i = strlen( lv_word )
      ( substring( val = lv_word off = i len = 1 ) ) ).
    
    LOOP AT candidates INTO DATA(lv_candidate).
      DATA(lv_norm) = to_upper( lv_candidate ).
      
      IF lv_norm = lv_word.
        CONTINUE.
      ELSEIF strlen( lv_norm ) <> strlen( lv_word ).
        CONTINUE.
      ELSE.
        DATA(lv_is_anagram) = abap_true.
        
        LOOP AT lt_chars INTO DATA(lv_char).
          REPLACE FIRST OCCURENCE OF lv_char IN lv_norm WITH ``.
          IF sy-subrc <> 0.
            lv_is_anagram = abap_false.
            EXIT.
          ENDIF.
        ENDLOOP.

        IF lv_is_anagram = abap_true.
          APPEND lv_candidate TO result.
        ENDIF.
        
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
