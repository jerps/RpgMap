document.write('\
\
<div id="rm_x_"><div class="prochdr1">rm_x_</div><div class="prochdr2"> - Convert a pointer to an RPG pointer value</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
value   pointer value<br>\
default pointer value options(*nopass)<br>\
</pre>\
<p>\
Return an RPG pointer from <code>value</code>, which must be a pointer.<br>\
If <code>value</code> is <code>*null</code> then return <code>*null</code>, or <code>default</code> \
when passed. If <code>value</code> is not compatible escape message RM00011 (value not \
compatible) is sent.<br>\
</p>\
\
');