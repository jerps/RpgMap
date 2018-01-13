**FREE

// RPGMAPVAL.RPGLE - RpgMap Values
// Copyright (c) 2017-2018 John Erps (john@erps.me)


ctl-opt copyright('Copyright (c) 2017-2018 John Erps (john@erps.me)');
ctl-opt nomain datfmt(*iso-) timfmt(*iso.) ccsid(*exact);


/include _TLIB_/INCLUDERPG,RPGMAP
/include RPGMAPGDEF.RPGLE
/include RPGMAPVALH.RPGLE
/include RPGMAPSYSH.RPGLE
/include RPGMAPCVAH.RPGLE
/include RPGMAPRBTC.RPGLE


// 100 <= aValue <= 199
dcl-c RMTYPE_CURSOR       21;
dcl-c RMTYPE_MAP         254;
dcl-c RMTYPE_IND         101;
dcl-c RMTYPE_INT10       111;
dcl-c RMTYPE_INT20       112;
dcl-c RMTYPE_PDEC10      121;
dcl-c RMTYPE_PDEC20      122;
dcl-c RMTYPE_PDEC30      123;
dcl-c RMTYPE_TIME        131;
dcl-c RMTYPE_DATE        132;
dcl-c RMTYPE_TS          133;
dcl-c RMTYPE_PTR         136;
dcl-c RMTYPE_PPTR        137;
dcl-c RMTYPE_CHAR        141;
dcl-c RMTYPE_STR         142;


// ----- Types

dcl-ds RMValueTypeInfo_t qualified inz template;
  id uns(3);
  // Flags:
  // xxxxxxx1 = map is manually disposed
  // xxxxxx1x = map is a vector
  // 1xxxxxxx = automatically disposed map or value is contained in a map
  // x1xxxxxx = map is immutable
  // xx1xxxxx = use alternate sort sequence
  // xxx1xxxx = special property "reversed order"
  // xxxx1xxx = special property "case insensitive order"
  flags char(1);
  usrd uns(5); // special property "user data": 1-65000
end-ds;

// Generic value
dcl-ds RMValueObj qualified based(RMValueObjP);
  type likeds(RMValueTypeInfo_t);
end-ds;

// Map
dcl-ds RMValueMap qualified based(RMValueMapP);
  type likeds(RMValueTypeInfo_t);
  map pointer; // Map impl.
  compf pointer(*proc); // Compare func, or *null
  attrs pointer; // A map with the attributes, or *null
end-ds;

// Cursor
dcl-ds RMValueCursor qualified based(RMValueCursorP);
  type likeds(RMValueTypeInfo_t);
  cursor pointer; // Cursor impl.
end-ds;

// Integer 10/20
dcl-ds RMValueInt10 qualified based(RMValueInt10P);
  type likeds(RMValueTypeInfo_t);
  value int(10);
end-ds;
dcl-ds RMValueInt20 qualified based(RMValueInt20P);
  type likeds(RMValueTypeInfo_t);
  value int(20);
end-ds;

// Packed decimal 10/20/30
dcl-ds RMValuePDec10 qualified based(RMValuePDec10P);
  type likeds(RMValueTypeInfo_t);
  value packed(14:4);
end-ds;
dcl-ds RMValuePDec20 qualified based(RMValuePDec20P);
  type likeds(RMValueTypeInfo_t);
  value packed(28:8);
end-ds;
dcl-ds RMValuePDec30 qualified based(RMValuePDec30P);
  type likeds(RMValueTypeInfo_t);
  value packed(46:16);
end-ds;

// Date, time, timestamp
dcl-ds RMValueDate qualified based(RMValueDateP);
  type likeds(RMValueTypeInfo_t);
  value date;
end-ds;
dcl-ds RMValueTime qualified based(RMValueTimeP);
  type likeds(RMValueTypeInfo_t);
  value time;
end-ds;
dcl-ds RMValueTs qualified based(RMValueTsP);
  type likeds(RMValueTypeInfo_t);
  value timestamp;
end-ds;
 
// Indicator
dcl-ds RMValueInd qualified based(RMValueIndP);
  type likeds(RMValueTypeInfo_t);
  value ind;
end-ds;
 
// Pointer
dcl-ds RMValuePtr qualified based(RMValuePtrP);
  type likeds(RMValueTypeInfo_t);
  value pointer;
end-ds;
 
// Procedure Pointer
dcl-ds RMValuePPtr qualified based(RMValuePPtrP);
  type likeds(RMValueTypeInfo_t);
  value pointer(*proc);
end-ds;
 
// Character data
dcl-ds RMValueChar qualified based(RMValueCharP);
  type likeds(RMValueTypeInfo_t);
  value pointer;
end-ds;
 
// String
dcl-ds RMValueStr qualified based(RMValueStrP);
  type likeds(RMValueTypeInfo_t);
  value pointer;
end-ds;


// ----- Exported procedures


// ----- Object


// Return object flags.
dcl-proc RMValObjFlags export;
dcl-pi *n char(1);
  obj pointer value;
end-pi;

  RMValueObjP = obj;
  return RMValueObj.type.flags;
      
end-proc;


// Set obj flags.
dcl-proc RMValObjSetFlags export;
dcl-pi *n;
  obj pointer value;
  flags char(1) value;
end-pi;

  RMValueObjP = obj;
  RMValueObj.type.flags = flags;
      
end-proc;


// Compare obj1 with obj2, with the compare function of map (if not *null).
dcl-proc RMValObjCompare export;
dcl-pi *n int(10);
  map pointer value;
  obj1 pointer value;
  obj2 pointer value;
end-pi;

  dcl-pr call_comp int(10) extproc(call_comp_p);
    obj1 pointer value;
    obj2 pointer value;
  end-pr;

  dcl-s t1 like(RMValueTypeInfo_t.id);
  dcl-s t2 like(RMValueTypeInfo_t.id);
  dcl-s f ind;
  dcl-s rof int(10);
  dcl-s call_comp_p pointer(*proc);
  dcl-s c int(10);

  rof = 1;
  
  f = *off;
  if obj1 <> *null;
    RMValueObjP = obj1;
    t1 = RMValueObj.type.id;
    f = %bitand(RMValueObj.type.flags:x'10') = x'10';
  endif;
  if obj2 <> *null;
    RMValueObjP = obj2;
    t2 = RMValueObj.type.id;
    f = f or %bitand(RMValueObj.type.flags:x'10') = x'10';
  endif;
  if f;
    rof = -1;
  endif;
  
  c = 99;
  call_comp_p = *null;
  if map <> *null;
    RMValueMapP = map;
    call_comp_p = RMValueMap.compf;
  endif;
  if call_comp_p <> *null;
    c = call_comp(obj1:obj2);
  endif;
  if c = -1 or c = 0 or c = 1;
    return c * rof;
  endif;
  
  if obj1 = *null and obj2 = *null;
    return 0;
  elseif obj1 = *null and obj2 <> *null;
    return -1 * rof;
  elseif obj1 <> *null and obj2 = *null;
    return 1 * rof;
  endif;

  select;
  when     t1 = RMTYPE_MAP
       and t2 = RMTYPE_MAP;
    return RMValMapCompare(map:obj1:obj2) * rof;
  when     (   t1 = RMTYPE_INT10
            or t1 = RMTYPE_INT20
            or t1 = RMTYPE_PDEC10
            or t1 = RMTYPE_PDEC20
            or t1 = RMTYPE_PDEC30)
       and (   t2 = RMTYPE_INT10
            or t2 = RMTYPE_INT20
            or t2 = RMTYPE_PDEC10
            or t2 = RMTYPE_PDEC20
            or t2 = RMTYPE_PDEC30);
    return RMValNumCompare(obj1:obj2) * rof;
  when     t1 = RMTYPE_TIME
       and t2 = RMTYPE_TIME;
    return RMValTimeCompare(obj1:obj2) * rof;
  when     t1 = RMTYPE_DATE
       and t2 = RMTYPE_DATE;
    return RMValDateCompare(obj1:obj2) * rof;
  when     t1 = RMTYPE_TS
       and t2 = RMTYPE_TS;
    return RMValTsCompare(obj1:obj2) * rof;
  when     (   t1 = RMTYPE_DATE
            or t1 = RMTYPE_TS)
       and (   t2 = RMTYPE_DATE
            or t2 = RMTYPE_TS);
    return RMValDtsCompare(obj1:obj2) * rof;
  when     t1 = RMTYPE_IND
       and t2 = RMTYPE_IND;
    return RMValIndCompare(obj1:obj2) * rof;
  when     t1 = RMTYPE_PTR
       and t2 = RMTYPE_PTR;
    return RMValPtrCompare(obj1:obj2) * rof;
  when     t1 = RMTYPE_PPTR
       and t2 = RMTYPE_PPTR;
    return RMValPPtrCompare(obj1:obj2) * rof;
  when     t1 = RMTYPE_CHAR
       and t2 = RMTYPE_CHAR;
    return RMValCharCompare(obj1:obj2) * rof;
  when     t1 = RMTYPE_STR
       and t2 = RMTYPE_STR;
    return RMValStrCompare(obj1:obj2) * rof;
  endsl;
  
  if t1 < t2;
    return -1 * rof;
  elseif t1 > t2;
    return 1 * rof;
  endif;
  return 0;
      
