CLASS zcl_acronym DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS parse IMPORTING phrase         TYPE string
                  RETURNING VALUE(acronym) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_acronym IMPLEMENTATION.
  METHOD parse.
    DATA(lv_phrase) = phrase.
    REPLACE ALL OCCURENCES OF REGEX ',|-|_' IN lv_phrase WITH ` `.
                      
    SPLIT lv_phrase AT ` ` INTO TABLE DATA(lt_phrase).
    
    acronym = REDUCE string(
      INIT acr = ``
      FOR word IN lt_phrase WHERE ( table_line IS NOT INITIAL )
      NEXT acr = acr && to_upper( word+0(1) ) ).
  ENDMETHOD.
ENDCLASS.
