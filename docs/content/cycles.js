document.write('\
\
<h2 id="cycles">Cycles</h2>\
<br>\
<p>\
When inserting maps into other maps cycles may be created. For example, when <code>map1</code> contains <code>map2</code> \
which contains <code>map1</code> again.\
</p>\
<p>\
RpgMap does not detect cycles. Care should be taken to avoid them. If a cycle is \
created then that will likely result in corruption and/or a stack overflow error.\
</p>\
\
');