end-proc;


// Copy object.
dcl-proc RMValObjCopy export;
dcl-pi *n pointer;
  obj pointer value;
  deep ind value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  RMValueObjP = obj;
  if     RMValueObj.type.id <> RMTYPE_MAP
     and (RMValueObj.type.id < 100 or RMValueObj.type.id > 199);
    RMSysSndEscapeMsg('RM00032');
  endif;
  select;
  when RMValueObj.type.id = RMTYPE_MAP;
    if %parms < 3;
      return RMValMapCopy(obj:deep);
    elseif %parms < 4;
      return RMValMapCopy(obj:deep:key1);
    else;
      return RMValMapCopy(obj:deep:key1:key2);
    endif;    
  when RMValueObj.type.id = RMTYPE_INT10;
    return RMValIntCopy(obj:10);
  when RMValueObj.type.id = RMTYPE_INT20;
    return RMValIntCopy(obj:20);
  when RMValueObj.type.id = RMTYPE_PDEC10;
    return RMValPDecCopy(obj:10);
  when RMValueObj.type.id = RMTYPE_PDEC20;
    return RMValPDecCopy(obj:20);
  when RMValueObj.type.id = RMTYPE_PDEC30;
    return RMValPDecCopy(obj:30);
  when RMValueObj.type.id = RMTYPE_DATE;
    return RMValDateCopy(obj);
  when RMValueObj.type.id = RMTYPE_TIME;
    return RMValTimeCopy(obj);
  when RMValueObj.type.id = RMTYPE_TS;
    return RMValTsCopy(obj);
  when RMValueObj.type.id = RMTYPE_IND;
    return RMValIndCopy(obj);
  when RMValueObj.type.id = RMTYPE_PTR;
    return RMValPtrCopy(obj);
  when RMValueObj.type.id = RMTYPE_PPTR;
    return RMValPPtrCopy(obj);
  when RMValueObj.type.id = RMTYPE_CHAR;
    return RMValCharCopy(obj);
  when RMValueObj.type.id = RMTYPE_STR;
    return RMValStrCopy(obj);
  other;
    RMSysSndEscapeMsg('RM09011');
  endsl;
  
  return *null;
      
end-proc;


// Set special property opt order for obj.
dcl-proc RMValObjSSP export;
dcl-pi *n;
  obj pointer value;
  opt int(10) value;
end-pi;

  RMValueObjP = obj;
  if     RMValueObj.type.id <> RMTYPE_MAP
     and (RMValueObj.type.id < 100 or RMValueObj.type.id > 199);
    RMSysSndEscapeMsg('RM00033');
  endif;
  if     opt <> 0 and opt <> 1 and opt <> 2 and opt <> 90 and opt <> 91
     and (opt > 0 or opt < -65000);
    RMSysSndEscapeMsg('RM00111':%char(opt));
  endif;
  if opt = 1 or opt = 2;
    if        RMValueObj.type.id <> RMTYPE_CHAR
          and RMValueObj.type.id <> RMTYPE_STR
       or %bitand(RMValueObj.type.flags:x'20') = x'20';
      RMSysSndEscapeMsg('RM00111':%char(opt));
    endif;
    RMValueObj.type.flags = %bitor(RMValueObj.type.flags:x'08');
  endif;
  if opt = 0 or opt = 2;
    RMValueObj.type.flags = %bitor(RMValueObj.type.flags:x'10');
  endif;
  if opt < 0;
    RMValueObj.type.usrd = 0 - opt;
  endif;
  if opt = 90;
    RMValueObj.type.flags = %bitand(RMValueObj.type.flags:x'E7');
  endif;
  if opt = 91;
    RMValueObj.type.usrd = 0;
  endif;
  
end-proc;


// ----- Map


// Create.
dcl-proc RMValMapCrt export;
dcl-pi *n pointer;
  flags char(1) value;
  mapi pointer value options(*nopass);
  compf pointer(*proc) value options(*nopass);
  attrs pointer value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pi;

  RMValueMapP = %alloc(%size(RMValueMap));
  RMValueMap.type.id = RMTYPE_MAP;
  RMValueMap.type.flags = flags;
  RMValueMap.compf = *null;
  if %parms >= %parmnum(mapi);
    RMValueMap.map = mapi;
  else;
    RMValueMap.map = RMBTreeCreate(%paddr(RMValObjCompare):%paddr(RMValMapImplDestroy)
                                  :RMValueMapP);
  endif;
  if %parms >= %parmnum(compf);
    RMValueMap.compf = compf;
  else;
    RMValueMap.compf = *null;
  endif;
  if %parms >= %parmnum(attrs);
    RMValueMap.attrs = attrs;
  else;
    RMValueMap.attrs = *null;
  endif;
  if %parms >= %parmnum(usrd);
    RMValueMap.type.usrd = usrd;
  else;
    RMValueMap.type.usrd = 0;
  endif;
  return RMValueMapP;
  
end-proc;


// Is map?
dcl-proc RMValIsMap export;
dcl-pi *n ind;
  obj pointer value;
  vector ind value options(*nopass);
  mandisp ind value options(*nopass);
end-pi;

  RMValueObjP = obj;
  return     RMValueObj.type.id = RMTYPE_MAP
         and (   %parms < 2
              or     %parms >= 2
                 and (       not vector
                         and %bitand(RMValueObj.type.flags:x'02') <> x'02'
                      or     vector
                         and %bitand(RMValueObj.type.flags:x'02') = x'02')
                 and (   %parms < 3
                      or     %parms >= 3
                         and (       not mandisp
                                 and %bitand(RMValueObj.type.flags:x'01') <> x'01'
                              or     mandisp
                                 and %bitand(RMValueObj.type.flags:x'01') = x'01')));

end-proc;


// Return map impl.
dcl-proc RMValMapImpl export;
dcl-pi *n pointer;
  map pointer value;
end-pi;

  RMValSetDsMap(map);
  return RMValueMap.map;
      
end-proc;


// Make map manually disposed.
dcl-proc RMValMakeMapManDisp export;
dcl-pi *n;
  map pointer value;
end-pi;
      
  if not RMValIsMap(map:*off:*off);
    RMSysSndEscapeMsg('RM00051');
  endif;
  RMValObjSetFlags(map:%bitor(RMValObjFlags(map):x'01'));
    
end-proc;


// Make map immutable.
dcl-proc RMValMakeMapImmut export;
dcl-pi *n;
  map pointer value;
end-pi;

  dcl-s c pointer;

  if %bitand(RMValObjFlags(map):x'40') = x'40';
    return;
  endif;
  
  c = RMBCursorCrt(RMValMapImpl(map):0:*null);
  dow RMBCursorReadNxtPrv(c:0) = 1;
    RMValueObjP = RMBCursorKey(c);
    if     RMValueObjP <> *null
       and RMValueObj.type.id = RMTYPE_MAP
       and %bitand(RMValueObj.type.flags:x'01') <> x'01';
      RMValMakeMapImmut(RMValueObjP);
    endif;
    RMValueObjP = RMBCursorItem(c);
    if     RMValueObjP <> *null
       and RMValueObj.type.id = RMTYPE_MAP
       and %bitand(RMValueObj.type.flags:x'01') <> x'01';
      RMValMakeMapImmut(RMValueObjP);
    endif;
  enddo;
  RMBCursorDispose(c);
  
  RMValObjSetFlags(map:%bitor(RMValObjFlags(map):x'40'));
    
end-proc;


// Set map comp. func.
dcl-proc RMValMapSetCompf export;
dcl-pi *n;
  map pointer value;
  comp pointer(*proc) value;
end-pi;

  RMValSetDsMap(map);
  RMValueMap.compf = comp;
      
