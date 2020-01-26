document.write('\
\
<div id="rm_insert_map"><div class="prochdr1">rm_insert_map</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Insert key/item pairs, from map</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
map  pointer value<br>\
map2 pointer value<br>\
key1 pointer value options(*nopass)<br>\
key2 pointer value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Like <a href="#rm_insert"><code>rm_insert</code></a>, but the key/item pairs to insert are contained in <code>map2</code>.<br>\
<span class="bullet1">&#9679;</span>&nbsp;The values and automatically disposed maps in <code>map2</code> that are to be \
inserted are not inserted directly, but instead a copy is made (<a href="#rm_copy"><code>rm_copy</code></a>) \
that is actually inserted. Manually disposed maps are not copied; they\'re \
inserted directly.<br>\
<span class="bullet1">&#9679;</span>&nbsp;If <code>key1</code> and/or <code>key2</code> are passed and not <code>*null</code> then only the key/item \
pairs in <code>map2</code> with key equal to or greater than <code>key1</code>, and equal to \
or less than <code>key2</code>, will be inserted. Both keys are optional. If <code>key1</code> \
is not passed or <code>*null</code> it\'s assumed to be the lowest key. If <code>key2</code> is \
not passed it\'s assumed to be the same as <code>key1</code> (if <code>key1</code> is passed). \
If <code>key2</code> is <code>*null</code> it\'s assumed to be the highest key. Nothing is \
inserted if <code>key1</code> is greater than <code>key2</code>, or if only <code>key1</code> is passed \
with value <code>*null</code>.<br>\
<span class="bullet1">&#9679;</span>&nbsp;This procedure disposes <code>key1</code> and <code>key2</code> automatically, unless \
<code>key1</code>/<code>key2</code> is a manually disposed map, or a value/map contained \
in a map.<br>\
<span class="bullet1">&#9679;</span>&nbsp;This procedure does not dispose <code>map2</code> or it\'s keys/items.\
</p>\
\
');
