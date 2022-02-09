MODULE ABBSERVER
  VAR iodev readChan;
  VAR iodev writeChan;
  VAR string message;
  VAR string subString;
  VAR string input;
  VAR num code;
  PERS tooldata gripper:=[TRUE,[[0,0,500],[1,0,0,0]],[0.001,[0,0,0.001],[1,0,0,0],0,0,0]];
  PERS wobjdata wall:=[FALSE,TRUE,"",[[0,0,0],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];
  !PERS speeddata currentSpeed;
  !PERS zonedata currentZone;
  VAR robtarget currentTarget;
  VAR num params{7};

  PROC parseMsg(string msg)
    VAR bool ok;
    VAR num length;
    VAR num acc:=1;
    VAR num ind:=1;
    VAR num newInd;

    length:=StrMatch(msg,1,"#");
    ok:=StrToVal(StrPart(msg,1,2),code);
    IF length>5 THEN
      message:=StrPart(msg,4,length-5);
      TEST code
      CASE 1:
        WHILE acc<8 DO
          newInd:=StrMatch(message,ind," ")+1;
          subString:=StrPart(message,ind,newInd-ind-1);
          ok:=StrToVal(subString,params{acc});
          ind:=newInd;
          acc:=acc+1;
        ENDWHILE
        currentTarget:=[[params{1},params{2},params{3}],[params{4},params{5},params{6},params{7}],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
      ENDTEST
    ELSE
      message:="null";
    ENDIF
  ENDPROC

  PROC initialize()
    wall:=[FALSE,TRUE,"",[[-271.694,-1031.52,406.486],[0.000446,-1,4.6E-05,4.6E-05]],[[0,0,0],[1,0,0,0]]];
    gripper:=[TRUE,[[0,0,500],[1,0,0,0]],[0.001,[0,0,0.001],[1,0,0,0],0,0,0]];
  ENDPROC

  PROC main()
    !Motion configuration
    ConfL\Off;
    Open "COM2",readChan\Read;
    Open "COM2",writeChan\Write;
    initialize;
    WHILE TRUE DO
      input:=ReadStr(readChan);
      parseMsg input;
      TEST code
      CASE 1:
        Write writeChan,"moveL command received";
        TPWrite "moveL in progress, code "\Num:=code;
        TPWrite "params 1 "\Num:=params{1};
        TPWrite "params 2 "\Num:=params{2};
        TPWrite "params 3 "\Num:=params{3};
        TPWrite "params 4 "\Num:=params{4};
        TPWrite "params 5 "\Num:=params{5};
        TPWrite "params 6 "\Num:=params{6};
        TPWrite "params 7 "\Num:=params{7};
        MoveL currentTarget,v20,z1,gripper\WObj:=wall;
      CASE 88:
        Write writeChan,"debug message received";
        TPWrite "debug message, code "\Num:=code;
        TPWrite message;
      CASE 99:
        Write writeChan,"normal program exit request received";
        TPWrite "normal program exit, code "\Num:=code;
        EXIT;
      ENDTEST
    ENDWHILE
    Close readChan;
    Close writeChan;
  ENDPROC
ENDMODULE