CLASS zcl_clock DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !hours   TYPE i
        !minutes TYPE i DEFAULT 0.
    METHODS get
      RETURNING
        VALUE(result) TYPE string.
    METHODS add
      IMPORTING
        !minutes TYPE i.
    METHODS sub
      IMPORTING
        !minutes TYPE i.

  PRIVATE SECTION.
    DATA total_minutes TYPE i.
    METHODS normalize.

ENDCLASS.



CLASS zcl_clock IMPLEMENTATION.

  METHOD add.
    total_minutes = total_minutes + minutes.
    normalize( ).
  ENDMETHOD.


  METHOD constructor.
    total_minutes = ( hours * 60 ) + minutes.
    normalize( ).
  ENDMETHOD.

  METHOD get.
    TYPES t_numc2 TYPE n LENGTH 2.
    DATA(display_hours) = CONV t_numc2( total_minutes DIV 60 ).
    DATA(display_minutes) = CONV t_numc2( total_minutes MOD 60 ).
    result = |{ display_hours }:{ display_minutes }|.
  ENDMETHOD.


  METHOD sub.
    total_minutes = total_minutes - minutes.
    normalize( ).
  ENDMETHOD.

  METHOD normalize.
    total_minutes = total_minutes MOD 1440.
    IF total_minutes < 0.
      total_minutes = total_minutes + 1440.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
