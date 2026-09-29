UNIT DateUnit;

INTERFACE{INTERFACE}
  TYPE
    Month = (NoMonth, Jan, Feb, Mar, Apr, May, Jun,
                      Jul, Aug, Sep, Oct, Nov, Dec);
    DayNum = 1..31;
    Date   = RECORD
               Mo : Month;
               Day: DayNum
             END;  
    FileOfDate = FILE OF Date;
           
  PROCEDURE WriteMonth(VAR FOut: TEXT; VAR Mo: Month); 
  {Выводим месяц в файл}
  PROCEDURE WriteDate(VAR FOut: TEXT; VAR Result: Date); 
  {Выводим дату в файл}
  PROCEDURE ReadMonth(VAR FIn: TEXT; VAR Mo: Month); 
  {Копируем данные из файла и определяем месяц}
  PROCEDURE ReadDate(VAR FIn: TEXT; VAR Result: Date); 
  {Копируем данные из файла и определяем дату}
  FUNCTION Less(VAR D1, D2: Date): BOOLEAN; 
  {Сравниваем  даты}
  PROCEDURE CopyOut(VAR DateFile: FileOfDate); 
  {Выводим данные из файла в OUTPUT}
  
{INTERFACE}
 
IMPLEMENTATION {IMPLEMENTATION}
    
  PROCEDURE WriteDate(VAR FOut: TEXT; VAR Result: Date);
  {Выводим дату в файл}
  BEGIN{WriteDate}
    WriteMonth(FOut, Result.Mo);
    WRITE(FOut, Result.Day:3)
  END;{WriteDate}
 
  PROCEDURE ReadDate(VAR FIn: TEXT; VAR Result: Date);
  {Копируем данные из файла и определяем дату}
  BEGIN{ReadDate}
    ReadMonth(FIn, Result.Mo);
    IF Result.Mo <> NoMonth
    THEN
      READ(FIn, Result.Day)
  END;{ReadDate}
 
  PROCEDURE ReadMonth(VAR FIn: TEXT; VAR Mo: Month);
  {Копируем данные из файла и определяем месяц}
  VAR
    Ch1, Ch2, Ch3: CHAR;
  BEGIN{ReadMonth}
    READ(FIn, Ch1, Ch2, Ch3);
    IF (Ch1 = 'J') AND (Ch2 = 'A') AND (Ch3 = 'N') THEN Mo := Jan ELSE
    IF (Ch1 = 'F') AND (Ch2 = 'E') AND (Ch3 = 'B') THEN Mo := Feb ELSE
    IF (Ch1 = 'M') AND (Ch2 = 'A') AND (Ch3 = 'R') THEN Mo := Mar ELSE
    IF (Ch1 = 'A') AND (Ch2 = 'P') AND (Ch3 = 'R') THEN Mo := Apr ELSE
    IF (Ch1 = 'M') AND (Ch2 = 'A') AND (Ch3 = 'Y') THEN Mo := May ELSE
    IF (Ch1 = 'J') AND (Ch2 = 'U') AND (Ch3 = 'N') THEN Mo := Jun ELSE
    IF (Ch1 = 'J') AND (Ch2 = 'U') AND (Ch3 = 'L') THEN Mo := Jul ELSE
    IF (Ch1 = 'A') AND (Ch2 = 'U') AND (Ch3 = 'G') THEN Mo := Aug ELSE
    IF (Ch1 = 'S') AND (Ch2 = 'E') AND (Ch3 = 'P') THEN Mo := Sep ELSE
    IF (Ch1 = 'O') AND (Ch2 = 'C') AND (Ch3 = 'T') THEN Mo := Oct ELSE
    IF (Ch1 = 'N') AND (Ch2 = 'O') AND (Ch3 = 'V') THEN Mo := Nov ELSE
    IF (Ch1 = 'D') AND (Ch2 = 'E') AND (Ch3 = 'C') THEN Mo := Dec
        ELSE Mo := NoMonth
  END;{ReadMonth}
 
  PROCEDURE WriteMonth(VAR FOut: TEXT; VAR Mo: Month);
  {Выводим месяц в файл}
  BEGIN{WriteMonth}
    IF Mo = Jan THEN WRITE('JAN') ELSE
    IF Mo = Feb THEN WRITE('FEB') ELSE
    IF Mo = Mar THEN WRITE('MAR') ELSE
    IF Mo = Apr THEN WRITE('APR') ELSE
    IF Mo = May THEN WRITE('MAY') ELSE
    IF Mo = Jun THEN WRITE('JUN') ELSE
    IF Mo = Jul THEN WRITE('JUL') ELSE
    IF Mo = Aug THEN WRITE('AUG') ELSE
    IF Mo = Sep THEN WRITE('SEP') ELSE
    IF Mo = Oct THEN WRITE('OCT') ELSE
    IF Mo = Nov THEN WRITE('NOV') ELSE
    IF Mo = Dec THEN WRITE('DEC')
      ELSE WRITE('NoMonth')
  END;{WriteMonth}
 
  FUNCTION Less(VAR D1, D2: Date): BOOLEAN;
  {Сравниваем  даты}
  {Less:= D1 < D2}
  BEGIN{Less}
    IF D1.Mo < D2.Mo
    THEN
      Less := TRUE
    ELSE
      IF D1.Mo > D2.Mo
      THEN
        Less := FALSE
      ELSE {D1.Mo = D2.Mo}
        Less := (D1.Day < D2.Day)
  END;{Less}
 
  PROCEDURE CopyOut(VAR DateFile: FileOfDate);
  {Выводим данные из файла в OUTPUT}
  VAR
    VarDate: Date;
  BEGIN{CopyOut}
    WHILE NOT EOF(DateFile)
    DO
      BEGIN
        READ(DateFile, VarDate);
        WriteDate(OUTPUT, VarDate);
        WRITELN(OUTPUT)
      END
  END;{CopyOut}
{IMPLEMENTATION} 
BEGIN{DateUnit}
END.{DateUnit}

