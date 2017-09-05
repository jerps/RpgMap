document.write('\
\
<div id="rm_sa"><div class="prochdr1">rm_sa</div><div class="prochdr2"> - Create a new string value, alt. sort sequence</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
value varchar(30000) ccsid(*utf8) const<br>\
opt   int(10)                     value options(*nopass)<br>\
</pre>\
<p>\
Like <a href="#rm_s"><code>rm_s</code></a>, but the string is compared using an alternate sort sequence. \
When two strings are compared which are both created with <a href="#rm_sa"><code>rm_sa</code></a> \
or <a href="#rm_sab"><code>rm_sab</code></a> the comparison is done using the alternate sort sequence, \
instead of the default. Which sort sequence depends on the build options \
that were used, but usually it is <code>*langidshr</code>.<br>\
Comparing strings using the alternate sort sequence takes considerably \
more resources than normal comparisons. Strings must be converted \
to the job CCSID first before they can be compared using the alternate \
sort sequence.<br>\
Pass <code>opt</code> to set special property or user data (see <a href="#rm_"><code>rm_</code></a>).\
</p>\
\
');