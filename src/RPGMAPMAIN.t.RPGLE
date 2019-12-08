**FREE

// RPGMAPMAIN.RPGLE - RpgMap Main
// (c) 2017-2018 John Erps


ctl-opt copyright('(c) 2017-2018 John Erps');
ctl-opt nomain datfmt(*iso-) timfmt(*iso.) ccsid(*exact);


/include _TLIB_/INCLUDERPG,RPGMAP
/include RPGMAPGDEF.RPGLE
/include RPGMAPVALH.RPGLE
/include RPGMAPSYSH.RPGLE
/include RPGMAPRBTC.RPGLE
/include RPGMAPGMFH.RPGLE


// ----- Options

dcl-c OPT_BEGIN1          x'5C8240';                 // *b
dcl-c OPT_BEGIN2          x'5C828587899540';         // *begin
dcl-c OPT_END1            x'5C8540';                 // *e
dcl-c OPT_END2            x'5C85958440';             // *end
dcl-c OPT_FIRST1          x'5C8640';                 // *f
dcl-c OPT_FIRST2          x'5C868999A2A340';         // *first
dcl-c OPT_LAST1           x'5C9340';                 // *l
dcl-c OPT_LAST2           x'5C9381A2A340';           // *last
dcl-c OPT_GE              x'5C878540';               // *ge
dcl-c OPT_LE              x'5C938540';               // *le
dcl-c OPT_MM              x'5C949440';               // *mm


// ----- Exported procedures


// ----- Map


// ----- RM_M <<<<<<<<<<
dcl-proc rm_m export;

  dcl-pi *n pointer;
/include _TLIB_/INCLUDERPG,RPGMAPI001
  end-pi;

  dcl-s na int(10);
  dcl-s k pointer dim(100) static;
  dcl-s i pointer dim(100) static;
  dcl-s m pointer;
  dcl-s x int(10);

  na = %div(%parms+1:2);

  if na > 0;
    %subarr(k:1:na) = *null;
    %subarr(i:1:na) = *null;
  endif;

/include RPGMAPI101.RPGLE

  m = RMValMapCrt(x'00');

  for x = 1 to na;
    if     k(x) <> *null
       and RMMInsert(m:0:k(x):i(x));
      k(x) = *null;
      i(x) = *null;
    endif;
  endfor;

  return m;

  on-exit;

  for x = 1 to na;
    if k(x) <> *null;
      RMMDisposeArg(k(x));
    endif;
    if i(x) <> *null;
      RMMDisposeArg(i(x));
    endif;
  endfor;

end-proc;


// ----- RM_MM <<<<<<<<<<
dcl-proc rm_mm export;

  dcl-pi *n pointer;
/include _TLIB_/INCLUDERPG,RPGMAPI001
  end-pi;

  dcl-s na int(10);
  dcl-s k pointer dim(100) static;
  dcl-s i pointer dim(100) static;
  dcl-s m pointer;
  dcl-s x int(10);

  na = %div(%parms+1:2);

  if na > 0;
    %subarr(k:1:na) = *null;
    %subarr(i:1:na) = *null;
  endif;

/include RPGMAPI101.RPGLE

  m = RMValMapCrt(x'01');

  for x = 1 to na;
    if     k(x) <> *null
       and RMMInsert(m:0:k(x):i(x));
      k(x) = *null;
      i(x) = *null;
    endif;
  endfor;

  return m;

  on-exit;

  for x = 1 to na;
    if k(x) <> *null;
      RMMDisposeArg(k(x));
    endif;
    if i(x) <> *null;
      RMMDisposeArg(i(x));
    endif;
  endfor;

end-proc;


// ----- RM_V <<<<<<<<<<
dcl-proc rm_v export;

  dcl-pi *n pointer;
/include _TLIB_/INCLUDERPG,RPGMAPI002
  end-pi;

  dcl-s na int(10);
  dcl-s i pointer dim(100) static;
  dcl-s m pointer;
  dcl-s k int(10);
  dcl-s kv pointer inz(*null);
  dcl-s x int(10);

  na = %parms;

  if na > 0;
    %subarr(i:1:na) = *null;
  endif;

/include RPGMAPI102.RPGLE

  m = RMValMapCrt(x'02');

  k = 0;
  for x = 1 to na;
    if i(x) <> *null;
      k += 1;
      kv = rm_i(k);
      if RMMInsert(m:0:kv:i(x));
        kv = *null;
        i(x) = *null;
      endif;
    endif;
  endfor;

  return m;

  on-exit;

  if kv <> *null;
    RMMDisposeArg(kv);
  endif;
  for x = 1 to na;
    if i(x) <> *null;
      RMMDisposeArg(i(x));
    endif;
  endfor;

end-proc;


// ----- RM_IS_M <<<<<<<<<<
dcl-proc rm_is_m export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsMap(obj);

end-proc;


// ----- RM_IS_MM <<<<<<<<<<
dcl-proc rm_is_mm export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsMap(obj:*off:*on);

end-proc;


// ----- RM_IS_V <<<<<<<<<<
dcl-proc rm_is_v export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsMap(obj:*on);

end-proc;


// ----- RM_IN_MAP <<<<<<<<<<
dcl-proc rm_in_map export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValInMap(obj);

end-proc;


// ----- RM_MAKE_MAP_MAN_DISP <<<<<<<<<<
dcl-proc rm_make_map_man_disp export;

  dcl-pi *n pointer;
    map pointer value;
  end-pi;

  RMValMakeMapManDisp(map);

  return map;

end-proc;


// ----- RM_MAKE_MAP_IMMUTABLE <<<<<<<<<<
dcl-proc rm_make_map_immutable export;

  dcl-pi *n pointer;
    map pointer value;
    opt char(10) value options(*nopass);
  end-pi;

  dcl-s mm int(10);

  if %parms < %parmnum(opt);
    mm = 0;
  elseif %scan(OPT_MM:opt+x'40') > 0;
    mm = 1;
  elseif opt <> '';
    RMSysSndEscapeMsg('RM00101':%trim(opt));
  endif;

  RMValTestIfMap(map);
  RMValMakeMapImmut(map:mm);

  return map;

end-proc;


// ----- RM_DISPOSE <<<<<<<<<<
dcl-proc rm_dispose export;

  dcl-pi *n;
/include _TLIB_/INCLUDERPG,RPGMAPI003
  end-pi;

  dcl-s na int(10);
  dcl-s o pointer dim(100) static;
  dcl-s i int(10);

  na = %parms;

  if na > 0;
    %subarr(o:1:na) = *null;
  endif;

/include RPGMAPI103.RPGLE

  for i = 1 to na;
    if o(i) <> *null;
      RMValDispose2(o(i));
    endif;
  endfor;

  return;

end-proc;


// ----- RM_INSERT <<<<<<<<<<
dcl-proc rm_insert export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI001
  end-pi;

  dcl-s na int(10);
  dcl-s k pointer dim(100) static;
  dcl-s i pointer dim(100) static;
  dcl-s x int(10);

  na = %div(%parms:2);

  if na > 0;
    %subarr(k:1:na) = *null;
    %subarr(i:1:na) = *null;
  endif;

/include RPGMAPI104.RPGLE

  for x = 1 to na;
    if     k(x) <> *null
       and RMMInsert(map:0:k(x):i(x));
      k(x) = *null;
      i(x) = *null;
    endif;
  endfor;

  return map;

  on-exit;

  for x = 1 to na;
    if k(x) <> *null;
      RMMDisposeArg(k(x));
    endif;
    if i(x) <> *null;
      RMMDisposeArg(i(x));
    endif;
  endfor;

end-proc;


// ----- RM_INSERT_1 <<<<<<<<<<
dcl-proc rm_insert_1 export;

  dcl-pi *n pointer;
    map pointer value;
    key pointer value options(*nopass);
    item pointer value options(*nopass);
  end-pi;

  dcl-s k pointer inz(*null);
  dcl-s i pointer inz(*null);

  if %parms > 1;
    k = key;
  endif;
  if %parms > 2;
    i = item;
  endif;

  if     k <> *null
     and RMMInsert(map:0:k:i);
    k = *null;
    i = *null;
  endif;

  return map;

  on-exit;

  if k <> *null;
    RMMDisposeArg(k);
  endif;
  if i <> *null;
    RMMDisposeArg(i);
  endif;

end-proc;


// ----- RM_INSM <<<<<<<<<<
dcl-proc rm_insm export;

  dcl-pi *n pointer;
    map pointer value;
    map2 pointer value;
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  if %parms < 3;
    RMMInsertFromMap(map:0:map2);
  elseif %parms < 4;
    RMMInsertFromMap(map:0:map2:key1);
  else;
    RMMInsertFromMap(map:0:map2:key1:key2);
  endif;

  return map;

  on-exit;

  if %parms > 2 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 3 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_INSC <<<<<<<<<<
