CLASS zcl_phone_number DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS clean
      IMPORTING
        !number       TYPE string
      RETURNING
        VALUE(result) TYPE string
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_phone_number IMPLEMENTATION.

  METHOD clean.
    result = replace( val   = number
                      pcre  = `[^0-9]`
                      with  = ``           
                      occ   = 0 ).
                      
    
    IF strlen( result ) = 11 AND substring( val = result off = 0 len = 1 ) = `1`.
      result = substring( val = result off = 1 ).
    ENDIF.
    
    IF NOT matches( val  = result 
                    pcre = `^[2-9][0-9]{2}[2-9][0-9]{6}$` ).
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

      " ^      - początek ciągu
      " [2-9]  - pierwszy znak musi być od 2 do 9
      " [0-9]{2}  - potem dokładnie 2 cyfry itd.
      " $      - koniec ciągu
        
  ENDMETHOD.
ENDCLASS.
