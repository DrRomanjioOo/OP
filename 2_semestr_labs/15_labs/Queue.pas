UNIT Queue;

INTERFACE
PROCEDURE EmptyQ; {очищает очередь}
PROCEDURE AddQ(VAR Elt: CHAR); {добавляет новый символ в очередь}
PROCEDURE DelQ; {удаляет первый символ из очереди}
PROCEDURE HeadQ(VAR Elt: CHAR); {читает первый символ Ch в очереди и возвращает указатель в начало очереди}

IMPLEMENTATION
VAR
  Q, TEMP: TEXT;

PROCEDURE CopyOpen (VAR F1, F2: TEXT);
 {Копирует строку из F1 в F2 без RESET или REWRITE;
  таким образом F1 должен быть готов для чтения,а F2 для записи,
  но прошлые строки у этих файлов могут быть не пусты }
VAR
  Ch: CHAR;
BEGIN{CopyOpen}
  WHILE NOT EOLN(F1)
  DO
    BEGIN
      READ(F1, Ch);
      WRITE(F2, Ch)
    END
END;{CopyOpen}

PROCEDURE EmptyQ;
BEGIN {EmptyQ}
  REWRITE(Q);
  WRITELN(Q);
  RESET(Q)
END;{EmptyQ}

PROCEDURE AddQ (VAR Elt: CHAR);
BEGIN{AddQ}
  REWRITE(Temp);
  CopyOpen(Q, Temp);
  WRITE(Temp, Elt);
  WRITELN(Temp);
  RESET(Temp);
  REWRITE(Q);
  CopyOpen(Temp, Q);
  WRITELN(Q);
  RESET(Q)
END;{AddQ}

PROCEDURE DelQ;
VAR
  Ch: CHAR;
BEGIN{DelQ}
  {удаляем первый элемент из Q};
  READ(Q, Ch);
  IF NOT EOF(Q)
  THEN {не пустой}
    BEGIN
      REWRITE(Temp);
      CopyOpen(Q, Temp);
      WRITELN(Temp);
      {копируем Temp в Q}
      RESET(Temp);
      REWRITE(Q);
      CopyOpen(Temp, Q);
      WRITELN(Q)
    END;
  RESET(Q)
END;{DelQ}

PROCEDURE HeadQ(VAR Elt: CHAR);
BEGIN{HeadQ}
  IF NOT EOLN(Q)
  THEN
    READ(Q, Elt)
  ELSE
    Elt := '#';
  RESET(Q)
END;{HeadQ}

BEGIN
END.

