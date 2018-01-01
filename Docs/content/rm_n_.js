document.write('\
\
<div id="rm_n_"><div class="prochdr1">rm_n_</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Convert an indicator to an RPG indicator value</div></div>\
<pre class="procsig">\
&lt;&lt;ind<br>\
value   pointer value<br>\
default ind     value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&sstarf;</span>&nbsp;Return an RPG <code>indicator</code> from <code>value</code>, which must be an indicator.<br>\
<span class="bullet1">&sstarf;</span>&nbsp;If <code>value</code> is <code>*null</code> then return <code>*off</code>, or <code>default</code> \
when passed. If <code>value</code> is not compatible escape message RM00011 (value not \
compatible) is sent.\
</p>\
\
');
