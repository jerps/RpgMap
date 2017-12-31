document.write('\
\
<div id="rm_gik"><div class="prochdr1">rm_gik</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Get item key</div></div>\
<pre class="proclongnm">rm_get_item_key</pre>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
map  pointer  value<br>\
item pointer  value<br>\
opt  char(10) value options(*nopass)<br>\
key1 pointer  value options(*nopass)<br>\
key2 pointer  value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#8407;</span>&nbsp;Return the key of the item in <code>map</code> that is equal to <code>item</code>.<br>\
<span class="bullet1">&#8407;</span>&nbsp;A slow linear search is performed.<br>\
<span class="bullet1">&#8407;</span>&nbsp;Items are always compared using the default compare function <a href="#rm_cmp"><code>rm_cmp</code></a>.<br>\
<span class="bullet1">&#8407;</span>&nbsp;In case there are multiple items equal to <code>item</code> then <code>opt</code> indicates \
which item: <code>\'*f\'</code> or <code>\'*first\'</code> for the first one (which is the default), \
or <code>\'*l\'</code> or <code>\'*last\'</code> for the last one (key order). Using <code>\'*f\'</code>/<code>\'*first\'</code> or \
<code>\'*l\'</code>/<code>\'*last\'</code> makes no difference in performance.</br>\
<span class="bullet1">&#8407;</span>&nbsp;If <code>key1</code> and/or <code>key2</code> are passed and not <code>*null</code> then only the items with \
keys equal to or greater than <code>key1</code>, and equal to or less than <code>key2</code>, \
will be considered. Both keys are optional. If <code>key1</code> is not passed or <code>*null</code> \
it\'s assumed to be the lowest key. If <code>key2</code> is not passed it\'s assumed to be \
the same as <code>key1</code> (if </code>key1</code> is passed). If <code>key2</code> is <code>*null</code> it\'s assumed to \
be the highest key. Return <code>*null</code> if <code>key1</code> is greater than <code>key2</code>, or if only \
<code>key1</code> is passed with value <code>*null</code>.<br>\
<span class="bullet1">&#8407;</span>&nbsp;This procedure disposes <code>item</code>, <code>key1</code> and <code>key2</code> automatically, unless they\'re \
a manually disposed map, or a value/map contained in a map.\
</p>\
\
');
