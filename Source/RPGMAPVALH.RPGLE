**FREE

// RPGMAPVALH.RPGLE - RPGMAPVAL header file 
// Copyright (c) 2017 John Erps (john@erps.me)


/if defined(RPGMAPVAL_H)
/eof
/else
/define RPGMAPVAL_H
/endif


// Obj flags.
dcl-pr RMValObjFlags char(1);
  obj pointer value;
end-pr;

// Set obj flags.
dcl-pr RMValObjSetFlags;
  obj pointer value;
  flags char(1) value;
end-pr;

// Compare objects.
dcl-pr RMValObjCompare int(10);
  map pointer value;
  obj1 pointer value;
  obj2 pointer value;
end-pr;

// Copy object.
dcl-pr RMValObjCopy pointer;
  obj pointer value;
  deep ind value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

// Set special property opt for obj.
dcl-pr RMValObjSSP;
  obj pointer value;
  opt int(10) value;
end-pr;

// Create a new map.
dcl-pr RMValMapCrt pointer;
  flags char(1) value;
  mapi pointer value options(*nopass);
  compf pointer(*proc) value options(*nopass);
  attrs pointer value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pr;

// Is map?
dcl-pr RMValIsMap ind;
  obj pointer value;
  vector ind value options(*nopass);
  mandisp ind value options(*nopass);
end-pr;

// Map impl.
dcl-pr RMValMapImpl pointer;
  map pointer value;
end-pr;

// Set map comp. func.
dcl-pr RMValMapSetCompf;
  map pointer value;
  comp pointer(*proc) value;
end-pr;

// Get map comp. func.
dcl-pr RMValMapGetCompf pointer(*proc);
  map pointer value;
end-pr;

// Set map attr.
dcl-pr RMValMapSetAttr;
  map pointer value;
  attr varchar(100) ccsid(*utf8) value options(*nopass);
  value varchar(100) ccsid(*utf8) value options(*nopass);
end-pr;

// Get map attr.
dcl-pr RMValMapGetAttr varchar(100) ccsid(*utf8);
  map pointer value;
  attr varchar(100) ccsid(*utf8) value;
end-pr;

// Return user data of map/value.
dcl-pr RMValRtnUsrDta int(10);
  obj pointer value;
end-pr;

// Dispose map, cursor or value.
dcl-pr RMValDispose;
  obj pointer value;
end-pr;

// Create a new cursor.
dcl-pr RMValCursorCrt pointer;
  map pointer value;
  pos int(10) value;
end-pr;

// Cursor impl.
dcl-pr RMValCursorImpl pointer;
  cursor pointer value;
end-pr;

// Is cursor?
dcl-pr RMValIsCursor ind;
  obj pointer value;
end-pr;

// Create a new integer value.
dcl-pr RMValIntCrt pointer;
  value int(20) value;
  digits uns(5) value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pr;

// Is integer?
dcl-pr RMValIsInt ind;
  obj pointer value;
  digits uns(5) value options(*nopass);
end-pr;

// Convert to integer RPG value.
dcl-pr RMValConv2Int int(20);
  value pointer value;
  default int(20) value options(*nopass);
end-pr;

// Create a new packed decimal value.
dcl-pr RMValPDecCrt pointer;
  value packed(46:16) value;
  digits uns(5) value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pr;

// Is packed decimal?
dcl-pr RMValIsPDec ind;
  obj pointer value;
  digits uns(5) value options(*nopass);
end-pr;

// Convert to packed decimal RPG value.
dcl-pr RMValConv2PDec packed(46:16);
  value pointer value;
  default packed(46:16) value options(*nopass);
end-pr;

// Create a new date value.
dcl-pr RMValDateCrt pointer;
  value date value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pr;

// Create a new time value.
dcl-pr RMValTimeCrt pointer;
  value time value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pr;

// Create a new timestamp value.
dcl-pr RMValTsCrt pointer;
  value timestamp value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pr;

// Is date?
dcl-pr RMValIsDate ind;
  obj pointer value;
end-pr;

// Is time?
dcl-pr RMValIsTime ind;
  obj pointer value;
end-pr;

// Is timestamp?
dcl-pr RMValIsTs ind;
  obj pointer value;
end-pr;

