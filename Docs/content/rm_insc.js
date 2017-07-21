document.write('\
\
<div id="rm_insc"><div class="prochdr1">rm_insc</div><div class="prochdr2"> - Insert key/item pairs, conditionally</div></div>\
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
Like <a href="#rm_ins"><code>rm_ins</code></a>, but a key/item pair is only inserted if there is \
no key in <code>map</code> that is equal to the key to be inserted.<br>\
Keys and items that are not inserted are disposed automatically, \
unless they are manually disposed maps, or values/maps contained \
in a map.\
</p>\
\
');