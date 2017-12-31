document.write('\
\
<div id="rm_i_"><div class="prochdr1">rm_i_</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Convert a number to an RPG integer value, 10 digits</div></div>\
<pre class="procsig">\
&lt;&lt;int(10)<br>\
value   pointer value<br>\
default int(10) value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#8226;</span>&nbsp;Return an RPG int(10) from <code>value</code>, which must be a number.<br>\
<span class="bullet1">&#8226;</span>&nbsp;If <code>value</code> is <code>*null</code> then return <code>0</code>, or <code>default</code> when passed. If <code>value</code> \
is not a number escape message RM00011 (value not compatible) is sent. \
If the value is too big for the returned integer format then message \
MCH1210 (receiver value too small) is sent.\
</p>\
\
');