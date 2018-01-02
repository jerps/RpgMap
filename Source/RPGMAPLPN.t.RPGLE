**FREE

// RPGMAPLPN.RPGLE - RpgMap Long Procedure Names
// Copyright (c) 2017-2018 John Erps (john@erps.me)


ctl-opt copyright('Copyright (c) 2017-2018 John Erps (john@erps.me)');
ctl-opt nomain datfmt(*iso-) timfmt(*iso.) ccsid(*exact);


/include _TLIB_/INCLUDERPG,RPGMAP
/include RPGMAPGDEF.RPGLE
/include RPGMAPVALH.RPGLE
/include RPGMAPSYSH.RPGLE
/include RPGMAPRBTC.RPGLE
/include RPGMAPGMFH.RPGLE


// ----- Exported procedures


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

  if %parms > 2;
    return rm_ins1(map:key:item);
  elseif %parms > 1;
    return rm_ins1(map:key);
  endif;
  return rm_ins1(map);
  
end-proc;


// ----- RM_INSERT_MAP <<<<<<<<<<
dcl-proc rm_insert_map export;
dcl-pi *n pointer;
  map pointer value;
  map2 pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  if %parms > 3;
    return rm_insm(map:map2:key1:key2);
  elseif %parms > 2;
    return rm_insm(map:map2:key1);
  endif;
  return rm_insm(map:map2);
  
end-proc;


// ----- RM_INSERT_COND <<<<<<<<<<
dcl-proc rm_insert_cond export;
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


// ----- RM_INSERT_COND_1 <<<<<<<<<<
dcl-proc rm_insert_cond_1 export;
dcl-pi *n pointer;
  map pointer value;
  key pointer value options(*nopass);
  item pointer value options(*nopass);
end-pi;

  if %parms > 2;
    return rm_insc1(map:key:item);
  elseif %parms > 1;
    return rm_insc1(map:key);
  endif;
  return rm_insc1(map);
  
end-proc;


// ----- RM_INSERT_COND_MAP <<<<<<<<<<
dcl-proc rm_insert_cond_map export;
dcl-pi *n pointer;
  map pointer value;
  map2 pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  if %parms > 3;
    return rm_inscm(map:map2:key1:key2);
  elseif %parms > 2;
    return rm_inscm(map:map2:key1);
  endif;
  return rm_inscm(map:map2);
  
end-proc;


// ----- RM_INSERT_EXCL <<<<<<<<<<
dcl-proc rm_insert_excl export;
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


// ----- RM_INSERT_EXCL_1 <<<<<<<<<<
dcl-proc rm_insert_excl_1 export;
dcl-pi *n pointer;
  map pointer value;
  key pointer value options(*nopass);
  item pointer value options(*nopass);
end-pi;

  if %parms > 2;
    return rm_insx1(map:key:item);
  elseif %parms > 1;
    return rm_insx1(map:key);
  endif;
  return rm_insx1(map);
  
end-proc;


// ----- RM_INSERT_EXCL_MAP <<<<<<<<<<
dcl-proc rm_insert_excl_map export;
dcl-pi *n pointer;
  map pointer value;
  map2 pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  if %parms > 3;
    return rm_insxm(map:map2:key1:key2);
  elseif %parms > 2;
    return rm_insxm(map:map2:key1);
  endif;
  return rm_insxm(map:map2);

end-proc;


// ----- RM_REMOVE <<<<<<<<<<
dcl-proc rm_remove export;
dcl-pi *n pointer;
  map pointer value;
  key pointer value;
  opt char(10) value options(*nopass);
end-pi;

  if %parms > 2;
    return rm_rmv(map:key:opt);
  endif;
  return rm_rmv(map:key);

end-proc;


// ----- RM_REMOVE_ALL <<<<<<<<<<
dcl-proc rm_remove_all export;
dcl-pi *n pointer;
  map pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  if %parms > 2;
    return rm_rmva(map:key1:key2);
  elseif %parms > 1;
    return rm_rmva(map:key1);
  endif;
  return rm_rmva(map);

end-proc;


// ----- RM_COMPARE <<<<<<<<<<
dcl-proc rm_compare export;
dcl-pi *n int(10);
  obj1 pointer value;
  obj2 pointer value;
end-pi;

  return RMValObjCompare(*null:obj1:obj2);
    
end-proc;


// ----- RM_COMPARE_EQ <<<<<<<<<<
dcl-proc rm_compare_eq export;
dcl-pi *n ind;
  obj1 pointer value;
  obj2 pointer value;
end-pi;

  return RMValObjCompare(*null:obj1:obj2) = 0;
    
end-proc;


// ----- RM_COMPARE_LT <<<<<<<<<<
dcl-proc rm_compare_lt export;
dcl-pi *n ind;
  obj1 pointer value;
  obj2 pointer value;
