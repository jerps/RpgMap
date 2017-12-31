document.write('\
\
<div id="rm_aap"><div class="prochdr1">rm_aap</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Create a new character data value, alt. sort seq., pointer to data</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
addr pointer value<br>\
size int(10) value<br>\
opt  int(10) value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#8407;</span>&nbsp;Like <a href="#rm_aa"><code>rm_aa</code></a>, but the data is taken from a pointer and a number of bytes (i.e. size).<br>\
<span class="bullet1">&#8407;</span>&nbsp;The size must be between 1 and 30.000.<br>\
<span class="bullet1">&#8407;</span>&nbsp;The passed number of bytes (<code>size</code>) are copied from the address to which \
the pointer (<code>addr</code>) points.<br>\
<span class="bullet1">&#8407;</span>&nbsp;Pass <code>opt</code> to set special property or user data (see <a href="#rm_"><code>rm_</code></a>).\
</p>\
\
');