end-proc;


// Get map comp. func.
dcl-proc RMValMapGetCompf export;
dcl-pi *n pointer(*proc);
  map pointer value;
end-pi;

  RMValSetDsMap(map);
  return RMValueMap.compf;
      
end-proc;


// Set map attr.
dcl-proc RMValMapSetAttr export;
dcl-pi *n;
  map pointer value;
  attr varchar(100) ccsid(*utf8) value options(*nopass);
  value varchar(100) ccsid(*utf8) value options(*nopass);
end-pi;

  dcl-s a pointer; 
  
  RMValSetDsMap(map);
  a = RMValueMap.attrs;
  if %parms < 2;
    if a <> *null;
      rm_dis(a);
      RMValSetDsMap(map);
      RMValueMap.attrs = *null;
    endif;
    return;
  endif;

  if attr = '';
    RMSysSndEscapeMsg('RM00102');
  endif;

  if %parms < 3;
    if a <> *null;
      rm_rmv(a:rm_s(attr));
      if rm_num(a) = 0;
        rm_dis(a);
        RMValSetDsMap(map);
        RMValueMap.attrs = *null;
      endif;
    endif;
    return;
  endif;
  
  if a = *null;
    a = rm_m();
    RMValSetDsMap(map);
    RMValueMap.attrs = a;
  endif;
  
  rm_insx1(a:rm_s(attr):rm_s(value));
  
  return;

end-proc;


// Get map attr.
dcl-proc RMValMapGetAttr export;
dcl-pi *n varchar(100) ccsid(*utf8);
  map pointer value;
  attr varchar(100) ccsid(*utf8) value;
end-pi;

  dcl-s a pointer;
  
  RMValSetDsMap(map);
  if RMValueMap.attrs = *null;
    return '';
  endif;
  
  a = RMValueMap.attrs;
  return rm_s_(rm_get(a:rm_s(attr)));

end-proc;


// Return user data of a map/value.
dcl-proc RMValRtnUsrDta export;
dcl-pi *n int(10);
  obj pointer value;
end-pi;

  RMValueObjP = obj;
  if     RMValueObj.type.id <> RMTYPE_MAP
     and (RMValueObj.type.id < 100 or RMValueObj.type.id > 199);
    RMSysSndEscapeMsg('RM09004');
  endif;
  return RMValueObj.type.usrd;

end-proc;


// Dispose map, cursor or value.
dcl-proc RMValDispose export;
dcl-pi *n;
  obj pointer value;
end-pi;

  dcl-s p pointer;
  dcl-s a pointer;

  RMValueObjP = obj;
  if RMValueObj.type.id = RMTYPE_MAP;
    RMValSetDsMap(obj);
    p = RMValueMapP;
    a = RMValueMap.attrs;
    RMBTreeDispose(RMValueMap.map);
    if a <> *null;
      rm_dis(a);
    endif;
    dealloc p;
  elseif RMValueObj.type.id = RMTYPE_CURSOR;
    RMValSetDsCursor(obj);
    // dispose cursor impl, 'RMValueCursor' will be disposed also.
    RMBCursorDispose(RMValueCursor.cursor);
  elseif RMValueObj.type.id >= 100 and RMValueObj.type.id <= 199;
    RMValDispValue(obj);
  else;
    RMSysSndEscapeMsg('RM09011');
  endif;
  
  return;
      
end-proc;


// Dispose map, cursor or value, if allowed.
dcl-proc RMValDispose2 export;
dcl-pi *n;
  obj pointer value;
end-pi;

  if obj = *null;
    return;
  endif;
  if %bitand(RMValObjFlags(obj):x'80') = x'80';
    RMSysSndEscapeMsg('RM00030');
  endif;
  RMValDispose(value);
      
end-proc;


// ----- Cursor


// Create.
dcl-proc RMValCursorCrt export;
dcl-pi *n pointer;
  map pointer value;
  pos int(10) value;
end-pi;

  RMValTestIfMap(map);
  RMValueCursorP = %alloc(%size(RMValueCursor));
  RMValueCursor.type.id = RMTYPE_CURSOR;
  RMValueCursor.type.flags = x'00';
  RMValueCursor.type.usrd = 0;
  // create the cursor impl, taking a pointer to the cursor data structure here
  // in "value space". When the map impl. destroys the cursor, this data structure
  // is also destroyed.
  RMValuecursor.cursor = RMBCursorCrt(RMValMapImpl(map):pos:RMValueCursorP);
  return RMValueCursorP;
  
end-proc;


// Return cursor impl.
dcl-proc RMValCursorImpl export;
dcl-pi *n pointer;
  cursor pointer value;
end-pi;

  RMValSetDsCursor(cursor);
  return RMValueCursor.cursor;
      
end-proc;


// Is cursor?
dcl-proc RMValIsCursor export;
dcl-pi *n ind;
  obj pointer value;
end-pi;

  RMValueObjP = obj;
  return RMValueObj.type.id = RMTYPE_CURSOR;
  
end-proc;


// ----- Integer


// Create
dcl-proc RMValIntCrt export;
dcl-pi *n pointer;
  value int(20) value;
  digits uns(5) value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pi;
  
  select;
  when digits = 10;
    RMValueInt10P = %alloc(%size(RMValueInt10));
    RMValueInt10.type.id = RMTYPE_INT10;
    if %parms >= %parmnum(flags);
      RMValueInt10.type.flags = flags;
    else;
      RMValueInt10.type.flags = x'00';
    endif;
    if %parms >= %parmnum(usrd);
      RMValueInt10.type.usrd = usrd;
    else;
      RMValueInt10.type.usrd = 0;
    endif;
    RMValueInt10.value = value;
    return RMValueInt10P;
  when digits = 20;
    RMValueInt20P = %alloc(%size(RMValueInt20));
    RMValueInt20.type.id = RMTYPE_INT20;
    if %parms >= %parmnum(flags);
      RMValueInt20.type.flags = flags;
    else;
      RMValueInt20.type.flags = x'00';
    endif;
    if %parms >= %parmnum(usrd);
      RMValueInt20.type.usrd = usrd;
    else;
      RMValueInt20.type.usrd = 0;
    endif;
    RMValueInt20.value = value;
    return RMValueInt20P;
  endsl;
  
  return *null;
  
end-proc;


// Is integer?
dcl-proc RMValIsInt export;
dcl-pi *n ind;
  obj pointer value;
  digits uns(5) value options(*nopass);
end-pi;

  RMValueObjP = obj;
  return
           %parms < %parmnum(digits)
       and (   RMValueObj.type.id = RMTYPE_INT10
            or RMValueObj.type.id = RMTYPE_INT20)
    or     %parms >= %parmnum(digits)
       and (   digits = 10 and RMValueObj.type.id = RMTYPE_INT10
            or digits = 20 and RMValueObj.type.id = RMTYPE_INT20);
  
end-proc;


// Convert a value to an RPG integer
dcl-proc RMValConv2Int export;
dcl-pi *n int(20);
  value pointer value;
  default int(20) value options(*nopass);
end-pi;

  if value = *null;
    if %parms > 1;
      return default;
    endif;
    return 0;
  endif;
  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_INT10;
    RMValueInt10P = value;
    return RMValueInt10.value;
  when RMValueObj.type.id = RMTYPE_INT20;
    RMValueInt20P = value;
    return RMValueInt20.value;
  when RMValueObj.type.id = RMTYPE_PDEC10;
    RMValuePDec10P = value;
    return RMValuePDec10.value;
  when RMValueObj.type.id = RMTYPE_PDEC20;
    RMValuePDec20P = value;
    return RMValuePDec20.value;
  when RMValueObj.type.id = RMTYPE_PDEC30;
    RMValuePDec30P = value;
    return RMValuePDec30.value;
  endsl;
  
  RMSysSndEscapeMsg('RM00011');

  return 0;
  
end-proc;


// ----- Packed Decimal


