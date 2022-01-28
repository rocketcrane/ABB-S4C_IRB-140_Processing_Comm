%%%
  VERSION:1
  LANGUAGE:ENGLISH
%%%
MODULE SERVER

VAR iodev readChan;
VAR iodev writeChan;
VAR string message;
VAR string input;
VAR num code;

PROC parseMsg(string msg)
	VAR bool ok;
	VAR num length;
	length := StrMatch(msg, 1, "#");
	ok := StrToVal(StrPart(msg, 1, 2), code);
	IF length > 5 THEN
		message := StrPart(msg, 4, length - 5);
	ELSE
		message := "null";
	ENDIF
ENDPROC

PROC main()
	Open "COM2",readChan\Read;
	Open "COM2",writeChan\Write;
	WHILE TRUE DO
		input := ReadStr(readChan);
		parseMsg input;
		TEST code
			CASE 88:
				tpWrite "debug message, code " \Num := code;
				tpWrite message;
				Write writeChan, "debug message received";
			CASE 99:
				tpWrite "normal program exit, code " \Num := code;
				Write writeChan, "normal program exit request received";
				EXIT;
		ENDTEST
	ENDWHILE
	Close readChan;
	Close writeChan;
ENDPROC

ENDMODULE