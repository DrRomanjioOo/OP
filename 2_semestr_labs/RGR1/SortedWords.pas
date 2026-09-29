UNIT SortedWords; {модуль для сравнения слов по алфавиту}

INTERFACE       
  PROCEDURE CompareWords(VAR Data: STRING; VAR PtrWord: STRING; VAR IsBigger: INTEGER);

IMPLEMENTATION

CONST
  Alphabet = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюяabcdefghijklmnopqrstuvwxyz'; {алфавит: сначала русские буквы с ё, затем английские}
  
FUNCTION GetRank(Ch: CHAR): INTEGER; {определяет порядковый номер буквы в алфавите}
VAR
  Pos: INTEGER;
  Found: BOOLEAN;
BEGIN {GetRank}
  Pos := 1;
  Found := FALSE;
  WHILE (Pos <= Length(Alphabet)) AND NOT Found
  DO
    BEGIN {поиск буквы в алфавите}
      IF Alphabet[Pos] = Ch
      THEN
        Found := TRUE
      ELSE
        Pos := Pos + 1
    END; {поиск буквы в алфавите}
  IF Found
  THEN
    GetRank := Pos
  ELSE
    GetRank := Length(Alphabet) + 1 {если буква не найдена возвращаем номер за пределами алфавита}
END; {GetRank}

PROCEDURE CompareWords(VAR Data: STRING; VAR PtrWord: STRING; VAR IsBigger: INTEGER); {сравнивает два слова, возвращает 1 если Data больше, 2 если меньше, 0 если равны}
VAR
  I: INTEGER;
  Rank1, Rank2: INTEGER;
  StopCompare: BOOLEAN;
BEGIN {CompareWords}
  IsBigger := 0;
  I := 1;
  StopCompare := FALSE;
  WHILE (I <= Length(Data)) AND (I <= Length(PtrWord)) AND NOT StopCompare
  DO
    BEGIN {посимвольное сравнение до первого различия}
      Rank1 := GetRank(Data[I]);
      Rank2 := GetRank(PtrWord[I]);             
      IF Rank1 < Rank2
      THEN
        BEGIN
          IsBigger := 2;
          StopCompare := TRUE
        END
      ELSE
        BEGIN
          IF Rank1 > Rank2
          THEN
            BEGIN
              IsBigger := 1;
              StopCompare := TRUE
            END
        END;
      I := I + 1
    END; {посимвольное сравнение до первого различия}
  IF NOT StopCompare
  THEN
    BEGIN
      IF Length(Data) < Length(PtrWord)
      THEN
        IsBigger := 2
      ELSE
        BEGIN
          IF Length(Data) > Length(PtrWord)
          THEN
            IsBigger := 1
        END
    END
END; {CompareWords}

BEGIN {SortedWords}
END. {SortedWords}
