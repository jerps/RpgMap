**FREE

// RPGMAPGMF.RPGLE - RpgMap Gen Main Func
// (c) 2017-2018 John Erps


ctl-opt copyright('(c) 2017 John Erps');
ctl-opt nomain datfmt(*iso-) timfmt(*iso.) ccsid(*exact);


/include _TLIB_/INCLUDERPG,RPGMAP
/include RPGMAPGDEF.RPGLE
/include RPGMAPGMFH.RPGLE
/include RPGMAPVALH.RPGLE
/include RPGMAPSYSH.RPGLE
/include RPGMAPRBTC.RPGLE


// ----- Exported procedures


// Return *on if the k/i pair has been inserted.
dcl-proc RMMInsert export;

  dcl-pi *n ind;
    map pointer value;
    mode int(10) value;
    k pointer value;
    i pointer value;
  end-pi;

  dcl-s obj pointer;
  dcl-s mapi pointer;
  dcl-s c pointer;
  dcl-s isv ind;
  dcl-s flags char(1);
  
  if %bitand(RMValObjFlags(map):x'02') = x'02' and not rm_isi(k);
    RMSysSndEscapeMsg('RM00002');
  endif;
  if %bitand(RMValObjFlags(map):x'40') = x'40';
    RMSysSndEscapeMsg('RM00005');
  endif;
  obj = k;
  exsr checkobj;
  if i <> *null;
    obj = i;
    exsr checkobj;
  endif;  
  mapi = RMValMapImpl(map);
  if mode = 1; //excl
    c = RMBCursorCrt(mapi:0:*null);
    RMBCursorSetLlGt(c:k:0);
    dow     RMBCursorReadNxtPrv(c:0) = 1
        and RMValObjCompare(map:k:RMBCursorKey(c)) = 0;
      RMBTreeRmv(mapi:RMBCursorNode(c));
    enddo;
    RMBCursorDispose(c);
  endif;
  if     mode = 2 //cond
     and RMBTreeHasKey(mapi:k) = 1;
    return *off;
  endif;
  RMBTreeInsert(mapi:k:i);
  flags = RMValObjFlags(k);
  if %bitand(flags:x'01') <> x'01';
    RMValObjSetFlags(k:%bitor(flags:x'80'));
  endif;
  if i <> *null;
    flags = RMValObjFlags(i);
    if %bitand(flags:x'01') <> x'01';
      RMValObjSetFlags(i:%bitor(flags:x'80'));
    endif;
  endif;
  
  RMBFireEvent(mapi:1:k:i);

  return *on;
  
  begsr checkobj;  
    if RMValIsCursor(obj);
      RMSysSndEscapeMsg('RM00201');
    endif;
    if %bitand(RMValObjFlags(obj):x'80') = x'80';
      if RMValIsMap(obj);
        RMSysSndEscapeMsg('RM00010');
      else;
        RMSysSndEscapeMsg('RM00012');
      endif;
    endif;
  endsr;
    
end-proc;


