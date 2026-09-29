PROGRAM SortDate(INPUT, OUTPUT);
USES DateUnit;
VAR
  Copying: BOOLEAN;
  D, VarDate: Date;
  TFile, DateFile: FileOfDate;
  FInput: TEXT;
 
BEGIN{SortDate}
  ASSIGN(DateFile, 'DF.DAT');
  ASSIGN(TFile, 'TF.DAT');
  ASSIGN(FInput, 'FI.TXT');
  REWRITE(DateFile);
  RESET(FInput);
  ReadDate(FInput, VarDate);
  READLN(FInput);
  WRITE(DateFile, VarDate);
  RESET(DateFile);
  WHILE NOT EOF(FInput)
  DO
    {Поместить новую дату в DateFile в соответствующее место}
    BEGIN
      RESET(DateFile);
      ReadDate(FInput, D);
      READLN(FInput);
      IF (D.Mo <> NoMonth)
      THEN
        BEGIN                
          {Копируем элементы меньшие, чем D из DateFile в TFile}
          REWRITE(TFile);
          Copying := TRUE;
          WHILE NOT EOF(DateFile) AND Copying
          DO
            BEGIN
              READ(DateFile, VarDate);
              IF Less(VarDate, D)
              THEN
                WRITE(TFile, VarDate)
              ELSE
                Copying := FALSE
            END;
          {Копируем D в TFile}
          WRITE(TFile, D);
          {Копируем остаток DateFile в TFile}
          IF NOT Copying
          THEN
            WRITE(TFile, VarDate);
          WHILE NOT EOF(DateFile)
          DO
            BEGIN
              READ(DateFile, VarDate);
              WRITE(TFile, VarDate)
            END;
          {Копируем TFile в DateFile}
          REWRITE(DateFile);
          RESET(TFile);
          WHILE NOT EOF(TFile)
          DO
            BEGIN
              READ(TFiLe, VarDate);
              WRITE(DateFile, VarDate)
            END
        END    
    END;
  {Копируем DateFile в OUTPUT}
  RESET(DateFile);
  CopyOut(DateFile)
END.{SortDate}


