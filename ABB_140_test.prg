%%%
  VERSION:1
  LANGUAGE:ENGLISH
%%%

VAR iodev readChan;
VAR iodev writeChan;
VAR string input;


PROC main()
	Open "COM3",readChan\Read;
	Open "COM3",writeChan\Write;
	WHILE TRUE DO
		Write writeChan,"hello";
		input := ReadStr(readChan);
		tpWrite input;
	ENDWHILE
Close readChan;
Close writeChan;

	
ENDPROC
ENDMODULE




