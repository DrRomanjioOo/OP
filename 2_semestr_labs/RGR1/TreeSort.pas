UNIT TreeSort; {модуль дл€ работы с бинарным деревом}

INTERFACE       
  PROCEDURE InitTree;
  PROCEDURE InsertInTree(VAR Data: STRING);
  PROCEDURE PrintStatistic(VAR OutFile: TEXT);

IMPLEMENTATION

USES
  SortedWords;

TYPE
  TreeNodePtr = ^TreeNode;
  TreeNode = RECORD
    Words: STRING; {слово}
    Counter: INTEGER; {количество вхождений}
    LLink, RLink: TreeNodePtr {указатели на левого и правого потомка}
  END;

VAR
  Root: TreeNodePtr; {корень дерева}
  
PROCEDURE InitTree; {инициализаци€ дерева}
BEGIN {InitTree}
  Root := NIL
END; {InitTree}

PROCEDURE InsertInTree(VAR Data: STRING); {добавление слова в дерево}
  
  PROCEDURE Insert(VAR Ptr: TreeNodePtr; VAR Data: STRING); {внутренн€€ рекурсивна€ процедура вставки}
  VAR
    IsBigger: INTEGER;
  BEGIN {Insert}
    IF Ptr = NIL
    THEN
      BEGIN {создаЄм новый узел}
        NEW(Ptr);
        Ptr^.Words := Data;
        Ptr^.Counter := 1;
        Ptr^.LLink := NIL;
        Ptr^.RLink := NIL
      END {создаЄм новый узел}
    ELSE
      BEGIN 
        CompareWords(Data, Ptr^.Words, IsBigger);
        IF IsBigger = 1
        THEN
          Insert(Ptr^.RLink, Data) {слово больше вправо}
        ELSE
          BEGIN
            IF IsBigger = 2
            THEN
              Insert(Ptr^.LLink, Data) {слово меньше влево}
            ELSE
              Ptr^.Counter := Ptr^.Counter + 1 {слова равны увеличение счетчика}
          END
      END
  END; {Insert}
  
BEGIN {InsertInTree}
  Insert(Root, Data)
END; {InsertInTree}

PROCEDURE PrintStatistic(VAR OutFile: TEXT); {вывод статистики в файл в алфавитном пор€дке}
  
  PROCEDURE PrintStat(Current: TreeNodePtr); {рекурсивный обход дерева (лево-корень-право)}
  BEGIN {PrintStat}
    IF Current <> NIL
    THEN
      BEGIN
        PrintStat(Current^.LLink);
        WRITELN(OutFile, Current^.Words, ' ', Current^.Counter);
        PrintStat(Current^.RLink)
      END
  END; {PrintStat}
  
BEGIN {PrintStatistic}
  PrintStat(Root)
END; {PrintStatistic}

BEGIN {TreeSort}
  Root := NIL
END. {TreeSort}
