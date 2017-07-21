document.write('\
\
<h2 id="valmap">Values and Maps</h2>\
<p>\
Maps contain values and maps, as key/item pairs. Maps are created with <a href="#rm_m"><code>rm_m</code></a>, \
<a href="#rm_mm"><code>rm_mm</code></a> or <a href="#rm_v"><code>rm_v</code></a>.\
</p>\
<p>\
RPG values can not be directly inserted into a map. They must first be "wrapped" into a value that <i>can</i> be \
inserted into a map. These are created with one of the many <code>rm_??</code> procedures. For example: <a href="#rm_i"><code>rm_i</code></a> \
for <code>int(10)</code> values, <a href="#rm_p2"><code>rm_p2</code></a> for <code>packed(28:8)</code> values, <a href="#rm_ap"><code>rm_ap</code></a> \
for character data values given with a pointer, etc. Look into the <a href="#api"><code>API</code></a> for a full list.\
</p>\
<p>\
A <code>rm_??</code> procedure wraps a normal RPG value into a value that can be stored into a map. \
Every <code>rm_??</code> procedure has a <code>rm_??_</code> procedure which does the opposite and unwraps the RPG \
value again. For example, <a href="#rm_t"><code>rm_t</code></a> wraps a RPG time value and <a href="#rm_t_"><code>rm_t_</code></a> \
unwraps, or converts, it again to a RPG time value. When unwrapping/converting certain data type conversions \
may happen. For example <a href="#rm_i_"><code>rm_i_</code></a> may convert a packed decimal value to an integer, \
and <a href="#rm_t_"><code>rm_t_</code></a> may convert a timestamp to a time. If the types are incompatible \
escape message RM00011 (value is not compatible) is sent.\
</p>\
<p>\
This wrapping/unwrapping of RPG values using <code>rm_??</code> and <code>rm_??_</code> is necessary to make RpgMap \
polymorphic, i.e. to let it handle different types uniformly.\
</p>\
<p>\
Key/item pairs are inserted into a map with one of the <code>rm_ins*</code> procedures such as <a href="#rm_ins"><code>rm_ins</code></a> \
or <a href="#rm_insc"><code>rm_insc</code></a>. When creating a map, the keys and items to insert can be \
immediately specified (see <a href="#example_1">example 1</a>).\
</p>\
<p>\
For most <code>rm_??</code> procedures there is also a <code>rm_is??</code> procedure to test whether an object is \
of that certain type.\
</p>\
<p>\
Key/item pairs are removed from a map with <a href="#rm_rmv"><code>rm_rmv</code></a> and <a href="#rm_rmva"><code>rm_rmva</code></a>.\
</p>\
<p>\
Items are retrieved using keys with the following procedures: <a href="#rm_get"><code>rm_get</code></a>, \
<a href="#rm__"><code>rm__</code></a> and e.g. <a href="#rm__i"><code>rm__i</code></a> and all variants. Every \
value type has a corresponding <code>rm__*</code> procedure.\
</p>\
\
');