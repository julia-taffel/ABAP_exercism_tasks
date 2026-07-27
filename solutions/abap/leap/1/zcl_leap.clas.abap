CLASS zcl_leap DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS leap
      IMPORTING
        year          TYPE i
      RETURNING
        VALUE(result) TYPE abap_bool.
ENDCLASS.

CLASS zcl_leap IMPLEMENTATION.

  METHOD leap.
  " COND sprawdza od góry do dołu, jak 1. zostanie spełniony, przypisuje wynik i kończy działanie
    result = COND abap_bool(
      WHEN year MOD 400 = 0 THEN 'X'
      WHEN year MOD 100 = 0 THEN ' '
      WHEN year MOD 4 = 0   THEN 'X'
      ELSE ' ' ).
  ENDMETHOD.

ENDCLASS.
