# RpgMap

RpgMap implements a versatile in-memory ordered key/value store, like a Java TreeMap or
a Python dict, for use with the RPG programming language.

>## [Docs](http://erps.me/RpgMap/Docs/index.html)

<br>

## Changes

<br>

* next
  
  * Added <code>rm_??__</code> procedures, to immediately dispose a value after unwrapping.
  
  * Added <code>rm_mmm (rm_make_map_manually_disposed)</code>, <code>rm_mmi (rm_make_map_immutable)</code>.

<br>

* v1.1.0 (dec 2017)
  
  * Start with semver versioning scheme.

<br>

* V2017.3 (sept 2017)

  * Fixed bug which caused procedure <code>rm_isv</code> to return *on for a normal map.
  
  * Maps can have event handlers which listen to "insert" and "remove" events.

  * Values and maps can now have associated "user data", which is an arbitrary integer value between 1 and 65.000.
  
  * Procedure <code>rm_sav (rm_set_attr_value)</code> now accepts up to 100 attribute name/values.
  
  * Parameter <code>pos</code> is now optional for procedures <code>rm_slln</code> and <code>rm_sgtp</code>.

  * New procedures:
    * <code>rm_usrd (rm_user_data)</code> (return user data) returns the user data associated with a map or value.
    
    * <code>rm_ismm</code> (is manually disposed map?) to test whether an object is a manually disposed map.
    
    * <code>rm_add_event_handler</code> (add event handler) to add an event handler to a map.
    
    * <code>rm_remove_event_handler</code> (remove event handler) to remove an event handler from a map.

<br>

* V2017.2 (aug 2017)
  
  * Many procedures now have a long procedure name besides the short name. The long name
  can optionally be used when a more descriptive name is needed. For example <code>rm_insc</code>
  can also be called as <code>rm_insert_cond</code>.
    
  * New procedures:
    * <code>rm_hit (rm_has_item)</code> (has item?) to test whether a map has an item
    equal to a given item.
    
    * <code>rm_nit (rm_num_items)</code> (number of items) which returns the number of items
  equal to a given item.
  
    * <code>rm_gik (rm_get_item_key)</code> (get item key) which returns the key of the first or last item
  equal to a given item.

<br>

* V2017.1 (jul 2017)
  * Initial