// Create
dcl-proc RMValPDecCrt export;
dcl-pi *n pointer;
  value packed(46:16) value;
  digits uns(5) value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pi;
  
  select;
  when digits = 10;
    RMValuePDec10P = %alloc(%size(RMValuePDec10));
    RMValuePDec10.type.id = RMTYPE_PDEC10;
    if %parms >= %parmnum(flags);
      RMValuePDec10.type.flags = flags;
    else;
      RMValuePDec10.type.flags = x'00';
    endif;
    if %parms >= %parmnum(usrd);
      RMValuePDec10.type.usrd = usrd;
    else;
      RMValuePDec10.type.usrd = 0;
    endif;
    RMValuePDec10.value = value;
    return RMValuePDec10P;
  when digits = 20;
    RMValuePDec20P = %alloc(%size(RMValuePDec20));
    RMValuePDec20.type.id = RMTYPE_PDEC20;
    if %parms >= %parmnum(flags);
      RMValuePDec20.type.flags = flags;
    else;
      RMValuePDec20.type.flags = x'00';
    endif;
    if %parms >= %parmnum(usrd);
      RMValuePDec20.type.usrd = usrd;
    else;
      RMValuePDec20.type.usrd = 0;
    endif;
    RMValuePDec20.value = value;
    return RMValuePDec20P;
  when digits = 30;
    RMValuePDec30P = %alloc(%size(RMValuePDec30));
    RMValuePDec30.type.id = RMTYPE_PDEC30;
    if %parms >= %parmnum(flags);
      RMValuePDec30.type.flags = flags;
    else;
      RMValuePDec30.type.flags = x'00';
    endif;
    if %parms >= %parmnum(usrd);
      RMValuePDec30.type.usrd = usrd;
    else;
      RMValuePDec30.type.usrd = 0;
    endif;
    RMValuePDec30.value = value;
    return RMValuePDec30P;
  endsl;
  
  return *null;
  
end-proc;


// Is packed decimal?
dcl-proc RMValIsPDec export;
dcl-pi *n ind;
  obj pointer value;
  digits uns(5) value options(*nopass);
end-pi;

  RMValueObjP = obj;
  return
           %parms < %parmnum(digits)
       and (   RMValueObj.type.id = RMTYPE_PDEC10
            or RMValueObj.type.id = RMTYPE_PDEC20
            or RMValueObj.type.id = RMTYPE_PDEC30)
    or     %parms >= %parmnum(digits)
       and (   digits = 10 and RMValueObj.type.id = RMTYPE_PDEC10
            or digits = 20 and RMValueObj.type.id = RMTYPE_PDEC20
            or digits = 30 and RMValueObj.type.id = RMTYPE_PDEC30);
  
end-proc;


// Convert a value to an RPG packed decimal
dcl-proc RMValConv2PDec export;
dcl-pi *n packed(46:16);
  value pointer value;
  default packed(46:16) value options(*nopass);
end-pi;

  if value = *null;
    if %parms > 1;
      return default;
    endif;
    return 0;
  endif;

  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_INT10;
    RMValueInt10P = value;
    return RMValueInt10.value;
  when RMValueObj.type.id = RMTYPE_INT20;
    RMValueInt20P = value;
    return RMValueInt20.value;
  when RMValueObj.type.id = RMTYPE_PDEC10;
    RMValuePDec10P = value;
    return RMValuePDec10.value;
  when RMValueObj.type.id = RMTYPE_PDEC20;
    RMValuePDec20P = value;
    return RMValuePDec20.value;
  when RMValueObj.type.id = RMTYPE_PDEC30;
    RMValuePDec30P = value;
    return RMValuePDec30.value;
  endsl;
  
  RMSysSndEscapeMsg('RM00011');

  return 0;
  
end-proc;


// ----- Date/Time


// Create date
dcl-proc RMValDateCrt export;
dcl-pi *n pointer;
  value date value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pi;

  RMValueDateP = %alloc(%size(RMValueDate));
  RMValueDate.type.id = RMTYPE_DATE;
  if %parms >= %parmnum(flags);
    RMValueDate.type.flags = flags;
  else;
    RMValueDate.type.flags = x'00';
  endif;
  if %parms >= %parmnum(usrd);
    RMValueDate.type.usrd = usrd;
  else;
    RMValueDate.type.usrd = 0;
  endif;
  RMValueDate.value = value;
  return RMValueDateP;
  
end-proc;


// Create time
dcl-proc RMValTimeCrt export;
dcl-pi *n pointer;
  value time value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pi;

  RMValueTimeP = %alloc(%size(RMValueTime));
  RMValueTime.type.id = RMTYPE_TIME;
  if %parms >= %parmnum(flags);
    RMValueTime.type.flags = flags;
  else;
    RMValueTime.type.flags = x'00';
  endif;
  if %parms >= %parmnum(usrd);
    RMValueTime.type.usrd = usrd;
  else;
    RMValueTime.type.usrd = 0;
  endif;
  RMValueTime.value = value;
  return RMValueTimeP;
  
end-proc;


// Create timestamp
dcl-proc RMValTsCrt export;
dcl-pi *n pointer;
  value timestamp value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pi;

  RMValueTsP = %alloc(%size(RMValueTs));
  RMValueTs.type.id = RMTYPE_TS;
  if %parms >= %parmnum(flags);
    RMValueTs.type.flags = flags;
  else;
    RMValueTs.type.flags = x'00';
  endif;
  if %parms >= %parmnum(usrd);
    RMValueTs.type.usrd = usrd;
  else;
    RMValueTs.type.usrd = 0;
  endif;
  RMValueTs.value = value;
  return RMValueTsP;
  
end-proc;


// Is date?
dcl-proc RMValIsDate export;
dcl-pi *n ind;
  obj pointer value;
end-pi;

  RMValueObjP = obj;
  return RMValueObj.type.id = RMTYPE_DATE;
  
end-proc;


// Is time?
dcl-proc RMValIsTime export;
dcl-pi *n ind;
  obj pointer value;
end-pi;

  RMValueObjP = obj;
  return RMValueObj.type.id = RMTYPE_TIME;
  
end-proc;


// Is timestamp?
dcl-proc RMValIsTs export;
dcl-pi *n ind;
  obj pointer value;
end-pi;

  RMValueObjP = obj;
  return RMValueObj.type.id = RMTYPE_TS;
  
end-proc;


// Convert a value to an RPG date
dcl-proc RMValConv2Date export;
dcl-pi *n date;
  value pointer value;
  default date value options(*nopass);
end-pi;

  if value = *null;
    if %parms > 1;
      return default;
    endif;
    return *loval;
  endif;

  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_DATE;
    RMValueDateP = value;
    return RMValueDate.value;
  when RMValueObj.type.id = RMTYPE_TS;
    RMValueTsP = value;
    return %date(RMValueTs.value);
  endsl;
  
  RMSysSndEscapeMsg('RM00011');

  return *loval;
  
end-proc;


// Convert a value to an RPG time
dcl-proc RMValConv2Time export;
dcl-pi *n time;
  value pointer value;
  default time value options(*nopass);
end-pi;

  if value = *null;
    if %parms > 1;
      return default;
    endif;
    return *loval;
  endif;

  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_TIME;
    RMValueTimeP = value;
    return RMValueTime.value;
  when RMValueObj.type.id = RMTYPE_TS;
    RMValueTsP = value;
    return %time(RMValueTs.value);
  endsl;
  
  RMSysSndEscapeMsg('RM00011');

  return *loval;
  
end-proc;


// Convert a value to an RPG timestamp
dcl-proc RMValConv2Ts export;
dcl-pi *n timestamp;
  value pointer value;
  default timestamp value options(*nopass);
end-pi;

  if value = *null;
    if %parms > 1;
      return default;
    endif;
    return *loval;
  endif;

  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_TS;
    RMValueTsP = value;
    return RMValueTs.value;
  when RMValueObj.type.id = RMTYPE_DATE;
    RMValueDateP = value;
    return %timestamp(RMValueDate.value);
  endsl;
  
  RMSysSndEscapeMsg('RM00011');

  return *loval;
  
end-proc;


// ----- Indicator


// Create indicator
dcl-proc RMValIndCrt export;
dcl-pi *n pointer;
  value ind value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pi;

  RMValueIndP = %alloc(%size(RMValueInd));
  RMValueInd.type.id = RMTYPE_IND;
  if %parms >= %parmnum(flags);
    RMValueInd.type.flags = flags;
  else;
    RMValueInd.type.flags = x'00';
  endif;
  if %parms >= %parmnum(usrd);
    RMValueInd.type.usrd = usrd;
  else;
    RMValueInd.type.usrd = 0;
  endif;
  RMValueInd.value = value;
  return RMValueIndP;
  
end-proc;


// Is indicator?
dcl-proc RMValIsInd export;
dcl-pi *n ind;
  obj pointer value;
end-pi;

  RMValueObjP = obj;
  return RMValueObj.type.id = RMTYPE_IND;
  
end-proc;


// Convert a value to an RPG indicator
dcl-proc RMValConv2Ind export;
dcl-pi *n ind;
  value pointer value;
  default ind value options(*nopass);
