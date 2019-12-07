document.write('\
\
<div id="rm_aa"><div class="prochdr1">rm_aa</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Create new character data value, alt. sort sequence</div></div>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
value varchar(30000) const<br>\
opt   int(10)        value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Like <a href="#rm_a"><code>rm_a</code></a>, but the character data is compared using an alternate sort \
sequence. When two character data values are compared which are both \
created with <a href="#rm_aa"><code>rm_aa</code></a> or <a href="#rm_aap"><code>rm_aap</code></a> the comparison is done using the alternate \
sort sequence, instead of the default. Which sort sequence that is depends on \
the build options that were used, but usually it is <code>*langidshr</code>.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Comparing data using an alternate sort sequence may take more resources than \
when the default sort sequence is used.<br>\
<span class="bullet1">&#9679;</span>&nbsp;Pass <code>opt</code> to set special property or user data (see <a href="#rm_"><code>rm_</code></a>).\
</p>\
\
');
