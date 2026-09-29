PROGRAM Prime(INPUT, OUTPUT);
CONST
  Max = 100;
  Min = 2;
VAR
  Sieve: SET OF Min..Max;
  MinNum, Num: INTEGER;
BEGIN
  Sieve := [Min..Max];
  MinNum := Min;
  WHILE MinNum <= Max
  DO
    BEGIN
      IF MinNum IN Sieve
      THEN
        BEGIN
          Num := MinNum;
          WHILE Num <= Max
          DO
            BEGIN
              Sieve := Sieve - [Num];
              Num := Num + MinNum;
            END;
          WRITE(MinNum, ' ')
        END;
      MinNum := MinNum + 1
    END;
  WRITELN 
END.

