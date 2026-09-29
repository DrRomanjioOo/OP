PROGRAM RunRecursiveSort(INPUT, OUTPUT);
VAR
  Ch: CHAR;
  F: TEXT;

PROCEDURE CopyFile(VAR InFile, OutFile: TEXT);
VAR
  Ch: CHAR;
BEGIN{CopyFile}
  WHILE NOT EOLN(InFile)
  DO
    BEGIN
      READ(InFile, Ch);
      WRITE(OutFile, Ch)
    END;
  WRITELN(OutFile)
END;{CopyFile}

PROCEDURE RecursiveSort(VAR F1: TEXT);
VAR 
  F2, F3: TEXT;
  Ch: CHAR;
PROCEDURE Split(VAR F1, F2, F3: TEXT);
VAR 
  Ch, Switch: CHAR;
BEGIN {Split}
  RESET(F1);
  REWRITE(F2);
  REWRITE(F3);
  Switch := '2';
  WHILE NOT EOLN(F1)
  DO
    BEGIN
      READ(F1, Ch);
      IF (Switch = '2')
      THEN
        BEGIN
          WRITE(F2, Ch);
          Switch := '3'
        END
      ELSE
        BEGIN
          WRITE(F3, Ch);
          Switch := '2'
        END
    END;
  WRITELN(F2);
  WRITELN(F3)
END;{Split}

PROCEDURE SortSymbols(VAR InFile, OutFile: TEXT; VAR Ch: CHAR; VAR Check: BOOLEAN);
BEGIN{SortSymbols}
  WRITE(OutFile, Ch);
  Check := NOT EOLN(InFile);
  IF Check 
  THEN 
    READ(InFile, Ch)
END;{SortSymbols}

PROCEDURE RemainingSymbols(VAR InFile, OutFile: TEXT; VAR Ch: CHAR; VAR Check: BOOLEAN);
BEGIN{RemainingSymbols}
  WHILE Check 
  DO
    BEGIN
      WRITE(OutFile, Ch);
      Check := NOT EOLN(InFile);
      IF Check 
      THEN 
        READ(InFile, Ch)
    END
END;{RemainingSymbols}

PROCEDURE Merge(VAR F1, F2, F3: TEXT);
VAR
  Ch2, Ch3: CHAR;
  CheckF2, CheckF3: BOOLEAN;
BEGIN {Merge}
  RESET(F2);
  RESET(F3);
  REWRITE(F1);
  CheckF2 := NOT EOLN(F2);
  CheckF3 := NOT EOLN(F3);
  IF CheckF2 
  THEN 
    READ(F2, Ch2);
  IF CheckF3
  THEN 
    READ(F3, Ch3);
  WHILE CheckF2 AND CheckF3 
  DO
    BEGIN
      IF Ch2 < Ch3 
      THEN
        SortSymbols(F2, F1, Ch2, CheckF2)
      ELSE
        SortSymbols(F3, F1, Ch3, CheckF3)
    END;
  RemainingSymbols(F2, F1, Ch2, CheckF2);
  RemainingSymbols(F3, F1, Ch3, CheckF3);
  WRITELN(F1)
END; {Merge}
BEGIN {RecursiveSort}
  RESET(F1);
  IF NOT (EOLN(F1))
  THEN
    BEGIN
      READ(F1, Ch);
      IF NOT (EOLN(F1))
      THEN
        BEGIN
          RESET(F1);
          Split(F1, F2, F3);
          RecursiveSort(F2);
          RecursiveSort(F3);
          Merge(F1, F2, F3)
        END
    END
END;{RecursiveSort}

BEGIN{RunRecursiveSort}
  REWRITE(F);
  CopyFile(INPUT, F);
  RESET(F);
  RecursiveSort(F);
  RESET(F);
  CopyFile(F, OUTPUT)
END.{RunRecursiveSort}
