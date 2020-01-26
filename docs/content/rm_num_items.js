document.write('\
\
<div id="rm_num_items"><div class="prochdr1">rm_num_items</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Number of items</div></div>\
<pre class="procsig">\
&lt;&lt;uns(20)<br>\
map  pointer value<br>\
item pointer value<br>\
key1 pointer value options(*nopass)<br>\
key2 pointer value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Return the number of items in <code>map</code> that are equal to <code>item</code>.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Items are always compared using the default compare function <a href="#rm_compare"><code>rm_compare</code></a>.<br>\
<span class="bullet1">&#9679;</span>&nbsp;If <code>key1</code> and/or <code>key2</code> are passed and not <code>*null</code> then only the items with \
keys equal to or greater than <code>key1</code>, and equal to or less than <code>key2</code>, \
will be considered. Both keys are optional. If <code>key1</code> is not passed or <code>*null</code> \
it\'s assumed to be the lowest key. If <code>key2</code> is not passed it\'s assumed to be \
the same as <code>key1</code> (if </code>key1</code> is passed). If <code>key2</code> is <code>*null</code> it\'s assumed to \
be the highest key. Return <code>0</code> if <code>key1</code> is greater than <code>key2</code>, or if only \
<code>key1</code> is passed with value <code>*null</code>.<br>\
<span class="bullet1">&#9679;</span>&nbsp;This procedure disposes <code>item</code>, <code>key1</code> and <code>key2</code> automatically, unless they\'re \
a manually disposed map, or a value/map contained in a map.\
</p>\
\
');
