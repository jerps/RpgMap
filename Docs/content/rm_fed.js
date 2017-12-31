document.write('\
\
<div id="rm_fed"><div class="prochdr1">rm_fed</div><div class="prochdr2">&nbsp;&nbsp;<pre class="prochsep">&#10072;</pre>&nbsp;&nbsp;For each do</div></div>\
<pre class="proclongnm">rm_for_each_do</pre>\
<pre class="procsig">\
&lt;&lt;pointer<br>\
map  pointer        value<br>\
proc pointer(*proc) value<br>\
usrd pointer        value options(*nopass)<br>\
key1 pointer        value options(*nopass)<br>\
key2 pointer        value options(*nopass)<br>\
</pre>\
<p>\
<span class="bullet1">&#8226;</span>&nbsp;Call procedure <code>proc</code> for each key/item pair in <code>map</code>, injecting a \
pointer, then return the pointer that was returned with the last call \
to <code>proc</code>.<br>\
<span class="bullet1">&#8226;</span>&nbsp;Procedure <code>proc</code> must have the following signature:\
</p>\
<pre class="procsig">\
  rtn type: pointer<br>\
  par. 1  : key  pointer value<br>\
       2  : item pointer value<br>\
       3  : usrd pointer value<br>\
       4  : stop ind<br>\
</pre>\
<p>\
<span class="bullet1">&#8226;</span>&nbsp;Procedure <code>proc</code> is executed for each key/item pair in <code>map</code>, starting \
with the lowest key, up to the highest key, or until <code>proc</code> sets output \
parameter <code>stop</code> to *on.<br>\
<span class="bullet1">&#8226;</span>&nbsp;Use <a href="#rm_fedr"><code>rm_fedr</code></a> to start with the highest key down to the lowest key.<br>\
<span class="bullet1">&#8226;</span>&nbsp;Each time <code>proc</code> is executed the key and item are passed as arguments <code>key</code> \
and <code>item</code>. Parameter <code>usrd</code> is a pointer to data that is user defined and \
can be anything (e.g. a map or a value), or the pointer is <code>*null</code>. Procedure \
<code>proc</code> returns this, or another, pointer which is then passed as argument \
<code>usrd</code> the next time </code>proc</code> is called again. So the return value of <code>proc</code> \
is used as input for <code>proc</code> the next time it\'s called. The initial user data \
pointer that is passed the first time <code>proc</code> is called is passed to <a href="#rm_fed"><code>rm_fed</code></a> \
or <a href="#rm_fedr"><code>rm_fedr</code></a> with parameter <code>usrd</code>.<br>\
<span class="bullet1">&#8226;</span>&nbsp;Parameter <code>usrd</code> is optional; if not passed the user data pointer is <code>*null</code>.<br>\
<span class="bullet1">&#8226;</span>&nbsp;If no key/item pair is read (and <code>proc</code> doesn\'t get called) the return \
value will be <code>usrd</code>, or <code>*null</code> if <code>usrd</code> is not passed.<br>\
<span class="bullet1">&#8226;</span>&nbsp;If <code>key1</code> and/or <code>key2</code> are passed then the key/item pairs that are \
processed are equal to or greater than <code>key1</code>, and equal to or less than \
<code>key2</code>. Both keys are optional. If <code>key1</code> is not passed or <code>*null</code> it\'s \
assumed to be the lowest key. If <code>key2</code> is not passed it\'s assumed to \
be the same as <code>key1</code> (if <code>key1</code> is passed). If <code>key2</code> is <code>*null</code> it\'s \
assumed to be the highest key. Read nothing if <code>key1</code> is greater than \
<code>key2</code>, or if only <code>key1</code> is passed with value <code>*null</code>.<br>\
<span class="bullet1">&#8226;</span>&nbsp;These procedures dispose <code>key1</code> and <code>key2</code> automatically, unless \
<code>key1</code>/<code>key2</code> is a manually disposed map, or a value/map contained \
in a map.\
</p>\
\
');