UNIT ProceduresForPG;
 
INTERFACE {INTERFACE}
  CONST
   Column = 5;
    Line = 5;
    MaxLenght = Line * Column;
  TYPE
    Amount = SET OF 1..MaxLenght; 
    Let = (NoLetters, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, W, V, X, Y, Z);
  VAR
    ValueForLetters: Amount;
    Letters: Let;
    Lenght: INTEGER;

{INTERFACE}

IMPLEMENTATION {IMPLEMENTATION}
PROCEDURE ReadLetters(VAR InFile: TEXT; VAR Letters: Let);
VAR
  Ch: CHAR;
BEGIN {ReadLetters}
  READ(InFile, Ch);
  CASE Ch OF
    'A': Letters := A;
  ELSE
    Letters := NoLetters
  END
END; {ReadLetters}
 
PROCEDURE PullOutValue(VAR Letters: Let; VAR ValueForLetters: Amount);
BEGIN {WhatLetters}
  CASE Letters OF
    A: ValueForLetters := [5, 9, 10, 13, 15, 18, 19, 20, 22, 25]
  END
END; {WhatLetters}

PROCEDURE WriteLetters(VAR Lenght: INTEGER; VAR ValueForLetters: Amount);
VAR
  I: INTEGER;
BEGIN {WriteLetters}
  PullOutValue(Letters, ValueForLetters);
  FOR I := 1 TO Lenght
  DO
    BEGIN
      IF I IN ValueForLetters
      THEN
        WRITE('#')
      ELSE
        WRITE(' ');
      IF (I MOD Column) = 0
      THEN
        BEGIN
          WRITELN;
          XPrint
        END
    END
END; {WriteLetters}
PROCEDURE XPrint
BEGIN
  ReadLetters(INPUT, Letters);
  IF Letters <> NoLetters
  THEN
    WriteLetters(Lenght, ValueForLetters)
  ELSE
    WRITE('INVALID LETTERS');
  WRITELN 
END;
BEGIN
END.
