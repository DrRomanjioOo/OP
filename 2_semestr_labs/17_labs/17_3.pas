PROGRAM Stat(INPUT, OUTPUT);
CONST
  NoDigit = -1;
  Overflow = -2;
  Base = 10;
  PercentScale = 100;
VAR
  Number, MaxNumber, MinNumber, Total, Sum, AverageDiv, AverageMod: INTEGER;
  OverFlowNumber, OverFlowSum: BOOLEAN;
PROCEDURE ReadDigit(VAR F: TEXT; VAR Digit: INTEGER);
{Считывает текущий символ из файл. Если он - цифра, возвращает его 
 преобразуя в значение типа INTEGER. Если считанный символ не цифра
 возвращает -1}
VAR
  Ch: CHAR;
BEGIN {ReadDigit}
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
END; {ReadDigit}

PROCEDURE ReadNumber(VAR F: TEXT; VAR Number: INTEGER);
VAR
  Digit: INTEGER;
BEGIN {ReadNumber}
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
END; {ReadNumber}

PROCEDURE CheckMaxNumber(VAR MaxNumber, Number: INTEGER);
BEGIN {CheckMaxNumber}
  IF MaxNumber < Number
  THEN
    MaxNumber := Number
END; {CheckMaxNumber}

PROCEDURE CheckMinNumber(VAR MinNumber, Number: INTEGER);
BEGIN {CheckMinNumber}
  IF MinNumber > Number
  THEN
    MinNumber := Number
END; {CheckMinNumber}

PROCEDURE SumNumber(VAR Sum, Number: INTEGER; VAR OverFlowSum: BOOLEAN);
BEGIN {SumNumber}
  IF (MaxInt - Number >= Sum)
  THEN
    Sum := Sum + Number
  ELSE
    OverFlowSum := TRUE
END; {SumNumber}

PROCEDURE AverageScore(VAR Sum, Total, AverageDiv, AverageMod: INTEGER);
BEGIN {AverageScore}
  AverageDiv := Sum DIV Total;
  AverageMod := ((Sum MOD Total) * PercentScale) DIV Total
END; {AverageScore}

BEGIN{Stat}
  Number := 0;
  MaxNumber := 0;
  MinNumber := MaxInt;
  Sum := 0;
  Total := 0;
  AverageDiv := 0;
  AverageMod := 0;
  OverFlowNumber := False;
  OverFlowSum := False;
  WHILE (NOT EOLN) AND (NOT (OverFlowSum OR OverFlowNumber))
  DO
    BEGIN
      ReadNumber(INPUT, Number);
      IF Number = Overflow
      THEN
        OverFlowNumber := True
      ELSE 
        IF Number <> NoDigit
        THEN
          BEGIN
            CheckMaxNumber(MaxNumber, Number);
            CheckMinNumber(MinNumber, Number);
            Total := Total + 1;
            SumNumber(Sum, Number, OverFlowSum)
          END
    END;
  IF OverFlowNumber
  THEN
    WRITELN('Ошибка: при вычислении числа, возникло переполнение')
  ELSE
    IF Total = 0
    THEN
      WRITELN('В файле отсутствуют числа')
    ELSE
      BEGIN
        WRITELN('Максимальное число: ', MaxNumber);
        WRITELN('Минимальное число: ', MinNumber);
        IF OverFlowSum
        THEN
          WRITELN('Ошибка: при вычислении суммы, возникло переполнение - среднее арифметическое невозможно вычислить')
        ELSE
          BEGIN
            WRITELN('Всего чисел: ', Total);
            AverageScore(Sum, Total, AverageDiv, AverageMod);
            WRITELN('Среднее арифметическое: ', AverageDiv, '.', AverageMod)
          END
      END
END.{Stat}
