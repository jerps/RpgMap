**FREE

// RPGMAPSYSH.RPGLE - RPGMAPSYS header file 
// Copyright (c) 2017 John Erps      


/if defined(RPGMAPSYS_H)
/eof
/else
/define RPGMAPSYS_H
/endif


// Send Escape Message
dcl-pr RMSysSndEscapeMsg;
  msgid char(7) value;
  msgdata varchar(500) value options(*nopass); 
end-pr;

// Convert CCSID
dcl-pr RMSysCvtCCSID uns(10);
  fromccsid int(10) value;
  toccsid int(10) value;
  frombuf pointer;
  frombufl uns(10);
  tobuf pointer;
  tobufl uns(10);
end-pr;
