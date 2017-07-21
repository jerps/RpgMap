**FREE

ctl-opt main(Main) ccsid(*exact) bnddir('_TLIB_/RPGMAP');


/include _TLIB_/INCLUDERPG,RPGMAP


dcl-proc Main;

  dcl-s map pointer;
  dcl-s maploans pointer;
  dcl-s cur pointer;
  dcl-s cur1 pointer;
  dcl-s cur2 pointer;
  dcl-s k pointer;
  dcl-s i pointer;
  dcl-s m pointer;
  dcl-s v pointer;
  dcl-s v2 pointer;
  dcl-s c pointer;
  dcl-s d date;
  dcl-s x int(10);
  dcl-s y int(10);
  
  display('1:');
  map = rm_ins(rm_mm():
    rm_v(rm_i(2):rm_i(1)):rm_p(20.1):
    rm_v(rm_i(1):rm_i(1)):rm_p(10.1):
    rm_v(rm_i(3):rm_i(2)):rm_p(30.2):
    rm_v(rm_i(3):rm_i(1)):rm_p(30.1):
    rm_v(rm_i(1):rm_i(3)):rm_p(10.3):
    rm_v(rm_i(2)):rm_p(20));
  display(%char(rm_num(map)));
  cur = rm_sll(rm_cur(map):rm_v(rm_i(2)));
  rm_rmv(rm_rmv(map:rm_v(rm_i(2))):rm_v(rm_i(2):rm_i(1)));
  dow rm_rdn(cur);
    display(%char(rm_i_(rm__i(rm_key(cur):2))) + ', ' + %char(rm_p_(rm_itm(cur))));
  enddo;
  rm_sgt(cur);
  dow rm_rdp(cur);
    display(%char(rm_p_(rm_itm(cur))));
  enddo;
  rm_dis(map);
  
  display('2:');
  map = rm_mm(
    rm_d(d'2001-01-01') : rm_v( rm_t(t'10.15.00') : rm_p(100.3) ) :
    rm_d(d'2002-04-01') : rm_v( rm_t(t'19.10.00') : rm_p(50.3) ) :
    rm_d(d'2002-05-01') : rm_v( rm_t(t'05.00.00') : rm_p(20.25) ) :
    rm_d(d'2002-05-05') : rm_v( rm_t(t'20.30.00') : rm_p(90) ) );
  cur = rm_sgt(rm_cur(map):rm_z(z'2002-04-30-00.00.00'));
  dow rm_rdp(cur);
    display(%char(rm_d_(rm_key(cur))) + ', ' + (%char(rm_p_(rm__i(rm_itm(cur):2)))));
  enddo;
  rm_dis(map);
  
  display('3:');
  map = rm_mm(
    rm_aa('abc')  : rm_i(1) :
    rm_aa('ABC')  : rm_i(2) :
    rm_aa('xx')   : rm_i(3) :
    rm_aa('hik')  : rm_i(4) :
    rm_aa('tram') : rm_i(5) :
    rm_aa('Tram') : rm_i(6) );
  cur = rm_cur(map);
  dow rm_rdn(cur);
    display(rm_a_(rm_key(cur)) + ':' + %char(rm_i_(rm_itm(cur))));
  enddo;
  rm_dis(map);
  
  display('4a:');
  map = rm_mm(
    rm_s('abc')  : rm_i(1) :
    rm_s('ABC')  : rm_i(2) :
    rm_s('xx')   : rm_i(3) :
    rm_s('hik')  : rm_i(4) :
    rm_s('tram') : rm_i(5) :
    rm_s('Tram') : rm_i(6) );
  cur = rm_cur(map);
  dow rm_rdn(cur);
    display(rm_s_(rm_key(cur)) + ':' + %char(rm_i_(rm_itm(cur))));
  enddo;
  rm_dis(map);
  
  display('4b:');
  map = rm_mm(
    rm_sa('abc')  : rm_i(1) :
    rm_sa('ABC')  : rm_i(2) :
    rm_sa('xx')   : rm_i(3) :
    rm_sa('hik')  : rm_i(4) :
    rm_sa('tram') : rm_i(5) :
    rm_sa('Tram') : rm_i(6) );
  cur = rm_cur(map);
  dow rm_rdn(cur);
    display(rm_s_(rm_key(cur)) + ':' + %char(rm_i_(rm_itm(cur))));
  enddo;
  rm_dis(map);

  display('5:');
  maploans = rm_mm(

    rm_v( rm_d(d'2017-01-01') : rm_i(1) ) : rm_m(
      rm_a('client name') : rm_s('fransen') :
      rm_a('amount')      : rm_p(100.90) :
      rm_a('payed')       : *null :
      rm_a('creditstop')  : rm_n(*on) ) :
  
    rm_v( rm_d(d'2017-05-01') : rm_i(1) ) : rm_m(
      rm_a('client name') : rm_s('piet') :
      rm_a('amount')      : rm_p(50.00) :
      rm_a('payed')       : rm_p(20.00) :
      rm_a('creditstop')  : rm_n(*off) :
      rm_a('payments')    : rm_m(
        rm_z(z'2017-05-05-16.15.00') : rm_p(15.00) :
        rm_z(z'2017-05-12-12.00.00') : rm_p(5.00) ) ) :
  
    rm_v( rm_d(d'2017-05-01') : rm_i(2) ) : rm_m(
      rm_a('client name') : rm_s('jan') :
      rm_a('amount')      : rm_p(200.00) :
      rm_a('payed')       : rm_p(10.50) :
      rm_a('creditstop')  : rm_n(*off) :
      rm_a('payments')    : rm_m(
        rm_z(z'2017-05-10-10.00.00') : rm_p(10.50) ) :
      rm_a('call log')    : rm_m(
        rm_z(z'2017-05-12-15.10.00') : rm_v(
          rm_t(t'00.10.05') : rm_s('+1-202-555-0195') : rm_s('+ 
          promised to pay 50 next week') ) :
        rm_z(z'2017-05-23-11.30.00') : rm_v(
          rm_t(t'00.02.00') : rm_s('+1-202-555-0195') : rm_s('+ 
          pays tomorrow') ) ) )
  );
  map = rm_cpyd(maploans);
  rm_dis(maploans);
  maploans = rm_cpyd(map);
  rm_dis(map);
  // display each loan's client name, all payments, and total call time, from 2017-05-01
  cur1 = rm_sll(rm_cur(maploans):rm_v(rm_d(d'2017-05-01')));
  dow rm_rdn(cur1);  
    k = rm_key(cur1);
    i = rm_itm(cur1);  
    display(rm_s_(rm__a(i:'client name')) + ':');
    m = rm__a(i:'payments');
    if m <> *null;
      display('  payments:');
      cur2 = rm_cur(m);
      dow rm_rdn(cur2);
        display('    ' + %char(rm_z_(rm_key(cur2))) + ': ' + %char(rm_p_(rm_itm(cur2))));
      enddo;
      rm_dis(cur2);
    endif;
    m = rm__a(i:'call log');
    if m <> *null;
      x = 0;
      cur2 = rm_cur(m);
      dow rm_rdn(cur2);
        x += %diff(rm_t_(rm__i(rm_itm(cur2):1)):t'00.00.00':*minutes);
      enddo;
      rm_dis(cur2);
      display('  call time: ' + %char(x));
    endif; 
  enddo;

  display('6:');
  map = rm_mm(
    rm_i(1) : rm_i(1) :
    rm_i(2) : rm_i(2) :
    rm_i(2) : rm_i(2) :
    rm_i(3) : rm_i(3) );
  rm_insx(map:rm_i(2):rm_i(100));
  cur = rm_cur(map);
  dow rm_rdn(cur);
    display(%char(rm_i_(rm_key(cur))) + ': ' + %char(rm_i_(rm_itm(cur))));
  enddo;
  rm_dis(map);

  display('7:');
  map = rm_ins(rm_cpy(maploans:rm_v(rm_d(d'2017-01-01'):rm_i(1))):
    rm_v( rm_d(d'2017-01-01') : rm_i(2) ) : rm_m(
      rm_a('client name') : rm_s('jansen') :
      rm_a('amount')      : rm_p(250.00) :
      rm_a('payed')       : rm_p(250.00) :
      rm_a('creditstop')  : rm_n(*off) ) );
  // display client name and payed.
  cur1 = rm_sll(rm_cur(map));
  dow rm_rdn(cur1);  
    m = rm_itm(cur1);
    display(rm_s_(rm__a(m:'client name')) + ': ' + %char(rm_p_(rm__a(m:'payed'))));
  enddo;
  rm_dis(map);

  display('8:');
  map = rm_cpy(maploans:rm_v(rm_d(d'2017-05-01')));
  // display client name and payed.
  cur1 = rm_sll(rm_cur(map));
  dow rm_rdn(cur1);  
    m = rm_itm(cur1);
    display(rm_s_(rm__a(m:'client name')) + ': ' + %char(rm_p_(rm__a(m:'payed'))));
  enddo;
  rm_dis(map);

  display('9:');
  // display client name and payed, 2017-05-01
  cur1 = rm_sgt(rm_cur(maploans):rm_v(rm_d(d'2017-05-01')));
  dow rm_rdp(cur1:rm_v(rm_d(d'2017-05-01')));  
    m = rm_itm(cur1);
    display(rm_s_(rm__a(m:'client name')) + ': ' + %char(rm_p_(rm__a(m:'payed'))));
  enddo;
  
  display('10:');
  v = rm_s('¡ ¢ £ ¤ ¥ ¦ § ¨ © ª « ¬ ­ ® ¯ ° ± ² ³ ´ µ ¶ · ¸ ¹ º » ¼ ½ ¾ ¿');
  display(rm_s_(v));
  display(rm_a_(v));
  rm_dis(v);
  v = rm_sab(x'cfbecfbf');
  v2 = rm_sab(x'c2a9c2ae');
  display(rm_s_(v));
  display(rm_a_(v));
  display(%char(rm_cmp(v:v2)));
  rm_dis(v:v2);
  v = rm_sb(x'c2a9c2ae');
  display(rm_s_(v));
  display(rm_a_(v));
  rm_dis(v);
  
  display('11:');
  map = rm_m();
  for x = 1 to 10;
    rm_ins(map:rm_i2(x):rm_v(rm_p3(x*2):rm_p3(x*3)));
  endfor;
  v = rm_fed(map:%paddr(rm_fed_proc_11):rm_i(0));
  display(%char(rm_i_(v)));
  rm_dis(map:v);

  display('12:');
  map = rm_m();
  rm_scf(map:%paddr(rm_comp_12));
  for x = 1 to 1000;
    rm_ins1(map:rm_i(x):rm_i(x));
  endfor;
  c = rm_sll(rm_cur(map):rm_i(990));
  dow rm_rdn(c:*null:rm_i(985));
    display(%char(rm_i_(rm_key(c))));
  enddo;
  rm_dis(map);

  display('13:');
  map = rm_m();
  for x = 1 to 1000;
    rm_ins1(map:rm_i(x:0):rm_i(x));
  endfor;
  c = rm_sll(rm_cur(map):rm_i(990));
  dow rm_rdn(c:*null:rm_i(985));
    display(%char(rm_i_(rm_key(c))));
  enddo;
  rm_dis(map);

  display('14:');
  map = rm_m();
  d = d'2017-01-01';
  y = 0;
  for x = 1 to 100;
    if %rem(x:10) = 0;
      d += %days(1);
      y = 0;
    endif;
    y += 1;
    rm_ins1(map :rm_v( rm_d(d) :rm_i(y:0) ) );
  endfor;
  c = rm_cur(map);
  dow rm_rdn(c);
    display(%char(rm_d_(rm__i(rm_key(c):1)))+': '+%char(rm_i_(rm__i(rm_key(c):2))));
  enddo;
  rm_dis(c);
  m = rm_cpy(map :rm_v( rm_d(d'2017-01-05') ) );
  c = rm_cur(m);
  dow rm_rdn(c);
    display(%char(rm_d_(rm__i(rm_key(c):1)))+': '+%char(rm_i_(rm__i(rm_key(c):2))));
  enddo;
  rm_dis(m:map);

  display('14:');
  map = rm_m();
  d = d'2017-01-01';
  y = 0;
  for x = 1 to 100;
    if %rem(x:10) = 0;
      d += %days(1);
      y = 0;
    endif;
    y += 1;
    rm_ins1(map :rm_v( rm_d(d) :rm_i(y:0) ) );
  endfor;
  c = rm_cur(map);
  dow rm_rdn(c);
    display(%char(rm_d_(rm__i(rm_key(c):1)))+': '+%char(rm_i_(rm__i(rm_key(c):2))));
  enddo;
  rm_dis(c);
  m = rm_cpy(map :rm_v( rm_d(d'2017-01-05') ) );
  c = rm_cur(m);
  dow rm_rdn(c);
    display(%char(rm_d_(rm__i(rm_key(c):1)))+': '+%char(rm_i_(rm__i(rm_key(c):2))));
  enddo;
  rm_dis(m);
  rm_dis(map);
  
  rm_dis(maploans);

end-proc;


dcl-proc rm_fed_proc_11;
dcl-pi *n pointer;
  k pointer value;
  i pointer value;
  d pointer value;
  s ind;
end-pi;
  
  dcl-s d2 pointer;

  d2 = rm_p3( rm_p3_(d) + ( rm_p3_(rm__i(i:2)) - rm_p3_(rm__i(i:1)) ) );
  rm_dis(d);
  return d2;
  
end-proc;

dcl-proc rm_comp_12;
dcl-pi *n int(10);
  obj1 pointer value;
  obj2 pointer value;
end-pi;
  
  return rm_cmp(obj1:obj2) * -1;
  
end-proc;




dcl-proc display;
dcl-pi *n;
  text varchar(500) value;
end-pi;
  dcl-s t char(52);
  t = text;
  dsply t;
end-proc;
