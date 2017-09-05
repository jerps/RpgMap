document.write('\
\
<div id="rm_"><div class="prochdr1">rm_</div><div class="prochdr2"> - Set special property</div></div>\
<pre class="proclongnm">rm_set_prop</pre>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
obj pointer value<br>\
opt int(10) value options(*nopass)<br>\
</pre>\
<p>\
Set the special property specified with <code>opt</code> for <code>obj</code>, which is a map or \
a value, and return <code>obj</code>.<br>\
<br>\
&nbsp;opt:<br>\
&nbsp;&nbsp;&nbsp; 0: reversed order,<br>\
&nbsp;&nbsp;&nbsp; 1: case insensitive order,<br>\
&nbsp;&nbsp;&nbsp; 2: both,<br>\
&nbsp;&nbsp;&nbsp;-1 .. -65000: user data (an integer between 1 and 65.000),<br>\
&nbsp;&nbsp;90: clear reversed order &amp; case insensitive order,<br>\
&nbsp;&nbsp;91: clear user data.<br>\
<br>\
If <code>opt</code> is not passed then 0 is assumed.<br>\
Some properties are not supported for some types.<br>\
Send escape message RM00111 if <code>opt</code> is not supported.<br>\
When creating values (e.g. with <a href="#rm_i"><code>rm_i</code></a> or <a href="#rm_a"><code>rm_a</code></a>) use parameter <code>opt</code> \
instead of <a href="#rm_"><code>rm_</code></a>, if possible. For example <code>rm_i(1:0)</code> creates an integer \
value, <code>1</code>, with reversed order, and <code>rm_a(\'abc\':-100)</code> creates a character \
value with user data <code>100</code>. When creating maps there is no <code>opt</code> parameter \
so <a href="#rm_"><code>rm_</code></a> must always be used instead.<br>\
Specify <code>90</code> or <code>91</code> for <code>opt</code> to clear (remove) special properties or user \
data.<br>\
<b>&gt; Reversed Order</b><br>\
If a map or value has the "reversed order" property, then when it\'s \
compared to other maps or values the sort order is reversed. Value \
<code>*hival</code> is then the lowest in order, and vice versa. When comparing \
two objects, reversed order is in effect when at least one has the \
reversed order property set, otherwise normal order is in effect.<br>\
<b>&gt; Case Insensitive Order</b><br>\
If <code>obj</code> is character data or a string, with normal sort sequence, \
then the "case insensitive order" can be set. If set, then when <code>obj</code> \
is compared with other character data or strings this is done without \
difference between uppercase and lowercase characters. Like reversed \
order, case insensitive order is in effect when two objects are compared \
and at least one of them has the case insensitive order property.<br>\
Some extra processing is required when a case insensitive comparison is \
done. Especially when setting this property for strings, as they need to \
be converted to the job CCSID first, before being compared case insensitive.<br>\
<b>&gt; User Data</b><br>\
A map or value can be associated with user data, which is a positive integer \
value between <code>1</code> and <code>65.000</code> that is application specific. Like attributes \
(<a href="#rm_sav"><code>rm_sav</code></a>), user data is used to store meta data.<br>\
Associating user data does not increase memory usage.<br>\
Procedure <a href="#rm_usrd"><code>rm_usrd</code></a> returns the user data for a map or value.<br>\
The user data is specified as a negative integer; specifying -1 means that \
<a href="#rm_usrd"><code>rm_usrd</code></a> returns 1.<br>\
If <code>opt</code> is <code>91</code> then the user data is cleared, i.e. <a href="#rm_usrd"><code>rm_usrd</code></a> returns <code>0</code>.\
</p>\
\
');