end-pi;

  if value = *null;
    if %parms > 1;
      return default;
    endif;
    return *off;
  endif;

  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_IND;
    RMValueIndP = value;
    return RMValueInd.value;
  endsl;
  
  RMSysSndEscapeMsg('RM00011');

  return *off;
  
end-proc;


// ----- Pointer


// Create pointer
dcl-proc RMValPtrCrt export;
dcl-pi *n pointer;
  value pointer value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pi;

  RMValuePtrP = %alloc(%size(RMValuePtr));
  RMValuePtr.type.id = RMTYPE_PTR;
  if %parms >= %parmnum(flags);
    RMValuePtr.type.flags = flags;
  else;
    RMValuePtr.type.flags = x'00';
  endif;
  if %parms >= %parmnum(usrd);
    RMValuePtr.type.usrd = usrd;
  else;
    RMValuePtr.type.usrd = 0;
  endif;
  RMValuePtr.value = value;
  return RMValuePtrP;
  
end-proc;


// Is pointer?
dcl-proc RMValIsPtr export;
dcl-pi *n ind;
  obj pointer value;
end-pi;

  RMValueObjP = obj;
  return RMValueObj.type.id = RMTYPE_PTR;
  
end-proc;


// Convert a value to an RPG pointer
dcl-proc RMValConv2Ptr export;
dcl-pi *n pointer;
  value pointer value;
  default pointer value options(*nopass);
end-pi;

  if value = *null;
    if %parms > 1;
      return default;
    endif;
    return *null;
  endif;

  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_PTR;
    RMValuePtrP = value;
    return RMValuePtr.value;
  endsl;
  
  RMSysSndEscapeMsg('RM00011');

  return *null;
  
end-proc;


// ----- Procedure Pointer


// Create procedure pointer
dcl-proc RMValPPtrCrt export;
dcl-pi *n pointer;
  value pointer(*proc) value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pi;

  RMValuePPtrP = %alloc(%size(RMValuePPtr));
  RMValuePPtr.type.id = RMTYPE_PPTR;
  if %parms >= %parmnum(flags);
    RMValuePPtr.type.flags = flags;
  else;
    RMValuePPtr.type.flags = x'00';
  endif;
  if %parms >= %parmnum(usrd);
    RMValuePPtr.type.usrd = usrd;
  else;
    RMValuePPtr.type.usrd = 0;
  endif;
  RMValuePPtr.value = value;
  return RMValuePPtrP;
  
end-proc;


// Is procedure pointer?
dcl-proc RMValIsPPtr export;
dcl-pi *n ind;
  obj pointer value;
end-pi;

  RMValueObjP = obj;
  return RMValueObj.type.id = RMTYPE_PPTR;
  
end-proc;


// Convert a value to an RPG procedure pointer
dcl-proc RMValConv2PPtr export;
dcl-pi *n pointer(*proc);
  value pointer value;
  default pointer(*proc) value options(*nopass);
end-pi;

  if value = *null;
    if %parms > 1;
      return default;
    endif;
    return *null;
  endif;

  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_PPTR;
    RMValuePPtrP = value;
    return RMValuePPtr.value;
  endsl;
  
  RMSysSndEscapeMsg('RM00011');

  return *null;
  
end-proc;


// ----- Character Data


// Create character data
dcl-proc RMValCharCrt export;
dcl-pi *n pointer;
  value varchar(30000) const;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pi;

  dcl-s v varchar(30000) based(vp);

  vp = %alloc(%len(value)+2);
  v = value;  
  RMValueCharP = %alloc(%size(RMValueChar));
  RMValueChar.type.id = RMTYPE_CHAR;
  if %parms >= %parmnum(flags);
    RMValueChar.type.flags = flags;
  else;
    RMValueChar.type.flags = x'00';
  endif;
  if %parms >= %parmnum(usrd);
    RMValueChar.type.usrd = usrd;
  else;
    RMValueChar.type.usrd = 0;
  endif;
  RMValueChar.value = vp;
  return RMValueCharP;
  
end-proc;


// Create character data using pointer to address and size.
dcl-proc RMValCharCrtPtr export;
dcl-pi *n pointer;
  addr pointer value;
  size int(10) value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pi;

  dcl-s d char(30000) based(dp);
  dcl-s v varchar(30000) based(vp);

  if size > 30000;
    RMSysSndEscapeMsg('RM00022');
  endif;
  if size < 1;
    RMSysSndEscapeMsg('RM00023');
  endif;
  dp = addr;
  vp = %alloc(size+2);
  v = %subst(d:1:size);
  RMValueCharP = %alloc(%size(RMValueChar));
  RMValueChar.type.id = RMTYPE_CHAR;
  if %parms >= %parmnum(flags);
    RMValueChar.type.flags = flags;
  else;
    RMValueChar.type.flags = x'00';
  endif;
  if %parms >= %parmnum(usrd);
    RMValueChar.type.usrd = usrd;
  else;
    RMValueChar.type.usrd = 0;
  endif;
  RMValueChar.value = vp;
  return RMValueCharP;
  
end-proc;


// Is character data?
dcl-proc RMValIsChar export;
dcl-pi *n ind;
  obj pointer value;
  ass ind value options(*nopass);
end-pi;

  RMValueObjP = obj;
  return     RMValueObj.type.id = RMTYPE_CHAR
         and (   %parms < 2
              or    %parms >= 2
                and (       not ass
                        and %bitand(RMValueObj.type.flags:x'20') <> x'20'
                     or     ass
                        and %bitand(RMValueObj.type.flags:x'20') = x'20'));
  
end-proc;


// Convert a value to RPG character data
dcl-proc RMValConv2Char export;
dcl-pi *n varchar(30000) rtnparm;
  value pointer value;
  default varchar(30000) const options(*nopass);
end-pi;

  dcl-s v varchar(30000) based(vp);

  if value = *null;
    if %parms > 2;
      return default;
    endif;
    return '';
  endif;

  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_CHAR;
    RMValueCharP = value;
    vp = RMValueChar.value;
    return v;
  when RMValueObj.type.id = RMTYPE_STR;
    RMValueStrP = value;
    vp = RMValueStr.value;
    return v;
  endsl;
  
  RMSysSndEscapeMsg('RM00011');

  return '';
  
end-proc;


// Convert a value to RPG character data, max 100 bytes
dcl-proc RMValConv2Char1 export;
dcl-pi *n varchar(100) rtnparm;
  value pointer value;
  default varchar(100) const options(*nopass);
end-pi;

  dcl-s v varchar(30000) based(vp);

  if value = *null;
    if %parms > 2;
      return default;
    endif;
    return '';
  endif;

  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_CHAR;
    RMValueCharP = value;
    vp = RMValueChar.value;
    return v;
  when RMValueObj.type.id = RMTYPE_STR;
    RMValueStrP = value;
    vp = RMValueStr.value;
    return v;
  endsl;
  
  RMSysSndEscapeMsg('RM00011');

  return '';
  
end-proc;


// Convert a value to RPG character data, max 1000 bytes.
dcl-proc RMValConv2Char2 export;
dcl-pi *n varchar(1000) rtnparm;
  value pointer value;
  default varchar(1000) const options(*nopass);
end-pi;

  dcl-s v varchar(30000) based(vp);

  if value = *null;
    if %parms > 2;
      return default;
    endif;
    return '';
  endif;

  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_CHAR;
    RMValueCharP = value;
    vp = RMValueChar.value;
    return v;
  when RMValueObj.type.id = RMTYPE_STR;
    RMValueStrP = value;
    vp = RMValueStr.value;
    return v;
  endsl;
  
  RMSysSndEscapeMsg('RM00011');

  return '';
  
end-proc;


// Convert a value to RPG character data, max 10000 bytes
dcl-proc RMValConv2Char3 export;
dcl-pi *n varchar(10000) rtnparm;
  value pointer value;
  default varchar(10000) const options(*nopass);
end-pi;

  dcl-s v varchar(30000) based(vp);

  if value = *null;
    if %parms > 2;
      return default;
    endif;
    return '';
  endif;

  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_CHAR;
    RMValueCharP = value;
    vp = RMValueChar.value;
    return v;
  when RMValueObj.type.id = RMTYPE_STR;
    RMValueStrP = value;
    vp = RMValueStr.value;
    return v;
  endsl;
  
  RMSysSndEscapeMsg('RM00011');

  return '';
  
end-proc;


// ----- String


