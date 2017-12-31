document.write('\
\
<h2 id="cursors">Cursors</h2>\
<br>\
<p>\
Cursors are used to iterate through the key/item pairs of a map. A cursor maintains a current position \
within the key/item pairs of a map. A cursor must first be created with <a href="#rm_cur"><code>rm_cur</code></a>.\
</p>\
<p>\
A cursor\'s position can be set with set-lower-limit, <a href="#rm_sll"><code>rm_sll</code></a>, or \
set-greater-than, <a href="#rm_sgt"><code>rm_sgt</code></a>. Procedures <a href="#rm_rdn"><code>rm_rdn</code></a> \
and <a href="#rm_rdp"><code>rm_rdp</code></a> must be used to read the next or previous key/item pair. \
Procedures <a href="#rm_key"><code>rm_key</code></a> and <a href="#rm_itm"><code>rm_itm</code></a> \
must be used to read the current key and item.\
</p>\
<p>\
A cursor must be disposed with <a href="#rm_dis"><code>rm_dis</code></a>, or it is automatically \
disposed when it\'s associated map is disposed.\
</p>\
<p>\
See <a href="#example_2">example 2</a> and <a href="#example_3">example 3</a>.\
</p>\
<p>\
Procedure <a href="#rm_fed">rm_fed</a> can also be used to iterate through key/item pairs. It uses \
a cursor under the covers.\
</p>\
\
');
