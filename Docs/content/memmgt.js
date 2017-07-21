document.write('\
\
<h2 id="memmgt">Memory Management</h2>\
<p>\
Values are created, and inserted into maps as keys and items, and/or used as arguments \
such as keys. They must be disposed (released, deallocated) when they\'re not used \
anymore. Procedure <a href="#rm_dis"><code>rm_dis</code></a> must be used to dispose \
values, maps and cursors.\
</p>\
<p>\
Values are automatically disposed. That means that when they\'re inserted in a map as key or item \
and the map is disposed or the key/item is removed from the map then the value is disposed. \
When a value is used as an argument, e.g. a key with <a href="#rm_get"><code>rm_get</code></a>, \
and the value is not in a map, then the value is also disposed. Usually there is no need to \
dispose values with <a href="#rm_dis"><code>rm_dis</code></a>; most of the time values are \
disposed automatically.\
</p>\
<p>\
<strong>The documentation of each procedure clearly states whether any arguments are automatically \
disposed.</strong>\
</p>\
<p>\
Because a value is automatically disposed it can not be inserted into more than one map.\
</p>\
<p>\
Just like values, maps are created and must be disposed too. To make this somewhat easier, \
a map is either automatically disposed (created with <a href="#rm_m"><code>rm_m</code></a>) just like a \
value, or it is manually disposed (created with <a href="#rm_mm"><code>rm_mm</code></a>). An automatically \
disposed map is governed by the same memory management rules as a value. It\'s disposed when \
the containing map is disposed or when the map is removed from the map, or when it has been \
used as an argument and is not in a map.\
</p>\
<p>\
An automatically disposed map can not be inserted into more than one map.\
</p>\
<p>\
A manually disposed map must always be manually disposed with <a href="#rm_dis"><code>rm_dis</code></a>, \
but unlike an automatically disposed map a manually disposed map can be inserted into more than one map.\
</p>\
<p>\
A value or an automatically disposed map that has been inserted into a map can not be disposed \
with <a href="#rm_dis"><code>rm_dis</code></a>.\
</p>\
<p>\
When a map is copied (<a href="#rm_cpy"><code>rm_cpy</code></a>) the copy contains a copy of the \
values and automatically disposed maps in the original. Manually disposed maps are only copied \
when a deep copy is made (<a href="#rm_cpyd"><code>rm_cpyd</code></a>).\
</p>\
<p>\
When keys/items are inserted from a map (e.g. <a href="#rm_insm"><code>rm_insm</code></a>) then \
a copy of the values and automatically disposed maps is inserted.\
</p>\
\
');