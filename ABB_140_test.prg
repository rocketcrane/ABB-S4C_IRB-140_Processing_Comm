%%%
  VERSION:1
  LANGUAGE:ENGLISH
%%%
MODULE SERVER

VAR iodev readChan;
VAR iodev writeChan;
VAR string input;
VAR string message;
VAR num code;

PROC parseMsg(string msg)
	VAR num length;
	VAR bool ok;
	length := StrMatch(msg, 1, "#");
	ok := StrToVal(StrPart(msg, 1, 2), code);
	IF length > 5 THEN
		message := StrPart(msg, 4, length - 2);
	ELSE
		message := "null";
	ENDIF
ENDPROC

PROC main()
	Open "COM3",readChan\Read;
	Open "COM3",writeChan\Write;
	WHILE TRUE DO
		Write writeChan,"Hello World";
		input := ReadStr(readChan);
		parseMsg input;
		tpWrite "code is: ";
		tpWrite code;
		tpWrite "message is: ";
		tpWrite message;
	ENDWHILE
	Close readChan;
	Close writeChan;
ENDPROC

ENDMODULE