// Convert to date RPG value.
dcl-pr RMValConv2Date date;
  value pointer value;
  default date value options(*nopass);
end-pr;

// Convert to time RPG value.
dcl-pr RMValConv2Time time;
  value pointer value;
  default time value options(*nopass);
end-pr;

// Convert to timestamp RPG value.
dcl-pr RMValConv2Ts timestamp;
  value pointer value;
  default timestamp value options(*nopass);
end-pr;

// Create a new indicator value.
dcl-pr RMValIndCrt pointer;
  value ind value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pr;

// Is indicator?
dcl-pr RMValIsInd ind;
  obj pointer value;
end-pr;

// Convert to indicator RPG value.
dcl-pr RMValConv2Ind ind;
  value pointer value;
  default ind value options(*nopass);
end-pr;

// Create a new pointer value.
dcl-pr RMValPtrCrt pointer;
  value pointer value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pr;

// Is pointer?
dcl-pr RMValIsPtr ind;
  obj pointer value;
end-pr;

// Convert to pointer RPG value.
dcl-pr RMValConv2Ptr pointer;
  value pointer value;
  default pointer value options(*nopass);
end-pr;

// Create a new procedure pointer value.
dcl-pr RMValPPtrCrt pointer;
  value pointer(*proc) value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pr;

// Is procedure pointer?
dcl-pr RMValIsPPtr ind;
  obj pointer value;
end-pr;

// Convert to procedure pointer RPG value.
dcl-pr RMValConv2PPtr pointer(*proc);
  value pointer value;
  default pointer(*proc) value options(*nopass);
end-pr;

// Create a new character data value.
dcl-pr RMValCharCrt pointer;
  value varchar(30000) const;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pr;

// Create a new character data value, using pointer to data.
dcl-pr RMValCharCrtPtr pointer;
  addr pointer value;
  size int(10) value;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pr;

// Is character data?
dcl-pr RMValIsChar ind;
  obj pointer value;
  ass ind value options(*nopass);
end-pr;

// Convert to character data RPG value.
dcl-pr RMValConv2Char varchar(30000) rtnparm;
  value pointer value;
  default varchar(30000) const options(*nopass);
end-pr;

// Convert to character data RPG value, max 100 bytes.
dcl-pr RMValConv2Char1 varchar(100) rtnparm;
  value pointer value;
  default varchar(100) const options(*nopass);
end-pr;

// Convert to character data RPG value, max 1000 bytes.
dcl-pr RMValConv2Char2 varchar(1000) rtnparm;
  value pointer value;
  default varchar(1000) const options(*nopass);
end-pr;

// Convert to character data RPG value, max 10000 bytes.
dcl-pr RMValConv2Char3 varchar(10000) rtnparm;
  value pointer value;
  default varchar(10000) const options(*nopass);
end-pr;

// Create a new string value.
dcl-pr RMValStrCrt pointer;
  value varchar(30000) const ccsid(*utf8);
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pr;

// Create a new string value from bytes.
dcl-pr RMValStrCrtBytes pointer;
  value varchar(30000) const;
  flags char(1) value options(*nopass);
  usrd uns(5) value options(*nopass);
end-pr;

// Is string?
dcl-pr RMValIsStr ind;
  obj pointer value;
  ass ind value options(*nopass);
end-pr;

// Convert to string RPG value.
dcl-pr RMValConv2Str varchar(30000) ccsid(*utf8) rtnparm;
  value pointer value;
  default varchar(30000) ccsid(*utf8) const options(*nopass);
end-pr;

// Convert to string RPG value, max 100 bytes.
dcl-pr RMValConv2Str1 varchar(100) ccsid(*utf8) rtnparm;
  value pointer value;
  default varchar(100) ccsid(*utf8) const options(*nopass);
end-pr;

// Convert to string RPG value, max 1000 bytes.
dcl-pr RMValConv2Str2 varchar(1000) ccsid(*utf8) rtnparm;
  value pointer value;
  default varchar(1000) ccsid(*utf8) const options(*nopass);
end-pr;

// Convert to string RPG value, max 10000 bytes.
dcl-pr RMValConv2Str3 varchar(10000) ccsid(*utf8) rtnparm;
  value pointer value;
  default varchar(10000) ccsid(*utf8) const options(*nopass);
end-pr;
