%%%
  VERSION:1
  LANGUAGE:ENGLISH
%%%

VAR iodev readChan;
VAR iodev writeChan;
VAR string input;

PROC parseMsg(string msg)
	VAR num length;
	VAR num newInd;
	VAR string message;
	length := StrMatch(msg, 1, "#");
	message := StrPart(msg, 4, length - 2);

PROC main()
	Open "COM3",readChan\Read;
	Open "COM3",writeChan\Write;
	WHILE TRUE DO
		Write writeChan,"Hello World";
		input := ReadStr(readChan);
		tpWrite input;
	ENDWHILE
Close readChan;
Close writeChan;

	
ENDPROC
ENDMODULE




