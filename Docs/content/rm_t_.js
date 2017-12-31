document.write('\
\
<div id="rm_t_"><div class="prochdr1">rm_t_</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Convert a time/timestamp to an RPG time value</div></div>\
<pre class="procsig">\
&lt;&lt;time<br>\
value   pointer value<br>\
default time    value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#8407;</span>&nbsp;Return an RPG time from <code>value</code>, which must be a time or timestamp.<br>\
<span class="bullet1">&#8407;</span>&nbsp;If <code>value</code> is <code>*null</code> then return <code>*loval</code>, or <code>default</code> \
when passed. If <code>value</code> is not compatible escape message RM00011 (value not \
compatible) is sent.<br>\
<span class="bullet1">&#8407;</span>&nbsp;A timestamp is converted to a time using BIF %time.\
</p>\
\
');
