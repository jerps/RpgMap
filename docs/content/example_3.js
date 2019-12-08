document.write('\
\
<h2 id="example_3">Example 3</h2>\
<br>\
<p>\
The following map represents three loans. Each loan has several attributes such as client \
name, amount, total payed. A loan can have registered payments, and a call log.\
<p>\
<pre class="pcode">\
map = rm_m(<br>\
<br>\
  rm_v( rm_d(d\'2017-01-01\') : rm_i(1) )   : rm_m(<br>\
    rm_a(\'client name\') : rm_s(\'fransen\') :<br>\
    rm_a(\'amount\')      : rm_p(100.90)    :<br>\
    rm_a(\'payed\')       : *null           :<br>\
    rm_a(\'creditstop\')  : rm_n(*on) )<br>\
  :<br>\
  rm_v( rm_d(d\'2017-05-01\') : rm_i(1) )   : rm_m(<br>\
    rm_a(\'client name\') : rm_s(\'piet\')    :<br>\
    rm_a(\'amount\')      : rm_p(50.00)     :<br>\
    rm_a(\'payed\')       : rm_p(20.00)     :<br>\
    rm_a(\'creditstop\')  : rm_n(*off)      :<br>\
    rm_a(\'payments\')    : rm_m(<br>\
      rm_z(z\'2017-05-05-16.15.00\') : rm_p(15.00) :<br>\
      rm_z(z\'2017-05-12-12.00.00\') : rm_p(5.00) ) )<br>\
  :<br>\
  rm_v( rm_d(d\'2017-05-01\') : rm_i(2) )   : rm_m(<br>\
    rm_a(\'client name\') : rm_s(\'jan\')     :<br>\
    rm_a(\'amount\')      : rm_p(200.00)    :<br>\
    rm_a(\'payed\')       : rm_p(10.50)     :<br>\
    rm_a(\'creditstop\')  : rm_n(*off)      :<br>\
    rm_a(\'payments\')    : rm_m(<br>\
      rm_z(z\'2017-05-10-10.00.00\') : rm_p(10.50) ) :<br>\
    rm_a(\'call log\')    : rm_m(<br>\
      rm_z(z\'2017-05-12-15.10.00\') : rm_v(<br>\
        rm_t(t\'00.10.05\') : rm_s(\'+1-202-555-0195\') : rm_s(\'+<br>\
        promised to pay 50 next week\') ) :<br>\
      rm_z(z\'2017-05-23-11.30.00\') : rm_v(<br>\
        rm_t(t\'00.02.00\') : rm_s(\'+1-202-555-0195\') : rm_s(\'+<br>\
        pays tomorrow\') ) ) )<br>\
);<br>\
</pre>\
<p>\
The following code displays each loan\'s client name, all payments, and total call time, \
from 2017-05-01.\
</p>\
<pre class="pcode">\
cur1 = rm_setll(rm_cur(map):rm_v(rm_d(d\'2017-05-01\')));<br>\
dow rm_read_next(cur1);<br>\
  k = rm_key(cur1);<br>\
  i = rm_item(cur1);<br>\
  display(rm_s_(rm__a(i:\'client name\')) + \':\');<br>\
  m = rm__a(i:\'payments\');<br>\
  if m <> *null;<br>\
    display(\'  payments:\');<br>\
    cur2 = rm_cur(m);<br>\
    dow rm_read_next(cur2);<br>\
      display(\'    \' + %char(rm_z_(rm_key(cur2))) +</br>\
              \': \'   + %char(rm_p_(rm_item(cur2))));<br>\
    enddo;<br>\
    rm_dispose(cur2);<br>\
  endif;<br>\
  m = rm__a(i:\'call log\');<br>\
  if m <> *null;<br>\
    x = 0;<br>\
    cur2 = rm_cur(m);<br>\
    dow rm_read_next(cur2);<br>\
      x += %diff(rm_t_(rm__i(rm_item(cur2):1)):t\'00.00.00\':*minutes);<br>\
    enddo;<br>\
    rm_dispose(cur2);<br>\
    display(\'  call time: \' + %char(x));<br>\
  endif;<br>\
enddo;<br>\
rm_dispose(map);<br>\
</pre>\
<br>\
<pre class="console">\
DSPLY  piet:<br>\
DSPLY    payments:<br>\
DSPLY      2017-05-05-16.15.00.000000: 15.0000<br>\
DSPLY      2017-05-12-12.00.00.000000: 5.0000<br>\
DSPLY  jan:<br>\
DSPLY    payments:<br>\
DSPLY      2017-05-10-10.00.00.000000: 10.5000<br>\
DSPLY    call time: 12<br>\
</pre>\
\
');
