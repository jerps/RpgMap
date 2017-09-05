document.write('\
\
<h2 id="escmsgs">Escape Messages</h2>\
<br>\
<p>\
The following is a list of all escape messages that can be sent.\
</p>\
<p>\
<div class="escmsg1"> RM00001: Key is *null.</div><br>\
<div class="escmsg2">> A *null key is inserted into a map.</div>\
</p>\
<p>\
<div class="escmsg1"> RM00002: Key is not an integer.</div><br>\
<div class="escmsg2">> A non-integer key is inserted into a vector.</div>\
</p>\
<p>\
<div class="escmsg1"> RM00010: Automatically disposed map is already contained in a map.</div><br>\
<div class="escmsg2">> An automatically disposed map which is already inserted into a map is inserted into a map again.</div>\
</p>\
<p>\
<div class="escmsg1"> RM00011: Value is not compatible.</div><br>\
<div class="escmsg2">> Tried to unwrap/convert an incompatible value to an RPG value.</div>\
</p>\
<p>\
<div class="escmsg1">RM00012: Value is already contained in a map.</div><br>\
<div class="escmsg2">> A value which is already inserted into a map is inserted into a map again.</div>\
</p>\
<p>\
<div class="escmsg1">RM00022: Character or string data can not exceed 30.000 bytes.</div>\
</p>\
<p>\
<div class="escmsg1">RM00023: Character or string data must be at least 1 byte.</div>\
</p>\
<p>\
<div class="escmsg1">RM00030: Can not dispose automatically disposed map or value contained in a map.</div><br>\
<div class="escmsg2">> A map or value that has been inserted into a map is being disposed with <a href="#rm_dis"><code>rm_dis</code></a>.</div>\
</p>\
<p>\
<div class="escmsg1">RM00032: Object to copy is not a value or a map.</div>\
</p>\
<p>\
<div class="escmsg1">RM00033: Special properties can only be set for values and maps.</div>\
</p>\
<p>\
<div class="escmsg1">RM00041: Map is not empty.</div><br>\
<div class="escmsg2">> Tried to change the compare function of a non-empty map.</div>\
</p>\
<p>\
<div class="escmsg1">RM00101: Unknown keyword: &amp;1</div>\
</p>\
<p>\
<div class="escmsg1">RM00102: A map\'s attribute name can not be blank or empty.</div>\
</p>\
<p>\
<div class="escmsg1">RM00201: A cursor can not be inserted into a map.</div>\
</p>\
<p>\
<div class="escmsg1">RM00111: Option not supported: &amp;1</div><br>\
<div class="escmsg2">> Unsupported "opt" argument given with <a href="#rm_"><code>rm_</code></a> or when creating a value.</div>\
</p>\
<p>\
<div class="escmsg1">RM01001: Error initializing iconv struct from CCSID &amp;1 to CCSID &amp;2.</div><br>\
<div class="escmsg2">> An error occurred while trying to initialize character conversion from CCSID &amp;1 to CCSID &amp;2.</div>\
</p>\
<p>\
<div class="escmsg1">RM09001: Object is not a map.</div>\
</p>\
<p>\
<div class="escmsg1">RM09001: Object is not a map.</div>\
</p>\
<p>\
<div class="escmsg1">RM09002: Object is not a value.</div>\
</p>\
<p>\
<div class="escmsg1">RM09003: Object is not a cursor.</div>\
</p>\
<p>\
<div class="escmsg1">RM09004: Object is not a map or a value.</div>\
</p>\
<p>\
<div class="escmsg1">RM09011: Unknown object.</div>\
</p>\
\
');