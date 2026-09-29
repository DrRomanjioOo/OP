PROGRAM CountWords; {основная программа подсчёта частоты слов в тексте}
USES
  ReaderWords, TreeSort;

VAR
  InFile, OutFile: TEXT;
  Word: STRING;
  WordCounter: INTEGER;
  
CONST 
  InputFile = 'INPUT.TXT'; {имя входного файла}
  StatisticFile = 'OUTPUT.TXT'; {имя выходного файла}
  MaxWords = 10000; {максимальное количество слов}
  
BEGIN {CountWords}
  WordCounter := 0;
  ASSIGN(InFile, InputFile);
  ASSIGN(OutFile, StatisticFile);
  RESET(InFile);
  REWRITE(OutFile);
  InitTree;
  WHILE (NOT EOF(InFile)) AND (WordCounter < MaxWords)
  DO
    BEGIN {чтение слов из файла до конца или до достижения лимита}
      ReadWord(InFile, Word); 
      IF Word <> ''
      THEN
        BEGIN
          InsertInTree(Word);
          WordCounter := WordCounter + 1
        END
    END; {чтение слов из файла до конца или до достижения лимита}
  PrintStatistic(OutFile)
END. {CountWords}
