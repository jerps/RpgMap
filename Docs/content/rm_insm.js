document.write('\
\
<div id="rm_insm"><div class="prochdr1">rm_insm</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Insert key/item pairs, from map</div></div>\
<pre class="proclongnm">rm_insert_map</pre>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
map  pointer value<br>\
map2 pointer value<br>\
key1 pointer value options(*nopass)<br>\
key2 pointer value options(*nopass)<br>\
</pre>\
<p>\
Like <a href="#rm_ins"><code>rm_ins</code></a>, but the key/item pairs to insert are contained in <code>map2</code>.<br>\
The values and automatically disposed maps in <code>map2</code> that are to be \
inserted are not inserted directly, but instead a copy is made (<a href="#rm_cpy"><code>rm_cpy</code></a>) \
that is actually inserted. Manually disposed maps are not copied; they\'re \
inserted directly.<br>\
If <code>key1</code> and/or <code>key2</code> are passed and not <code>*null</code> then only the key/item \
pairs in <code>map2</code> with key equal to or greater than <code>key1</code>, and equal to \
or less than <code>key2</code>, will be inserted. Both keys are optional. If <code>key1</code> \
is not passed or <code>*null</code> it\'s assumed to be the lowest key. If <code>key2</code> is \
not passed it\'s assumed to be the same as <code>key1</code> (if <code>key1</code> is passed). \
If <code>key2</code> is <code>*null</code> it\'s assumed to be the highest key. Nothing is \
inserted if <code>key1</code> is greater than <code>key2</code>, or if only <code>key1</code> is passed \
with value <code>*null</code>.<br>\
This procedure disposes <code>key1</code> and <code>key2</code> automatically, unless \
<code>key1</code>/<code>key2</code> is a manually disposed map, or a value/map contained \
in a map.<br>\
This procedure does not dispose <code>map2</code> or it\'s keys/items.\
</p>\
\
');