dcl-proc rm_insc export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI001
  end-pi;

  dcl-s na int(10);
  dcl-s k pointer dim(100) static;
  dcl-s i pointer dim(100) static;
  dcl-s x int(10);

  na = %div(%parms:2);

  if na > 0;
    %subarr(k:1:na) = *null;
    %subarr(i:1:na) = *null;
  endif;

/include RPGMAPI104.RPGLE

  for x = 1 to na;
    if     k(x) <> *null
       and RMMInsert(map:2:k(x):i(x));
      k(x) = *null;
      i(x) = *null;
    endif;
  endfor;

  return map;

  on-exit;

  for x = 1 to na;
    if k(x) <> *null;
      RMMDisposeArg(k(x));
    endif;
    if i(x) <> *null;
      RMMDisposeArg(i(x));
    endif;
  endfor;

end-proc;


// ----- RM_INSC1 <<<<<<<<<<
dcl-proc rm_insc1 export;

  dcl-pi *n pointer;
    map pointer value;
    key pointer value options(*nopass);
    item pointer value options(*nopass);
  end-pi;

  dcl-s k pointer inz(*null);
  dcl-s i pointer inz(*null);

  if %parms > 1;
    k = key;
  endif;
  if %parms > 2;
    i = item;
  endif;

  if     k <> *null
     and RMMInsert(map:2:k:i);
    k = *null;
    i = *null;
  endif;

  return map;

  on-exit;

  if k <> *null;
    RMMDisposeArg(k);
  endif;
  if i <> *null;
    RMMDisposeArg(i);
  endif;

end-proc;


// ----- RM_INSCM <<<<<<<<<<
dcl-proc rm_inscm export;

  dcl-pi *n pointer;
    map pointer value;
    map2 pointer value;
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  if %parms < 3;
    RMMInsertFromMap(map:2:map2);
  elseif %parms < 4;
    RMMInsertFromMap(map:2:map2:key1);
  else;
    RMMInsertFromMap(map:2:map2:key1:key2);
  endif;

  return map;

  on-exit;

  if %parms > 2 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 3 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_INSX <<<<<<<<<<
dcl-proc rm_insx export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI001
  end-pi;

  dcl-s na int(10);
  dcl-s k pointer dim(100) static;
  dcl-s i pointer dim(100) static;
  dcl-s x int(10);

  na = %div(%parms:2);

  if na > 0;
    %subarr(k:1:na) = *null;
    %subarr(i:1:na) = *null;
  endif;

/include RPGMAPI104.RPGLE

  for x = 1 to na;
    if     k(x) <> *null
       and RMMInsert(map:1:k(x):i(x));
      k(x) = *null;
      i(x) = *null;
    endif;
  endfor;

  return map;

  on-exit;

  for x = 1 to na;
    if k(x) <> *null;
      RMMDisposeArg(k(x));
    endif;
    if i(x) <> *null;
      RMMDisposeArg(i(x));
    endif;
  endfor;

end-proc;


// ----- RM_INSX1 <<<<<<<<<<
dcl-proc rm_insx1 export;

  dcl-pi *n pointer;
    map pointer value;
    key pointer value options(*nopass);
    item pointer value options(*nopass);
  end-pi;

  dcl-s k pointer inz(*null);
  dcl-s i pointer inz(*null);

  if %parms > 1;
    k = key;
  endif;
  if %parms > 2;
    i = item;
  endif;

  if     k <> *null
     and RMMInsert(map:1:k:i);
    k = *null;
    i = *null;
  endif;

  return map;

  on-exit;

  if k <> *null;
    RMMDisposeArg(k);
  endif;
  if i <> *null;
    RMMDisposeArg(i);
  endif;

end-proc;


// ----- RM_INSXM <<<<<<<<<<
dcl-proc rm_insxm export;

  dcl-pi *n pointer;
    map pointer value;
    map2 pointer value;
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  if %parms < 3;
    RMMInsertFromMap(map:1:map2);
  elseif %parms < 4;
    RMMInsertFromMap(map:1:map2:key1);
  else;
    RMMInsertFromMap(map:1:map2:key1:key2);
  endif;

  return map;

  on-exit;

  if %parms > 2 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 3 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_RMV <<<<<<<<<<
dcl-proc rm_rmv export;

  dcl-pi *n pointer;
    map pointer value;
    key pointer value;
    opt char(10) value options(*nopass);
  end-pi;

  dcl-s mapi pointer;
  dcl-s node pointer;
  dcl-s fl int(10);

  if key = *null;
    return map;
  endif;

  if %bitand(RMValObjFlags(map):x'40') = x'40';
    RMSysSndEscapeMsg('RM00005');
  endif;

  if %parms < %parmnum(opt);
    fl = 0;
  elseif %scan(OPT_FIRST1:opt+x'40') > 0 or %scan(OPT_FIRST2:opt+x'40') > 0;
    fl = 0;
  elseif %scan(OPT_LAST1:opt+x'40') > 0 or %scan(OPT_LAST2:opt+x'40') > 0;
    fl = 1;
  elseif opt <> '';
    RMSysSndEscapeMsg('RM00101':%trim(opt));
  endif;

  mapi = RMValMapImpl(map);
  node = RMBTreeGet(mapi:key:fl);
  if node <> *null;
    RMBTreeRmv(mapi:node);
  endif;

  return map;

  on-exit;

  if key <> *null;
    RMMDisposeArg(key);
  endif;

end-proc;


// ----- RM_RMVA <<<<<<<<<<
dcl-proc rm_rmva export;

  dcl-pi *n pointer;
    map pointer value;
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  dcl-s mapi pointer;
  dcl-s c pointer;

  if %bitand(RMValObjFlags(map):x'40') = x'40';
    RMSysSndEscapeMsg('RM00005');
  endif;

  mapi = RMValMapImpl(map);
  c = RMBCursorCrt(mapi:0:*null);
  if %parms = 2 and key1 = *null;
    RMBCursorSetLlGt(c:*null:1);
  elseif     %parms > 1
         and key1 <> *null;
    RMBCursorSetLlGt(c:key1:0);
  endif;
  dow RMBCursorReadNxtPrv(c:0) = 1;
    if %parms > 2;
      if     key2 <> *null
         and RMValObjCompare(map:RMBCursorKey(c):key2) = 1;
        leave;
      endif;
    elseif     %parms = 2
           and RMValObjCompare(map:RMBCursorKey(c):key1) = 1;
      leave;
    endif;
    RMBTreeRmv(mapi:RMBCursorNode(c));
  enddo;
  RMBCursorDispose(c);

  return map;

  on-exit;

  if %parms > 1 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 2 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_CMP <<<<<<<<<<
dcl-proc rm_cmp export;

  dcl-pi *n int(10);
    obj1 pointer value;
    obj2 pointer value;
  end-pi;

  return RMValObjCompare(*null:obj1:obj2);

end-proc;


// ----- RM_CEQ <<<<<<<<<<
dcl-proc rm_ceq export;

  dcl-pi *n ind;
    obj1 pointer value;
    obj2 pointer value;
  end-pi;

  return RMValObjCompare(*null:obj1:obj2) = 0;

end-proc;


// ----- RM_CLT <<<<<<<<<<
dcl-proc rm_clt export;

  dcl-pi *n ind;
    obj1 pointer value;
    obj2 pointer value;
  end-pi;

  return RMValObjCompare(*null:obj1:obj2) = -1;

end-proc;


// ----- RM_CLE <<<<<<<<<<
dcl-proc rm_cle export;

  dcl-pi *n ind;
    obj1 pointer value;
    obj2 pointer value;
  end-pi;

  return RMValObjCompare(*null:obj1:obj2) <> 1;

end-proc;


// ----- RM_CGT <<<<<<<<<<
dcl-proc rm_cgt export;

  dcl-pi *n ind;
    obj1 pointer value;
    obj2 pointer value;
  end-pi;

  return RMValObjCompare(*null:obj1:obj2) = 1;

end-proc;


// ----- RM_CGE <<<<<<<<<<
dcl-proc rm_cge export;

  dcl-pi *n ind;
    obj1 pointer value;
    obj2 pointer value;
  end-pi;

  return RMValObjCompare(*null:obj1:obj2) <> -1;

end-proc;


// ----- RM_ <<<<<<<<<<
dcl-proc rm_ export;

  dcl-pi *n pointer;
    obj pointer value;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1;
    RMValObjSSP(obj:opt);
  else;
    RMValObjSSP(obj:0);
  endif;
  return obj;

end-proc;


