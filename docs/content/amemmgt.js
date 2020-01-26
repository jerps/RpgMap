document.write('\
\
<h2 id="amemmgt">Automatic Memory Management</h2>\
<br>\
<p>\
Maps and values must be disposed at some time to free the used memory and not cause memory leaks. \
To help with that RpgMap implements some simple rules that govern automatic disposal of maps and values.\
</p>\
<p>\
Procedure <a href="#rm_dispose"><code>rm_dispose</code></a> is used to explicitly dispose values, maps and cursors.\
</p>\
<p>\
Every data type has a <code>rm_??__</code> procedure (two trailing underscores) to dispose a value immediately \
after <a href="#mapval">unwrapping</a>.\
</p>\
<p>\
<span class="bullet1">&#9679;</span><span class="bullet1">&#9679;</span><span class="bullet1">&#9679;</span>&nbsp;<strong>When a value is inserted in a map as key or item and the map is disposed, or <u>the value is removed \
from a map</u>, then the value is disposed</strong>.<br>\
<br>\
<span class="bullet1">&#9679;</span><span class="bullet1">&#9679;</span><span class="bullet1">&#9679;</span><strong>&nbsp;When a value is used as an argument, e.g. as a key when calling <a href="#rm_get"><code>rm_get</code></a>, \
and the value has not been inserted into a map then the value is immediately disposed after being used</strong>.<br>\
<p>\
Because a value is automatically disposed it can not be inserted into more than one map.\
</p>\
<p>\
Maps come in mainly two flavors: automatically (<a href="#rm_m"><code>rm_m</code></a>) or manually (<a href="#rm_mm"><code>rm_mm</code></a>) disposed.\
</p>\
<p>\
<span class="bullet1">&#9679;</span><span class="bullet1">&#9679;</span><span class="bullet1">&#9679;</span>&nbsp;<strong>Automatically disposed maps are governed by the same memory management rules as values</strong>.<br>\
</p>\
<p>\
Like values, automatically disposed maps are disposed when their containing map is disposed or when they\'re removed \
from a map, or when they\'ve been used as an argument and are not contained in a map.\
</p>\
<p>\
An automatically disposed map can not be inserted into more than one map.\
</p>\
<p>\
The documentation of procedures accepting automatically disposed maps are values as arguments clearly state whether \
any arguments will be disposed.\
</p>\
<p>\
A manually disposed map must always be explicitly disposed with <a href="#rm_dispose"><code>rm_dispose</code></a>. \
But unlike an automatically disposed map a manually disposed map can be inserted into more than one map.\
</p>\
<p>\
A value or an automatically disposed map that has been inserted into a map can not be explicitly disposed \
with <a href="#rm_dispose"><code>rm_dispose</code></a>, or with one of the <code>rm_??__</code> procedures.\
</p>\
<p>\
When a map is copied (<a href="#rm_copy"><code>rm_copy</code></a>) the copy contains a copy of the \
values and automatically disposed maps in the original. Manually disposed maps are only copied \
when a deep copy is made (<a href="#rm_copy_deep"><code>rm_copy_deep</code></a>).\
</p>\
<p>\
Similar to copying a map, when keys/items are inserted from a map (e.g. <a href="#rm_insert_map"><code>rm_insert_map</code></a>) then \
only manually disposed maps are directly inserted, while a copy of the values and automatically disposed \
maps is inserted.\
</p>\
<p>\
An automatically disposed map (not a vector) can be made manually disposed with <a href="#rm_make_map_man_disp"><code>rm_make_map_man_disp</code></a>, \
but not vice versa.\
</p>\
\
');