end-pi;

  return RMValObjCompare(*null:obj1:obj2) = -1;
    
end-proc;


// ----- RM_COMPARE_LE <<<<<<<<<<
dcl-proc rm_compare_le export;
dcl-pi *n ind;
  obj1 pointer value;
  obj2 pointer value;
end-pi;
  
  return RMValObjCompare(*null:obj1:obj2) <> 1;
    
end-proc;


// ----- RM_COMPARE_GT <<<<<<<<<<
dcl-proc rm_compare_gt export;
dcl-pi *n ind;
  obj1 pointer value;
  obj2 pointer value;
end-pi;

  return RMValObjCompare(*null:obj1:obj2) = 1;
    
end-proc;


// ----- RM_COMPARE_GE <<<<<<<<<<
dcl-proc rm_compare_ge export;
dcl-pi *n ind;
  obj1 pointer value;
  obj2 pointer value;
end-pi;
  
  return RMValObjCompare(*null:obj1:obj2) <> -1;
    
end-proc;


// ----- RM_SET_PROP <<<<<<<<<<
dcl-proc rm_set_prop export;
dcl-pi *n pointer;
  obj pointer value;
  opt int(10) value options(*nopass);
end-pi;

  if %parms > 1;
    return rm_(obj:opt);
  endif;
  return rm_(obj);

end-proc;


// ----- RM_HAS_KEY <<<<<<<<<<
dcl-proc rm_has_key export;
dcl-pi *n ind;
  map pointer value;
  key pointer value;
end-pi;

  return rm_hky(map:key);

end-proc;


// ----- RM_HAS_KEYS <<<<<<<<<<
dcl-proc rm_has_keys export;
dcl-pi *n ind;
  map pointer value;
  key pointer value;
  opt char(10) value options(*nopass);
end-pi;

  if %parms > 2;
    return rm_hks(map:key:opt);
  endif;
  return rm_hks(map:key);

end-proc;


// ----- RM_NUM_KEYS <<<<<<<<<<
dcl-proc rm_num_keys export;
dcl-pi *n uns(20);
  map pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  if %parms > 2;
    return rm_num(map:key1:key2);
  elseif %parms > 1;
    return rm_num(map:key1);
  endif;
  return rm_num(map);

end-proc;


// ----- RM_HAS_ITEM <<<<<<<<<<
dcl-proc rm_has_item export;
dcl-pi *n ind;
  map pointer value;
  item pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  if %parms > 3;
    return rm_hit(map:item:key1:key2);
  elseif %parms > 2;
    return rm_hit(map:item:key1);
  endif;
  return rm_hit(map:item);

end-proc;


// ----- RM_NUM_ITEMS <<<<<<<<<<
dcl-proc rm_num_items export;
dcl-pi *n uns(20);
  map pointer value;
  item pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  if %parms > 3;
    return rm_nit(map:item:key1:key2);
  elseif %parms > 2;
    return rm_nit(map:item:key1);
  endif;
  return rm_nit(map:item);

end-proc;


// ----- RM_GET_ITEM_KEY <<<<<<<<<<
dcl-proc rm_get_item_key export;
dcl-pi *n pointer;
  map pointer value;
  item pointer value;
  opt char(10) value options(*nopass);
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  if %parms > 4;
    return rm_gik(map:item:opt:key1:key2);
  elseif %parms > 3;
    return rm_gik(map:item:opt:key1);
  elseif %parms > 2;
    return rm_gik(map:item:opt);
  endif;
  return rm_gik(map:item);

end-proc;


// ----- RM_COPY <<<<<<<<<<
dcl-proc rm_copy export;
dcl-pi *n pointer;
  obj pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  if %parms > 2;
    return rm_cpy(obj:key1:key2);
  elseif %parms > 1;
    return rm_cpy(obj:key1);
  endif;
  return rm_cpy(obj);

end-proc;


// ----- RM_COPY_DEEP <<<<<<<<<<
dcl-proc rm_copy_deep export;
dcl-pi *n pointer;
  obj pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  if %parms > 2;
    return rm_cpyd(obj:key1:key2);
  elseif %parms > 1;
    return rm_cpyd(obj:key1);
  endif;
  return rm_cpyd(obj);

end-proc;


// ----- RM_CURSOR <<<<<<<<<<
dcl-proc rm_cursor export;
dcl-pi *n pointer;
  map pointer value;
  opt char(10) value options(*nopass);
end-pi;

  if %parms > 1;
    return rm_cur(map:opt);
  endif;
  return rm_cur(map);

end-proc;


// ----- RM_SETLL <<<<<<<<<<
dcl-proc rm_setll export;
dcl-pi *n pointer;
  cur pointer value;
  key pointer value options(*nopass);
