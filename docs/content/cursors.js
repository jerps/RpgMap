document.write('\
\
<h2 id="cursors">Cursors</h2>\
<br>\
<p>\
Cursors are used to iterate through the key/item pairs of a map. A cursor maintains a current position \
within the key/item pairs of a map. A cursor must first be created with <a href="#rm_cursor"><code>rm_cursor</code></a>.\
</p>\
<p>\
A cursor\'s position can be set with set lower limit, <a href="#rm_setll"><code>rm_setll</code></a>, or \
set greater than, <a href="#rm_setgt"><code>rm_setgt</code></a>. Procedures <a href="#rm_read_next"><code>rm_read_next</code></a> \
and <a href="#rm_read_prev"><code>rm_read_prev</code></a> must be used to read the next or previous key/item pair. \
Procedures <a href="#rm_key"><code>rm_key</code></a> and <a href="#rm_item"><code>rm_item</code></a> \
must be used to read the current key and item.\
</p>\
<p>\
A cursor must be disposed with <a href="#rm_dispose"><code>rm_dispose</code></a>, or it is automatically \
disposed when it\'s associated map is disposed.\
</p>\
<p>\
See <a href="#example_2">example 2</a> and <a href="#example_3">example 3</a>.\
</p>\
<p>\
Procedure <a href="#rm_for_each_do"><code>rm_for_each_do</code></a> can also be used to iterate through key/item pairs. It uses \
a cursor under the covers.\
</p>\
\
');
