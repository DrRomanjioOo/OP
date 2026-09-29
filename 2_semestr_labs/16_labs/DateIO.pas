UNIT DateIO;

INTERFACE{INTERFACE}

TYPE{Тип данных, описывающая месяцы в году}
  Month = (NoMonth, JAN, FEB, MAR, APR, MAY, JUN,
                    JUL, AUG, SEP, OCT, NOV, DEC);                  
PROCEDURE ReadMonth(VAR InFile: TEXT; VAR Mo: Month);
{Процедура на ситывания входа данных и определеня месяца}
PROCEDURE WriteMonth(VAR OutFile: TEXT; VAR Mo: Month);
{Процедура на вывод месяца}

IMPLEMENTATION{IMPLEMENTATION}

PROCEDURE ReadMonth(VAR InFile: TEXT; VAR Mo: Month);
{Процедура на ситывания входа данных и определеня месяца}
VAR
  Ch1, Ch2, Ch3: CHAR;
BEGIN{ReadMonth}
  IF NOT EOLN(InFile){FIn содержит хотя бы 3 симовола}
  THEN
    BEGIN
      READ(InFile, Ch1);
      IF NOT EOLN(InFile)
      THEN
        BEGIN
          READ(InFile, Ch2);
          IF NOT EOLN(InFile)
          THEN
            BEGIN
              READ(InFile, Ch3); 
              IF (Ch1='J') AND (Ch2='A') AND (Ch3='N') THEN Mo := JAN ELSE
              IF (Ch1='F') AND (Ch2='E') AND (Ch3='B') THEN Mo := FEB ELSE
              IF (Ch1='M') AND (Ch2='A') AND (Ch3='R') THEN Mo := MAR ELSE
              IF (Ch1='A') AND (Ch2='P') AND (Ch3='R') THEN Mo := APR ELSE
              IF (Ch1='M') AND (Ch2='A') AND (Ch3='Y') THEN Mo := MAY ELSE
              IF (Ch1='J') AND (Ch2='U') AND (Ch3='N') THEN Mo := JUN ELSE
              IF (Ch1='J') AND (Ch2='U') AND (Ch3='L') THEN Mo := JUL ELSE
              IF (Ch1='A') AND (Ch2='U') AND (Ch3='G') THEN Mo := AUG ELSE
              IF (Ch1='S') AND (Ch2='E') AND (Ch3='P') THEN Mo := SEP ELSE
              IF (Ch1='O') AND (Ch2='C') AND (Ch3='T') THEN Mo := OCT ELSE
              IF (Ch1='N') AND (Ch2='O') AND (Ch3='V') THEN Mo := NOV ELSE
              IF (Ch1='D') AND (Ch2='E') AND (Ch3='C') THEN Mo := DEC
                ELSE Mo := NoMonth
            END
          ELSE 
            Mo := NoMonth
        END
      ELSE 
        Mo := NoMonth
    END
  ELSE 
    Mo := NoMonth
END;{ReadMonth}

PROCEDURE WriteMonth(VAR OutFile: TEXT; VAR Mo: Month);
{Процедура на вывод месяца}
VAR
  Ch1, Ch2, Ch3: CHAR;
BEGIN{WriteMonth}
  IF Mo = JAN THEN WRITE(OutFile, 'JAN') ELSE
  IF Mo = FEB THEN WRITE(OutFile, 'FEB') ELSE
  IF Mo = MAR THEN WRITE(OutFile, 'MAR') ELSE
  IF Mo = APR THEN WRITE(OutFile, 'APR') ELSE
  IF Mo = MAY THEN WRITE(OutFile, 'MAY') ELSE
  IF Mo = JUN THEN WRITE(OutFile, 'JUN') ELSE
  IF Mo = JUL THEN WRITE(OutFile, 'JUL') ELSE
  IF Mo = AUG THEN WRITE(OutFile, 'AUG') ELSE
  IF Mo = SEP THEN WRITE(OutFile, 'SEP') ELSE
  IF Mo = OCT THEN WRITE(OutFile, 'OCT') ELSE
  IF Mo = NOV THEN WRITE(OutFile, 'NOV') ELSE
  IF Mo = DEC THEN WRITE(OutFile, 'DEC')
     ELSE WRITE('NoMonth')
END;{WriteMonth}

BEGIN{DateIO}

END.{DateIO}


