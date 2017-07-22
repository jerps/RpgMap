# RpgMap

RpgMap implements a versatile in-memory ordered key/value store, like a Java TreeMap or
an associative array, for use with the RPG programming language.

>## [Docs](http://jerps.nl/RpgMap/Docs/index.html)

<br>

## Changes

<br>

* V2017.2 (aug 2017)
  
  * Many procedures now have a long procedure name besides the short name. The long name
  can optionally be used when a more descriptive name is needed. For example <code>rm_insc</code>
  can also be called as <code>rm_insert_cond</code>.
    
  * New procedures:
    * <code>rm_hit</code> (has item?) to test whether a map has an item
    equal to a given item.
    
    * <code>rm_nit</code> (number of items) which returns the number of items
  equal to a given item.
  
    * <code>rm_gik</code> (get item key) which returns the key of the first or last item
  equal to a given item.

<br>

* V2017.1 (jul 2017)
  * Initial