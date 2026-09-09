CLASS zcl_relative_distance DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_family,
        parent   TYPE string,
        children TYPE string_table,
      END OF ty_family,
      ty_family_tree TYPE STANDARD TABLE OF ty_family WITH KEY parent.

    METHODS degree_of_separation
      IMPORTING
        family_tree   TYPE ty_family_tree
        person_a      TYPE string
        person_b      TYPE string
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES: BEGIN OF ty_node_map,
            child  TYPE string,
            parent TYPE string,
           END OF ty_noe_map.
    DATA lt_parent_map TYPE HASHED TABLE OF ty_node_map WITH UNIQUE KEY child.
ENDCLASS.


CLASS zcl_relative_distance IMPLEMENTATION.
  METHOD degree_of_separation.
    result = -1.
    
    LOOP AT family_tree ASSIGNING FIELD-SYMBOL(<ls_family>).
      IF line_exists( <ls_family>-children[ table_line = person_a ] ) AND 
         line_exists( <ls_family>-children[ table_line = person_b ] ).
        result = 1.
        RETURN.
      ENDIF.
    
      LOOP AT <ls_family>-children ASSIGNING FIELD-SYMBOL(<lv_child>).
        INSERT VALUE #( child = <lv_child> parent = <ls_family>-parent ) INTO TABLE lt_parent_map.
      ENDLOOP.
    ENDLOOP.

    DATA(lt_path_a) = VALUE string_table( ( person_a ) ).
    DATA(lt_path_b) = VALUE string_table( ( person_b ) ).
    DATA(lv_current) = person_a.
      
    WHILE line_exists( lt_parent_map[ child = lv_current ] ).
      lv_current = lt_parent_map[ child = lv_current ]-parent.
      APPEND lv_current TO lt_path_a.
    ENDWHILE.

    lv_current = person_b.
    WHILE line_exists( lt_parent_map[ child = lv_current ] ).
      lv_current = lt_parent_map[ child = lv_current ]-parent.
      APPEND lv_current TO lt_path_b.
    ENDWHILE.

    LOOP AT lt_path_a INTO DATA(lv_person).
      DATA(lv_index_a) = sy-tabix.
      DATA(lv_index_b) = line_index( lt_path_b[ table_line = lv_person ] ).
      
      IF lv_index_b > 0.
          result = ( lv_index_a - 1 ) + ( lv_index_b - 1 ).
          IF lv_index_a > 1 AND lv_index_b > 1.
            result = result - 1.
          ELSE.
            RETURN.
          ENDIF.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


ENDCLASS.
