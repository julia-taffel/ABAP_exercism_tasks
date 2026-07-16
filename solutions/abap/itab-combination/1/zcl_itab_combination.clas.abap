CLASS zcl_itab_combination DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF alphatab_type,
             cola TYPE string,
             colb TYPE string,
             colc TYPE string,
           END OF alphatab_type.
    TYPES alphas TYPE STANDARD TABLE OF alphatab_type.

    TYPES: BEGIN OF numtab_type,
             col1 TYPE string,
             col2 TYPE string,
             col3 TYPE string,
           END OF numtab_type.
    TYPES nums TYPE STANDARD TABLE OF numtab_type.

    TYPES: BEGIN OF combined_data_type,
             colx TYPE string,
             coly TYPE string,
             colz TYPE string,
           END OF combined_data_type.
    TYPES combined_data TYPE STANDARD TABLE OF combined_data_type WITH EMPTY KEY.

    METHODS perform_combination
      IMPORTING
        alphas             TYPE alphas
        nums               TYPE nums
      RETURNING
        VALUE(combined_data) TYPE combined_data.

  PROTECTED SECTION.
  PRIVATE SECTION.


ENDCLASS.

CLASS zcl_itab_combination IMPLEMENTATION.

  METHOD perform_combination.
    FIELD-SYMBOLS: <a_tab> LIKE LINE OF alphas.
    FIELD-SYMBOLS: <n_tab> LIKE LINE OF nums.
    FIELD-SYMBOLS: <c_tab> LIKE LINE OF combined_data.
    
    LOOP AT alphas ASSIGNING <a_tab> .
      DATA(lv_index) = sy-tabix.
      
      READ TABLE nums ASSIGNING <n_tab> INDEX lv_index.

      IF sy-subrc = 0.
        APPEND INITIAL LINE TO combined_data ASSIGNING <c_tab>.
        <c_tab>-colx = |{ <a_tab>-cola }{ <n_tab>-col1 }|.
        <c_tab>-coly = |{ <a_tab>-colb }{ <n_tab>-col2 }|.
        <c_tab>-colz = |{ <a_tab>-colc }{ <n_tab>-col3 }|.
      ENDIF.
    ENDLOOP.   
  ENDMETHOD.

ENDCLASS.
