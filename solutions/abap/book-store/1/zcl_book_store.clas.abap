CLASS zcl_book_store DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    "! ID of book to buy from 1 to 5
    TYPES book_id TYPE i.

    TYPES basket_type TYPE SORTED TABLE OF book_id
      WITH NON-UNIQUE KEY table_line.

    TYPES total TYPE p LENGTH 3 DECIMALS 2.

    "! @parameter basket | E.g., buying two copies of the first book and one copy of the second book
    "!                     is equivalent to ( ( 1 ) ( 1 ) ( 2 ) )
    METHODS calculate_total
      IMPORTING basket       TYPE basket_type
      RETURNING VALUE(total) TYPE total.

  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES: group TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    DATA: lt_groups TYPE TABLE OF group.
ENDCLASS.

CLASS zcl_book_store IMPLEMENTATION.

  METHOD calculate_total.
    IF basket IS INITIAL.
      total = 0.
      RETURN.
    ENDIF.

    IF lines( basket ) = 1.
      total = 8.
      RETURN.
    ENDIF.

    LOOP AT basket INTO DATA(lv_book).
      DATA(lv_assigned) = abap_false.

      LOOP AT lt_groups ASSIGNING FIELD-SYMBOL(<group>).
        IF NOT line_exists( <group>[ table_line = lv_book ] ).
          INSERT lv_book INTO TABLE <group>.
          lv_assigned = abap_true.
          EXIT.
        ENDIF.
      ENDLOOP.

      IF lv_assigned = abap_false.
        INSERT VALUE #( ( lv_book ) ) INTO TABLE lt_groups.
      ENDIF.
    ENDLOOP.

    LOOP AT lt_groups ASSIGNING FIELD-SYMBOL(<group1>).
      IF lines( <group1> ) <> 5.
        CONTINUE.
      ENDIF.
      
      LOOP AT lt_groups ASSIGNING FIELD-SYMBOL(<group2>).
        IF lines( <group2> ) <> 3.
          CONTINUE.
        ENDIF.
        
        LOOP AT <group1> ASSIGNING FIELD-SYMBOL(<book1>).
          IF NOT line_exists( <group2>[ table_line = <book1> ] ).
            INSERT <book1> INTO TABLE <group2>.
            DELETE TABLE <group1> FROM <book1>.
            EXIT.
          ENDIF.
        ENDLOOP.

        IF lines( <group1> ) = 4.
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    LOOP AT lt_groups INTO DATA(lv_group).
      DATA: discount TYPE total.
      CASE lines( lv_group ).
        WHEN 1. 
          discount = '1.00'.
        WHEN 2. 
          discount = '0.95'.
        WHEN 3. 
          discount = '0.90'.
        WHEN 4. 
          discount = '0.80'.
        WHEN 5. 
          discount = '0.75'.
      ENDCASE.

      total += 8 * lines( lv_group ) * discount.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
