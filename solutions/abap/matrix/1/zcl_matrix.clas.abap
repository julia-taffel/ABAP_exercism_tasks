CLASS zcl_matrix DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS matrix_row
      IMPORTING
        string        TYPE string
        index         TYPE i
      RETURNING
        VALUE(result) TYPE integertab.
    METHODS matrix_column
      IMPORTING
        string        TYPE string
        index         TYPE i
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: lt_lines   TYPE STANDARD TABLE OF string WITH EMPTY KEY,
          lt_values TYPE STANDARD TABLE OF string WITH EMPTY KEY,
          lv_line    TYPE string,
          lv_value  TYPE string.
ENDCLASS.



CLASS zcl_matrix IMPLEMENTATION.
  METHOD matrix_row.
    SPLIT string AT `\n` INTO TABLE lt_lines.
    READ TABLE lt_lines INDEX index INTO lv_line.
    
    SPLIT lv_line AT space INTO TABLE lt_values.
    result = CONV #( lt_values ).
  ENDMETHOD.



  METHOD matrix_column.    
    SPLIT string AT `\n` INTO TABLE lt_lines.
    LOOP AT lt_lines INTO lv_line.
      SPLIT lv_line AT space INTO TABLE lt_values.

      READ TABLE lt_values INDEX index INTO lv_value.
      APPEND lv_value TO result.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