// Create string
dcl-proc RMValStrCrt export;
dcl-pi *n pointer;
  value varchar(30000) const ccsid(*utf8);
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pi;

  dcl-s v varchar(30000) ccsid(*utf8) based(vp);

  vp = %alloc(%len(value)+2);
  v = value;  
  RMValueStrP = %alloc(%size(RMValueStr));
  RMValueStr.type.id = RMTYPE_STR;
  if %parms >= %parmnum(flags);
    RMValueStr.type.flags = flags;
  else;
    RMValueStr.type.flags = x'00';
  endif;
  if %parms >= %parmnum(usrd);
    RMValueStr.type.usrd = usrd;
  else;
    RMValueStr.type.usrd = 0;
  endif;
  RMValueStr.value = vp;
  return RMValueStrP;
  
end-proc;


// Create string from bytes
dcl-proc RMValStrCrtBytes export;
dcl-pi *n pointer;
  value varchar(30000) const;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pi;

  dcl-s v varchar(30000) based(vp);

  vp = %alloc(%len(value)+2);
  v = value;  
  RMValueStrP = %alloc(%size(RMValueStr));
  RMValueStr.type.id = RMTYPE_STR;
  if %parms >= %parmnum(flags);
    RMValueStr.type.flags = flags;
  else;
    RMValueStr.type.flags = x'00';
  endif;
  if %parms >= %parmnum(usrd);
    RMValueStr.type.usrd = usrd;
  else;
    RMValueStr.type.usrd = 0;
  endif;
  RMValueStr.value = vp;
  return RMValueStrP;
  
end-proc;


// Is string?
dcl-proc RMValIsStr export;
dcl-pi *n ind;
  obj pointer value;
  ass ind value options(*nopass);
end-pi;

  RMValueObjP = obj;
  return     RMValueObj.type.id = RMTYPE_STR
         and (   %parms < 2
              or     %parms >= 2
                 and (       not ass
                         and %bitand(RMValueObj.type.flags:x'20') <> x'20'
                      or     ass
                         and %bitand(RMValueObj.type.flags:x'20') = x'20'));
  
end-proc;


// Convert a value to RPG string (utf-8 text)
dcl-proc RMValConv2Str export;
dcl-pi *n varchar(30000) ccsid(*utf8) rtnparm;
  value pointer value;
  default varchar(30000) ccsid(*utf8) const options(*nopass);
end-pi;

  dcl-s v varchar(30000) ccsid(*utf8) based(vp);

  if value = *null;
    if %parms > 2;
      return default;
    endif;
    return '';
  endif;

  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_STR;
    RMValueStrP = value;
    vp = RMValueStr.value;
    return v;
  endsl;
  
  RMSysSndEscapeMsg('RM00011');

  return '';
  
end-proc;


// Convert a value to RPG string (utf-8 text), max. 100 bytes
dcl-proc RMValConv2Str1 export;
dcl-pi *n varchar(100) ccsid(*utf8) rtnparm;
  value pointer value;
  default varchar(100) ccsid(*utf8) const options(*nopass);
end-pi;

  dcl-s v varchar(30000) ccsid(*utf8) based(vp);

  if value = *null;
    if %parms > 2;
      return default;
    endif;
    return '';
  endif;

  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_STR;
    RMValueStrP = value;
    vp = RMValueStr.value;
    return v;
  endsl;
  
  RMSysSndEscapeMsg('RM00011');

  return '';
  
end-proc;


// Convert a value to RPG string (utf-8 text), max. 1000 bytes
dcl-proc RMValConv2Str2 export;
dcl-pi *n varchar(1000) ccsid(*utf8) rtnparm;
  value pointer value;
  default varchar(1000) ccsid(*utf8) const options(*nopass);
end-pi;

  dcl-s v varchar(30000) ccsid(*utf8) based(vp);

  if value = *null;
    if %parms > 2;
      return default;
    endif;
    return '';
  endif;

  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_STR;
    RMValueStrP = value;
    vp = RMValueStr.value;
    return v;
  endsl;
  
  RMSysSndEscapeMsg('RM00011');

  return '';
  
end-proc;


// Convert a value to RPG string (utf-8 text), max. 10000 bytes
dcl-proc RMValConv2Str3 export;
dcl-pi *n varchar(10000) ccsid(*utf8) rtnparm;
  value pointer value;
  default varchar(10000) ccsid(*utf8) const options(*nopass);
end-pi;

  dcl-s v varchar(30000) ccsid(*utf8) based(vp);

  if value = *null;
    if %parms > 2;
      return default;
    endif;
    return '';
  endif;

  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_STR;
    RMValueStrP = value;
    vp = RMValueStr.value;
    return v;
  endsl;
  
  RMSysSndEscapeMsg('RM00011');

  return '';
  
end-proc;


// ----- Internal procedures


// Compare numbers.
dcl-proc RMValNumCompare;
dcl-pi *n int(10);
  obj1 pointer value;
  obj2 pointer value;
end-pi;

  dcl-s v1 packed(46:16);
  dcl-s v2 packed(46:16);
  
  v1 = RMValConv2PDec(obj1);
  v2 = RMValConv2PDec(obj2);
  
  if v1 < v2;
    return -1;
  elseif v1 > v2;
    return 1;
  endif;
  return 0;
  
end-proc;


// Compare maps, in the context of map (which can be *null).
dcl-proc RMValMapCompare;
dcl-pi *n int(10);
  map pointer value;
  obj1 pointer value;
  obj2 pointer value;
end-pi;

  dcl-s m1 pointer;
  dcl-s m2 pointer;
  dcl-s c1 pointer;
  dcl-s c2 pointer;
  dcl-s o1 pointer;
  dcl-s o2 pointer;
  dcl-s cv ind;
  dcl-s f1 int(10);
  dcl-s f2 int(10);
  dcl-s ck ind;
  dcl-s c int(10);
    
  c = 0;
  
  cv =     %bitand(RMValObjFlags(obj1):x'02') = x'02'
       and %bitand(RMValObjFlags(obj2):x'02') = x'02';
  
  m1 = RMValMapImpl(obj1);
  m2 = RMValMapImpl(obj2);
  if not cv;
    c1 = RMBCursorCrt(m1:0:*null);
    c2 = RMBCursorCrt(m2:0:*null);
    ck = *on;
    dou f1 <> 1 or f2 <> 1 or c <> 0;
      exsr compnxtobjs;
    enddo;
    RMBCursorDispose(c1);
    RMBCursorDispose(c2);
  endif;
  
  if c <> 0;
    return c;
  endif;
  
  c1 = RMBCursorCrt(m1:0:*null);
  c2 = RMBCursorCrt(m2:0:*null);
  ck = *off;
  dou f1 <> 1 or f2 <> 1 or c <> 0;
    exsr compnxtobjs;
  enddo;
  if cv and f1 <> f2;
    c = 0;
  endif;
  RMBCursorDispose(c1);
  RMBCursorDispose(c2);
  
  return c;
    
  begsr compnxtobjs;
    f1 = RMBCursorReadNxtPrv(c1:0);
    if f1 = 1;
      if ck;
        o1 = RMBCursorKey(c1);
      else;
        o1 = RMBCursorItem(c1);
      endif;
    endif;
    f2 = RMBCursorReadNxtPrv(c2:0);
    if f2 = 1;
      if ck;
        o2 = RMBCursorKey(c2);
      else;
        o2 = RMBCursorItem(c2);
      endif;
    endif;
    if f1 = 1 and f2 = 1;
      c = RMValObjCompare(map:o1:o2);
    elseif f1 <> 1 and f2 <> 1;
      c = 0;
    elseif f1 = 1;
      c = 1;
    else;
      c = -1;
    endif;
  endsr;
  
end-proc;


// Compare dates.
dcl-proc RMValDateCompare;
dcl-pi *n int(10);
  obj1 pointer value;
  obj2 pointer value;
end-pi;

  dcl-s v date;
  
  RMValueDateP = obj1;
  v = RMValueDate.value;
  RMValueDateP = obj2;
  
  if v < RMValueDate.value;
    return -1;
  elseif v > RMValueDate.value;
    return 1;
  endif;
  return 0;
  
end-proc;


// Compare times.
dcl-proc RMValTimeCompare;
dcl-pi *n int(10);
  obj1 pointer value;
  obj2 pointer value;
end-pi;

  dcl-s v time;
  
  RMValueTimeP = obj1;
  v = RMValueTime.value;
  RMValueTimeP = obj2;
  
  if v < RMValueTime.value;
    return -1;
  elseif v > RMValueTime.value;
    return 1;
  endif;
  return 0;
  
