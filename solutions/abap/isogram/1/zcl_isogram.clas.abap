CLASS zcl_isogram DEFINITION PUBLIC.

  PUBLIC SECTION.
    METHODS is_isogram
      IMPORTING
        VALUE(phrase)        TYPE string
      RETURNING
        VALUE(result) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_isogram IMPLEMENTATION.

  METHOD is_isogram.
    result = abap_true.
    phrase = to_upper( phrase ).
    REPLACE ALL OCCURRENCES OF REGEX '[^A-Z]' IN phrase WITH ''.
    
    DO strlen( phrase ) TIMES.
      DATA(lv_char) = substring( val = phrase
                                 off = sy-index - 1
                                 len = 1 ).
                                 
      IF count( val = phrase sub = lv_char ) > 1.
        result = abap_false.
        RETURN.
      ENDIF.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
