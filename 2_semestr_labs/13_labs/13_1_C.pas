PROGRAM RunBubbleSort(INPUT, OUTPUT);

PROCEDURE CopyFile(VAR InFile, OutFile: TEXT);
VAR
  Ch: CHAR;
BEGIN { CopyFile}
  WHILE NOT EOLN(InFile)
  DO
    BEGIN
      READ(InFile, Ch);
      WRITE(OutFile, Ch)
    END;
  WRITELN(OutFile)
END; {CopyFile}

PROCEDURE CopyAndSwap(VAR F1, F2: TEXT; VAR Sorted: CHAR);
{ Копируем F1 в F2,проверяя отсортированность
и переставляя первые соседние символы по порядку}
VAR
  Ch1, Ch2: CHAR;
BEGIN { CopyAndSwap}
  IF NOT EOLN(F1)
  THEN
    BEGIN
      READ(F1, Ch1);
      WHILE NOT EOLN(F1)
      DO { По крайней мере два символа остается для Ch1,Ch2 }
        BEGIN
          READ(F1, Ch2);
          {Выводим min(Ch1,Ch2) в F2,
          отсортированные символы}
          IF Ch1 <= Ch2
          THEN
            BEGIN
              WRITE(F2, Ch1);
              Ch1 := Ch2
            END
          ELSE
            BEGIN
              WRITE(F2, Ch2);
              Sorted := 'N'
            END
        END;
      WRITELN(F2, Ch1) { Выводим последний символ в F2 }
    END
END; { CopyAndSwap}

PROCEDURE BubbleSort(VAR InFile, OutFile: TEXT);
VAR
  Sorted: CHAR;
  F1, F2: TEXT;
BEGIN { BubbleSort }
  { Копируем INPUT в F1 }
  REWRITE(F1);
  CopyFile(InFile, F1);
  Sorted := 'N';
  WHILE Sorted = 'N'
  DO
    BEGIN { Копируем F1 в F2,проверяя отсортированность
      и переставляя первые соседние символы по порядку}
      Sorted := 'Y';
      RESET(F1);
      REWRITE(F2);
      CopyAndSwap(F1, F2, Sorted);
      { Копируем F2 в F1}
      REWRITE(F1);
      RESET(F2);
      CopyFile(F2, F1)
    END;
  RESET(F1);
  CopyFile(F1, OutFile)
END; { BubbleSort }

BEGIN{ Sortirovka}
  BubbleSort(INPUT, OUTPUT)
END.{ Sortirovka}