end-proc;


// Compare timestamps.
dcl-proc RMValTsCompare;
dcl-pi *n int(10);
  obj1 pointer value;
  obj2 pointer value;
end-pi;

  dcl-s v timestamp;
  
  RMValueTsP = obj1;
  v = RMValueTs.value;
  RMValueTsP = obj2;
  
  if v < RMValueTs.value;
    return -1;
  elseif v > RMValueTs.value;
    return 1;
  endif;
  return 0;
  
end-proc;


// Compare dates and timestamps.
dcl-proc RMValDtsCompare;
dcl-pi *n int(10);
  obj1 pointer value;
  obj2 pointer value;
end-pi;

  dcl-s v1 timestamp;
  dcl-s v2 timestamp;
  
  v1 = RMValConv2Ts(obj1);
  v2 = RMValConv2Ts(obj2);
  
  if v1 < v2;
    return -1;
  elseif v1 > v2;
    return 1;
  endif;
  return 0;
  
end-proc;


// Compare indicators.
dcl-proc RMValIndCompare;
dcl-pi *n int(10);
  obj1 pointer value;
  obj2 pointer value;
end-pi;

  dcl-s v ind;
  
  RMValueIndP = obj1;
  v = RMValueInd.value;
  RMValueIndP = obj2;
  
  if not v and RMValueInd.value;
    return -1;
  elseif v and not RMValueInd.value;
    return 1;
  endif;
  return 0;
  
end-proc;


// Compare pointers.
dcl-proc RMValPtrCompare;
dcl-pi *n int(10);
  obj1 pointer value;
  obj2 pointer value;
end-pi;

  dcl-s v pointer;
  
  RMValuePtrP = obj1;
  v = RMValuePtr.value;
  RMValuePtrP = obj2;
  
  if v < RMValuePtr.value;
    return -1;
  elseif v > RMValuePtr.value;
    return 1;
  endif;
  return 0;
  
end-proc;


// Compare procedure pointers.
dcl-proc RMValPPtrCompare;
dcl-pi *n int(10);
  obj1 pointer value;
  obj2 pointer value;
end-pi;

  dcl-ds d1;
    v1 pointer(*proc);
  end-ds;
  dcl-ds d2;
    v2 pointer(*proc);
  end-ds;
  
  RMValuePPtrP = obj1;
  v1 = RMValuePPtr.value;
  RMValuePPtrP = obj2;
  v2 = RMValuePPtr.value;
  
  if d1 < d2;
    return -1;
  elseif d1 > d2;	
    return 1;
  endif;
  return 0;
  
end-proc;


// Compare character data.
dcl-proc RMValCharCompare;
dcl-pi *n int(10);
  obj1 pointer value;
  obj2 pointer value;
end-pi;

  dcl-s v1 varchar(30000) based(v1p);
  dcl-s v2 varchar(30000) based(v2p);
  dcl-s ass1 ind;
  dcl-s ass2 ind;
  dcl-s ci ind;
  
  RMValueCharP = obj1;
  v1p = RMValueChar.value;
  ass1 = %bitand(RMValueChar.type.flags:x'20') = x'20';
  ci = %bitand(RMValueChar.type.flags:x'08') = x'08';
  RMValueCharP = obj2;
  v2p = RMValueChar.value;
  ass2 = %bitand(RMValueObj.type.flags:x'20') = x'20';
  ci = ci or %bitand(RMValueChar.type.flags:x'08') = x'08';
  
  if ass1 and ass2;
    return RMCvaCompareChar(v1p:v2p);
  elseif not ass1 and not ass2;
    if ci;
      return RMValCaseInsCharComp(v1:v2);
    else;
      if v1 < v2;
        return -1;
      elseif v1 > v2;
        return 1;
      endif;
      return 0;
    endif;
  endif;
  
  if ass1;
    return 1;
  endif;
  return -1;
  
end-proc;


// Compare strings.
dcl-proc RMValStrCompare;
dcl-pi *n int(10);
  obj1 pointer value;
  obj2 pointer value;
end-pi;

  dcl-s v1 varchar(30000) ccsid(*utf8) based(v1p);
  dcl-s v2 varchar(30000) ccsid(*utf8) based(v2p);
  dcl-s c1 varchar(120000) static;
  dcl-s c2 varchar(120000) static;
  dcl-s ass1 ind;
  dcl-s ass2 ind;
  dcl-s ci ind;
  dcl-s inbuf pointer;
  dcl-s inbufl uns(10);
  dcl-s outbuf pointer;
  dcl-s outbufl uns(10);
  
  RMValueStrP = obj1;
  v1p = RMValueStr.value;
  ass1 = %bitand(RMValueStr.type.flags:x'20') = x'20';
  ci = %bitand(RMValueStr.type.flags:x'08') = x'08';
  RMValueStrP = obj2;
  v2p = RMValueStr.value;
  ass2 = %bitand(RMValueStr.type.flags:x'20') = x'20';
  ci = ci or %bitand(RMValueStr.type.flags:x'08') = x'08';
  
  if ass1 and ass2;
    return RMCvaCompareStr(v1p:v2p);
  elseif not ass1 and not ass2;
    if ci;
      inbuf = %addr(v1:*data);
      inbufl = %len(v1);
      outbuf = %addr(c1:*data);
      outbufl = %size(c1) - 4;
      %len(c1) = outbufl;
      RMSysCvtCCSID(1208:0:inbuf:inbufl:outbuf:outbufl);
      %len(c1) = %size(c1) - 4 - outbufl;
      inbuf = %addr(v2:*data);
      inbufl = %len(v2);
      outbuf = %addr(c2:*data);
      outbufl = %size(c2) - 4;
      %len(c2) = outbufl;
      RMSysCvtCCSID(1208:0:inbuf:inbufl:outbuf:outbufl);
      %len(c2) = %size(c2) - 4 - outbufl;
      return RMValCaseInsCharComp2(c1:c2);
    else;
      if v1 < v2;
        return -1;
      elseif v1 > v2;
        return 1;
      endif;
      return 0;
    endif;
  endif;
  
  if ass1;
    return 1;
  endif;
  return -1;
  
end-proc;


// Compare character data case insensitive.
// PROC RMValCaseInsCharComp IS A COPY OF THIS PROC, but with varchar(120000).
dcl-proc RMValCaseInsCharComp;
dcl-pi *n int(10);
  c1 varchar(30000);
  c2 varchar(30000);
end-pi;

  dcl-pr memicomp int(10) extproc('__memicmp');
    v1 pointer value;
    v2 pointer value;
    len uns(10) value;
  end-pr;
  
  dcl-s l1 int(10);
  dcl-s l2 int(10);
  dcl-s l uns(10);
  dcl-s c int(10);
  dcl-s r int(10);

  l1 = %len(c1);
  dow l1 > 0 and %subst(c1:l1:1) = ' ';
    l1 -= 1;
  enddo;
  l2 = %len(c2);
  dow l2 > 0 and %subst(c2:l2:1) = ' ';
    l2 -= 1;
  enddo;
  if l2 < l1;
    l = l2;
  else;
    l = l1;
  endif;
  if l = 0;
    c = 0;
  else;
    r = memicomp(%addr(c1:*data):%addr(c2:*data):l);
    if r < 0;
      c = -1;
    elseif r > 0;
      c = 1;
    else;
      c = 0;
    endif;
  endif;
  if c = 0;
    if l1 > l;
      c = 1;
    elseif l2 > l;
      c = -1;
    endif;
  endif;
  return c;
  
end-proc;


// COPY OF RMValCaseInsCharComp, but with varchar(120000).
dcl-proc RMValCaseInsCharComp2;
dcl-pi *n int(10);
  c1 varchar(120000);
  c2 varchar(120000);
end-pi;

  dcl-pr memicomp int(10) extproc('__memicmp');
    v1 pointer value;
    v2 pointer value;
    len uns(10) value;
  end-pr;
  
  dcl-s l1 int(10);
  dcl-s l2 int(10);
  dcl-s l uns(10);
  dcl-s c int(10);
  dcl-s r int(10);

  l1 = %len(c1);
  dow l1 > 0 and %subst(c1:l1:1) = ' ';
    l1 -= 1;
  enddo;
  l2 = %len(c2);
  dow l2 > 0 and %subst(c2:l2:1) = ' ';
    l2 -= 1;
  enddo;
  if l2 < l1;
    l = l2;
  else;
    l = l1;
  endif;
  if l = 0;
    c = 0;
  else;
    r = memicomp(%addr(c1:*data):%addr(c2:*data):l);
    if r < 0;
      c = -1;
    elseif r > 0;
      c = 1;
    else;
      c = 0;
    endif;
  endif;
  if c = 0;
    if l1 > l;
      c = 1;
    elseif l2 > l;
      c = -1;
    endif;
  endif;
  return c;
  
