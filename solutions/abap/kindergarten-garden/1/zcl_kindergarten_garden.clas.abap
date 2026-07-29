CLASS zcl_kindergarten_garden DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor.
    METHODS plants
      IMPORTING                                  "Przykładowy diagram:
        diagram        TYPE string               "[window][window][window]
        student        TYPE string               "VRCGVVRVCGGCCGVRGCVCGCGV
      RETURNING                                  "VRCCCGCRRGVCGCRVVCVGCGCV
        VALUE(results) TYPE string_table.
    
    METHODS plant_encoding
      IMPORTING
        plant_code      TYPE string
      RETURNING
        VALUE(lv_plant) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA students TYPE string_table.

ENDCLASS.


CLASS zcl_kindergarten_garden IMPLEMENTATION.
  METHOD constructor.
    students = VALUE #( ( `Alice` ) ( `Bob` ) ( `Charlie` ) ( `David` )
                        ( `Eve` ) ( `Fred` ) ( `Ginny` ) ( `Harriet` )
                        ( `Ileana` ) ( `Joseph` ) ( `Kincaid` ) ( `Larry` ) ).
  ENDMETHOD.
  
  METHOD plant_encoding.
    lv_plant = SWITCH #( to_upper( plant_code )
        WHEN 'G' THEN 'grass'
        WHEN 'C' THEN 'clover'
        WHEN 'R' THEN 'radishes'
        WHEN 'V' THEN 'violets'
        ELSE 'None' ).
  ENDMETHOD.

  METHOD plants.  
    DATA(lv_index) = line_index( students[ table_line = student ] ).
    IF lv_index = 0.
      RETURN.
    ENDIF.

    SPLIT diagram AT '\n' INTO TABLE DATA(lt_diagram).
    
    DATA(lv_offset) = ( lv_index - 1 ) * 2. 

    LOOP AT lt_diagram ASSIGNING FIELD-SYMBOL(<row>).
      DO 2 TIMES.
        DATA(plant_code) = substring( val = <row> off = lv_offset + sy-index - 1 len = 1 ).
        APPEND plant_encoding( plant_code ) TO results.
      ENDDO.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
