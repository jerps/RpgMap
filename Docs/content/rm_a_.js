document.write('\
\
<div id="rm_a_"><div class="prochdr1">rm_a_</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Convert character data to RPG character data</div></div>\
<pre class="procsig">\
&lt;&lt;varchar(30000)<br>\
value   pointer        value<br>\
default varchar(30000) const options(*nopass)<br>\
</pre>\
<p>\
Return RPG character data from <code>value</code>, which must be character data \
or a string. If <code>value</code> is a string then the raw bytes are returned; \
no text conversion. If <code>value</code> is <code>*null</code> then return <code>\'\'</code>, or <code>default</code> \
when passed. If <code>value</code> is not compatible escape message RM00011 (value \
not compatible) is sent.<br>\
Procedures <a href="#rm_a1_"><code>rm_a1_</code></a>, <a href="#rm_a2_"><code>rm_a2_</code></a> and <a href="#rm_a3_"><code>rm_a3_</code></a> are a bit faster because \
of the shorter return value (100, 1000 or 10000).\
</p>\
\
');