end-proc;


// Copy map.
dcl-proc RMValMapCopy;
dcl-pi *n pointer;
  map pointer value;
  deep ind value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  dcl-s mapi1 pointer;
  dcl-s mapi2 pointer;
  dcl-s newmap pointer;
  dcl-s attrs pointer;
  dcl-s c pointer;
  dcl-s k pointer;
  dcl-s i pointer;
  
  mapi2 = RMBTreeCreate(%paddr(RMValObjCompare):%paddr(RMValMapImplDestroy):*null);
  RMValueMapP = map;
  mapi1 = RMValueMap.map;
  attrs = *null;
  if RMValueMap.attrs <> *null;
    attrs = rm_cpy(RMValueMap.attrs);
  endif;
  RMValueMapP = map;
  newmap = RMValMapCrt(RMValueMap.type.flags:mapi2:RMValueMap.compf:attrs
                      :RMValueMap.type.usrd);
  RMBTreeSetValstruct(mapi2:newmap);
  c = RMBCursorCrt(mapi1:0:*null);
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
    k = RMBCursorKey(c);
    i = RMBCursorItem(c);
    if     k <> *null
       and (   deep or not RMValIsMap(k)
            or %bitand(RMValObjFlags(k):x'01') <> x'01');
      k = RMValObjCopy(k:deep);
    endif;
    if     i <> *null
       and (   deep or not RMValIsMap(i)
            or %bitand(RMValObjFlags(i):x'01') <> x'01');
      i = RMValObjCopy(i:deep);
    endif;
    if k <> *null;
      RMBTreeInsert(mapi2:k:i);
    endif;
  enddo;
  RMBCursorDispose(c);
  
  return newmap;
  
end-proc;


// Copy integer.
dcl-proc RMValIntCopy;
dcl-pi *n pointer;
  value pointer value;
  digits uns(5) value;
end-pi;

  select;
  when digits = 10;
    RMValueInt10P = value;
    return RMValIntCrt(RMValueInt10.value:digits:RMValueInt10.type.flags
                      :RMValueInt10.type.usrd);
  when digits = 20;
    RMValueInt20P = value;
    return RMValIntCrt(RMValueInt20.value:digits:RMValueInt20.type.flags
                      :RMValueInt20.type.usrd);
  endsl;

  return *null;
  
end-proc;


// Copy packed decimal.
dcl-proc RMValPDecCopy;
dcl-pi *n pointer;
  value pointer value;
  digits uns(5) value;
end-pi;

  select;
  when digits = 10;
    RMValuePDec10P = value;
    return RMValPDecCrt(RMValuePDec10.value:digits:RMValuePDec10.type.flags
                       :RMValuePDec10.type.usrd);
  when digits = 20;
    RMValuePDec20P = value;
    return RMValPDecCrt(RMValuePDec20.value:digits:RMValuePDec20.type.flags
                       :RMValuePDec20.type.usrd);
  when digits = 30;
    RMValuePDec30P = value;
    return RMValPDecCrt(RMValuePDec30.value:digits:RMValuePDec30.type.flags
                       :RMValuePDec30.type.usrd);
  endsl;

  return *null;
  
end-proc;


// Copy date.
dcl-proc RMValDateCopy;
dcl-pi *n pointer;
  value pointer value;
end-pi;

  RMValueDateP = value;
  return RMValDateCrt(RMValueDate.value:RMValueDate.type.flags:RMValueDate.type.usrd);
  
end-proc;


// Copy time.
dcl-proc RMValTimeCopy;
dcl-pi *n pointer;
  value pointer value;
end-pi;

  RMValueTimeP = value;
  return RMValTimeCrt(RMValueTime.value:RMValueTime.type.flags:RMValueTime.type.usrd);
  
end-proc;


// Copy timestamp.
dcl-proc RMValTsCopy;
dcl-pi *n pointer;
  value pointer value;
end-pi;

  RMValueTsP = value;
  return RMValTsCrt(RMValueTs.value:RMValueTs.type.flags:RMValueTs.type.usrd);
  
end-proc;


// Copy indicator.
dcl-proc RMValIndCopy;
dcl-pi *n pointer;
  value pointer value;
end-pi;

  RMValueIndP = value;
  return RMValIndCrt(RMValueInd.value:RMValueInd.type.flags:RMValueInd.type.usrd);
  
end-proc;


// Copy pointer.
dcl-proc RMValPtrCopy;
dcl-pi *n pointer;
  value pointer value;
end-pi;

  RMValuePtrP = value;
  return RMValPtrCrt(RMValuePtr.value:RMValuePtr.type.flags:RMValuePtr.type.usrd);
  
end-proc;


// Copy procedure pointer.
dcl-proc RMValPPtrCopy;
dcl-pi *n pointer;
  value pointer value;
end-pi;

  RMValuePPtrP = value;
  return RMValPPtrCrt(RMValuePPtr.value:RMValuePPtr.type.flags:RMValuePPtr.type.usrd);
  
end-proc;


// Copy character data.
dcl-proc RMValCharCopy;
dcl-pi *n pointer;
  value pointer value;
end-pi;

  dcl-s v varchar(30000) based(vp);
  
  RMValueCharP = value;
  vp = RMValueChar.value;
  return RMValCharCrt(v:RMValueChar.type.flags:RMValueChar.type.usrd);
  
end-proc;


// Copy string
dcl-proc RMValStrCopy;
dcl-pi *n pointer;
  value pointer value;
end-pi;

  dcl-s v varchar(30000) ccsid(*utf8) based(vp);
  
  RMValueStrP = value;
  vp = RMValueStr.value;
  return RMValStrCrt(v:RMValueStr.type.flags:RMValueStr.type.usrd);
  
end-proc;


// Dispose 'value'.
dcl-proc RMValDispValue;
dcl-pi *n;
  value pointer value;
end-pi;

  RMValueObjP = value;
  select;
  when RMValueObj.type.id = RMTYPE_CHAR;
    RMValueCharP = value;
    dealloc RMValueChar.value;
  when RMValueObj.type.id = RMTYPE_STR;
    RMValueStrP = value;
    dealloc RMValueStr.value;
  endsl;

  dealloc value;
    
end-proc;


// Destroy 'obj', which is a key, an item or a cursor.
// Called from map implementation when a key, item or cursor is destroyed.
// Do nothing if 'obj' is *null or a map that is manually disposed.
dcl-proc RMValMapImplDestroy;
dcl-pi *n;
  obj pointer value;
end-pi;

  if obj = *null;
    return;
  endif;
  RMValueMapP = obj;
  if RMValueMap.type.id = RMTYPE_MAP and %bitand(x'01':RMValueMap.type.flags) = x'01';
    return;
  endif;
  
  RMValueObjP = obj;
  if RMValueObj.type.id = RMTYPE_MAP;
    RMValDispose(obj);
  elseif RMValueObj.type.id >= 100 and RMValueObj.type.id <= 199;
    RMValDispValue(obj);
  else;
    // A cursor impl is destroyed; destroy 'obj' which points to a RMValueCursor struct.
    dealloc obj;
  endif;
  
  return;
  
end-proc;


dcl-proc RMValSetDsMap;
dcl-pi *n;
  map pointer value;
end-pi;

  RMValueMapP = map;
  if RMValueMap.type.id <> RMTYPE_MAP;
    RMSysSndEscapeMsg('RM09001');
  endif;
  return;
      
end-proc;


dcl-proc RMValSetDsCursor;
dcl-pi *n;
  cursor pointer value;
end-pi;

  RMValueCursorP = cursor;
  if RMValueCursor.type.id <> RMTYPE_CURSOR;
    RMSysSndEscapeMsg('RM09003');
  endif;
  return;
      
end-proc;


// Test if 'obj' is a map. 
dcl-proc RMValTestIfMap;
dcl-pi *n;
  obj pointer value;
end-pi;

  RMValueObjP = obj;
  if RMValueObj.type.id <> RMTYPE_MAP;
    RMSysSndEscapeMsg('RM09001');
  endif;  
  
  return;
      
end-proc;
