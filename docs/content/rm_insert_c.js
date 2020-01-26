document.write('\
\
<div id="rm_insert_c"><div class="prochdr1">rm_insert_c</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Insert key/item pairs, conditionally</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
map  pointer value<br>\
k001 pointer value options(*nopass)<br>\
i001 pointer value options(*nopass)<br>\
...<br>\
k100 pointer value options(*nopass)<br>\
i100 pointer value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Like <a href="#rm_insert"><code>rm_insert</code></a>, but a key/item pair is only inserted if there is \
no key in <code>map</code> that is equal to the key to be inserted.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Keys and items that are not inserted are disposed automatically, \
unless they are manually disposed maps, or values/maps contained \
in a map.\
</p>\
\
');
