document.write('\
\
<h2 id="cycles">Cycles</h2>\
<p>\
When inserting maps into other maps cycles may be created. For example when map1 contains map2 which \
contains map1 again.\
</p>\
<p>\
RpgMap does not detect cycles. Care should be taken to avoid them. If a cycle is \
created then that will likely result in a stack overflow error.\
</p>\
\
');