UNIT ReaderWords; {модуль дл€ чтени€ слов из текстового файла}

INTERFACE
  PROCEDURE ReadWord(VAR InFile: TEXT; VAR Word: STRING); {извлекает очередное слово из файла}

IMPLEMENTATION           

CONST
  UpperLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZјЅ¬√ƒ≈®∆«»… ЋћЌќѕ–—“”‘’÷„ЎўЏџ№Ёёя'; {заглавные буквы}
  LowerLetters = 'abcdefghijklmnopqrstuvwxyzабвгдеЄжзийклмнопрстуфхцчшщъыьэю€'; {строчные буквы}
    
FUNCTION MakeLower(Ch: CHAR): CHAR; {преобразует заглавную букву в строчную}
VAR
  Position: INTEGER;
  Found: BOOLEAN;
BEGIN {MakeLower}
  Position := 1;
  Found := FALSE;
  WHILE (Position <= Length(UpperLetters)) AND NOT Found
  DO
    BEGIN {поиск символа среди заглавных букв}
      IF UpperLetters[Position] = Ch
      THEN
        BEGIN
          Found := TRUE;
          MakeLower := LowerLetters[Position]
        END
      ELSE
        Position := Position + 1
    END; {поиск символа среди заглавных букв}
  IF NOT Found
  THEN
    MakeLower := Ch {символ не буква или уже строчный}
END; {MakeLower}

FUNCTION IsLetter(Ch: CHAR): BOOLEAN; {провер€ет €вл€етс€ ли символ буквой}
VAR
  Position: INTEGER;
  Found: BOOLEAN;
BEGIN {IsLetter}
  Position := 1;
  Found := FALSE;
  WHILE (Position <= Length(UpperLetters)) AND NOT Found
  DO
    BEGIN {поиск среди заглавных букв}
      IF UpperLetters[Position] = Ch
      THEN
        Found := TRUE
      ELSE
        Position := Position + 1
    END; {поиск среди заглавных букв}
  Position := 1;
  WHILE (Position <= Length(LowerLetters)) AND NOT Found
  DO
    BEGIN {поиск среди строчных букв}
      IF LowerLetters[Position] = Ch
      THEN
        Found := TRUE
      ELSE
        Position := Position + 1
    END; {поиск среди строчных букв}
  IsLetter := Found
END; {IsLetter}

PROCEDURE ReadWord(VAR InFile: TEXT; VAR Word: STRING); {извлекает очередное слово из файла}
VAR
  Ch: CHAR;
  TempWord: STRING;
  FoundLetter: BOOLEAN;
  ReadingWord: BOOLEAN;
  HasLetter: BOOLEAN;
  I: INTEGER;
  StopReading: BOOLEAN;
  StopSearching: BOOLEAN;
  HyphenCount: INTEGER;
BEGIN {ReadWord}
  Word := '';
  TempWord := '';
  FoundLetter := FALSE;
  ReadingWord := TRUE;
  StopSearching := FALSE;
  HyphenCount := 0;  
  WHILE (NOT EOF(InFile)) AND (NOT FoundLetter) AND (NOT StopSearching)
  DO
    BEGIN {пропускаем небуквенные символы до первой буквы}
      IF EOLN(InFile)
      THEN
        BEGIN
          READLN(InFile);
          HyphenCount := 0
        END
      ELSE
        BEGIN
          READ(InFile, Ch);       
          IF IsLetter(Ch)
          THEN
            BEGIN
              TempWord := MakeLower(Ch);
              FoundLetter := TRUE;
              HyphenCount := 0
            END
          ELSE
            BEGIN
              IF Ch = '-'
              THEN
                HyphenCount := HyphenCount + 1
              ELSE
                HyphenCount := 0;
              IF EOF(InFile)
              THEN
                StopSearching := TRUE
            END
        END
    END; {пропускаем небуквенные символы до первой буквы}     
  IF FoundLetter
  THEN
    BEGIN
      StopReading := FALSE;
      WHILE (NOT EOF(InFile)) AND ReadingWord AND (NOT StopReading)
      DO
        BEGIN {чтение букв слова до разделител€}
          IF EOLN(InFile)
          THEN
            BEGIN
              READLN(InFile);
              ReadingWord := FALSE
            END
          ELSE
            BEGIN
              READ(InFile, Ch);  
              IF IsLetter(Ch)
              THEN
                BEGIN
                  IF HyphenCount > 0
                  THEN
                    BEGIN
                      TempWord := TempWord + '-';
                      HyphenCount := 0
                    END;
                  TempWord := TempWord + MakeLower(Ch)
                END
              ELSE
                BEGIN
                  IF Ch = '-'
                  THEN
                    BEGIN
                      HyphenCount := HyphenCount + 1
                    END
                  ELSE
                    BEGIN
                      IF Ch = ''''
                      THEN
                        BEGIN
                          IF HyphenCount > 0
                          THEN
                            BEGIN
                              TempWord := TempWord + '-';
                              HyphenCount := 0
                            END;
                          TempWord := TempWord + Ch
                        END
                      ELSE
                        BEGIN
                          StopReading := TRUE
                        END
                    END
                END
            END
        END; {чтение букв слова до разделител€}      
      HasLetter := FALSE;
      I := 1;
      WHILE (I <= Length(TempWord)) AND (NOT HasLetter)
      DO
        BEGIN {проверка что в слове есть хот€ бы одна буква}
          IF IsLetter(TempWord[I])
          THEN
            HasLetter := TRUE;
          I := I + 1
        END; {проверка что в слове есть хот€ бы одна буква}    
      IF HasLetter
      THEN
        Word := TempWord
    END
END; {ReadWord}

BEGIN {ReaderWords}
END. {ReaderWords}
