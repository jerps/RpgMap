document.write('\
\
<div id="rm_cpyd"><div class="prochdr1">rm_cpyd</div><div class="prochdr2"> - Deep copy map or value</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
obj  pointer value<br>\
key1 pointer value options(*nopass)<br>\
key2 pointer value options(*nopass)<br>\
</pre>\
<p>\
Like <a href="#rm_cpy"><code>rm_cpy</code></a>, but returns a deep copy.<br>\
For values, <a href="#rm_cpyd"><code>rm_cpyd</code></a> has the same effect as <a href="#rm_cpy"><code>rm_cpy</code></a>.<br>\
For maps, contained manually disposed maps are copied also, recursively, \
like automatically disposed maps.\
</p>\
\
');