document.write('\
\
<div id="rm_s_"><div class="prochdr1">rm_s_</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Convert string to RPG utf-8 character data</div></div>\
<pre class="procsig">\
&lt;&lt;varchar(30000) ccsid(*utf8)<br>\
value   pointer                     value<br>\
default varchar(30000) ccsid(*utf8) const options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Return an RPG <code>varchar(30000)</code> in utf-8 format from <code>value</code>, which must \
be a string. If <code>value</code> is <code>*null</code> then return <code>\'\'</code>, or <code>default</code> when \
passed. If <code>value</code> is not compatible escape message RM00011 (value \
not compatible) is sent.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Procedures <a href="#rm_s1_"><code>rm_s1_</code></a>, <a href="#rm_s2_"><code>rm_s2_</code></a> and <a href="#rm_s3_"><code>rm_s3_</code></a> are a bit faster because \
of the shorter return value (100, 1000 or 10000).\
</p>\
\
');
