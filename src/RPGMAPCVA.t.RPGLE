**FREE

// RPGMAPCVA.RPGLE - RpgMap Compare Values Alt seq
// (c) 2017 John Erps


ctl-opt copyright('(c) 2017 John Erps');
ctl-opt nomain datfmt(*iso-) timfmt(*iso.) ccsid(*exact) altseq(*ext) srtseq(_SRTSEQ_);


/include RPGMAPGDEF.RPGLE
/include RPGMAPCVAH.RPGLE
/include RPGMAPSYSH.RPGLE


dcl-proc RMCvaCompareStr export;

  dcl-pi *n int(10);
    s1 pointer value;
    s2 pointer value;
  end-pi;

  dcl-s u varchar(30000) based(up);
  dcl-s v1 varchar(120000) static;
  dcl-s v2 varchar(120000) static;
  dcl-s inbuf pointer;
  dcl-s inbufl uns(10);
  dcl-s outbuf pointer;
  dcl-s outbufl uns(10);
  
  up = s1;
  inbuf = %addr(u:*data);
  inbufl = %len(u);
  outbuf = %addr(v1:*data);
  outbufl = %size(v1) - 4;
  %len(v1) = outbufl;
  RMSysCvtCCSID(1208:0:inbuf:inbufl:outbuf:outbufl);
  %len(v1) = %size(v1) - 4 - outbufl;
  
  up = s2;
  inbuf = %addr(u:*data);
  inbufl = %len(u);
  outbuf = %addr(v2:*data);
  outbufl = %size(v2) - 4;
  %len(v2) = outbufl;
  RMSysCvtCCSID(1208:0:inbuf:inbufl:outbuf:outbufl);
  %len(v2) = %size(v2) - 4 - outbufl;
  
  if v1 < v2;
    return -1;
  elseif v1 > v2;
    return 1;
  endif;
  return 0;
      
end-proc;


dcl-proc RMCvaCompareChar export;

  dcl-pi *n int(10);
    c1 pointer value;
    c2 pointer value;
  end-pi;

  dcl-s v1 varchar(30000) based(v1p);
  dcl-s v2 varchar(30000) based(v2p);
  
  v1p = c1;
  v2p = c2;
  
  if v1 < v2;
    return -1;
  elseif v1 > v2;
    return 1;
  endif;
  return 0;
      
end-proc;