dcl-proc RMMInsertFromMap export;

  dcl-pi *n;
    map pointer value;
    mode int(10) value;
    map2 pointer value;
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  dcl-s c pointer;
  dcl-s k pointer;
  dcl-s i pointer;
  dcl-s dk ind inz(*off);
  dcl-s di ind inz(*off);
      
  c = RMBCursorCrt(RMValMapImpl(map2):0:*null);
  if %parms = 4 and key1 = *null;
    RMBCursorSetLlGt(c:*null:1);
  elseif     %parms > 3
         and key1 <> *null;
    RMBCursorSetLlGt(c:key1:0);
  endif;
  dow RMBCursorReadNxtPrv(c:0) = 1;
    if %parms > 4;
      if     key2 <> *null
         and RMValObjCompare(map2:RMBCursorKey(c):key2) = 1;
        leave;
      endif;
    elseif     %parms = 4
           and RMValObjCompare(map2:RMBCursorKey(c):key1) = 1;
      leave;
    endif;
    k = RMBCursorKey(c);
    i = RMBCursorItem(c);
    dk = *off;
    di = *off;
    if     k <> *null
       and (not RMValIsMap(k) or %bitand(RMValObjFlags(k):x'01') <> x'01');
      k = rm_cpy(k);
      dk = *on;
    endif;
    if     i <> *null
       and (not RMValIsMap(i) or %bitand(RMValObjFlags(i):x'01') <> x'01');
      i = rm_cpy(i);
      di = *on;
    endif;
    if     k <> *null
       and RMMInsert(map:mode:k:i);
      dk = *off;
      di = *off;
    endif;
    if dk;
      dk = *off;
      RMValDispose(k);
    endif;
    if di;
      di = *off;
      RMValDispose(i);
    endif;
  enddo;
  RMBCursorDispose(c);
  
  return;
  
  on-exit;
  
  if dk;
    dk = *off;
    RMValDispose(k);
  endif;
  if di;
    di = *off;
    RMValDispose(i);
  endif;

end-proc;


dcl-proc RMMForEachDo export;

  dcl-pi *n pointer;
    map pointer value;
    proc pointer(*proc) value;
    rev ind value;
    usrd pointer value options(*nopass);
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  dcl-pr call_proc pointer extproc(call_proc_p);
    key pointer value;
    item pointer value;
    usrd pointer value;
    stop ind;
  end-pr;

  dcl-s call_proc_p pointer(*proc);
  dcl-s usrd2 pointer;
  dcl-s stop ind;
  dcl-s c pointer;
      
  if %parms >= %parmnum(usrd);
    usrd2 = usrd;
  else;
    usrd2 = *null;
  endif;
  
  stop = *off;
  call_proc_p = proc;
  c = RMBCursorCrt(RMValMapImpl(map):0:*null);
  if %parms = 5 and key1 = *null;
    if not rev;
      RMBCursorSetLlGt(c:*null:1);
    endif;
  elseif rev;
    if %parms = 5;
      RMBCursorSetLlGt(c:key1:1);
    elseif    %parms < 6
           or key2 = *null;
      RMBCursorSetLlGt(c:*null:1);
    else;
      RMBCursorSetLlGt(c:key2:1);
    endif;
  elseif     %parms > 4
         and key1 <> *null;
    RMBCursorSetLlGt(c:key1:0);
  endif;
  dow        rev and RMBCursorReadNxtPrv(c:1) = 1
      or not rev and RMBCursorReadNxtPrv(c:0) = 1;
    if rev;
      if     %parms > 4
         and key1 <> *null
         and RMValObjCompare(map:RMBCursorKey(c):key1) = -1;
        leave;
      endif;
    elseif %parms > 5;
      if     key2 <> *null
         and RMValObjCompare(map:RMBCursorKey(c):key2) = 1;
        leave;
      endif;
    elseif     %parms = 5
           and RMValObjCompare(map:RMBCursorKey(c):key1) = 1;
      leave;
    endif;
    usrd2 = call_proc(RMBCursorKey(c):RMBCursorItem(c):usrd2:stop);
    if stop;
      leave;
    endif;
  enddo;
  RMBCursorDispose(c);
  
  return usrd2;

end-proc;


// Dispose obj, which has been used as an argument.
// Do not dispose if obj is *null, a cursor, a manually disposed map,
// or a value/map contained in a map.
dcl-proc RMMDisposeArg export;

  dcl-pi *n;
    obj pointer value;
  end-pi;

  if    obj = *null
     or RMValIsCursor(obj)
     or %bitand(RMValObjFlags(obj):x'01') = x'01'
     or %bitand(RMValObjFlags(obj):x'80') = x'80';
    return;
  endif;
  RMValDispose(obj);
      
end-proc;


// ----- Internal procedures
