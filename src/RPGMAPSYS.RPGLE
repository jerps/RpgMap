**FREE

// RPGMAPSYS.RPGLE - RpgMap System 
// (c) 2017 John Erps (john.erps@gmail.com)


ctl-opt copyright('(c) 2017 John Erps (john.erps@gmail.com)');
ctl-opt nomain datfmt(*iso-) timfmt(*iso.) ccsid(*exact);


/include RPGMAPGDEF.RPGLE
/include RPGMAPSYSH.RPGLE


// ----- OS400 API Constants

dcl-c OS4Iconv_ERR 4294967295;


// ----- OS400 API Data Defs

dcl-ds OS4Error qualified;
  bytesprov int(10) inz(%size(OS4Error));
  bytesavail int(10);
  excid char(7);
  reserved char(1);
  excdata char(500);
end-ds;

dcl-ds OS4Iconv_t qualified template;
  return_value int(10);
  cd int(10) dim(12);
end-ds;

dcl-ds OS4IconvQtqCode_t qualified template;
  CCSID int(10) inz;
  ConvAlt int(10) inz;
  SubsAlt int(10) inz;
  ShiftAlt int(10) inz(1);
  InpLenOp int(10) inz;
  ErrorOpt int(10) inz;
  Reserved char(8) inz(*allx'00');
end-ds;


// ----- OS400 API Prototypes

dcl-pr OS4SndPgmMsg extpgm('QMHSNDPM'); 
    msgid char(7) const;
    qmsgf char(20) const;
    msgdata char(500) const options(*varsize);
    msgdatalen int(10) const;
    msgtype char(10) const;
    csentry char(10) const;
    cscounter int(10) const;
    msgkey char(4);
    err like(OS4Error);
end-pr;

dcl-pr OS4IconvQtqOpen like(OS4Iconv_t) extproc('QtqIconvOpen'); 
  toCode likeds(OS4IconvQtqCode_t) const;
  fromCode likeds(OS4IconvQtqCode_t) const;
end-pr;

dcl-pr OS4Iconv uns(10) extproc('iconv');
  cd like(OS4Iconv_t) value;
  inbuf pointer;
  inbytesleft uns(10);
  outbuf pointer;
  outbytesleft uns(10);
end-pr;

dcl-pr OS4IconvClose int(10) extproc('iconv_close');
  hConv likeds(OS4Iconv_t) value;
end-pr;


// ----- Globals

dcl-s OS4IconvInit ind inz(*off);
dcl-ds OS4IconvFromCCSID likeds(OS4IconvQtqCode_t) inz(*likeds);
dcl-ds OS4IconvToCCSID likeds(OS4IconvQtqCode_t) inz(*likeds);
dcl-ds OS4Iconvh likeds(OS4Iconv_t) inz(*likeds);


// ----- Exported procedures


// Return errno
dcl-proc RMSysErrno export;

  dcl-pi *n int(10);
  end-pi;

  dcl-pr OS4Errno_ pointer extproc('__errno');
  end-pr;
  dcl-s errno int(10) based(errno_);
  
  errno_ = OS4Errno_();
  return errno;
  
end-proc;


// Send Escape Message
dcl-proc RMSysSndEscapeMsg export;

  dcl-pi *n;
    msgid char(7) value;
    msgdata varchar(500) value options(*nopass); 
  end-pi;

  dcl-s msgd char(500);
  dcl-s msgdl int(10);
  dcl-s msgkey char(4);

  if %parms >= %parmnum(msgdata);
    msgd = msgdata;
    msgdl = %len(msgdata);
  else;
    msgdl = 0;
  endif;
  OS4SndPgmMsg(msgid:'RPGMAP    '+RMLIB:msgd:msgdl:'*ESCAPE':'*':0:msgkey:OS4Error);
  
end-proc;


// Convert data to different CCSID.
// This procedure is a wrapper for Iconv().
dcl-proc RMSysCvtCCSID export;

  dcl-pi *n ind;
    fromccsid int(10) value;
    toccsid int(10) value;
    frombuf pointer;
    frombufl uns(10);
    tobuf pointer;
    tobufl uns(10);
    noinitshst ind value options(*nopass);
  end-pi;
  
  dcl-s shiftalt int(10);
  
  if     %parmnum(noinitshst) >= %parms
     and noinitshst;
    shiftalt = 0;
  else;
    shiftalt = 1;
  endif;
  
  if    not OS4IconvInit
     or fromccsid <> OS4IconvFromCCSID.CCSID
     or toccsid <> OS4IconvToCCSID.CCSID
     or shiftalt <> OS4IconvFromCCSID.ShiftAlt;
    if OS4IconvInit;
      OS4IconvClose(OS4Iconvh);
    endif;
    OS4IconvFromCCSID.CCSID = fromccsid;
    OS4IconvToCCSID.CCSID = toccsid;
    OS4IconvFromCCSID.ShiftAlt = shiftalt;
    OS4Iconvh = *allx'00';
    OS4Iconvh = OS4IconvQtqOpen(OS4IconvToCCSID:OS4IconvFromCCSID);
    if OS4Iconvh.return_value = -1;
      RMSysSndEscapeMsg('RM01001'
          :%editc(%dec(fromccsid:5:0):'X')+%editc(%dec(toccsid:5:0):'X'));
    endif;
    OS4IconvInit = *on;
  endif;
  return OS4IConv(OS4Iconvh:frombuf:frombufl:tobuf:tobufl) <> OS4Iconv_ERR;

end-proc;
  

// ----- Internal procedures
