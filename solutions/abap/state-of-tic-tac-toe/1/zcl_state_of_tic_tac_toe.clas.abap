CLASS zcl_state_of_tic_tac_toe DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES player_type TYPE c LENGTH 1.
    "! E.g., ( ( `XOO` ) ( ` X ` ) ( `  X` ) )
    TYPES board_type TYPE TABLE OF string INITIAL SIZE 3.

    CONSTANTS: BEGIN OF player_enum,
                 one TYPE player_type VALUE 'X',
                 two TYPE player_type VALUE 'O',
               END OF player_enum.

    CONSTANTS: BEGIN OF state_enum,
                 ongoing_game TYPE string VALUE `Ongoing game`,
                 draw         TYPE string VALUE `Draw`,
                 win          TYPE string VALUE `Win`,
               END OF state_enum.

    "! @parameter state | Possible values are enumerated in state_enum
    "! @raising cx_parameter_invalid | Board is invalid
    METHODS get_state
      IMPORTING board        TYPE board_type
      RETURNING VALUE(state) TYPE string
      RAISING   cx_parameter_invalid.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_state_of_tic_tac_toe IMPLEMENTATION.

  METHOD get_state.
    IF lines( board ) < 3.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
    
    DATA(r1) = board[ 1 ].
    DATA(r2) = board[ 2 ].
    DATA(r3) = board[ 3 ].

    IF strlen( r1 ) <> 3 OR strlen( r2 ) <> 3 OR strlen( r3 ) <> 3.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
    
    DATA(blank) = count( val = r1 sub = ' ' ) + 
                  count( val = r2 sub = ' ' ) + 
                  count( val = r3 sub = ' ' ).
    IF blank = 9.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    DATA(x_count) = count( val = r1 sub = player_enum-one ) +
                    count( val = r2 sub = player_enum-one ) +
                    count( val = r3 sub = player_enum-one ).

    DATA(o_count) = count( val = r1 sub = player_enum-two ) +
                    count( val = r2 sub = player_enum-two ) +
                    count( val = r3 sub = player_enum-two ).

    "poprawność ruchów
    IF x_count < o_count OR x_count > o_count + 1.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    DATA(x_won) = abap_false.
    DATA(o_won) = abap_false.

    "Wygrane
    DATA(lines) = VALUE string_table(
      " Wiersze
      ( r1 ) ( r2 ) ( r3 )
      " Kolumny
      ( |{ r1+0(1) }{ r2+0(1) }{ r3+0(1) }| )
      ( |{ r1+1(1) }{ r2+1(1) }{ r3+1(1) }| )
      ( |{ r1+2(1) }{ r2+2(1) }{ r3+2(1) }| )
      " Przekątne
      ( |{ r1+0(1) }{ r2+1(1) }{ r3+2(1) }| )
      ( |{ r1+2(1) }{ r2+1(1) }{ r3+0(1) }| )
    ).

    LOOP AT lines INTO DATA(line).
      IF line = 'XXX'.
        x_won = abap_true.
      ELSEIF line = 'OOO'.
        o_won = abap_true.
      ENDIF.
    ENDLOOP.

    "Może być tylko 1 wygrana
    IF x_won = abap_true AND o_won = abap_true.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    "Poprawność ruchów
    IF ( x_won = abap_true AND x_count <> o_count + 1 ) OR
       ( o_won = abap_true AND x_count <> o_count ).
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    IF x_won = abap_true OR o_won = abap_true.
      state = state_enum-win.
    ELSEIF blank = 0.
      state = state_enum-draw.
    ELSE.
      state = state_enum-ongoing_game.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
