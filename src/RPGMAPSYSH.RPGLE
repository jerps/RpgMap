**FREE

// RPGMAPSYSH.RPGLE - RPGMAPSYS header file 
// (c) 2017 John Erps


/if defined(RPGMAPSYS_H)
/eof
/else
/define RPGMAPSYS_H
/endif


// Return errno
dcl-pr RMSysErrno int(10);
end-pr;

// Send Escape Message
dcl-pr RMSysSndEscapeMsg;
  msgid char(7) value;
  msgdata varchar(500) value options(*nopass); 
end-pr;

// Convert CCSID, wrapper proc for Iconv.
// Return *on if ok, else return *off.
// Par. noinitshst: *on = don't go into the initial shift state.
dcl-pr RMSysCvtCCSID ind;
  fromccsid int(10) value;
  toccsid int(10) value;
  frombuf pointer;
  frombufl uns(10);
  tobuf pointer;
  tobufl uns(10);
  noinitshst ind value options(*nopass);
end-pr;
