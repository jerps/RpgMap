document.write('\
\
<div id="rm_copy_deep"><div class="prochdr1">rm_copy_deep</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Deep copy map or value</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
obj  pointer value<br>\
key1 pointer value options(*nopass)<br>\
key2 pointer value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Like <a href="#rm_copy"><code>rm_copy</code></a>, but returns a deep copy.<br>\
<span class="bullet1">&#9679;</span>&nbsp;For values, <a href="#rm_copy_deep"><code>rm_copy_deep</code></a> has the same effect as <a href="#rm_copy"><code>rm_copy</code></a>.<br>\
<span class="bullet1">&#9679;</span>&nbsp;For maps, contained manually disposed maps are copied also, recursively, \
like automatically disposed maps.\
</p>\
\
');
