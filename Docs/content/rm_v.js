document.write('\
\
<div id="rm_v"><div class="prochdr1">rm_v</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Create a new vector, automatically disposed</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
i001 pointer value options(*nopass)<br>\
...<br>\
i100 pointer value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&sstarf;</span>&nbsp;Create a vector, i.e. same as <a href="#rm_m"><code>rm_m</code></a> except that the keys can be only \
integer values and two vectors are compared in a special way (see <a href="#rm_cmp"><code>rm_cmp</code></a>). \
E.g. <code>rm_v(rm_d(d\'2017-01-01\'):rm_i(10))</code> and <code>rm_v(rm_d(d\'2017-01-01\'))</code> are \
considered equal.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;The parameters of this procedure to immediately populate the vector only \
accept items. The keys are automatically generated. The first item is inserted \
with key <code>rm_i(1)</code>, the second with key <code>rm_i(2)</code>, etc.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;A vector represents a simple sequence of items, and is specially useful as \
a (partial) composite key.\
</p>\
\
');
