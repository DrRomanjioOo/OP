PROGRAM RunRCopy(INPUT, OUTPUT);

PROCEDURE RCopy(VAR F1, F2: TEXT);
VAR
  Ch: CHAR;
BEGIN
  IF NOT EOLN(F1)
  THEN
    BEGIN
      READ(F1, Ch);
      WRITE(F2, Ch);
      RCopy(F1, F2)
    END;
  WRITELN(OUTPUT)
END;

BEGIN{RunRCopy}
  RCopy(INPUT, OUTPUT)
END.{RunRCopy}
