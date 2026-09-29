PROGRAM PRIME(INPUT, OUTPUT);
CONST
  MinDigit = 65;
  MaxDigit = 68;
VAR
  Sieve: SET OF MinDigit .. MaxDigit;
  Counter, Digit: INTEGER;
BEGIN
  Sieve := [MinDigit .. MaxDigit];
  Counter := 2;
  WHILE Counter <= MaxDigit
  DO
    BEGIN 
      Digit := Counter;
      IF Digit IN Sieve
      THEN
        WRITE(Digit, ' ');
      WHILE Digit <= MaxDigit
      DO
        BEGIN 
          Sieve := Sieve - [Digit];
          Digit := Digit + Counter 
        END;
      Counter := Counter + 1
    END;
  WRITELN
END.
