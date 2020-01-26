**FREE

ctl-opt main(Main) ccsid(*exact) bnddir('_TLIB_/RPGMAP');


/include _TLIB_/INCLUDERPG,RPGMAP



dcl-proc Main;

  dcl-s m pointer;
  dcl-s m2 pointer;
  dcl-s c pointer;
  dcl-s x int(10);

  display('18:');
  m = rm_m();
  m2 = rm_m();
  rm_add_event_handler(m:%paddr(event_handler_1));
  rm_add_event_handler(m:%paddr(event_handler_2):m2);
  for x = 1 by 2 to 19;
    rm_insert(m:rm_i(x):rm_i(x+1));
  endfor;
  rm_remove_all(m);
  c = rm_setll(rm_cursor(m2));
  dow rm_read_next(c);
    display('R: '+%editc(%dec(rm_i_(rm_key(c)):3:0):'X')+' '+%editc(%dec(rm_i_(rm_item(c)):3:0):'X'));
  enddo;
  rm_dispose(m:m2);

end-proc;



dcl-proc event_handler_1;
dcl-pi *n int(10);
  event int(10) value;
  map pointer value;
  key pointer value;
  item pointer value;
  usrd pointer value;
end-pi;

  if event = 1;
    display('I: '+%editc(%dec(rm_i_(key):3:0):'X')+' '+%editc(%dec(rm_i_(item):3:0):'X'));
  endif;
  return 0;

end-proc;


dcl-proc event_handler_2;
dcl-pi *n int(10);
  event int(10) value;
  map pointer value;
  key pointer value;
  item pointer value;
  usrd pointer value;
end-pi;

  if event = 2;
    rm_insert(usrd:rm_(rm_copy(key)):rm_copy(item));
  endif;
  return 0;

end-proc;



dcl-proc display;
dcl-pi *n;
  text varchar(500) value;
end-pi;
  dcl-s t char(52);
  t = text;
  dsply t;
end-proc;

