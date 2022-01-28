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
VAR num length;
VAR num acc;

PROC parseMsg(string msg)
	VAR bool ok;
	length := StrMatch(msg, 1, "#");
	ok := StrToVal(StrPart(msg, 1, 2), code);
	!IF length > 5 THEN
	!	message := StrPart(msg, 4, length - 2);
	!ELSE
	!	message := "null";
	!ENDIF
ENDPROC

PROC main()
	Open "COM2",readChan\Read;
	Open "COM2",writeChan\Write;
	WHILE TRUE DO
		Write writeChan,"Hello World";
		input := ReadStr(readChan);
		parseMsg input;
		acc := acc + 1;
		tpWrite "number of times ReadStr has returned: " \Num := acc;
		tpWrite "code is: " \Num := code;
		tpWrite "length is: " \Num := length;
		tpWrite input;
	ENDWHILE
	Close readChan;
	Close writeChan;
ENDPROC

ENDMODULE