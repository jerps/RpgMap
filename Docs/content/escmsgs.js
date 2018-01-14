document.write('\
\
<h2 id="escmsgs">Escape Messages</h2>\
<br>\
<p>\
The following is a list of all escape messages that can be sent.\
</p>\
<p>\
<div class="escmsg1"><strong>RM00001</strong>: Key is *null.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;A *null key is inserted into a map.</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM00002</strong>: Key is not an integer.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;A non-integer key is inserted into a vector.</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM00005</strong>: Map is immutable; can not insert/remove key/item pairs.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;-</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM00010</strong>: Automatically disposed map is already contained in a map.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;An automatically disposed map which is already inserted into a map is inserted into a map again.</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM00011</strong>: Value is not compatible.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;Tried to unwrap/convert an incompatible value to an RPG value.</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM00012</strong>: Value is already contained in a map.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;A value which is already inserted into a map is inserted into a map again.</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM00022</strong>: Character or string data can not exceed 30.000 bytes.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;-</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM00023</strong>: Character or string data must be at least 1 byte.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;-</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM00030</strong>: Can not dispose automatically disposed map or value contained in a map.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;A map or value that has been inserted into a map is being disposed with <a href="#rm_dis"><code>rm_dis</code></a>.</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM00032</strong>: Object to copy is not a value or a map.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;-</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM00033</strong>: Special properties can only be set for values and maps.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;-</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM00041</strong>: Map is not empty.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;Tried to change the compare function of a non-empty map.</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM00051</strong>: Object is not an automatically disposed map or it is a vector; can not make manually disposed.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;-</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM00101</strong>: Unknown keyword: &amp;1</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;-</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM00102</strong>: A map\'s attribute name can not be blank or empty.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;-</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM00201</strong>: A cursor can not be inserted into a map.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;-</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM00111</strong>: Option not supported: &amp;1</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;Unsupported "opt" argument given with <a href="#rm_"><code>rm_</code></a> or when creating a value.</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM01001</strong>: Error initializing iconv struct from CCSID &amp;1 to CCSID &amp;2.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;An error occurred while trying to initialize character conversion from CCSID &amp;1 to CCSID &amp;2.</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM09001</strong>: Object is not a map.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;-</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM09002</strong>: Object is not a value.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;-</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM09003</strong>: Object is not a cursor.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;-</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM09004</strong>: Object is not a map or a value.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;-</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM09005</strong>: Object is not an automatically disposed map or a value.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;-</div>\
</p>\
<p>\
<div class="escmsg1"><strong>RM09011</strong>: Unknown object.</div>\
&nbsp;<div class="escmsg2"><span class="bullet1">&sstarf;</span>&nbsp;-</div>\
</p>\
\
');
