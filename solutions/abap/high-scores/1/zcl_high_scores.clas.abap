CLASS zcl_high_scores DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS constructor
      IMPORTING
        scores TYPE integertab.

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA scores_list TYPE integertab.

ENDCLASS.


CLASS zcl_high_scores IMPLEMENTATION.

  METHOD constructor.
    me->scores_list = scores.
  ENDMETHOD.

  METHOD list_scores.
    result = scores_list.
  ENDMETHOD.

  METHOD latest.
    IF scores_list IS NOT INITIAL. " jeśli istnieje
      result = scores_list[ lines( scores_list ) ]. 
      " tabela[ indeks ] bezpośredni dostęp do pozycji w tabeli o podanym indeksie 
      " lines( tabela )-wbudowana funkcja zwracająca całkowitą liczbę wierszy w tabeli
    ENDIF.
  ENDMETHOD.

  METHOD personalbest.
    result = REDUCE i(
      INIT max = 0 " inicjalizacja zmiennej pomocniczej
      FOR lv_row IN scores_list
      NEXT max = nmax( val1 = max 
                       val2 = lv_row)
      " nmax()-funkcja wbudowana, która porównuje dwie liczby i zwraca większą
      " NEXT wykonuje akcję dla każdego wiersza
    ).
  ENDMETHOD.

  METHOD personaltopthree.
    DATA(lt_sorted) = scores_list.
    SORT lt_sorted BY table_line DESCENDING. 
    " table_line specjalne słowo-klucz wskazujące, że tabela jest typu prostego i nie posiada wielu kolumn (pól).
    
    APPEND LINES OF lt_sorted FROM 1 TO 3 TO result.
  ENDMETHOD.


ENDCLASS.
