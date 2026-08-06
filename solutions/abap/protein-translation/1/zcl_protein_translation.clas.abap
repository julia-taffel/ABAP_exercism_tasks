CLASS zcl_protein_translation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS proteins
      IMPORTING
        strand        TYPE string
      RETURNING
        VALUE(result) TYPE string_table
      RAISING
        cx_parameter_invalid.

    METHODS amino_acids
      IMPORTING 
        codon TYPE string
      RETURNING 
        VALUE(amino_acid) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_protein_translation IMPLEMENTATION.
  METHOD proteins.
    DATA(lv_length) = strlen( strand ).
    DATA(lv_offset) = 0.

    WHILE lv_offset < lv_length.
      IF lv_length - lv_offset < 3.
        RAISE EXCEPTION TYPE cx_parameter_invalid.
      ENDIF.
      
      DATA(lv_codon) = substring( val = strand off = lv_offset len = 3 ).
      DATA(lv_amino_acid) = amino_acids( codon = lv_codon ).

      IF lv_amino_acid = 'STOP'.
        EXIT.
      ELSEIF lv_amino_acid = '0'.
        RAISE EXCEPTION TYPE cx_parameter_invalid.
      ENDIF.

      INSERT lv_amino_acid INTO TABLE result.
      lv_offset += 3.
    ENDWHILE.
  ENDMETHOD.
  
  METHOD amino_acids.
    amino_acid = COND string(
      WHEN codon = 'AUG' THEN 'Methionine'
      WHEN codon = 'UUU' OR codon = 'UUC'
        THEN 'Phenylalanine'
      WHEN codon = 'UUA' OR codon = 'UUG'
        THEN 'Leucine'
      WHEN codon = 'UCU' OR codon = 'UCC' OR codon = 'UCA' OR codon = 'UCG'
        THEN 'Serine'
      WHEN codon = 'UAU' OR codon = 'UAC'
        THEN 'Tyrosine'
      WHEN codon = 'UGU' OR codon = 'UGC'
        THEN 'Cysteine'
      WHEN codon = 'UGG' THEN 'Tryptophan'
      WHEN codon = 'UAA' OR codon = 'UAG' OR codon = 'UGA'
        THEN 'STOP'
      ELSE '0' ).
  ENDMETHOD.
ENDCLASS.
