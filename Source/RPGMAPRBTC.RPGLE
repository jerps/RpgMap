**FREE

// RPGMAPRBTC.RPGLE - RedBlackTree and Cursors header file, RPG version  */
// (c) 2017 John Erps (john.erps@gmail.com)


/if defined(RPGMAPRBTC_H)
/eof
/else
/define RPGMAPRBTC_H
/endif


dcl-pr RMBTreeCreate pointer extproc(*dclcase); 
  compFunc pointer(*proc) value;
  destFunc pointer(*proc) value; 
  valstruct pointer value;
end-pr;

dcl-pr RMBTreeSetValstruct extproc(*dclcase); 
  tree pointer value;
  valstruct pointer value;
end-pr;

dcl-pr RMBTreeNodeKey pointer extproc(*dclcase); 
  node pointer value;
end-pr;
dcl-pr RMBTreeNodeItem pointer extproc(*dclcase); 
  node pointer value;
end-pr;

dcl-pr RMBTreeDispose extproc(*dclcase); 
  tree pointer value;
end-pr;

dcl-pr RMBTreeInsert pointer extproc(*dclcase); 
  tree pointer value;
  key pointer value;
  item pointer value;
end-pr;

dcl-pr RMBTreeRmv extproc(*dclcase); 
  tree pointer value;
  node pointer value;
end-pr;

dcl-pr RMBTreeNum uns(20) extproc(*dclcase); 
  tree pointer value;
end-pr;

dcl-pr RMBTreeGet pointer extproc(*dclcase); 
  tree pointer value;
  key pointer value;
  firstlast int(10) value;
end-pr;

dcl-pr RMBTreeHasKey int(10) extproc(*dclcase); 
  tree pointer value;
  key pointer value;
end-pr;

dcl-pr RMBTreeHasKeys int(10) extproc(*dclcase); 
  tree pointer value;
  key pointer value;
  llgt int(10) value;
end-pr;

dcl-pr RMBCursorCrt pointer extproc(*dclcase); 
  tree pointer value;
  pos int(10) value;
  valstruct pointer value;
end-pr;

dcl-pr RMBCursorDispose extproc(*dclcase); 
  cursor pointer value;
end-pr;

dcl-pr RMBCursorNode pointer extproc(*dclcase); 
  cursor pointer value;
end-pr;

dcl-pr RMBCursorKey pointer extproc(*dclcase); 
  cursor pointer value;
end-pr;

dcl-pr RMBCursorItem pointer extproc(*dclcase); 
  cursor pointer value;
end-pr;

dcl-pr RMBCursorSetLlGt extproc(*dclcase); 
  cursor pointer value;
  key pointer value;
  llgt int(10) value;
end-pr;

dcl-pr RMBCursorHasNxtPrv int(10) extproc(*dclcase); 
  cursor pointer value;
  nxtprv int(10) value;
end-pr;

dcl-pr RMBCursorHasNxtPrv2 int(10) extproc(*dclcase); 
  cursor pointer value;
  nxtprv int(10) value;
  key1 pointer value;
  key2 pointer value;
  opt int(10) value;
end-pr;

dcl-pr RMBCursorReadNxtPrv int(10) extproc(*dclcase); 
  cursor pointer value;
  nxtprv int(10) value;
end-pr;

dcl-pr RMBCursorReadNxtPrv2 int(10) extproc(*dclcase); 
  cursor pointer value;
  nxtprv int(10) value;
  key1 pointer value;
  key2 pointer value;
  opt int(10) value;
end-pr;

dcl-pr RMBAddEventh extproc(*dclcase); 
  tree pointer value;
  proc pointer(*proc) value;
  usrd pointer value;
end-pr;

dcl-pr RMBRmvEventh extproc(*dclcase); 
  tree pointer value;
  proc pointer(*proc) value;
end-pr;

dcl-pr RMBFireEvent extproc(*dclcase); 
  tree pointer value;
  event int(10) value;
  key pointer value;
  item pointer value;
end-pr;
