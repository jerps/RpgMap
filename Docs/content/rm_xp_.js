document.write('\
\
<div id="rm_xp_"><div class="prochdr1">rm_xp_</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Convert a procedure pointer to an RPG procedure pointer value</div></div>\
<pre class="procsig">\
&lt;&lt;pointer(*proc)<br>\
value   pointer        value<br>\
default pointer(*proc) value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#8226;</span>&nbsp;Return an RPG procedure pointer from <code>value</code>, which must be a procedure pointer.<br>\
<span class="bullet1">&#8226;</span>&nbsp;If <code>value</code> is <code>*null</code> then return <code>*null</code>, or <code>default</code> \
when passed. If <code>value</code> is not compatible escape message RM00011 (value not \
compatible) is sent.\
</p>\
\
');