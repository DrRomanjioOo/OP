PROGRAM CheckReadNumber(INPUT, OUTPUT);
CONST
  Base = 10;
  NoDigit = -1;
  Overflow = -2;
VAR
  Number: INTEGER;

PROCEDURE ReadDigit(VAR F: TEXT; VAR Digit: INTEGER);
{Считывает текущий символ из файл. Если он - цифра, возвращает его 
 преобразуя в значение типа INTEGER. Если считанный символ не цифра
 возвращает -1}
VAR
  Ch: CHAR;
BEGIN{ReadDigit}
  IF NOT EOLN(F)
  THEN
    BEGIN
     READ(F, Ch);
     IF Ch = '0' THEN Digit := 0 ELSE
     IF Ch = '1' THEN Digit := 1 ELSE    
     IF Ch = '2' THEN Digit := 2 ELSE
     IF Ch = '3' THEN Digit := 3 ELSE
     IF Ch = '4' THEN Digit := 4 ELSE
     IF Ch = '5' THEN Digit := 5 ELSE
     IF Ch = '6' THEN Digit := 6 ELSE
     IF Ch = '7' THEN Digit := 7 ELSE
     IF Ch = '8' THEN Digit := 8 ELSE
     IF Ch = '9' THEN Digit := 9
     ELSE  
       Digit := NoDigit
    END
  ELSE
    Digit := NoDigit  
END;{ReadDigit}

PROCEDURE ReadNumber(VAR F: TEXT; VAR Number: INTEGER);
VAR
  Digit: INTEGER;
BEGIN{ReadNumber}
  Number := NoDigit;
  Digit := 0;
  IF NOT EOLN(F)
  THEN
    BEGIN
      ReadDigit(F, Digit);
      IF Digit <> NoDigit
      THEN
        Number := 0;
      WHILE ((Digit <> NoDigit) AND (Number <> Overflow))
      DO
        BEGIN
          IF ((Number = (MaxInt DIV Base)) AND (Digit > (MaxInt MOD Base))) OR (Number > (MaxInt DIV Base))
          THEN
            Number := Overflow
          ELSE
            Number := Number * Base + Digit;
          ReadDigit(F, Digit)                               
        END
    END
END;{ReadNumber}

BEGIN{CheckReadNumber}
  ReadNumber(INPUT, Number);
  WRITELN(Number)
END.{CheckReadNumber}



