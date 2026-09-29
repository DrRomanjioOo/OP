
PROGRAM CountSymbols(INPUT, OUTPUT);
VAR
  Thousand, X100, X10, X1: CHAR;
USES Count3;
BEGIN{CountSymbols}
  Thousand := '0';
  Start;
  Value(X100, X10, X1);
  WHILE NOT EOLN
  DO
    BEGIN
      READ(X1);
      Bump(Thousand);
      Value(X100, X10, X1)  
    END;
  IF Thousand = '0'
  THEN
    WRITELN('Количесвто символов: ', X100, X10, X1)
  ELSE
    WRITELN('Счётчик переполнен')    
END.{CountSymbols}