// ----- RM_GET <<<<<<<<<<
dcl-proc rm_get export;

  dcl-pi *n pointer;
    map pointer value;
    key pointer value;
    opt char(10) value options(*nopass);
  end-pi;

  dcl-s node pointer;
  dcl-s fl int(10);
  dcl-s item pointer;

  if key = *null;
    return *null;
  endif;

  if %parms < %parmnum(opt);
    fl = 0;
  elseif %scan(OPT_FIRST1:opt+x'40') > 0 or %scan(OPT_FIRST2:opt+x'40') > 0;
    fl = 0;
  elseif %scan(OPT_LAST1:opt+x'40') > 0 or %scan(OPT_LAST2:opt+x'40') > 0;
    fl = 1;
  elseif opt <> '';
    RMSysSndEscapeMsg('RM00101':%trim(opt));
  endif;

  item = *null;
  node = RMBTreeGet(RMValMapImpl(map):key:fl);
  if node <> *null;
    item = RMBTreeNodeItem(node);
  endif;

  return item;

  on-exit;

  if key <> *null;
    RMMDisposeArg(key);
  endif;

end-proc;


// ----- RM__ <<<<<<<<<<
dcl-proc rm__ export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI051
  end-pi;

  dcl-s na int(10);
  dcl-s k pointer dim(10) static;
  dcl-s mapi pointer;
  dcl-s item pointer;
  dcl-s node pointer;
  dcl-s i int(10);

  na = %parms-1;

  if na > 0;
    %subarr(k:1:na) = *null;
  endif;

/include RPGMAPI151.RPGLE

  mapi = RMValMapImpl(map);
  item = *null;
  for i = 1 to na;
    if k(i) <> *null;
      if item <> *null;
        if RMValIsMap(item);
          mapi = RMValMapImpl(item);
        else;
          item = *null;
          leave;
        endif;
      endif;
      node = RMBTreeGet(mapi:k(i):0);
      if node = *null;
        item = *null;
      else;
        item = RMBTreeNodeItem(node);
      endif;
      if item = *null;
        leave;
      endif;
    endif;
  endfor;

  return item;

  on-exit;

  for i = 1 to na;
    if k(i) <> *null;
      RMMDisposeArg(k(i));
    endif;
  endfor;

end-proc;


// ----- RM__I <<<<<<<<<<
dcl-proc rm__i export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI052
  end-pi;

  dcl-s k pointer dim(10) inz(*null);

/include RPGMAPI152.RPGLE

  return rm__(map:k(1):k(2):k(3):k(4):k(5):k(6):k(7):k(8):k(9):k(10));

end-proc;


// ----- RM__P <<<<<<<<<<
dcl-proc rm__p export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI053
  end-pi;

  dcl-s k pointer dim(10) inz(*null);

/include RPGMAPI153.RPGLE

  return rm__(map:k(1):k(2):k(3):k(4):k(5):k(6):k(7):k(8):k(9):k(10));

end-proc;


// ----- RM__D <<<<<<<<<<
dcl-proc rm__d export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI054
  end-pi;

  dcl-s k pointer dim(10) inz(*null);

/include RPGMAPI154.RPGLE

  return rm__(map:k(1):k(2):k(3):k(4):k(5):k(6):k(7):k(8):k(9):k(10));

end-proc;


// ----- RM__T <<<<<<<<<<
dcl-proc rm__t export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI055
  end-pi;

  dcl-s k pointer dim(10) inz(*null);

/include RPGMAPI155.RPGLE

  return rm__(map:k(1):k(2):k(3):k(4):k(5):k(6):k(7):k(8):k(9):k(10));

end-proc;


// ----- RM__Z <<<<<<<<<<
dcl-proc rm__z export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI056
  end-pi;

  dcl-s k pointer dim(10) inz(*null);

/include RPGMAPI156.RPGLE

  return rm__(map:k(1):k(2):k(3):k(4):k(5):k(6):k(7):k(8):k(9):k(10));

end-proc;


// ----- RM__N <<<<<<<<<<
dcl-proc rm__n export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI057
  end-pi;

  dcl-s k pointer dim(10) inz(*null);

/include RPGMAPI157.RPGLE

  return rm__(map:k(1):k(2):k(3):k(4):k(5):k(6):k(7):k(8):k(9):k(10));

end-proc;


// ----- RM__X <<<<<<<<<<
dcl-proc rm__x export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI062
  end-pi;

  dcl-s k pointer dim(10) inz(*null);

/include RPGMAPI162.RPGLE

  return rm__(map:k(1):k(2):k(3):k(4):k(5):k(6):k(7):k(8):k(9):k(10));

end-proc;


// ----- RM__XP <<<<<<<<<<
dcl-proc rm__xp export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI063
  end-pi;

  dcl-s k pointer dim(10) inz(*null);

/include RPGMAPI163.RPGLE

  return rm__(map:k(1):k(2):k(3):k(4):k(5):k(6):k(7):k(8):k(9):k(10));

end-proc;


// ----- RM__A <<<<<<<<<<
dcl-proc rm__a export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI058
  end-pi;

  dcl-s k pointer dim(10) inz(*null);

/include RPGMAPI158.RPGLE

  return rm__(map:k(1):k(2):k(3):k(4):k(5):k(6):k(7):k(8):k(9):k(10));

end-proc;


// ----- RM__AA <<<<<<<<<<
dcl-proc rm__aa export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI060
  end-pi;

  dcl-s k pointer dim(10) inz(*null);

/include RPGMAPI160.RPGLE

  return rm__(map:k(1):k(2):k(3):k(4):k(5):k(6):k(7):k(8):k(9):k(10));

end-proc;


// ----- RM__S <<<<<<<<<<
dcl-proc rm__s export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI059
  end-pi;

  dcl-s k pointer dim(10) inz(*null);

/include RPGMAPI159.RPGLE

  return rm__(map:k(1):k(2):k(3):k(4):k(5):k(6):k(7):k(8):k(9):k(10));

end-proc;


// ----- RM__SA <<<<<<<<<<
dcl-proc rm__sa export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI061
  end-pi;

  dcl-s k pointer dim(10) inz(*null);

/include RPGMAPI161.RPGLE

  return rm__(map:k(1):k(2):k(3):k(4):k(5):k(6):k(7):k(8):k(9):k(10));

end-proc;


// ----- RM_HKY <<<<<<<<<<
dcl-proc rm_hky export;

  dcl-pi *n ind;
    map pointer value;
    key pointer value;
  end-pi;

  if key = *null;
    return *off;
  endif;
  return RMBTreeHasKey(RMValMapImpl(map):key) = 1;

  on-exit;

  if key <> *null;
    RMMDisposeArg(key);
  endif;

end-proc;


// ----- RM_HKS <<<<<<<<<<
dcl-proc rm_hks export;

  dcl-pi *n ind;
    map pointer value;
    key pointer value;
    opt char(10) value options(*nopass);
  end-pi;

  dcl-s llgt int(10);

  if %parms < %parmnum(opt);
    llgt = 0;
  elseif %scan(OPT_GE:opt+x'40') > 0;
    llgt = 0;
  elseif %scan(OPT_LE:opt+x'40') > 0;
    llgt = 1;
  elseif opt <> '';
    RMSysSndEscapeMsg('RM00101':%trim(opt));
  endif;

  if key = *null;
    return *off;
  endif;
  return RMBTreeHasKeys(RMValMapImpl(map):key:llgt) = 1;

  on-exit;

  if key <> *null;
    RMMDisposeArg(key);
  endif;

end-proc;


// ----- RM_NUM <<<<<<<<<<
dcl-proc rm_num export;

  dcl-pi *n uns(20);
    map pointer value;
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  dcl-s c pointer;
  dcl-s n uns(20);

  if    %parms < 2
     or     key1 = *null
        and %parms > 2 and key2 = *null;
    return RMBTreeNum(RMValMapImpl(map));
  endif;
  if %parms = 2 and key1 = *null;
    return 0;
  endif;
  n = 0;
  c = RMBCursorCrt(RMValMapImpl(map):0:*null);
  if %parms > 1 and key1 <> *null;
    RMBCursorSetLlGt(c:key1:0);
  endif;
  dow RMBCursorReadNxtPrv(c:0) = 1;
    if %parms > 2;
      if     key2 <> *null
         and RMValObjCompare(map:RMBCursorKey(c):key2) = 1;
        leave;
      endif;
    elseif     %parms = 2
           and RMValObjCompare(map:RMBCursorKey(c):key1) = 1;
      leave;
    endif;
    n += 1;
  enddo;
  RMBCursorDispose(c);

  return n;

  on-exit;

  if %parms > 1 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 2 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_HIT <<<<<<<<<<
dcl-proc rm_hit export;

  dcl-pi *n ind;
    map pointer value;
    item pointer value;
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  dcl-s f ind;
  dcl-s c pointer;

  f = *off;
  c = RMBCursorCrt(RMValMapImpl(map):0:*null);
  if %parms = 3 and key1 = *null;
    RMBCursorSetLlGt(c:*null:1);
  elseif     %parms > 2
         and key1 <> *null;
    RMBCursorSetLlGt(c:key1:0);
  endif;
  dow RMBCursorReadNxtPrv(c:0) = 1;
    if %parms > 3;
      if     key2 <> *null
         and RMValObjCompare(map:RMBCursorKey(c):key2) = 1;
        leave;
      endif;
    elseif     %parms = 3
           and RMValObjCompare(map:RMBCursorKey(c):key1) = 1;
      leave;
    endif;
    if RMValObjCompare(*null:item:RMBCursorItem(c)) = 0;
      f = *on;
      leave;
    endif;
  enddo;
  RMBCursorDispose(c);
  return f;

  on-exit;

  if item <> *null;
    RMMDisposeArg(item);
  endif;
  if %parms > 2 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 3 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_NIT <<<<<<<<<<
