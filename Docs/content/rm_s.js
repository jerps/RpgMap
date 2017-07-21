document.write('\
\
<div id="rm_s"><div class="prochdr1">rm_s</div><div class="prochdr2"> - Create a new string value</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
value varchar(30000) ccsid(*utf8) const<br>\
opt   int(10)                     value options(*nopass)<br>\
</pre>\
<p>\
Create a new string value, up to 30.000 bytes long.<br>\
A string is character data in utf8 format.<br>\
Pass <code>opt</code> to set special property (see <a href="#rm_"><code>rm_</code></a>).\
</p>\
\
');