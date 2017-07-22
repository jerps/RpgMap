document.write('\
\
<h1 id="introduction">Introduction</h1>\
<p>\
In dynamic languages, for example Java or Python, collection types such as maps/dictionaries, \
lists, etc, are commonly used. They are the workhorses for in-memory data processing.\
</p>\
<p>\
RpgMap implements a versatile in-memory ordered key/value store, like a Java TreeMap or \
an associative array, for use with the RPG programming language. An RpgMap stores key/item \
pairs. It associates keys with items. The keys and items in an RpgMap can be values such \
as integers and dates or other RpgMaps. An RpgMap can contain any mix of types. The key/item \
pairs are always sorted by key. Items can be retrieved by key very fast because of an \
efficient red-black tree implementation.\
</p>\
<p>\
An RpgMap may contain duplicate keys.\
<p>\
<p>\
An RpgMap is simply called a "map" from here on.\
</p>\
<p>\
Maps support a rich set of operations, such as different ways of populating (new) maps \
with keys and items, looking up items by key, testing the existence of keys, iterating \
through key/item pairs using cursors which support set-lower-limit, set-greater-than, \
read, read-previous, read-equal semantics, etc.\
</p>\
<p>\
Key/item pairs can be inserted and removed while iterating through a map. The behavior \
is well defined.\
</p>\
<p>\
The keys and items in a map can be any mix of maps and values of different types. The \
supported value types are integer, packed decimal, date, time, timestamp, indicator, \
(procedure) pointer and character data.\
</p>\
<p>\
Besides normal character data, there is an extra "string" value type, which is text in utf8 \
format. There is also a special map type, "vector", which is used to represent simple lists \
or sequences. Because of the way vectors are compared with each other they are especially \
useful as (partial) composite keys (e.g. a key which consists of a date and an integer).\
</p>\
<p>\
A special type of character data or string conforms to an alternate sort (collating) sequence, \
such as *langidshr, when compared with the same type (see "altseq"/"srtseq" RPG control spec \
keywords). Values and maps can have the special "reversed order" property, which reverses their \
sort order when compared to other values and maps. Character data and strings can have the \
"case insensitive order" property.\
</p>\
<p>\
Maps can have one or more attributes. These can be used to store settings and other metadata \
related to a map.\
</p>\
<p>\
Most procedures have short names to facilitate compact code. However, many procedures also have \
a long name that is more descriptive.\
</p>\
<p>\
There are some restrictions. Floating point values and zoned decimals are not supported. \
Character data and strings can not be longer than 30.000 bytes. Integer values can be int(10) \
or int(20). Packed decimal values can be packed(14:4), packed(28:8) or packed(46:16).\
</p>\
\
');