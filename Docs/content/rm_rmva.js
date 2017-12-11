document.write('\
\
<div id="rm_rmva"><div class="prochdr1">rm_rmva</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Remove all key/item pairs</div></div>\
<pre class="proclongnm">rm_remove_all</pre>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
map  pointer value<br>\
key1 pointer value options(*nopass)<br>\
key2 pointer value options(*nopass)<br>\
</pre>\
<p>\
Like <a href="#rm_rmv"><code>rm_rmv</code></a>, but all key/item pairs with key equal to or greater \
than <code>key1</code>, and equal to or less than <code>key2</code> are removed from <code>map</code>.<br>\
Both keys are optional. If <code>key1</code> is not passed or <code>*null</code> it\'s assumed \
to be the lowest key. If <code>key2</code> is not passed it\'s assumed to be the \
same as <code>key1</code> (if <code>key1</code> is passed). If <code>key2</code> is <code>*null</code> it\'s assumed \
to be the highest key. Remove nothing if <code>key1</code> is greater than <code>key2</code>, \
or if only <code>key1</code> is passed with value <code>*null</code>.<br>\
This procedure disposes <code>key1</code> and <code>key2</code> automatically, unless \
<code>key1</code>/<code>key2</code> is a manually disposed map, or a value/map contained in \
a map.\
</p>\
\
');