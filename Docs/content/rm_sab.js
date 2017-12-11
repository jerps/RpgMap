document.write('\
\
<div id="rm_sab"><div class="prochdr1">rm_sab</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Create a new string value, alt. sort seq., from binary</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
value varchar(30000) const<br>\
opt   int(10)        value options(*nopass)<br>\
</pre>\
<p>\
Like <a href="#rm_sa"><code>rm_sa</code></a>, but <code>value</code> takes the raw bytes, already in utf8 format.<br>\
Pass <code>opt</code> to set special property or user data (see <a href="#rm_"><code>rm_</code></a>).\
</p>\
\
');