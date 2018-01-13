document.write('\
\
<div id="rm_cpy"><div class="prochdr1">rm_cpy</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Copy map or value</div></div>\
<pre class="proclongnm">rm_copy</pre>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
obj  pointer value<br>\
key1 pointer value options(*nopass)<br>\
key2 pointer value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&sstarf;</span>&nbsp;Return a (shallow) copy of <code>obj</code>, which must be a map or a value.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;The new map or value has the same properties and attributes as <code>obj</code>, \
except that a new copy of a map is always mutable. The copy contains \
the same key/item pairs as <code>obj</code>. The keys/items in the copy that are \
values or automatically disposed maps are copies of the originals in \
<code>obj</code>. Manually disposed maps are not copied; the copy will contain \
the same instances.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;Event handlers are NOT copied; the copy has no event handlers.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;Return <code>*null</code> if <code>obj</code> is <code>*null</code>.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;Use <a href="#rm_cpyd"><code>rm_cpyd</code></a> to make a deep copy of a map, \
in which case manually disposed maps are also (deep) copied.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;The new copy is always mutable. Maps contained in <code>obj</code> that are \
immutable stay immutable and copies of these maps that are included in the copy are also immutable.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;Be aware that when manually disposed maps are not used then <a href="#rm_cpy"><code>rm_cpy</code></a> \
and <a href="#rm_cpyd"><code>rm_cpyd</code></a> have the same effect, i.e. contained maps are copied \
recursively, effectively producing a deep copy. Avoid excessive memory \
use. When only manually disposed maps are used instead of automatically \
disposed maps then <a href="#rm_cpy"><code>rm_cpy</code></a> will produce a real shallow copy.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;If <code>key1</code> and/or <code>key2</code> are passed and not <code>*null</code> the copy will only \
contain the key/item pairs from <code>obj</code> with key equal to or greater than \
<code>key1</code>, and equal to or less than <code>key2</code>. Both keys are optional. If \
<code>key1</code> is not passed or <code>*null</code> it\'s assumed to be the lowest key. If \
<code>key2</code> is not passed it\'s assumed to be the same as <code>key1</code> (if <code>key1</code> \
is passed). If <code>key2</code> is <code>*null</code> it\'s assumed to be the highest key. \
Return an empty map if <code>key1</code> is greater than <code>key2</code>, or if only <code>key1</code> \
is passed with value <code>*null</code>.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;Ignore <code>key1</code>/<code>key2</code> if <code>obj</code> is a value.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;An alternative way to copy for example an integer value: <code>rm_i(rm_i_(val))</code>.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;This procedure disposes <code>key1</code> and <code>key2</code> automatically, unless \
<code>key1</code>/<code>key2</code> is a manually disposed map, or a value/map contained \
in a map.\
</p>\
\
');
