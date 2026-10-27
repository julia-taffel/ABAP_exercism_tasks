CLASS zcl_collatz_conjecture DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS ret_steps IMPORTING num          TYPE i
                      RETURNING VALUE(steps) TYPE i
                      RAISING   cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_collatz_conjecture IMPLEMENTATION.
  METHOD ret_steps.
    steps = 0.
    IF num < 1.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ELSEIF num = 1.
      EXIT.
    ENDIF.

    DATA(lv_num) = num.
    WHILE lv_num > 1.
      CASE lv_num MOD 2.
        WHEN 0.
          lv_num /= 2.
        WHEN 1.
          lv_num = lv_num * 3 + 1.
      ENDCASE.
      
      steps += 1.
    ENDWHILE.
  ENDMETHOD.
ENDCLASS.
