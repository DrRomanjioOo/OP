PROGRAM TestRemove(INPUT, OUTPUT);
USES Queue;
VAR
  Ch: CHAR;
    
PROCEDURE RemoveExtraBlanks;
TYPE
  StateType = (START, WORD, SPACE);
VAR
  Ch, Blank, LineEnd: CHAR;
  State: StateType;
BEGIN{RemoveExtraBlanks}
  Blank := ' ';
  LineEnd := '$';
  State := START;
  AddQ(LineEnd);
  HeadQ(Ch); 
  WHILE Ch <> LineEnd
  DO
    BEGIN
      CASE State OF
        START:
          IF Ch <> Blank
          THEN
            BEGIN
              AddQ(Ch);
              State := WORD
            END;            
        WORD:
          IF Ch = Blank
          THEN
            State := SPACE
          ELSE
            AddQ(Ch);          
        SPACE:
          IF Ch <> Blank
          THEN
            BEGIN
              AddQ(Blank);
              AddQ(Ch);
              State := WORD
            END
      END;      
      DelQ;
      HeadQ(Ch)
    END;
  DelQ
END; {RemoveExtraBlanks}

BEGIN{TestRemove}
  EmptyQ;
  WRITE('Вход: ');
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      AddQ(Ch)
    END;
  RemoveExtraBlanks;
  WRITE('Выход: ');
  HeadQ(Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(Ch);
      DelQ;
      HeadQ(Ch)
    END;
  WRITELN
END.{TestRemove}
