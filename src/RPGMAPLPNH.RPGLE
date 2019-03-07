**FREE

// RPGMAPLPNH.RPGLE - RPGMAPLPN header file 
// (c) 2017-2018 John Erps (john.erps@gmail.com)


/if defined(RPGMAPLPN_H)
/eof
/else
/define RPGMAPLPN_H
/endif


dcl-pr rm_in_map ind extproc(*dclcase);
  obj pointer value;
end-pr;

dcl-pr rm_make_map_manually_disposed pointer extproc(*dclcase);
  map pointer value;
end-pr;

dcl-pr rm_make_map_immutable pointer extproc(*dclcase);
  map pointer value;
  opt char(10) value options(*nopass);
end-pr;

dcl-pr rm_dispose extproc(*dclcase);
/include _TLIB_/INCLUDERPG,RPGMAPI003
end-pr;

dcl-pr rm_insert pointer extproc(*dclcase);
  map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI001
end-pr;

dcl-pr rm_insert_1 pointer extproc(*dclcase);
  map pointer value;
  key pointer value options(*nopass);
  item pointer value options(*nopass);
end-pr;

dcl-pr rm_insert_map pointer extproc(*dclcase);
  map pointer value;
  map2 pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_insert_cond pointer extproc(*dclcase);
  map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI001
end-pr;

dcl-pr rm_insert_cond_1 pointer extproc(*dclcase);
  map pointer value;
  key pointer value options(*nopass);
  item pointer value options(*nopass);
end-pr;

dcl-pr rm_insert_cond_map pointer extproc(*dclcase);
  map pointer value;
  map2 pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_insert_excl pointer extproc(*dclcase);
  map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI001
end-pr;

dcl-pr rm_insert_excl_1 pointer extproc(*dclcase);
  map pointer value;
  key pointer value options(*nopass);
  item pointer value options(*nopass);
end-pr;

dcl-pr rm_insert_excl_map pointer extproc(*dclcase);
  map pointer value;
  map2 pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_remove pointer extproc(*dclcase);
  map pointer value;
  key pointer value;
  opt char(10) value options(*nopass);
end-pr;

dcl-pr rm_remove_all pointer extproc(*dclcase);
  map pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_compare int(10) extproc(*dclcase);
  obj1 pointer value;
  obj2 pointer value;
end-pr;

dcl-pr rm_compare_eq ind extproc(*dclcase);
  obj1 pointer value;
  obj2 pointer value;
end-pr;

dcl-pr rm_compare_lt ind extproc(*dclcase);
  obj1 pointer value;
  obj2 pointer value;
end-pr;

dcl-pr rm_compare_le ind extproc(*dclcase);
  obj1 pointer value;
  obj2 pointer value;
end-pr;

dcl-pr rm_compare_gt ind extproc(*dclcase);
  obj1 pointer value;
  obj2 pointer value;
end-pr;

dcl-pr rm_compare_ge ind extproc(*dclcase);
  obj1 pointer value;
  obj2 pointer value;
end-pr;

dcl-pr rm_set_prop pointer extproc(*dclcase);
  obj pointer value;
  opt int(10) value options(*nopass);
end-pr;

dcl-pr rm_has_key ind extproc(*dclcase);
  map pointer value;
  key pointer value;
end-pr;

dcl-pr rm_has_keys ind extproc(*dclcase);
  map pointer value;
  key pointer value;
  opt char(10) value options(*nopass);
end-pr;

dcl-pr rm_num_keys uns(20) extproc(*dclcase);
  map pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_has_item ind extproc(*dclcase);
  map pointer value;
  item pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_num_items uns(20) extproc(*dclcase);
  map pointer value;
  item pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_get_item_key pointer extproc(*dclcase);
  map pointer value;
  item pointer value;
  opt char(10) value options(*nopass);
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_copy pointer extproc(*dclcase);
  obj pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_copy_deep pointer extproc(*dclcase);
  obj pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_cursor pointer extproc(*dclcase);
  map pointer value;
  opt char(10) value options(*nopass);
end-pr;

dcl-pr rm_setll pointer extproc(*dclcase);
  cur pointer value;
  key pointer value options(*nopass);
end-pr;

dcl-pr rm_setgt pointer extproc(*dclcase);
  cur pointer value;
  key pointer value options(*nopass);
end-pr;

dcl-pr rm_read_next ind extproc(*dclcase);
  cur pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_read_prev ind extproc(*dclcase);
  cur pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_item pointer extproc(*dclcase);
  cur pointer value;
end-pr;

dcl-pr rm_setll_read_next ind extproc(*dclcase);
  cur pointer value;
  pos ind options(*nopass:*omit);
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_setgt_read_prev ind extproc(*dclcase);
  cur pointer value;
  pos ind options(*nopass:*omit);
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_has_next ind extproc(*dclcase);
  cur pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_has_prev ind extproc(*dclcase);
  cur pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_for_each_do pointer extproc(*dclcase);
  map pointer value;
  proc pointer(*proc) value;
  usrd pointer value options(*nopass);
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_for_each_do_rev pointer extproc(*dclcase);
  map pointer value;
  proc pointer(*proc) value;
  usrd pointer value options(*nopass);
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr rm_set_comp_fun pointer extproc(*dclcase);
  map pointer value;
  comp pointer(*proc) value;
end-pr;

dcl-pr rm_get_comp_fun pointer(*proc) extproc(*dclcase);
  map pointer value;
end-pr;

dcl-pr rm_set_attr_val pointer extproc(*dclcase);
  map pointer value;
/include _TLIB_/INCLUDERPG,RPGMAPI064
end-pr;

dcl-pr rm_get_attr_val varchar(100) ccsid(*utf8) extproc(*dclcase);
  map pointer value;
  attr varchar(100) ccsid(*utf8) value;
end-pr;

dcl-pr rm_user_data int(10) extproc(*dclcase);
  obj pointer value;
end-pr;