dcl-proc rm_nit export;

  dcl-pi *n uns(20);
    map pointer value;
    item pointer value;
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  dcl-s n uns(20);
  dcl-s c pointer;

  n = 0;
  c = RMBCursorCrt(RMValMapImpl(map):0:*null);
  if %parms = 3 and key1 = *null;
    RMBCursorSetLlGt(c:*null:1);
  elseif     %parms > 2
         and key1 <> *null;
    RMBCursorSetLlGt(c:key1:0);
  endif;
  dow RMBCursorReadNxtPrv(c:0) = 1;
    if %parms > 3;
      if     key2 <> *null
         and RMValObjCompare(map:RMBCursorKey(c):key2) = 1;
        leave;
      endif;
    elseif     %parms = 3
           and RMValObjCompare(map:RMBCursorKey(c):key1) = 1;
      leave;
    endif;
    if RMValObjCompare(*null:item:RMBCursorItem(c)) = 0;
      n += 1;
    endif;
  enddo;
  RMBCursorDispose(c);
  return n;

  on-exit;

  if item <> *null;
    RMMDisposeArg(item);
  endif;
  if %parms > 2 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 3 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_GIK <<<<<<<<<<
dcl-proc rm_gik export;

  dcl-pi *n pointer;
    map pointer value;
    item pointer value;
    opt char(10) value options(*nopass);
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  dcl-s k pointer;
  dcl-s l ind;
  dcl-s c pointer;

  if %parms < %parmnum(opt);
    l = *off;
  elseif %scan(OPT_FIRST1:opt+x'40') > 0 or %scan(OPT_FIRST2:opt+x'40') > 0;
    l = *off;
  elseif %scan(OPT_LAST1:opt+x'40') > 0 or %scan(OPT_LAST2:opt+x'40') > 0;
    l = *on;
  elseif opt <> '';
    RMSysSndEscapeMsg('RM00101':%trim(opt));
  endif;

  k = *null;
  c = RMBCursorCrt(RMValMapImpl(map):0:*null);
  if %parms = 4 and key1 = *null;
    if not l;
      RMBCursorSetLlGt(c:*null:1);
    endif;
  elseif l;
    if %parms = 4;
      RMBCursorSetLlGt(c:key1:1);
    elseif    %parms < 5
           or key2 = *null;
      RMBCursorSetLlGt(c:*null:1);
    else;
      RMBCursorSetLlGt(c:key2:1);
    endif;
  elseif     %parms > 3
         and key1 <> *null;
    RMBCursorSetLlGt(c:key1:0);
  endif;
  dow        l and RMBCursorReadNxtPrv(c:1) = 1
      or not l and RMBCursorReadNxtPrv(c:0) = 1;
    if l;
      if     %parms > 3
         and key1 <> *null
         and RMValObjCompare(map:RMBCursorKey(c):key1) = -1;
        leave;
      endif;
    elseif %parms > 4;
      if     key2 <> *null
         and RMValObjCompare(map:RMBCursorKey(c):key2) = 1;
        leave;
      endif;
    elseif     %parms = 4
           and RMValObjCompare(map:RMBCursorKey(c):key1) = 1;
      leave;
    endif;
    if RMValObjCompare(*null:item:RMBCursorItem(c)) = 0;
      k = RMBCursorKey(c);
      leave;
    endif;
  enddo;
  RMBCursorDispose(c);
  return k;

  on-exit;

  if item <> *null;
    RMMDisposeArg(item);
  endif;
  if %parms > 2 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 3 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_CPY <<<<<<<<<<
dcl-proc rm_cpy export;

  dcl-pi *n pointer;
    obj pointer value;
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  dcl-s o pointer;

  if obj = *null;
    return *null;
  endif;

  if %parms < 2;
    o = RMValObjCopy(obj:*off);
  elseif %parms < 3;
    o = RMValObjCopy(obj:*off:key1);
  else;
    o = RMValObjCopy(obj:*off:key1:key2);
  endif;

  RMValObjSetFlags(o:%bitand(RMValObjFlags(o):x'3F'));

  return o;

  on-exit;

  if %parms > 1 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 2 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_CPYD <<<<<<<<<<
dcl-proc rm_cpyd export;

  dcl-pi *n pointer;
    obj pointer value;
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  dcl-s o pointer;

  if obj = *null;
    return *null;
  endif;

  if %parms < 2;
    o = RMValObjCopy(obj:*on);
  elseif %parms < 3;
    o = RMValObjCopy(obj:*on:key1);
  else;
    o = RMValObjCopy(obj:*on:key1:key2);
  endif;

  RMValObjSetFlags(o:%bitand(RMValObjFlags(o):x'3F'));

  return o;

  on-exit;

  if %parms > 1 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 2 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_CUR <<<<<<<<<<
dcl-proc rm_cur export;

  dcl-pi *n pointer;
    map pointer value;
    opt char(10) value options(*nopass);
  end-pi;

  dcl-s pos int(10);

  if %parms < %parmnum(opt);
    pos = 0;
  elseif %scan(OPT_BEGIN1:opt+x'40') > 0 or %scan(OPT_BEGIN2:opt+x'40') > 0;
    pos = 0;
  elseif %scan(OPT_END1:opt+x'40') > 0 or %scan(OPT_END2:opt+x'40') > 0;
    pos = 1;
  elseif opt <> '';
    RMSysSndEscapeMsg('RM00101':%trim(opt));
  endif;

  return RMValCursorCrt(map:pos);

end-proc;


// ----- RM_SETLL <<<<<<<<<<
dcl-proc rm_setll export;

  dcl-pi *n pointer;
    cur pointer value;
    key pointer value options(*nopass);
  end-pi;

  if %parms >= %parmnum(key);
    RMBCursorSetLlGt(RMValCursorImpl(cur):key:0);
  else;
    RMBCursorSetLlGt(RMValCursorImpl(cur):*null:0);
  endif;

  return cur;

  on-exit;

  if %parms >= %parmnum(key) and key <> *null;
    RMMDisposeArg(key);
  endif;

end-proc;


// ----- RM_SETGT <<<<<<<<<<
dcl-proc rm_setgt export;

  dcl-pi *n pointer;
    cur pointer value;
    key pointer value options(*nopass);
  end-pi;

  if %parms >= %parmnum(key);
    RMBCursorSetLlGt(RMValCursorImpl(cur):key:1);
  else;
    RMBCursorSetLlGt(RMValCursorImpl(cur):*null:1);
  endif;

  return cur;

  on-exit;

  if %parms >= %parmnum(key) and key <> *null;
    RMMDisposeArg(key);
  endif;

end-proc;


// ----- RM_READ_NEXT <<<<<<<<<<
dcl-proc rm_read_next export;

  dcl-pi *n ind;
    cur pointer value;
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  if %parms = 2 and key1 = *null;
    return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):0:*null:*null:1) = 1;
  elseif %parms = 2;
    return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):0:key1:*null:2) = 1;
  elseif %parms < 2;
    return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):0:*null:*null:0) = 1;
  elseif %parms < 3;
    return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):0:key1:*null:0) = 1;
  endif;
  return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):0:key1:key2:0) = 1;

  on-exit;

  if %parms > 1 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 2 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_READ_PREV <<<<<<<<<<
dcl-proc rm_read_prev export;

  dcl-pi *n ind;
    cur pointer value;
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  if %parms = 2 and key1 = *null;
    return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):1:*null:*null:1) = 1;
  elseif %parms = 2;
    return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):1:key1:*null:2) = 1;
  elseif %parms < 2;
    return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):1:*null:*null:0) = 1;
  elseif %parms < 3;
    return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):1:key1:*null:0) = 1;
  endif;
  return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):1:key1:key2:0) = 1;

  on-exit;

  if %parms > 1 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 2 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_KEY <<<<<<<<<<
dcl-proc rm_key export;

  dcl-pi *n pointer;
    cur pointer value;
  end-pi;

  return RMBCursorKey(RMValCursorImpl(cur));

end-proc;


// ----- RM_ITEM <<<<<<<<<<
dcl-proc rm_item export;

  dcl-pi *n pointer;
    cur pointer value;
  end-pi;

  return RMBCursorItem(RMValCursorImpl(cur));

end-proc;


