**FREE

ctl-opt main(Main) ccsid(*exact) bnddir('_TLIB_/RPGMAP');


/include _TLIB_/INCLUDERPG,RPGMAP


dcl-c IFS_O_RDONLY 1;
dcl-c IFS_O_TEXTDATA 16777216;


dcl-pr ifs_open int(10) extproc('open');
  path pointer value;
  oflag int(10) value;
  mode uns(10) value options(*nopass);
  codepage uns(10) value options(*nopass);
end-pr;
dcl-pr ifs_read int(10) extproc('read');
  fd int(10) value;
  buf pointer value;
  nbyte uns(10) value;
end-pr;
dcl-pr ifs_close int(10) extproc('close');
 fd int(10) value;
end-pr;


dcl-proc Main;

  dcl-s m pointer;
  dcl-s m2 pointer;
  dcl-s c pointer;
  dcl-s c2 pointer;
  dcl-s pos ind;
  dcl-s k pointer;
  dcl-s i pointer;
  dcl-s x int(10);
  dcl-s y int(10);
  dcl-s z int(10);
  dcl-s t varchar(500);
  dcl-s fd int(10);
  dcl-s path char(100);
  dcl-s buf char(1000);
  dcl-s word varchar(100);
  dcl-s ch char(1);

  display('15:');
  m = rm_m();
  m2 = rm_m();
  for x = 1 to 5;
    for y = 1 to 5;
      for z = 1 to 5;
        rm_insert_1(m :rm_m( rm_d(d'2017-01-01'+%days(x)) :rm_v( rm_i(y) :rm_i(z) ) ) :
                       rm_sa('*'+%char(x)+'*'+%char(y)+'*'+%char(z)+'*') );
        rm_insert_1(m2:rm_sa('*'+%char(x)+'*'+%char(y)+'*'+%char(z)+'*') :
                       rm_m( rm_d(d'2017-01-01'+%days(x)) :rm_v( rm_i(y) :rm_i(z) ) ) );
      endfor;
    endfor;
  endfor;
  pos = *on;
  c = rm_cur(m);
  dow rm_setll_read_next(c:pos);
    c2 = rm_cur(rm_key(c));
    t = '?';
    if rm_read_next(c2) and rm_isd(rm_key(c2));
      t = %char(rm_d_(rm_key(c2)));
    endif;
    display(t + ': ' + rm_s_(rm_item(c)));
  enddo;
  rm_dispose(c);
  pos = *on;
  c = rm_cur(m2);
  dow rm_setll_read_next(c:pos:rm_sa('*3*'):*null);
    display(rm_s_(rm_key(c)));
  enddo;
  rm_dispose(m:m2);

  display('16:');
  m = rm_m();
  path = '/QSYS.LIB/_TLIB_.LIB/INCLUDERPG.FILE/RPGMAP.MBR' + x'00';
  fd = ifs_open(%addr(path):IFS_O_RDONLY+IFS_O_TEXTDATA);
  if fd = -1;
    display('error: ' + %char(cerrno()));
  else;
    word = '';
    z = %size(buf);
    x = z + 1;
    dow 0=0;
      if x > z;
        if z < %size(buf);
          leave;
        endif;
        z = ifs_read(fd:%addr(buf):%size(buf));
        if z = -1;
          display('error: ' + %char(cerrno()));
        else;
          if z = 0;
            leave;
          endif;
          x = 1;
        endif;
      endif;
      ch = %subst(buf:x:1);
      if ch >= x'41' and ch <= x'FE';
        if %len(word) < %len(word:*max);
          word += ch;
        endif;
      else;
        if word <> '';
          rm_insx1(m :rm_a(word) :rm_i(1+rm_i_(rm__a(m:word))) );
        endif;
        word = '';
      endif;
      x += 1;
    enddo;
  endif;
  ifs_close(fd);
  m2 = rm_m();
  c = rm_setll(rm_cur(m));
  dow rm_read_next(c);
    rm_insert_1(m2 :rm_v( rm_(rm_cpy(rm_item(c))) :rm_cpy(rm_key(c)) ) );
  enddo;
  rm_dispose(c);
  c = rm_setll(rm_cur(m2));
  dow rm_read_next(c);
    display(%char(rm_i_(rm__i(rm_key(c):1))) + ': ' + rm_a_(rm__i(rm_key(c):2)) );
  enddo;
  rm_dispose(m:m2);

  display('17a:');
  m = rm_m(
    rm_a('zza':2) : rm_i(1) :
    rm_a('Zza':2) : rm_i(2) :
    rm_a('Bdfee':2) : rm_i(3) :
    rm_a('hhhhhh':2) : rm_i(4) :
    rm_a('bdfe':2) : rm_i(5) );
  c = rm_setll(rm_cur(m));
  dow rm_read_next(c);
    display(rm_a_(rm_key(c)));
  enddo;
  rm_dispose(m);

  display('17b:');
  m = rm_m(
    rm_s('zza':2) : rm_i(1) :
    rm_s('Zza':2) : rm_i(2) :
    rm_s('Bdfee':2) : rm_i(3) :
    rm_s('hhhhhh':2) : rm_i(4) :
    rm_s('bdfe':2) : rm_i(5) );
  c = rm_setll(rm_cur(m));
  dow rm_read_next(c);
    display(rm_s_(rm_key(c)));
  enddo;
  rm_dispose(m);

end-proc;



dcl-proc cerrno;
dcl-pi *n int(10);
end-pi;

  dcl-pr errno pointer extproc('__errno');
  end-pr;

  dcl-s v int(10) based(vp);

  vp = errno();
  return v;

end-proc;



dcl-proc display;
dcl-pi *n;
  text varchar(500) value;
end-pi;
  dcl-s t char(52);
  t = text;
  dsply t;
end-proc;

