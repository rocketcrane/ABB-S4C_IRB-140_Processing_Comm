%%%
  VERSION:1
  LANGUAGE:ENGLISH
%%%

MODULE AAA
  PERS tooldata gripper:=[TRUE,[[0,0,500],[1,0,0,0]],[0.001,[0,0,0.001],[1,0,0,0],0,0,0]];
  PERS wobjdata wall:=[FALSE,TRUE,"",[[-271.694,-1031.52,406.486],[0.000446,-1,4.6E-05,4.6E-05]],[[0,0,0],[1,0,0,0]]];

  PROC main()
    !Motion configuration
    ConfL\Off;
    
    MoveL [[0,0,0],[0.000446,-1,4.6E-05,4.6E-05],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],v20,z1,gripper\WObj:=wall;
  ENDPROC
ENDMODULE