// ----- RM_SETLL_READ_NEXT <<<<<<<<<<
dcl-proc rm_setll_read_next export;

  dcl-pi *n ind;
    cur pointer value;
    pos ind options(*nopass:*omit);
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  dcl-s pg ind;

  pg =     %parms >= 2
       and %addr(pos) <> *null;

  if not pg or pos;
    if pg;
      pos = *off;
    endif;
    if %parms >= %parmnum(key1);
      RMBCursorSetLlGt(RMValCursorImpl(cur):key1:0);
    else;
      RMBCursorSetLlGt(RMValCursorImpl(cur):*null:0);
    endif;
  endif;

  if %parms = 3 and key1 = *null;
    return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):0:*null:*null:1) = 1;
  elseif %parms = 3;
    return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):0:key1:*null:2) = 1;
  elseif %parms < 3;
    return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):0:*null:*null:0) = 1;
  elseif %parms < 4;
    return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):0:key1:*null:0) = 1;
  endif;
  return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):0:key1:key2:0) = 1;

  on-exit;

  if %parms > 2 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 3 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;



// ----- RM_SETGT_READ_PREV <<<<<<<<<<
dcl-proc rm_setgt_read_prev export;

  dcl-pi *n ind;
    cur pointer value;
    pos ind options(*nopass:*omit);
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  dcl-s pg ind;

  pg =     %parms >= 2
       and %addr(pos) <> *null;

  if not pg or pos;
    if pg;
      pos = *off;
    endif;
    if %parms >= %parmnum(key1);
      RMBCursorSetLlGt(RMValCursorImpl(cur):key1:1);
    else;
      RMBCursorSetLlGt(RMValCursorImpl(cur):*null:1);
    endif;
  endif;

  if %parms = 3 and key1 = *null;
    return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):1:*null:*null:1) = 1;
  elseif %parms = 3;
    return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):1:key1:*null:2) = 1;
  elseif %parms < 3;
    return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):1:*null:*null:0) = 1;
  elseif %parms < 4;
    return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):1:key1:*null:0) = 1;
  endif;
  return RMBCursorReadNxtPrv2(RMValCursorImpl(cur):1:key1:key2:0) = 1;

  on-exit;

  if %parms > 2 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 3 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_HAS_NEXT <<<<<<<<<<
dcl-proc rm_has_next export;

  dcl-pi *n ind;
    cur pointer value;
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  if %parms = 2 and key1 = *null;
    return RMBCursorHasNxtPrv2(RMValCursorImpl(cur):0:*null:*null:1) = 1;
  elseif %parms = 2;
    return RMBCursorHasNxtPrv2(RMValCursorImpl(cur):0:key1:*null:2) = 1;
  elseif %parms < 2;
    return RMBCursorHasNxtPrv2(RMValCursorImpl(cur):0:*null:*null:0) = 1;
  elseif %parms < 3;
    return RMBCursorHasNxtPrv2(RMValCursorImpl(cur):0:key1:*null:0) = 1;
  endif;
  return RMBCursorHasNxtPrv2(RMValCursorImpl(cur):0:key1:key2:0) = 1;

  on-exit;

  if %parms > 1 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 2 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_HAS_PREV <<<<<<<<<<
dcl-proc rm_has_prev export;

  dcl-pi *n ind;
    cur pointer value;
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  if %parms = 2 and key1 = *null;
    return RMBCursorHasNxtPrv2(RMValCursorImpl(cur):1:*null:*null:1) = 1;
  elseif %parms = 2;
    return RMBCursorHasNxtPrv2(RMValCursorImpl(cur):1:key1:*null:2) = 1;
  elseif %parms < 2;
    return RMBCursorHasNxtPrv2(RMValCursorImpl(cur):1:*null:*null:0) = 1;
  elseif %parms < 3;
    return RMBCursorHasNxtPrv2(RMValCursorImpl(cur):1:key1:*null:0) = 1;
  endif;
  return RMBCursorHasNxtPrv2(RMValCursorImpl(cur):1:key1:key2:0) = 1;

  on-exit;

  if %parms > 1 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 2 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_FOR_EACH_DO <<<<<<<<<<
dcl-proc rm_for_each_do export;

  dcl-pi *n pointer;
    map pointer value;
    proc pointer(*proc) value;
    usrd pointer value options(*nopass);
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  if %parms < 3;
    return RMMForEachDo(map:proc:*off);
  elseif %parms < 4;
    return RMMForEachDo(map:proc:*off:usrd);
  elseif %parms < 5;
    return RMMForEachDo(map:proc:*off:usrd:key1);
  endif;
  return RMMForEachDo(map:proc:*off:usrd:key1:key2);

  on-exit;

  if %parms > 3 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 4 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_FOR_EACH_DO_REV <<<<<<<<<<
dcl-proc rm_for_each_do_rev export;

  dcl-pi *n pointer;
    map pointer value;
    proc pointer(*proc) value;
    usrd pointer value options(*nopass);
    key1 pointer value options(*nopass);
    key2 pointer value options(*nopass);
  end-pi;

  if %parms < 3;
    return RMMForEachDo(map:proc:*on);
  elseif %parms < 4;
    return RMMForEachDo(map:proc:*on:usrd);
  elseif %parms < 5;
    return RMMForEachDo(map:proc:*on:usrd:key1);
  endif;
  return RMMForEachDo(map:proc:*on:usrd:key1:key2);

  on-exit;

  if %parms > 3 and key1 <> *null;
    RMMDisposeArg(key1);
  endif;
  if %parms > 4 and key2 <> *null;
    RMMDisposeArg(key2);
  endif;

end-proc;


// ----- RM_SET_COMP_FUN <<<<<<<<<<
dcl-proc rm_set_comp_fun export;

  dcl-pi *n pointer;
    map pointer value;
    comp pointer(*proc) value;
  end-pi;

  if RMBTreeNum(RMValMapImpl(map)) > 0;
    RMSysSndEscapeMsg('RM00041');
  endif;

  RMValMapSetCompf(map:comp);

  return map;

end-proc;


// ----- RM_GET_COMP_FUN <<<<<<<<<<
dcl-proc rm_get_comp_fun export;

  dcl-pi *n pointer(*proc);
    map pointer value;
  end-pi;

  return RMValMapGetCompf(map);

end-proc;


// ----- RM_SET_ATTR_VAL <<<<<<<<<<
dcl-proc rm_set_attr_val export;

  dcl-pi *n pointer;
    map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI064
  end-pi;

  dcl-s na int(10);
  dcl-s a varchar(100) ccsid(*utf8) dim(100) static;
  dcl-s v varchar(100) ccsid(*utf8) dim(100) static;
  dcl-s x int(10);

  na = %div(%parms:2);

  if na > 0;
    %subarr(a:1:na) = '';
    %subarr(v:1:na) = '';
  endif;

/include RPGMAPI164.RPGLE

  if na = 0;
    RMValMapSetAttr(map);
  else;
    for x = 1 to na;
      if v(x) = '';
        RMValMapSetAttr(map:a(x));
      else;
        RMValMapSetAttr(map:a(x):v(x));
      endif;
    endfor;
  endif;

  return map;

end-proc;


// ----- RM_GET_ATTR_VAL <<<<<<<<<<
dcl-proc rm_get_attr_val export;

  dcl-pi *n varchar(100) ccsid(*utf8);
    map pointer value;
    attr varchar(100) ccsid(*utf8) value;
  end-pi;

  return RMValMapGetAttr(map:attr);

end-proc;


// ----- RM_USER_DATA <<<<<<<<<<
dcl-proc rm_user_data export;

  dcl-pi *n int(10);
    obj pointer value;
  end-pi;

  return RMValRtnUsrDta(obj);

end-proc;


// ----- RM_I <<<<<<<<<<
dcl-proc rm_i export;

  dcl-pi *n pointer;
    value int(10) value;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1 and opt = 0;
    return RMValIntCrt(value:10:x'10');
  elseif %parms > 1 and opt < 0 and opt >= -65000;
    return RMValIntCrt(value:10:x'00':0-opt);
  elseif %parms > 1;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValIntCrt(value:10);

end-proc;


// ----- RM_I1 <<<<<<<<<<
dcl-proc rm_i1 export;

  dcl-pi *n pointer;
    value int(10) value;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1 and opt = 0;
    return RMValIntCrt(value:10:x'10');
  elseif %parms > 1 and opt < 0 and opt >= -65000;
    return RMValIntCrt(value:10:x'00':0-opt);
  elseif %parms > 1;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValIntCrt(value:10);

end-proc;


// ----- RM_I2 <<<<<<<<<<
dcl-proc rm_i2 export;

  dcl-pi *n pointer;
    value int(20) value;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1 and opt = 0;
    return RMValIntCrt(value:20:x'10');
  elseif %parms > 1 and opt < 0 and opt >= -65000;
    return RMValIntCrt(value:20:x'00':0-opt);
  elseif %parms > 1;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValIntCrt(value:20);

end-proc;


