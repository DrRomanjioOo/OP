PROGRAM Decryption(INPUT, OUTPUT);
{Переводит символы из INPUT в код согласно Chiper 
  и печатает новые символы в OUTPUT}
CONST
  Len = 20;
  Let = [' ', 'A' .. 'Z'];
TYPE
  Letter = ' ' .. 'Z';
  Str = ARRAY [1 .. Len] OF Letter;
  Chiper = ARRAY [Letter] OF CHAR;
  Length = 0 .. Len;
VAR
  Msg: Str;
  Code: Chiper;
  MsgLength: Length;
  ExitProgram: BOOLEAN;
  F: TEXT;

PROCEDURE Initialize(VAR Code: Chiper);
VAR
  Ch1, Ch2: CHAR;
  F: TEXT;
{Присвоить Code шифр замены}
BEGIN {Initialize}
  ASSIGN(F, 'DECRYPTEDCODE.TXT');
  RESET(F);
  WHILE NOT EOF(F)
  DO
    BEGIN
      IF NOT EOLN(F)
      THEN
        BEGIN
          READ(F, Ch1);
          IF NOT EOLN(F)
          THEN
            BEGIN
              READ(F, Ch2);
              IF (Ch1 IN [' ' .. 'Z']) AND (Ch2 IN [' ' .. 'Z'])
              THEN
                Code[Ch2] := Ch1
            END
         END;
      READLN(F)
    END;
  CLOSE(F)
END; {Initialize}  

PROCEDURE Decode(VAR S: Str; MsgLength: Length);
{Выводит символы из Code, соответствующие символам из S}
VAR
  Index: INTEGER;
BEGIN {Decode}
  FOR Index := 1 TO MsgLength
  DO
    IF S[Index] IN [' ' .. 'Z']
    THEN
      WRITE(Code[S[Index]])
    ELSE
      WRITE(S[Index]);
  WRITELN
END;  {Decode}

BEGIN{Decryption}
  {Инициализировать Code}
  Initialize(Code);
  ExitProgram := False;
  WHILE NOT EOF AND NOT ExitProgram
  DO
    BEGIN
      WRITE('Зашифрованные данные: ');
      {читать строку в Msg и распечатать ее}
      MsgLength := 0;
      WHILE NOT EOLN AND (MsgLength < Len)
      DO
        BEGIN
          MsgLength := MsgLength + 1;
          READ(Msg[MsgLength]);
          WRITE(Msg[MsgLength])
        END;
      READLN;
      WRITELN;
      IF MsgLength = 0
      THEN
        ExitProgram := True;
      {распечатать кодированное сообщение}
      WRITE('Расшифрованные данные: ');
      Decode(Msg, MsgLength)
    END;
  WRITELN
END.{Decryption}
