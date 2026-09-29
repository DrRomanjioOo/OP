PROGRAM SortMonth(INPUT, OUTPUT);
USES DateIO;
VAR
  M1, M2: Month;
BEGIN
  {—чиитаем два мес€ца подр€д из INPUT}
  ReadMonth(INPUT, M1);
  ReadMonth(INPUT, M2);  
  {—равнение мес€цев}
  IF (M1 = NoMonth) OR (M2 = NoMonth) THEN
    WRITELN(OUTPUT, '¬ходные данные записаны неверно')
  ELSE 
  IF M1 < M2 
  THEN
    BEGIN
      WriteMonth(OUTPUT, M1);
      WRITE(OUTPUT, ' предшествует ');
      WriteMonth(OUTPUT, M2);
      WRITELN(OUTPUT)
    END
  ELSE 
    IF M1 > M2 
    THEN
      BEGIN
        WriteMonth(OUTPUT, M1);
        WRITE(OUTPUT, ' следует за ');
        WriteMonth(OUTPUT, M2);
      WRITELN(OUTPUT)
      END
    ELSE {M1 = M2}
      BEGIN
        WRITE(OUTPUT, 'ќба мес€ца ');
        WriteMonth(OUTPUT, M1);
        WRITELN(OUTPUT)
      END
END.
