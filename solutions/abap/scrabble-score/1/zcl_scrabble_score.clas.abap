CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD score.
    IF input IS INITIAL. " pusty ciąg znaków
      result = 0.
      RETURN.
    ENDIF.
  
    DATA(lv_normal) = to_upper( input ).
    DATA(lv_length) = strlen( lv_normal ).
    
    result = REDUCE i( " redukcja danych do pojedyńczej wartości
      INIT sum = 0
      FOR i = 0 UNTIL i >= lv_length
        NEXT sum = sum + SWITCH i( substring( val = lv_normal off = i len = 1 ) 
        " switch podobne do case, zwrócenie wartości do równania bez konieczności rozpisywania operacji przypisania
          WHEN 'A' OR 'E' OR 'I' OR 'O' OR 'U' OR 'L' OR 'N' OR 'R' OR 'S' OR 'T' THEN 1
          WHEN 'D' OR 'G' THEN 2
          WHEN 'B' OR 'C' OR 'M' OR 'P' THEN 3
          WHEN 'F' OR 'H' OR 'V' OR 'W' OR 'Y' THEN 4
          WHEN 'K' THEN 5
          WHEN 'J' OR 'X' THEN 8
          WHEN 'Q' OR 'Z' THEN 10
          ELSE 0
        )
    ).
  ENDMETHOD.

ENDCLASS.
