## RpgMap v1.2.0

#### RpgMap implements a versatile in-memory ordered key/value store, like a Java TreeMap or a Python dict, for use with the RPG programming language

***

### [Docs](http://johnerps.com/RpgMap/Docs/index.html)

***

### Changes

* v1.2.0 (july 2018)

  * New procedures:

  * Fixed bug "obj already contained" in `rm_ins?m`.

  * RPGMAP signature is now "V1" and only changes when the major version number is changed.

  * `rm_??__` to immediately dispose an RpgMap value after unwrapping.

  * `rm_inm (rm_in_map)` to test whether a map or value is (contained) in a map.

  * `rm_mmm (rm_make_map_manually_disposed)` to make a map manually disposed.

  * `rm_mmi (rm_make_map_immutable)` to make a map immutable.

* v1.1.0 (dec 2017)

  * Start with semver versioning scheme.

* V2017.3 (sept 2017)

  * Fixed bug which caused procedure `rm_isv` to return *on for a normal map.

  * Maps can have event handlers which listen to "insert" and "remove" events.

  * Values and maps can now have associated "user data", which is an arbitrary integer value between 1 and 65.000.

  * Procedure `rm_sav (rm_set_attr_value)` now accepts up to 100 attribute name/values.

  * Parameter `pos` is now optional for procedures `rm_slln` and `rm_sgtp`.

  * New procedures:

    * `rm_usrd (rm_user_data)` (return user data) returns the user data associated with a map or value.

    * `rm_ismm` (is manually disposed map?) to test whether an object is a manually disposed map.

    * `rm_add_event_handler` (add event handler) to add an event handler to a map.

    * `rm_remove_event_handler` (remove event handler) to remove an event handler from a map.

* V2017.2 (aug 2017)

  * Many procedures now have a long procedure name besides the short name. The long name
  can optionally be used when a more descriptive name is needed. For example `rm_insc` can also be called as `rm_insert_cond`.

  * New procedures:

    * `rm_hit (rm_has_item)` (has item?) to test whether a map has an item equal to a given item.

    * `rm_nit (rm_num_items)` (number of items) which returns the number of items equal to a given item.

    * `rm_gik (rm_get_item_key)` (get item key) which returns the key of the first or last item equal to a given item.

* V2017.1 (jul 2017)

  * Initial
