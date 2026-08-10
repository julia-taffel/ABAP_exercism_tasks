CLASS zcl_space_age DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES age_in_years TYPE p LENGTH 3 DECIMALS 2.
    METHODS age
      IMPORTING
        planet        TYPE string
        seconds       TYPE i
      RETURNING
        VALUE(result) TYPE age_in_years
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: lv_period TYPE decfloat34.
ENDCLASS.


CLASS zcl_space_age IMPLEMENTATION.
  METHOD age.
    CASE planet.
      WHEN 'Mercury'. lv_period = '0.2408467'.
      WHEN 'Venus'.   lv_period = '0.61519726'.
      WHEN 'Earth'.   lv_period = '1.0'.
      WHEN 'Mars'.    lv_period = '1.8808158'.
      WHEN 'Jupiter'. lv_period = '11.862615'.
      WHEN 'Saturn'.  lv_period = '29.447498'.
      WHEN 'Uranus'.  lv_period = '84.016846'.
      WHEN 'Neptune'. lv_period = '164.79132'.
      WHEN OTHERS.
        RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDCASE.

    DATA(lv_years) = seconds / CONV decfloat34( '31557600' ).
    result = lv_years / lv_period.
  ENDMETHOD.


ENDCLASS.
