document.write('\
\
<div id="rm_num"><div class="prochdr1">rm_num</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Number of key/item pairs</div></div>\
<pre class="proclongnm">rm_num_keys</pre>\
<pre class="procsig">\
&lt;&lt;uns(20)<br>\
map  pointer value<br>\
key1 pointer value options(*nopass)<br>\
key2 pointer value options(*nopass)<br>\
</pre>\
<p>\
Return the number of key/item pairs in <code>map</code> with key equal to or \
greater than <code>key1</code>, and equal to or less than <code>key2</code>. Both keys \
are optional. If <code>key1</code> is not passed or <code>*null</code> it\'s assumed to be \
the lowest key. If <code>key2</code> is not passed it\'s assumed to be the same \
as <code>key1</code> (if <code>key1</code> is passed). If <code>key2</code> is <code>*null</code> it\'s assumed to \
be the highest key. Return <code>0</code> if <code>key1</code> is greater than <code>key2</code>, or \
only <code>key1</code> is passed with value <code>*null</code>.<br>\
This procedure is not efficient. Unless both keys are <code>*null</code> or not \
passed (i.e. all key/item pairs) it counts the number of keys each \
time it\'s called (no caching).<br>\
This procedure disposes <code>key1</code> and <code>key2</code> automatically, unless \
<code>key1</code>/<code>key2</code> is a manually disposed map, or a value/map contained \
in a map.\
</p>\
\
');