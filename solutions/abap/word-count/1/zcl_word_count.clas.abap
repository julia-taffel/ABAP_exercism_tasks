CLASS zcl_word_count DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF return_structure,
        word  TYPE string,
        count TYPE i,
      END OF return_structure,
      return_table TYPE STANDARD TABLE OF return_structure WITH KEY word.
    METHODS count_words
      IMPORTING
        !phrase       TYPE string
      RETURNING
        VALUE(result) TYPE return_table .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: lt_text TYPE string_table,
          lv_word TYPE string.
ENDCLASS.


CLASS zcl_word_count IMPLEMENTATION.

  METHOD count_words.
    DATA(lv_phrase) = to_lower( phrase ).
    
    REPLACE ALL OCCURRENCES OF '\n' IN lv_phrase WITH ` `.
    REPLACE ALL OCCURRENCES OF '\t' IN lv_phrase WITH ` `.
    REPLACE ALL OCCURRENCES OF `'` IN lv_phrase WITH ``.
    REPLACE ALL OCCURRENCES OF REGEX '[^a-z0-9]' IN lv_phrase WITH ` `.
    
    SPLIT lv_phrase AT ' ' INTO TABLE lt_text.
      
    LOOP AT lt_text INTO lv_word.
      IF lv_word IS INITIAL.
        CONTINUE.
      ENDIF.
      
      READ TABLE result ASSIGNING FIELD-SYMBOL(<ls_result>) WITH KEY word = lv_word.

      IF sy-subrc = 0.
        <ls_result>-count = <ls_result>-count + 1.
      ELSE.
        INSERT VALUE #( word  = lv_word
                      count = 1 ) INTO TABLE result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
