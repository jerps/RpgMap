document.write('\
\
<div id="rm_p_"><div class="prochdr1">rm_p_</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Convert a number to an RPG packed decimal value, 10.4 digits</div></div>\
<pre class="procsig">\
&lt;&lt;packed(14:4)<br>\
value   pointer      value<br>\
default packed(14:4) value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&sstarf;</span>&nbsp;Return an RPG <code>packed(14:4)</code> from <code>value</code>, \
which must be a number. If <code>value</code> is <code>*null</code> then return <code>0</code>, or <code>default</code> \
when passed. If <code>value</code> is not a number escape message RM00011 (value not \
compatible) is sent. If the value is too big for the returned packed \
decimal format then message MCH1210 (receiver value too small) is sent.\
</p>\
\
');
