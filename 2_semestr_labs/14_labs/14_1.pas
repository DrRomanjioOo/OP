PROGRAM ReverseString(INPUT, OUTPUT);

PROCEDURE Recursion(VAR F1, F2: TEXT);
VAR
  Ch: CHAR;
BEGIN
  IF NOT EOLN(F1)
  THEN
    BEGIN
      READ(F1, Ch);
      Recursion(F1, F2);
      WRITE(F2, Ch)
    END
END;

BEGIN{ReverseString}
  Recursion(INPUT, OUTPUT);
  WRITELN(OUTPUT)
END.{ReverseString}
