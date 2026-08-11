CLASS zcl_nucleotide_count DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF count_by_nucleotide,
        nucleotide TYPE c LENGTH 1,
        count      TYPE i,
      END OF count_by_nucleotide,
      ty_nucleotide_counts TYPE STANDARD TABLE OF count_by_nucleotide WITH KEY nucleotide.
    METHODS nucleotide_counts
      IMPORTING
        strand        TYPE string
      RETURNING
        VALUE(result) TYPE ty_nucleotide_counts
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_nucleotide_count IMPLEMENTATION.
  METHOD nucleotide_counts.
    result = VALUE ty_nucleotide_counts(
      ( nucleotide = 'A' count = 0 )
      ( nucleotide = 'C' count = 0 )
      ( nucleotide = 'G' count = 0 )
      ( nucleotide = 'T' count = 0 )
    ).
  
    DO strlen( strand ) TIMES.
      DATA(lv_char) = substring( val = strand 
                                   off = sy-index - 1 
                                   len = 1 ).

      READ TABLE result ASSIGNING FIELD-SYMBOL(<fs_result>) WITH KEY nucleotide = lv_char.
      
      IF sy-subrc = 0.
        <fs_result>-count += 1.
      ELSE. 
        RAISE EXCEPTION TYPE cx_parameter_invalid.
      ENDIF.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
