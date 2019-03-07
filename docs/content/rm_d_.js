document.write('\
\
<div id="rm_d_"><div class="prochdr1">rm_d_</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Convert a date/timestamp to an RPG date value</div></div>\
<pre class="procsig">\
&lt;&lt;date(*iso-)<br>\
value   pointer     value<br>\
default date(*iso-) value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#9679;</span>&nbsp;Return an RPG <code>date</code> from <code>value</code>, which must be a date or timestamp.<br>\
<span class="bullet1">&#9679;</span>&nbsp;If <code>value</code> is <code>*null</code> then return <code>*loval</code>, or <code>default</code> \
when passed. If <code>value</code> is not compatible escape message RM00011 (value not \
compatible) is sent.<br>\
<span class="bullet1">&#9679;</span>&nbsp;A timestamp is converted to a date using BIF %date.\
</p>\
\
');
