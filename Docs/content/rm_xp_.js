document.write('\
\
<div id="rm_xp_"><div class="prochdr1">rm_xp_</div><div class="prochdr2"> - Convert a procedure pointer to an RPG procedure pointer value</div></div>\
<pre class="procsig">\
&lt;&lt;pointer(*proc)<br>\
value   pointer        value<br>\
default pointer(*proc) value options(*nopass)<br>\
</pre>\
<p>\
Return an RPG procedure pointer from <code>value</code>, which must be a procedure pointer.<br>\
If <code>value</code> is <code>*null</code> then return <code>*null</code>, or <code>default</code> \
when passed. If <code>value</code> is not compatible escape message RM00011 (value not \
compatible) is sent.<br>\
</p>\
\
');