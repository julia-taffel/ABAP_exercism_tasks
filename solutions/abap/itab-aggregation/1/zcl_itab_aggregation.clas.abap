CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
    FIELD-SYMBOLS: <agg> LIKE LINE OF aggregated_data.
    LOOP AT initial_numbers INTO DATA(ls_row).
      READ TABLE aggregated_data ASSIGNING <agg> WITH KEY group = ls_row-group.

      IF sy-subrc = 0.
        <agg>-count = <agg>-count + 1.
        <agg>-sum   = <agg>-sum + ls_row-number.

        IF ls_row-number < <agg>-min.
          <agg>-min = ls_row-number.
        ENDIF.
        
        IF ls_row-number > <agg>-max.
          <agg>-max = ls_row-number.
        ENDIF.

        <agg>-average = <agg>-sum / <agg>-count.
      ELSE.
        APPEND VALUE #(
        group = ls_row-group
        count = 1
        sum = ls_row-number
        min = ls_row-number
        max = ls_row-number
        average = ls_row-number
        ) TO aggregated_data.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