// ----- RM_ISI <<<<<<<<<<
dcl-proc rm_isi export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsInt(obj);

end-proc;


// ----- RM_ISI1 <<<<<<<<<<
dcl-proc rm_isi1 export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsInt(obj:10);

end-proc;


// ----- RM_ISI2 <<<<<<<<<<
dcl-proc rm_isi2 export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsInt(obj:20);

end-proc;


// ----- RM_I_ <<<<<<<<<<
dcl-proc rm_i_ export;

  dcl-pi *n int(10);
    value pointer value;
    default int(10) value options(*nopass);
  end-pi;

  if %parms > 1;
    return RMValConv2Int(value:default);
  endif;
  return RMValConv2Int(value);

end-proc;


// ----- RM_I__ <<<<<<<<<<
dcl-proc rm_i__ export;

  dcl-pi *n int(10);
    value pointer value;
    default int(10) value options(*nopass);
  end-pi;

  dcl-s r int(10);

  if %parms > 1;
    r = RMValConv2Int(value:default);
  else;
    r = RMValConv2Int(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_I1_ <<<<<<<<<<
dcl-proc rm_i1_ export;

  dcl-pi *n int(10);
    value pointer value;
    default int(10) value options(*nopass);
  end-pi;

  if %parms > 1;
    return RMValConv2Int(value:default);
  endif;
  return RMValConv2Int(value);

end-proc;


// ----- RM_I1__ <<<<<<<<<<
dcl-proc rm_i1__ export;

  dcl-pi *n int(10);
    value pointer value;
    default int(10) value options(*nopass);
  end-pi;

  dcl-s r int(10);

  if %parms > 1;
    r = RMValConv2Int(value:default);
  else;
    r = RMValConv2Int(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_I2_ <<<<<<<<<<
dcl-proc rm_i2_ export;

  dcl-pi *n int(20);
    value pointer value;
    default int(20) value options(*nopass);
  end-pi;

  if %parms > 1;
    return RMValConv2Int(value:default);
  endif;
  return RMValConv2Int(value);

end-proc;


// ----- RM_I2__ <<<<<<<<<<
dcl-proc rm_i2__ export;

  dcl-pi *n int(20);
    value pointer value;
    default int(20) value options(*nopass);
  end-pi;

  dcl-s r int(20);

  if %parms > 1;
    r = RMValConv2Int(value:default);
  else;
    r = RMValConv2Int(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_P <<<<<<<<<<
dcl-proc rm_p export;

  dcl-pi *n pointer;
    value packed(14:4) value;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1 and opt = 0;
    return RMValPDecCrt(value:10:x'10');
  elseif %parms > 1 and opt < 0 and opt >= -65000;
    return RMValPDecCrt(value:10:x'00':0-opt);
  elseif %parms > 1;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValPDecCrt(value:10);

end-proc;


// ----- RM_P1 <<<<<<<<<<
dcl-proc rm_p1 export;

  dcl-pi *n pointer;
    value packed(14:4) value;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1 and opt = 0;
    return RMValPDecCrt(value:10:x'10');
  elseif %parms > 1 and opt < 0 and opt >= -65000;
    return RMValPDecCrt(value:10:x'00':0-opt);
  elseif %parms > 1;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValPDecCrt(value:10);

end-proc;


// ----- RM_P2 <<<<<<<<<<
dcl-proc rm_p2 export;

  dcl-pi *n pointer;
    value packed(28:8) value;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1 and opt = 0;
    return RMValPDecCrt(value:20:x'10');
  elseif %parms > 1 and opt < 0 and opt >= -65000;
    return RMValPDecCrt(value:20:x'00':0-opt);
  elseif %parms > 1;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValPDecCrt(value:20);

end-proc;


// ----- RM_P3 <<<<<<<<<<
dcl-proc rm_p3 export;

  dcl-pi *n pointer;
    value packed(46:16) value;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1 and opt = 0;
    return RMValPDecCrt(value:30:x'10');
  elseif %parms > 1 and opt < 0 and opt >= -65000;
    return RMValPDecCrt(value:30:x'00':0-opt);
  elseif %parms > 1;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValPDecCrt(value:30);

end-proc;


// ----- RM_ISP <<<<<<<<<<
dcl-proc rm_isp export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsPDec(obj);

end-proc;


// ----- RM_ISP1 <<<<<<<<<<
dcl-proc rm_isp1 export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsPDec(obj:10);

end-proc;


// ----- RM_ISP2 <<<<<<<<<<
dcl-proc rm_isp2 export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsPDec(obj:20);

end-proc;


// ----- RM_ISP3 <<<<<<<<<<
dcl-proc rm_isp3 export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsPDec(obj:30);

end-proc;


// ----- RM_P_ <<<<<<<<<<
dcl-proc rm_p_ export;

  dcl-pi *n packed(14:4);
    value pointer value;
    default packed(14:4) value options(*nopass);
  end-pi;

  if %parms > 1;
    return RMValConv2PDec(value:default);
  endif;
  return RMValConv2PDec(value);

end-proc;


// ----- RM_P__ <<<<<<<<<<
dcl-proc rm_p__ export;

  dcl-pi *n packed(14:4);
    value pointer value;
    default packed(14:4) value options(*nopass);
  end-pi;

  dcl-s r packed(14:4);

  if %parms > 1;
    r = RMValConv2PDec(value:default);
  else;
    r = RMValConv2PDec(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_P1_ <<<<<<<<<<
dcl-proc rm_p1_ export;

  dcl-pi *n packed(14:4);
    value pointer value;
    default packed(14:4) value options(*nopass);
  end-pi;

  if %parms > 1;
    return RMValConv2PDec(value:default);
  endif;
  return RMValConv2PDec(value);

end-proc;


// ----- RM_P1__ <<<<<<<<<<
dcl-proc rm_p1__ export;

  dcl-pi *n packed(14:4);
    value pointer value;
    default packed(14:4) value options(*nopass);
  end-pi;

  dcl-s r packed(14:4);

  if %parms > 1;
    r = RMValConv2PDec(value:default);
  else;
    r = RMValConv2PDec(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_P2_ <<<<<<<<<<
dcl-proc rm_p2_ export;

  dcl-pi *n packed(28:8);
    value pointer value;
    default packed(28:8) value options(*nopass);
  end-pi;

  if %parms > 1;
    return RMValConv2PDec(value:default);
  endif;
  return RMValConv2PDec(value);

end-proc;


// ----- RM_P2__ <<<<<<<<<<
dcl-proc rm_p2__ export;

  dcl-pi *n packed(28:8);
    value pointer value;
    default packed(28:8) value options(*nopass);
  end-pi;

  dcl-s r packed(28:8);

  if %parms > 1;
    r = RMValConv2PDec(value:default);
  else;
    r = RMValConv2PDec(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_P3_ <<<<<<<<<<
dcl-proc rm_p3_ export;

  dcl-pi *n packed(46:16);
    value pointer value;
    default packed(46:16) value options(*nopass);
  end-pi;

  if %parms > 1;
    return RMValConv2PDec(value:default);
  endif;
  return RMValConv2PDec(value);

end-proc;


// ----- RM_P3__ <<<<<<<<<<
dcl-proc rm_p3__ export;

  dcl-pi *n packed(46:16);
    value pointer value;
    default packed(46:16) value options(*nopass);
  end-pi;

  dcl-s r packed(46:16);

  if %parms > 1;
    r = RMValConv2PDec(value:default);
  else;
    r = RMValConv2PDec(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_D <<<<<<<<<<
dcl-proc rm_d export;

  dcl-pi *n pointer;
    value date value;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1 and opt = 0;
    return RMValDateCrt(value:x'10');
  elseif %parms > 1 and opt < 0 and opt >= -65000;
    return RMValDateCrt(value:x'00':0-opt);
  elseif %parms > 1;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValDateCrt(value);

end-proc;


// ----- RM_T <<<<<<<<<<
dcl-proc rm_t export;

  dcl-pi *n pointer;
    value time value;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1 and opt = 0;
    return RMValTimeCrt(value:x'10');
  elseif %parms > 1 and opt < 0 and opt >= -65000;
    return RMValTimeCrt(value:x'00':0-opt);
  elseif %parms > 1;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValTimeCrt(value);

end-proc;


// ----- RM_Z <<<<<<<<<<
dcl-proc rm_z export;

  dcl-pi *n pointer;
    value timestamp value;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1 and opt = 0;
    return RMValTsCrt(value:x'10');
  elseif %parms > 1 and opt < 0 and opt >= -65000;
    return RMValTsCrt(value:x'00':0-opt);
  elseif %parms > 1;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValTsCrt(value);

end-proc;


// ----- RM_ISD <<<<<<<<<<
dcl-proc rm_isd export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsDate(obj);

end-proc;


// ----- RM_IST <<<<<<<<<<
dcl-proc rm_ist export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsTime(obj);

end-proc;


// ----- RM_ISZ <<<<<<<<<<
dcl-proc rm_isz export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsTs(obj);

end-proc;


// ----- RM_D_ <<<<<<<<<<
dcl-proc rm_d_ export;

  dcl-pi *n date;
    value pointer value;
    default date value options(*nopass);
  end-pi;

  if %parms > 1;
    return RMValConv2Date(value:default);
  endif;
  return RMValConv2Date(value);

end-proc;


// ----- RM_D__ <<<<<<<<<<
dcl-proc rm_d__ export;

  dcl-pi *n date;
    value pointer value;
    default date value options(*nopass);
  end-pi;

  dcl-s r date;

  if %parms > 1;
    r = RMValConv2Date(value:default);
  else;
    r = RMValConv2Date(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_T_ <<<<<<<<<<
dcl-proc rm_t_ export;

  dcl-pi *n time;
    value pointer value;
    default time value options(*nopass);
  end-pi;

  if %parms > 1;
    return RMValConv2Time(value:default);
  endif;
  return RMValConv2Time(value);

end-proc;


// ----- RM_T__ <<<<<<<<<<
dcl-proc rm_t__ export;

  dcl-pi *n time;
    value pointer value;
    default time value options(*nopass);
  end-pi;

  dcl-s r time;

  if %parms > 1;
    r = RMValConv2Time(value:default);
  else;
    r = RMValConv2Time(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_Z_ <<<<<<<<<<
dcl-proc rm_z_ export;

  dcl-pi *n timestamp;
    value pointer value;
    default timestamp value options(*nopass);
  end-pi;

  if %parms > 1;
    return RMValConv2Ts(value:default);
  endif;
  return RMValConv2Ts(value);

end-proc;


// ----- RM_Z__ <<<<<<<<<<
dcl-proc rm_z__ export;

  dcl-pi *n timestamp;
    value pointer value;
    default timestamp value options(*nopass);
  end-pi;

  dcl-s r timestamp;

  if %parms > 1;
    r = RMValConv2Ts(value:default);
  else;
    r = RMValConv2Ts(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_N <<<<<<<<<<
dcl-proc rm_n export;

  dcl-pi *n pointer;
    value ind value;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1 and opt = 0;
    return RMValIndCrt(value:x'10');
  elseif %parms > 1 and opt < 0 and opt >= -65000;
    return RMValIndCrt(value:x'00':0-opt);
  elseif %parms > 1;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValIndCrt(value);

end-proc;


// ----- RM_ISN <<<<<<<<<<
dcl-proc rm_isn export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsInd(obj);

end-proc;


// ----- RM_N_ <<<<<<<<<<
dcl-proc rm_n_ export;

  dcl-pi *n ind;
    value pointer value;
    default ind value options(*nopass);
  end-pi;

  if %parms > 1;
    return RMValConv2Ind(value:default);
  endif;
  return RMValConv2Ind(value);

end-proc;


// ----- RM_N__ <<<<<<<<<<
dcl-proc rm_n__ export;

  dcl-pi *n ind;
    value pointer value;
    default ind value options(*nopass);
  end-pi;

  dcl-s r ind;

  if %parms > 1;
    r = RMValConv2Ind(value:default);
  else;
    r = RMValConv2Ind(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_X <<<<<<<<<<
dcl-proc rm_x export;

  dcl-pi *n pointer;
    value pointer value;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1 and opt = 0;
    return RMValPtrCrt(value:x'10');
  elseif %parms > 1 and opt < 0 and opt >= -65000;
    return RMValPtrCrt(value:x'00':0-opt);
  elseif %parms > 1;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValPtrCrt(value);

end-proc;


// ----- RM_ISX <<<<<<<<<<
dcl-proc rm_isx export;
dcl-pi *n ind;
  obj pointer value;
end-pi;

  return RMValIsPtr(obj);

end-proc;


// ----- RM_X_ <<<<<<<<<<
dcl-proc rm_x_ export;

  dcl-pi *n pointer;
    value pointer value;
    default pointer value options(*nopass);
  end-pi;

  if %parms > 1;
    return RMValConv2Ptr(value:default);
  endif;
  return RMValConv2Ptr(value);

end-proc;


// ----- RM_X__ <<<<<<<<<<
dcl-proc rm_x__ export;

  dcl-pi *n pointer;
    value pointer value;
    default pointer value options(*nopass);
  end-pi;

  dcl-s r pointer;

  if %parms > 1;
    r = RMValConv2Ptr(value:default);
  else;
    r = RMValConv2Ptr(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_XP <<<<<<<<<<
dcl-proc rm_xp export;

  dcl-pi *n pointer;
    value pointer(*proc) value;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1 and opt = 0;
    return RMValPPtrCrt(value:x'10');
  elseif %parms > 1 and opt < 0 and opt >= -65000;
    return RMValPPtrCrt(value:x'00':0-opt);
  elseif %parms > 1;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValPPtrCrt(value);

end-proc;


// ----- RM_ISXP <<<<<<<<<<
dcl-proc rm_isxp export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsPPtr(obj);

end-proc;


// ----- RM_XP_ <<<<<<<<<<
dcl-proc rm_xP_ export;

  dcl-pi *n pointer(*proc);
    value pointer value;
    default pointer(*proc) value options(*nopass);
  end-pi;

  if %parms > 1;
    return RMValConv2PPtr(value:default);
  endif;
  return RMValConv2PPtr(value);

end-proc;


// ----- RM_XP__ <<<<<<<<<<
dcl-proc rm_xp__ export;

  dcl-pi *n pointer(*proc);
    value pointer value;
    default pointer(*proc) value options(*nopass);
  end-pi;

  dcl-s r pointer(*proc);

  if %parms > 1;
    r = RMValConv2PPtr(value:default);
  else;
    r = RMValConv2PPtr(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_A <<<<<<<<<<
dcl-proc rm_a export;

  dcl-pi *n pointer;
    value varchar(30000) const;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1;
    select;
    when opt = 0;
      return RMValCharCrt(value:x'10');
    when opt = 1;
      return RMValCharCrt(value:x'08');
    when opt = 2;
      return RMValCharCrt(value:x'18');
    when opt < 0 and opt >= -65000;
      return RMValCharCrt(value:x'00':0-opt);
    endsl;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValCharCrt(value);

end-proc;


// ----- RM_AP <<<<<<<<<<
dcl-proc rm_ap export;

  dcl-pi *n pointer;
    addr pointer value;
    size int(10) value;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 2;
    select;
    when opt = 0;
      return RMValCharCrtPtr(addr:size:x'10');
    when opt = 1;
      return RMValCharCrtPtr(addr:size:x'08');
    when opt = 2;
      return RMValCharCrtPtr(addr:size:x'18');
    when opt < 0 and opt >= -65000;
      return RMValCharCrtPtr(addr:size:x'00':0-opt);
    endsl;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValCharCrtPtr(addr:size);

end-proc;


// ----- RM_AA <<<<<<<<<<
dcl-proc rm_aa export;

  dcl-pi *n pointer;
    value varchar(30000) const;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1 and opt = 0;
    return RMValCharCrt(value:x'30');
  elseif %parms > 1 and opt < 0 and opt >= -65000;
    return RMValCharCrt(value:x'20':0-opt);
  elseif %parms > 1;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValCharCrt(value:x'20');

end-proc;


// ----- RM_AAP <<<<<<<<<<
dcl-proc rm_aap export;

  dcl-pi *n pointer;
    addr pointer value;
    size int(10) value;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 2 and opt = 0;
    return RMValCharCrtPtr(addr:size:x'30');
  elseif %parms > 2 and opt < 0 and opt >= -65000;
    return RMValCharCrtPtr(addr:size:x'20':0-opt);
  elseif %parms > 2;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValCharCrtPtr(addr:size:x'20');

end-proc;


// ----- RM_ISA <<<<<<<<<<
dcl-proc rm_isa export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsChar(obj);

end-proc;


// ----- RM_ISAA <<<<<<<<<<
dcl-proc rm_isaa export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsChar(obj:*on);

end-proc;


// ----- RM_A_ <<<<<<<<<<
dcl-proc rm_a_ export;

  dcl-pi *n varchar(30000) rtnparm;
    value pointer value;
    default varchar(30000) const options(*nopass);
  end-pi;

  if %parms > 2;
    return RMValConv2Char(value:default);
  endif;
  return RMValConv2Char(value);

end-proc;


// ----- RM_A__ <<<<<<<<<<
dcl-proc rm_a__ export;

  dcl-pi *n varchar(30000) rtnparm;
    value pointer value;
    default varchar(30000) const options(*nopass);
  end-pi;

  dcl-s r varchar(30000);

  if %parms > 2;
    r = RMValConv2Char(value:default);
  else;
    r = RMValConv2Char(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_A1_ <<<<<<<<<<
dcl-proc rm_a1_ export;

  dcl-pi *n varchar(100) rtnparm;
    value pointer value;
    default varchar(100) const options(*nopass);
  end-pi;

  if %parms > 2;
    return RMValConv2Char1(value:default);
  endif;
  return RMValConv2Char1(value);

end-proc;


// ----- RM_A1__ <<<<<<<<<<
dcl-proc rm_a1__ export;

  dcl-pi *n varchar(100) rtnparm;
    value pointer value;
    default varchar(100) const options(*nopass);
  end-pi;

  dcl-s r varchar(100);

  if %parms > 2;
    r = RMValConv2Char1(value:default);
  else;
    r = RMValConv2Char1(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_A2_ <<<<<<<<<<
dcl-proc rm_a2_ export;

  dcl-pi *n varchar(1000) rtnparm;
    value pointer value;
    default varchar(1000) const options(*nopass);
  end-pi;

  if %parms > 2;
    return RMValConv2Char2(value:default);
  endif;
  return RMValConv2Char2(value);

end-proc;


// ----- RM_A2__ <<<<<<<<<<
dcl-proc rm_a2__ export;

  dcl-pi *n varchar(1000) rtnparm;
    value pointer value;
    default varchar(1000) const options(*nopass);
  end-pi;

  dcl-s r varchar(1000);

  if %parms > 2;
    r = RMValConv2Char2(value:default);
  else;
    r = RMValConv2Char2(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_A3_ <<<<<<<<<<
dcl-proc rm_a3_ export;

  dcl-pi *n varchar(10000) rtnparm;
    value pointer value;
    default varchar(10000) const options(*nopass);
  end-pi;

  if %parms > 2;
    return RMValConv2Char3(value:default);
  endif;
  return RMValConv2Char3(value);

end-proc;


// ----- RM_A3__ <<<<<<<<<<
dcl-proc rm_a3__ export;

  dcl-pi *n varchar(10000) rtnparm;
    value pointer value;
    default varchar(10000) const options(*nopass);
  end-pi;

  dcl-s r varchar(10000);

  if %parms > 2;
    r = RMValConv2Char3(value:default);
  else;
    r = RMValConv2Char3(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_S <<<<<<<<<<
dcl-proc rm_s export;

  dcl-pi *n pointer;
    value varchar(30000) ccsid(*utf8) const;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1;
    select;
    when opt = 0;
      return RMValStrCrt(value:x'10');
    when opt = 1;
      return RMValStrCrt(value:x'08');
    when opt = 2;
      return RMValStrCrt(value:x'18');
    when opt < 0 and opt >= -65000;
      return RMValStrCrt(value:x'00':0-opt);
    endsl;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValStrCrt(value);

end-proc;


// ----- RM_SB <<<<<<<<<<
dcl-proc rm_sb export;

  dcl-pi *n pointer;
    value varchar(30000) const;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1;
    select;
    when opt = 0;
      return RMValStrCrtBytes(value:x'10');
    when opt = 1;
      return RMValStrCrtBytes(value:x'08');
    when opt = 2;
      return RMValStrCrtBytes(value:x'18');
    when opt < 0 and opt >= -65000;
      return RMValStrCrtBytes(value:x'00':0-opt);
    endsl;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValStrCrtBytes(value);

end-proc;


// ----- RM_SA <<<<<<<<<<
dcl-proc rm_sa export;

  dcl-pi *n pointer;
    value varchar(30000) ccsid(*utf8) const;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1 and opt = 0;
    return RMValStrCrt(value:x'30');
  elseif %parms > 1 and opt < 0 and opt >= -65000;
    return RMValStrCrt(value:x'20':0-opt);
  elseif %parms > 1;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValStrCrt(value:x'20');

end-proc;


// ----- RM_SAB <<<<<<<<<<
dcl-proc rm_sab export;

  dcl-pi *n pointer;
    value varchar(30000) const;
    opt int(10) value options(*nopass);
  end-pi;

  if %parms > 1 and opt = 0;
    return RMValStrCrtBytes(value:x'30');
  elseif %parms > 1 and opt < 0 and opt >= -65000;
    return RMValStrCrtBytes(value:x'20':0-opt);
  elseif %parms > 1;
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  return RMValStrCrtBytes(value:x'20');

end-proc;


// ----- RM_ISS <<<<<<<<<<
dcl-proc rm_iss export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsStr(obj);

end-proc;


// ----- RM_ISSA <<<<<<<<<<
dcl-proc rm_issa export;

  dcl-pi *n ind;
    obj pointer value;
  end-pi;

  return RMValIsStr(obj:*on);

end-proc;


// ----- RM_S_ <<<<<<<<<<
dcl-proc rm_s_ export;

  dcl-pi *n varchar(30000) ccsid(*utf8) rtnparm;
    value pointer value;
    default varchar(30000) ccsid(*utf8) const options(*nopass);
  end-pi;

  if %parms > 2;
    return RMValConv2Str(value:default);
  endif;
  return RMValConv2Str(value);

end-proc;


// ----- RM_S__ <<<<<<<<<<
dcl-proc rm_s__ export;

  dcl-pi *n varchar(30000) ccsid(*utf8) rtnparm;
    value pointer value;
    default varchar(30000) ccsid(*utf8) const options(*nopass);
  end-pi;

  dcl-s r varchar(30000) ccsid(*utf8);

  if %parms > 2;
    r = RMValConv2Str(value:default);
  else;
    r = RMValConv2Str(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_S1_ <<<<<<<<<<
dcl-proc rm_s1_ export;

  dcl-pi *n varchar(100) ccsid(*utf8) rtnparm;
    value pointer value;
    default varchar(100) ccsid(*utf8) const options(*nopass);
  end-pi;

  if %parms > 2;
    return RMValConv2Str1(value:default);
  endif;
  return RMValConv2Str1(value);

end-proc;


// ----- RM_S1__ <<<<<<<<<<
dcl-proc rm_s1__ export;

  dcl-pi *n varchar(100) ccsid(*utf8) rtnparm;
    value pointer value;
    default varchar(100) ccsid(*utf8) const options(*nopass);
  end-pi;

  dcl-s r varchar(100) ccsid(*utf8);

  if %parms > 2;
    r = RMValConv2Str1(value:default);
  else;
    r = RMValConv2Str1(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_S2_ <<<<<<<<<<
dcl-proc rm_s2_ export;

  dcl-pi *n varchar(1000) ccsid(*utf8) rtnparm;
    value pointer value;
    default varchar(1000) ccsid(*utf8) const options(*nopass);
  end-pi;

  if %parms > 2;
    return RMValConv2Str2(value:default);
  endif;
  return RMValConv2Str2(value);

end-proc;


// ----- RM_S2__ <<<<<<<<<<
dcl-proc rm_s2__ export;

  dcl-pi *n varchar(1000) ccsid(*utf8) rtnparm;
    value pointer value;
    default varchar(1000) ccsid(*utf8) const options(*nopass);
  end-pi;

  dcl-s r varchar(1000) ccsid(*utf8);

  if %parms > 2;
    r = RMValConv2Str2(value:default);
  else;
    r = RMValConv2Str2(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_S3_ <<<<<<<<<<
dcl-proc rm_s3_ export;

  dcl-pi *n varchar(10000) ccsid(*utf8) rtnparm;
    value pointer value;
    default varchar(10000) ccsid(*utf8) const options(*nopass);
  end-pi;

  if %parms > 2;
    return RMValConv2Str3(value:default);
  endif;
  return RMValConv2Str3(value);

end-proc;


// ----- RM_S3__ <<<<<<<<<<
dcl-proc rm_s3__ export;

  dcl-pi *n varchar(10000) ccsid(*utf8) rtnparm;
    value pointer value;
    default varchar(10000) ccsid(*utf8) const options(*nopass);
  end-pi;

  dcl-s r varchar(10000) ccsid(*utf8);

  if %parms > 2;
    r = RMValConv2Str3(value:default);
  else;
    r = RMValConv2Str3(value);
  endif;
  RMValDispose2(value);
  return r;

end-proc;


// ----- RM_ADD_EVENT_HANDLER <<<<<<<<<<
dcl-proc rm_add_event_handler export;

  dcl-pi *n pointer;
    map pointer value;
    hproc pointer(*proc) value;
    usrd pointer value options(*nopass);
  end-pi;

  if %parms > 2;
    RMBAddEventh(RMValMapImpl(map):hproc:usrd);
  else;
    RMBAddEventh(RMValMapImpl(map):hproc:*null);
  endif;
  return map;

end-proc;


// ----- RM_REMOVE_EVENT_HANDLER <<<<<<<<<<
dcl-proc rm_remove_event_handler export;

  dcl-pi *n pointer;
    map pointer value;
    hproc pointer(*proc) value;
  end-pi;

  RMBRmvEventh(RMValMapImpl(map):hproc);
  return map;

end-proc;


// ----- Internal procedures
