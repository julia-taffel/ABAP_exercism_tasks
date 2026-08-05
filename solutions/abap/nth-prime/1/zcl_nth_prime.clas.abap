CLASS zcl_nth_prime DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS prime
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
      tt_primes TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    DATA lt_primes TYPE tt_primes.
ENDCLASS.


CLASS zcl_nth_prime IMPLEMENTATION.
  METHOD prime.
    "znajduje liczbę pierwszą na pozycji n
    IF input <= 0.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ELSEIF input = 1.
      result = 2.
    ENDIF.
    APPEND 2 TO lt_primes.
    
    DATA(lv_candidate) = 3.
    WHILE lines( lt_primes ) < input.
      DATA(lv_is_prime) = abap_true.
      
      LOOP AT lt_primes ASSIGNING FIELD-SYMBOL(<prime>).
        IF <prime> * <prime> > lv_candidate.
          EXIT.
        ENDIF.
        
        IF lv_candidate MOD <prime> = 0.
          lv_is_prime = abap_false.
          EXIT.
        ENDIF.
      ENDLOOP.

      IF lv_is_prime = abap_true.
        APPEND lv_candidate TO lt_primes.
      ENDIF.
      
      lv_candidate += 2.
    ENDWHILE.

    result = lt_primes[ input ].
  ENDMETHOD.


ENDCLASS.
