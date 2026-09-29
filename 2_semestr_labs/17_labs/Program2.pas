
PROGRAM Stat(INPUT, OUTPUT);
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
       Digit := -1
    END
  ELSE
    Digit := -1  
END; {ReadDigit}

PROCEDURE ReadNumber(VAR F: TEXT; VAR Number: INTEGER);
VAR
  Digit: INTEGER;
BEGIN {ReadNumber}
  Number := -1;
  Digit := 0;
  IF NOT EOLN(F)
  THEN
    BEGIN
      ReadDigit(F, Digit);
      IF Digit <> -1
      THEN
        Number := 0;
      WHILE ((Digit <> -1) AND (Number <> -2))
      DO
        BEGIN
          IF ((Number >= (MaxInt DIV 10)) AND (Digit > (MaxInt MOD 10))) OR (Number > (MaxInt DIV 10))
          THEN
            Number := -2
          ELSE
            Number := Number * 10 + Digit;
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

PROCEDURE SumNumber(VAR Sum, Number: INTEGER);
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
  AverageMod := ((Sum MOD Total) * 100) DIV Total
END; {AverageScore}
BEGIN {Stat}
  Number := 0;
  MaxNumber := 0;
  MinNumber := 2147483647;
  Total := 0;
  AverageDiv := 0;
  AverageMod := 0;
  OverFlowNumber := False;
  OverFLowSum := False;
  WHILE (NOT EOLN) AND ( NOT (OverFlowSum OR OverFlowNumber))
  DO
    BEGIN
      ReadNumber(INPUT, Number);
      IF Number >= 0
      THEN
        BEGIN
          CheckMaxNumber(MaxNumber, Number);
          CheckMinNumber(MinNumber, Number);
          Total := Total + 1;
          SumNumber(Sum, Number) 
        END
      ELSE
        OverFlowNumber := True
    END;
  IF OverFlowNumber
  THEN
    WRITELN('Ошибка: при вычислении числа, возникло переполнение')
  ELSE
    BEGIN
      WRITELN('MaxNumber: ', MaxNumber);
      WRITELN('MinNumber: ', MinNumber);
      IF OverFlowSum
      THEN
        WRITELN('Ошибка: при вычислении суммы, возникло переполнение - среднее арифемтическое невозможно вычислить')
      ELSE
        BEGIN
          WRITELN('Total: ', Total);
          AverageScore(Sum, Total, AverageDiv, AverageMod);
          WRITELN('Average: ', AverageDiv, '.', AverageMod)
        END
    END
END. {Stat}