end-pi;

  if %parms > 1;
    return rm_sll(cur:key);
  endif;
  return rm_sll(cur);

end-proc;


// ----- RM_SETGT <<<<<<<<<<
dcl-proc rm_setgt export;
dcl-pi *n pointer;
  cur pointer value;
  key pointer value options(*nopass);
end-pi;

  if %parms > 1;
    return rm_sgt(cur:key);
  endif;
  return rm_sgt(cur);

end-proc;


// ----- RM_READ_NEXT <<<<<<<<<<
dcl-proc rm_read_next export;
dcl-pi *n ind;
  cur pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  if %parms > 2;
    return rm_rdn(cur:key1:key2);
  elseif %parms > 1;
    return rm_rdn(cur:key1);
  endif;
  return rm_rdn(cur);

end-proc;


// ----- RM_READ_PREV <<<<<<<<<<
dcl-proc rm_read_prev export;
dcl-pi *n ind;
  cur pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  if %parms > 2;
    return rm_rdp(cur:key1:key2);
  elseif %parms > 1;
    return rm_rdp(cur:key1);
  endif;
  return rm_rdp(cur);

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

  if     %parms > 1
     and %addr(pos) <> *null;
    if %parms > 3;
      return rm_slln(cur:pos:key1:key2);
    elseif %parms > 2;
      return rm_slln(cur:pos:key1);
    elseif %parms > 1;
      return rm_slln(cur:pos);
    endif;
  elseif %parms > 1;
    if %parms > 3;
      return rm_slln(cur:*omit:key1:key2);
    elseif %parms > 2;
      return rm_slln(cur:*omit:key1);
    endif;
  endif;
  return rm_slln(cur);

end-proc;


// ----- RM_SETGT_READ_PREV <<<<<<<<<<
dcl-proc rm_setgt_read_prev export;
dcl-pi *n ind;
  cur pointer value;
  pos ind options(*nopass:*omit);
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  if     %parms > 1
     and %addr(pos) <> *null;
    if %parms > 3;
      return rm_sgtp(cur:pos:key1:key2);
    elseif %parms > 2;
      return rm_sgtp(cur:pos:key1);
    elseif %parms > 1;
      return rm_sgtp(cur:pos);
    endif;
  elseif %parms > 1;
    if %parms > 3;
      return rm_sgtp(cur:*omit:key1:key2);
    elseif %parms > 2;
      return rm_sgtp(cur:*omit:key1);
    endif;
  endif;
  return rm_sgtp(cur);

end-proc;


// ----- RM_HAS_NEXT <<<<<<<<<<
dcl-proc rm_has_next export;
dcl-pi *n ind;
  cur pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  if %parms > 2;
    return rm_hsn(cur:key1:key2);
  elseif %parms > 1;
    return rm_hsn(cur:key1);
  endif;
  return rm_hsn(cur);

end-proc;


// ----- RM_HAS_PREV <<<<<<<<<<
dcl-proc rm_has_prev export;
dcl-pi *n ind;
  cur pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pi;

  if %parms > 2;
    return rm_hsp(cur:key1:key2);
  elseif %parms > 1;
    return rm_hsp(cur:key1);
  endif;
  return rm_hsp(cur);

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

  if %parms > 4;
    return rm_fed(map:proc:usrd:key1:key2);
  elseif %parms > 3;
    return rm_fed(map:proc:usrd:key1);
  elseif %parms > 2;
    return rm_fed(map:proc:usrd);
  endif;
  return rm_fed(map:proc);

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

  if %parms > 4;
    return rm_fedr(map:proc:usrd:key1:key2);
  elseif %parms > 3;
    return rm_fedr(map:proc:usrd:key1);
  elseif %parms > 2;
    return rm_fedr(map:proc:usrd);
  endif;
  return rm_fedr(map:proc);

end-proc;


// ----- RM_SET_COMP_FUN <<<<<<<<<<
dcl-proc rm_set_comp_fun export;
dcl-pi *n pointer;
  map pointer value;
  comp pointer(*proc) value;
end-pi;

  return rm_scf(map:comp);
  
end-proc;


// ----- RM_GET_COMP_FUN <<<<<<<<<<
dcl-proc rm_get_comp_fun export;
dcl-pi *n pointer(*proc);
  map pointer value;
end-pi;

  return rm_gcf(map);
  
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

  return rm_gav(map:attr);
  
end-proc;


// ----- RM_USER_DATA <<<<<<<<<<
dcl-proc rm_user_data export;
dcl-pi *n int(10);
  obj pointer value;
end-pi;

  return RMValRtnUsrDta(obj);
      
end-proc;


// ----- Internal procedures
