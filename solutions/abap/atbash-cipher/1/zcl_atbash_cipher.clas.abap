CLASS zcl_atbash_cipher DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS decode
      IMPORTING
        cipher_text TYPE string
      RETURNING
        VALUE(plain_text)  TYPE string .
    METHODS encode
      IMPORTING
        plain_text        TYPE string
      RETURNING
        VALUE(cipher_text) TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS:
      c_alphabet TYPE string VALUE 'abcdefghijklmnopqrstuvwxyz',
      c_reversed TYPE string VALUE 'zyxwvutsrqponmlkjihgfedcba'.
ENDCLASS.



CLASS zcl_atbash_cipher IMPLEMENTATION.

  METHOD decode.
    DATA(lv_text) = to_lower( cipher_text ).
    REPLACE ALL OCCURRENCES OF REGEX '[^a-z0-9]' IN lv_text WITH ''.
    "zamiana wszystkiego oprócz a-z i 0-9

    "translate() funkcja z operacją podmiany
    plain_text = translate( val  = lv_text
                            from = c_alphabet
                            to   = c_reversed ).
  ENDMETHOD.

  METHOD encode.
    DATA(lv_text) = to_lower( plain_text ).
    REPLACE ALL OCCURRENCES OF REGEX '[^a-z0-9]' IN lv_text WITH ''.
    DATA(lv_ciphered) = translate( val  = lv_text
                                 from = c_alphabet
                                 to   = c_reversed ).
    
    DATA(lv_length) = strlen( lv_ciphered ).
    IF lv_length > 5.
      DATA(lv_offset) = 0.
  
      WHILE lv_offset < lv_length.
        DATA(lv_chunk_len) = nmin( val1 = 5
                                   val2 = lv_length - lv_offset ).
                          "nmin() minimum z dwóch wartości
                          
        DATA(lv_chunk) = substring( val = lv_ciphered
                                    off = lv_offset
                                    len = lv_chunk_len ).
  
        IF cipher_text IS INITIAL.
          cipher_text = lv_chunk.
        ELSE.
          cipher_text = |{ cipher_text } { lv_chunk }|.
        ENDIF.

        lv_offset = lv_offset + 5.
      ENDWHILE.
    ELSE.
      cipher_text = lv_ciphered.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
