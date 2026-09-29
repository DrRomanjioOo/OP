PROGRAM Encryption(INPUT, OUTPUT);
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

PROCEDURE Initialize(VAR Code: Chiper);
{Присвоить Code шифр замены}
BEGIN {Initialize}
  Code[' '] := '-';
  Code['A'] := 'Z';
  Code['B'] := 'Y';
  Code['C'] := 'X';
  Code['D'] := '#';
  Code['E'] := 'V';
  Code['F'] := 'U';
  Code['G'] := 'T';
  Code['H'] := 'S';
  Code['I'] := 'O';
  Code['J'] := 'Q';
  Code['K'] := 'P';
  Code['L'] := '!';
  Code['M'] := 'N';
  Code['N'] := 'M';
  Code['O'] := '2';
  Code['P'] := 'K';
  Code['Q'] := '$';
  Code['R'] := 'D';
  Code['S'] := 'H';
  Code['T'] := '*';
  Code['U'] := 'F';
  Code['V'] := 'E';
  Code['W'] := 'T';
  Code['X'] := 'C';
  Code['Y'] := 'B';
  Code['Z'] := 'A'
END;  {Initialize}

PROCEDURE Encode(VAR S: Str; MsgLength: Length);
{Выводит символы из Code, соответствующие символам из S}
VAR
  Index: INTEGER;
BEGIN {Encode}
  FOR Index := 1 TO MsgLength
  DO
    IF S[Index] IN Let
    THEN
      WRITE(Code[S[Index]])
    ELSE
      WRITE(S[Index]);
  WRITELN
END; {Encode}

BEGIN{Encryption}
  {Инициализировать Code}
  Initialize(Code);
  ExitProgram := False;
  WHILE NOT EOF AND NOT ExitProgram
  DO
    BEGIN
      WRITE('Входные данные: ');
      {читать строку в Msg и распечатать её}
      MsgLength := 0;
      WHILE NOT EOLN AND (MsgLength < Len)
      DO
        BEGIN
          MsgLength := MsgLength + 1;
          READ(Msg[MsgLength]);
          WRITE(Msg[MsgLEngth])
        END;
      READLN;
      WRITELN;
      IF MsgLength = 0
      THEN
        ExitProgram := True;
      {распечатать кодированное сообщение}
      WRITE('Зашифрованные данные: ');
      Encode(Msg, MsgLength)
    END;
  WRITELN
END.{Encryption}
