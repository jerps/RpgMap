**FREE

// RPGMAPGMFH.RPGLE - RPGMAPGMF header file 
// (c) 2017 John Erps


/if defined(RPGMAPGMF_H)
/eof
/else
/define RPGMAPGMF_H
/endif


dcl-pr RMMInsert ind;
  map pointer value;
  mode int(10) value;
  k pointer value;
  i pointer value;
end-pr;

dcl-pr RMMInsertFromMap;
  map pointer value;
  mode int(10) value;
  map2 pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr RMMForEachDo pointer;
  map pointer value;
  proc pointer(*proc) value;
  rev ind value;
  usrd pointer value options(*nopass);
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;

dcl-pr RMMDisposeArg;
  obj pointer value;
end-pr;
