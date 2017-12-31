document.write('\
\
<div id="rm_"><div class="prochdr1">rm_</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;Set special property</div></div>\
<pre class="proclongnm">rm_set_prop</pre>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
obj pointer value<br>\
opt int(10) value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#8407;</span>&nbsp;Set the special property specified with <code>opt</code> for <code>obj</code>, which is a map or \
a value, and return <code>obj</code>.<br>\
<br>\
&nbsp;<code>opt</code>:<br>\
&nbsp;&nbsp;&nbsp; <code>0</code>: reversed order,<br>\
&nbsp;&nbsp;&nbsp; <code>1</code>: case insensitive order,<br>\
&nbsp;&nbsp;&nbsp; <code>2</code>: both,<br>\
&nbsp;&nbsp;&nbsp;<code>-1</code> .. <code>-65000</code>: user data (a positive integer between 1 and 65.000),<br>\
&nbsp;&nbsp;<code>90</code>: clear reversed order &amp; case insensitive order,<br>\
&nbsp;&nbsp;<code>91</code>: clear user data.<br>\
<br>\
<span class="bullet1">&#8407;</span>&nbsp;If <code>opt</code> is not passed then 0 is assumed.<br>\
<span class="bullet1">&#8407;</span>&nbsp;Some properties are not supported for some types.<br>\
<span class="bullet1">&#8407;</span>&nbsp;Send escape message RM00111 if <code>opt</code> is not supported.<br>\
<span class="bullet1">&#8407;</span>&nbsp;When creating values (e.g. with <a href="#rm_i"><code>rm_i</code></a> or <a href="#rm_a"><code>rm_a</code></a>) use parameter <code>opt</code> \
instead of <a href="#rm_"><code>rm_</code></a>, if possible. For example <code>rm_i(1:0)</code> creates an integer \
value, <code>1</code>, with reversed order, and <code>rm_a(\'abc\':-100)</code> creates a character \
value with user data <code>100</code>. When creating maps there is no <code>opt</code> parameter \
so <a href="#rm_"><code>rm_</code></a> must always be used instead.<br>\
<span class="bullet1">&#8407;</span>&nbsp;Specify <code>90</code> or <code>91</code> for <code>opt</code> to clear (remove) special properties or user \
data.<br>\
<b>--&nbsp;Reversed Order&nbsp;--</b><br>\
<span class="bullet1">&#8407;</span>&nbsp;If a map or value has the "reversed order" property, then when it\'s \
compared to other maps or values the sort order is reversed. Value \
<code>*hival</code> is then the lowest in order, and vice versa. When comparing \
two objects, reversed order is in effect when at least one has the \
reversed order property set, otherwise normal order is in effect.<br>\
<b>--&nbsp;Case Insensitive Order&nbsp;--</b><br>\
<span class="bullet1">&#8407;</span>&nbsp;If <code>obj</code> is character data or a string, with normal sort sequence, \
then the "case insensitive order" can be set. If set, then when <code>obj</code> \
is compared with other character data or strings this is done without \
difference between uppercase and lowercase characters. Like reversed \
order, case insensitive order is in effect when two objects are compared \
and at least one of them has the case insensitive order property.<br>\
<span class="bullet1">&#8407;</span>&nbsp;Some extra processing is required when a case insensitive comparison is \
done. Especially when setting this property for strings, as they need to \
be converted to the job CCSID first, before being compared case insensitive.<br>\
<b>--&nbsp;User Data&nbsp;--</b><br>\
<span class="bullet1">&#8407;</span>&nbsp;A map or value can be associated with user data, which is a positive integer \
value between <code>1</code> and <code>65.000</code> that is application specific. Like attributes \
(<a href="#rm_sav"><code>rm_sav</code></a>), user data is used to store meta data.<br>\
<span class="bullet1">&#8407;</span>&nbsp;Associating user data does not increase memory usage.<br>\
<span class="bullet1">&#8407;</span>&nbsp;Procedure <a href="#rm_usrd"><code>rm_usrd</code></a> returns the user data for a map or value.<br>\
<span class="bullet1">&#8407;</span>&nbsp;The user data is specified as a negative integer; specifying <code>-1</code> means that \
<a href="#rm_usrd"><code>rm_usrd</code></a> returns <code>1</code>.<br>\
<span class="bullet1">&#8407;</span>&nbsp;If <code>opt</code> is <code>91</code> then the user data is cleared, i.e. <a href="#rm_usrd"><code>rm_usrd</code></a> returns <code>0</code>.\
</p>\
\
');
