**FREE

// RPGMAP.RPGLE - RpgMap header file 
// (c) 2017-2019 John Erps


// v1.2.1


// RpgMap is not thread safe.


/if defined(RPGMAP_H)
/eof
/else
/define RPGMAP_H
/endif


// ----- Constants

// Maximum length in bytes for character/string values
dcl-c RPGMAP_MAXBYTES 30000;

// Minimum/maximum numeric values 
dcl-c RPGMAP_I1_MIN                       -2147483648;
dcl-c RPGMAP_I1_MAX                        2147483647;
dcl-c RPGMAP_I2_MIN              -9223372036854775808;
dcl-c RPGMAP_I2_MAX               9223372036854775807;
dcl-c RPGMAP_P1_MIN                       -9999999999.9999;
dcl-c RPGMAP_P1_MAX                        9999999999.9999;
dcl-c RPGMAP_P2_MIN             -99999999999999999999.99999999;
dcl-c RPGMAP_P2_MAX              99999999999999999999.99999999;
dcl-c RPGMAP_P3_MIN   -999999999999999999999999999999.9999999999999999;
dcl-c RPGMAP_P3_MAX    999999999999999999999999999999.9999999999999999;


////////// rm_m - Create a new map, automatically disposed
// Create a new map and return a pointer to it.
// The map should be disposed - with 'rm_dis' - when it's not needed
// anymore. If the map is inserted into a map as a key or item it will
// be automatically disposed when the containing map is disposed or when
// the key/item is removed, and 'rm_dis' can not be used anymore to dispose
// the map.
// Like a value, an automatically disposed map can be inserted into
// (contained in) one map only, i.e. it can be inserted only once (even
// when inserting into the same map). Escape message RM00010 will be sent
// if an automatically disposed map is inserted into a map for a second time.
// The new map can be immediately populated with key/item pairs by passing
// the keys and items as arguments. This is the same as calling 'rm_ins1'
// repeatedly, with arguments 1 and 2 as the first key and item, resp.,
// arguments 3 and 4 as the second key and item, etc. Up to 100 key/item
// pairs can be passed. An item is optional (or *null). Key/items
// of which the key is *null are ignored.
// Items which were not inserted because no key was specified will be
// disposed, unless the item is a manually disposed map, or a value/map
// contained in a map.
dcl-pr rm_m pointer extproc(*dclcase);
// Parameters k001/i001 .. k100/i100
// k001 pointer value options(*nopass);
// i001 pointer value options(*nopass);
// k002 pointer value options(*nopass);
// i002 pointer value options(*nopass);
// ...
/include _TLIB_/INCLUDERPG,RPGMAPI001
end-pr;


////////// rm_mm - Create a new map, manually disposed
// Same as 'rm_m' except that the new map is not automatically disposed
// and must always be manually disposed with 'rm_dis'. However, unlike
// automatically disposed maps, a manually disposed map can be inserted
// into multiple maps.
dcl-pr rm_mm pointer extproc(*dclcase);
// Parameters k001/i001 .. k100/i100
// k001 pointer value options(*nopass);
// i001 pointer value options(*nopass);
// k002 pointer value options(*nopass);
// i002 pointer value options(*nopass);
// ...
/include _TLIB_/INCLUDERPG,RPGMAPI001
end-pr;


////////// rm_v - Create a new vector, automatically disposed
// Create a vector, i.e. same as 'rm_m' except that the keys can be only
// integer values and two vectors are compared in a special way (see 'rm_cmp').
// E.g. rm_v(rm_d(d'2017-01-01'):rm_i(10)) and rm_v(rm_d(d'2017-01-01')) are 
// considered equal.
// The parameters of this procedure to immediately populate the vector only
// accept items. The keys are automatically generated. The first item is inserted
// with key 'rm_i(1)', the second with key 'rm_i(2)', etc.
// A vector represents a simple sequence of items, and is specially useful as
// a (partial) composite key.
dcl-pr rm_v pointer extproc(*dclcase);
// Parameters i001 .. i100
// i001 pointer value options(*nopass);
// i002 pointer value options(*nopass);
// ...
/include _TLIB_/INCLUDERPG,RPGMAPI002
end-pr;


////////// rm_ism - Is map?
// Return *on if 'obj' is a map/vector, else return *off.
dcl-pr rm_ism ind extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_ismm - Is manually disposed map?
// Return *on if 'obj' is a manually disposed map, else return *off.
dcl-pr rm_ismm ind extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_isv - Is vector?
// Return *on if 'obj' is a vector, else return *off.
dcl-pr rm_isv ind extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_inm (rm_in_map) - In map?
// Return *on if 'obj' is (contained) in a map, else return *off.
// Send escape message RM09005 if 'obj' is not a value or an
// automatically disposed map.
dcl-pr rm_inm ind extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_mmm (rm_make_map_manually_disposed) - Make map manually disposed
// Make 'map' a *manually* disposed map, and return 'map'.
// Send escape message RM00051 if 'map' is not an automatically disposed map,
// or if 'map' is a vector.
// This operation can not be undone; a manually disposed map can not be made
// automatically disposed.
dcl-pr rm_mmm pointer extproc(*dclcase);
  map pointer value;
end-pr;


////////// rm_mmi (rm_make_map_immutable) - Make map immutable
// Make 'map' immutable, and return 'map'.
// An immutable map can not be mutated, i.e. no key/item pairs can be inserted
// into or removed from the map. If a key/item pair is inserted into or removed
// from an immutable map then escape message RM00005 is sent.
// All contained *automatically* disposed maps (thus including vectors) are also
// made immutable, recursively.
// If 'opt' is passed with "*mm" then all contained *manually* disposed maps are
// also made immutable, recursively, like contained automatically disposed maps.
// If 'map' is already immutable then this operation has no effect.
// This operation can not be undone; an immutable map can not be made mutable again.
// When a map is copied ('rm_cpy') then the new copy is mutable.
dcl-pr rm_mmi pointer extproc(*dclcase);
  map pointer value;
  opt char(10) value options(*nopass);
end-pr;


////////// rm_dis (rm_dispose) - Dispose maps, cursors and values
// Dispose objects 'o001' thru 'o100'. Each object can be a map, a cursor
// or a value.
// When an object is disposed its memory is released/freed.
// Use this procedure when a map, cursor or value is not used anymore.
// If a map is disposed then all associated cursors are also disposed.
// If a map is disposed then all its keys and items are also disposed, i.e.
// all contained maps and values are disposed except manually disposed maps,
// which must always be disposed directly using 'rm_dis'.
// Values and automatically disposed maps that are contained in (have been
// inserted into) a map can not be directly disposed with 'rm_dis'.
// Send escape message RM00030 if the object to dispose is a value that is
// contained in a map, or is an automatically disposed map that is contained
// in a map.
dcl-pr rm_dis extproc(*dclcase);
// Parameters o001 .. o100
// o001 pointer value options(*nopass);
// o002 pointer value options(*nopass);
// ...
/include _TLIB_/INCLUDERPG,RPGMAPI003
end-pr;


////////// rm_ins (rm_insert) - Insert key/item pairs
// Insert up to 100 new key/item pairs into 'map' and return 'map'.
// The keys and items must be maps or values. Values are automatically
// disposed when their containing map is disposed, or when the key/item
// is removed from the map. Maps that are not created with 'rm_mm' are
// also automatically disposed, just like values.
// A key/item pair is inserted into a specific slot, depending on the
// key's order among the other keys. This slot is fixed and the key's
// order should not be affected by changing the key's contents and/or
// properties.
// Values and maps that are automatically disposed can only be inserted
// once into a map. When an automatically disposed map or a value is
// inserted into a map and the map/value has already been inserted into
// a map then escape message RM00010/RM00012 is sent.
// Keys can not be *null.
// Items can be *null.
// A map is allowed to contain duplicate keys (i.e. keys that are equal).
// If 'map' already contains one or more keys that are equal to 'key' then
// 'key' is inserted at the end. Searching among equal keys is linear
// time, O(n), and lots of duplicates and/or "equal" searches should therefore
// be avoided.
// Starting at the second argument, every even and uneven argument corresponds
// to a key/item pair that is to be inserted. Pairs where the key is *null
// are ignored.
// Items which were not inserted (because no key was specified) will be
// disposed, unless the item is a manually disposed map, or a value/map
// contained in a map.
dcl-pr rm_ins pointer extproc(*dclcase);
  map pointer value;
// Parameters k001/i001 .. k100/i100
// k001 pointer value options(*nopass);
// i001 pointer value options(*nopass);
// k002 pointer value options(*nopass);
// i002 pointer value options(*nopass);
// ...
/include _TLIB_/INCLUDERPG,RPGMAPI001
end-pr;


////////// rm_ins1 (rm_insert_1) - Insert 1 key/item pair
// Like 'rm_ins', but with only one key/item pair.
// This is the faster version when only one key/item pair needs
// to be inserted.
dcl-pr rm_ins1 pointer extproc(*dclcase);
  map pointer value;
  key pointer value options(*nopass);
  item pointer value options(*nopass);
end-pr;


////////// rm_insm (rm_insert_map) - Insert key/item pairs, from map
// Like 'rm_ins', but the key/item pairs to insert are contained in 'map2'.
// The values and automatically disposed maps in 'map2' that are to be
// inserted are not inserted directly, but instead a copy is made ('rm_cpy')
// that is actually inserted. Manually disposed maps are not copied; they're
// inserted directly.
// If 'key1' and/or 'key2' are passed and not *null then only the key/item
// pairs in 'map2' with key equal to or greater than 'key1', and equal to
// or less than 'key2', will be inserted. Both keys are optional. If 'key1'
// is not passed or *null it's assumed to be the lowest key. If 'key2' is
// not passed it's assumed to be the same as 'key1' (if 'key1' is passed).
// If 'key2' is *null it's assumed to be the highest key. Nothing is
// inserted if 'key1' is greater than 'key2', or if only 'key1' is passed
// with value *null.
// This procedure disposes 'key1' and 'key2' automatically, unless
// 'key1'/'key2' is a manually disposed map, or a value/map contained
// in a map.
// This procedure does not dispose 'map2' or it's keys/items.
dcl-pr rm_insm pointer extproc(*dclcase);
  map pointer value;
  map2 pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;


////////// rm_insc (rm_insert_cond) - Insert key/item pairs, conditionally
// Like 'rm_ins', but a key/item pair is only inserted if there is
// no key in 'map' that is equal to the key to be inserted. 
// Keys and items that are not inserted are disposed automatically,
// unless they are manually disposed maps, or values/maps contained
// in a map.
dcl-pr rm_insc pointer extproc(*dclcase);
  map pointer value;
// Parameters k001/i001 .. k100/i100
// k001 pointer value options(*nopass);
// i001 pointer value options(*nopass);
// k002 pointer value options(*nopass);
// i002 pointer value options(*nopass);
// ...
/include _TLIB_/INCLUDERPG,RPGMAPI001
end-pr;


////////// rm_insc1 (rm_insert_cond_1) - Insert 1 key/item pair, conditionally
// Like 'rm_insc', but with only one key/item pair.
// This is the faster version when only one key/item pair needs
// to be inserted.
dcl-pr rm_insc1 pointer extproc(*dclcase);
  map pointer value;
  key pointer value options(*nopass);
  item pointer value options(*nopass);
end-pr;


////////// rm_inscm (rm_insert_cond_map) - Insert key/item pairs, conditionally, from map
// Like 'rm_insm', but a key/item pair is only inserted if there is
// no key in 'map' that is equal to the key to be inserted.
dcl-pr rm_inscm pointer extproc(*dclcase);
  map pointer value;
  map2 pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;


////////// rm_insx (rm_insert_excl) - Insert key/item pairs, exclusive
// Like 'rm_ins', but before a key/item pair is inserted all key/item
// pairs with a key equal to the key to be inserted are removed first
// (i.e. they're replaced).
dcl-pr rm_insx pointer extproc(*dclcase);
  map pointer value;
// Parameters k001/i001 .. k100/i100
// k001 pointer value options(*nopass);
// i001 pointer value options(*nopass);
// k002 pointer value options(*nopass);
// i002 pointer value options(*nopass);
// ...
/include _TLIB_/INCLUDERPG,RPGMAPI001
end-pr;


////////// rm_insx1 (rm_insert_excl_1) - Insert 1 key/item pair, exclusive
// Like 'rm_insx', but with only one key/item pair.
// This is the faster version when only one key/item pair needs
// to be inserted.
dcl-pr rm_insx1 pointer extproc(*dclcase);
  map pointer value;
  key pointer value options(*nopass);
  item pointer value options(*nopass);
end-pr;


////////// rm_insxm (rm_insert_excl_map) - Insert key/item pairs, exclusive, from map
// Like 'rm_insm', but before a key/item pair is inserted all key/item
// pairs with a key equal to the key to be inserted are removed first.
dcl-pr rm_insxm pointer extproc(*dclcase);
  map pointer value;
  map2 pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;


////////// rm_rmv (rm_remove) - Remove key/item pair
// Remove the key/item pair with key equal to 'key' from 'map', if 
// found, and return 'map'. If not found do nothing, and return 'map'.
// If the key and/or item is a value or an automatically disposed map
// then they're disposed.
// In case there are multiple keys equal to 'key' then 'opt' indicates
// which key: "*f" or "*first" for the first one (which is the default),
// or "*l" or "*last" for the last one.
// This procedure disposes 'key' automatically, unless 'key' is a manually
// disposed map, or a value/map contained in a map.
dcl-pr rm_rmv pointer extproc(*dclcase);
  map pointer value;
  key pointer value;
  opt char(10) value options(*nopass);
end-pr;


////////// rm_rmva (rm_remove_all) - Remove all key/item pairs
// Like 'rm_rmv', but all key/item pairs with key equal to or greater
// than 'key1', and equal to or less than 'key2' are removed from 'map'.
// Both keys are optional. If 'key1' is not passed or *null it's assumed
// to be the lowest key. If 'key2' is not passed it's assumed to be the 
// same as 'key1' (if 'key1' is passed). If 'key2' is *null it's assumed
// to be the highest key. Remove nothing if 'key1' is greater than 'key2',
// or if only 'key1' is passed with value *null.
// This procedure disposes 'key1' and 'key2' automatically, unless
// 'key1'/'key2' is a manually disposed map, or a value/map contained in
// a map.
dcl-pr rm_rmva pointer extproc(*dclcase);
  map pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;


////////// rm_cmp (rm_compare) - Compare two objects
// Compare 'obj1' with 'obj2'. They can be *null, a value or a map.
// Return -1 if 'obj1' is less than 'obj2', return 1 if 'obj1' is
// greater than 'obj2', return 0 if 'obj1' and 'obj2' are equal.
// Two *nulls are considered equal.
// This is the default compare function for maps. The compare function
// of a map determines the ordering of the keys in the map. This can
// be overridden for a specific map with 'rm_scf'.
// Two objects have a natural ordering when they are of the same kind:
//   - character data having the same sort sequence;
//   - strings having the same sort sequence;
//   - numbers;
//   - times;
//   - dates and timestamps;
//   - indicators (*off < *on);
//   - pointers;
//   - procedure pointers;
//   - maps.
// If the objects don't have a natural order then they are ordered
// based on their type as follows:
//     *null `< n < i < p < t < d < z < x < xp < a < aa < s < sa < m/v 
// Two maps are equal if they both have the exact same keys and items,
// in the same order.
// The attributes of maps ('rm_sav') are ignored when doing comparisons
// between maps.
// When two maps or a map and a vector are compared, then first the keys
// of the two maps are compared, in order. The lowest key of the first map
// is compared with the lowest key of the second map. If they are equal then
// the next two keys are compared, until the two keys are unequal or until
// the last key of one or both of the maps have been compared. If the two
// keys are unequal then the result is the comparison of these keys. If one
// map has no more keys but the other still has keys to compare then the
// latter is considered greater. If the keys of both maps are exactly the
// same then the items are compared using the same method. The items are
// compared one by one from each map, in key-order, starting with the two
// items with the lowest key, until the two items are unequal or until there
// are no items left.
// When two vectors (maps created with 'rm_v') are compared the comparison
// is done in a special way. Only the items are compared (in key-order);
// not the keys. So the keys of two vectors may differ, but the vectors
// are still be considered equal when their items are equal. Also, if the
// vectors have a different number of items (keys) the extra items are
// ignored. So rm_v(rm_d(d'2017-01-01'):rm_i(10)) and rm_v(rm_d(d'2017-01-01'))
// are considered equal. An empty vector, rm_v(), is equal to every other
// vector. The way two vectors are compared makes them suitable as (partial)
// composite keys.
// When either one of 'obj1' or 'obj2' has the "reversed order" special
// property (see 'rm_') then the ordering between 'obj1' and 'obj2' is
// reversed wrt the normal ordering. What is normally greater than is now
// less than and vice versa (*hival has the lowest order).
// When either one of 'obj1' or 'obj2' has the "case insensitive order"
// special property (see 'rm_') then both are compared such that there
// is no difference between uppercase and lowercase characters.
// Character data and strings (char data in utf-8 format) can have the
// property that an alternate sort (collating) sequence is used to
// compare them. The specific sort sequence is fixed; it's set when
// RpgMap is built. When not explicitly changed it should be *langidshr.
// When two character data fields or two strings are compared with each
/// other and both have this property then the comparison is done using
// the alternate sort sequence.
// Strings must be converted first to the job CCSID before they can be
// compared using the alternate sort sequence. This takes considerably
// more resources than when the default sort sequence is used.
dcl-pr rm_cmp int(10) extproc(*dclcase);
  obj1 pointer value;
  obj2 pointer value;
end-pr;
////////// rm_ceq (rm_compare_eq) - 'obj1' = 'obj2' ?
// Return *on if 'obj1' is equal to 'obj2', else return *off.
dcl-pr rm_ceq ind extproc(*dclcase);
  obj1 pointer value;
  obj2 pointer value;
end-pr;
////////// rm_clt (rm_compare_lt) - 'obj1' < 'obj2' ?
// Return *on if 'obj1' is less than 'obj2', else return *off.
dcl-pr rm_clt ind extproc(*dclcase);
  obj1 pointer value;
  obj2 pointer value;
end-pr;
////////// rm_cle (rm_compare_le) - 'obj1' <= 'obj2' ?
// Return *on if 'obj1' is equal to or less than 'obj2', else return *off.
dcl-pr rm_cle ind extproc(*dclcase);
  obj1 pointer value;
  obj2 pointer value;
end-pr;
////////// rm_cgt (rm_compare_gt) - 'obj1' > 'obj2' ?
// Return *on if 'obj1' is greater than 'obj2', else return *off.
dcl-pr rm_cgt ind extproc(*dclcase);
  obj1 pointer value;
  obj2 pointer value;
end-pr;
////////// rm_cge (rm_compare_ge) - 'obj1' >= 'obj2' ?
// Return *on if 'obj1' is equal to or greater than 'obj2', else return *off.
dcl-pr rm_cge ind extproc(*dclcase);
  obj1 pointer value;
  obj2 pointer value;
end-pr;


////////// rm_ (rm_set_prop) - Set special property
// Set the special property specified with 'opt' for 'obj', which is a map or
// a value, and return 'obj'.
// opt:
//   0: reversed order,
//   1: case insensitive order,
//   2: both,
//  -1 .. -65000: user data (an integer between 1 and 65.000),
//  90: clear reversed order & case insensitive order,
//  91: clear user data.
// If 'opt' is not passed then 0 is assumed.
// Some properties are not supported for some types.
// Send escape message RM00111 if 'opt' is not supported.
// When creating values (e.g. with 'rm_i' or 'rm_a') use the creating
// procedure's 'opt' parameter to set a special property, instead of 
// using 'rm_', if possible. For example 'rm_i(1:0)' creates an integer
// value, 1, with reversed order, and 'rm_a('abc':-100)' creates a character
// value with user data 100. When creating maps there is no 'opt' parameter
// so 'rm_' must always be used instead.
// Specify 90 or 91 for 'opt' to clear (remove) special properties or user
// data.
// ** Reversed Order **
// If a map or value has the "reversed order" property, then when it's
// compared to other maps or values the sort order is reversed. Value
// *hival is then the lowest in order, and vice versa. When comparing
// two objects, reversed order is in effect when at least one has the
// reversed order property set, otherwise normal order is in effect.
// ** Case Insensitive Order **
// If 'obj' is character data or a string, with normal sort sequence,
// then the "case insensitive order" can be set. If set, then when 'obj'
// is compared with other character data or strings this is done without
// difference between uppercase and lowercase characters. Like reversed
// order, case insensitive order is in effect when two objects are compared
// and at least one of them has the case insensitive order property.
// Some extra processing is required when a case insensitive comparison is
// done. Especially when setting this property for strings, as they need to
// be converted to the job CCSID first, before being compared case insensitive.
// ** User Data **
// A map or value can be associated with user data, which is a positive integer
// value between 1 and 65.000 that is application specific. Like attributes
// ('rm_sav'), user data is used to store meta data.
// Associating user data does not increase memory usage.
// Procedure 'rm_usrd' returns the user data for a map or value.
// The user data is specified as a negative integer; specifying -1 means that
// 'rm_usrd' returns 1.
// If 'opt' is 91 then the user data is cleared, i.e. 'rm_usrd' returns 0.
dcl-pr rm_ pointer extproc(*dclcase);
  obj pointer value;
  opt int(10) value options(*nopass);
end-pr;


////////// rm_get - Retrieve item with a key
// Return the item of the key/item pair in 'map' with key equal to 'key'.
// Return *null if not found.
// In case there are multiple keys equal to 'key' then 'opt' indicates
// which key: "*f" or "*first" for the first one (which is the default),
// or "*l" or "*last" for the last one.
// This procedure disposes 'key' automatically, unless 'key' is a manually
// disposed map, or a value/map contained in a map.
dcl-pr rm_get pointer extproc(*dclcase);
  map pointer value;
  key pointer value;
  opt char(10) value options(*nopass);
end-pr;


////////// rm__ - Retrieve item with one or more keys
// Like 'rm_get', but procedures 'rm__*' retrieve an item using one or more
// keys. There is a version for each data type, so that the keys can be given
// as normal RPG data types (although they can't be intermixed).
// When multiple keys are given the item is retrieved through one or more
// nested maps.
// First the item in 'map' with key equal to the first passed key is retrieved.
// If found and the item is a map and there is a second key passed then the item
// in this map with key equal to the second key is retrieved, etc. Return the last
// item retrieved, or *null if a key was not found in a map or if there are more
// keys passed than there are nested maps.
// Up to 10 keys can be passed. Parameters 'k01' through 'k10' are all
// optional. If none are passed then *null is returned. Keys that are *null
// are ignored.
// Use procedure 'rm__' as a generic procedure which accepts keys of any type.
// Use procedures 'rm__*' as a shortcut to pass keys as normal RPG values
// of a certain type. For character and string keys up to 200 bytes can be
// passed.
// If there are multiple keys equal to 'key' then the first one is selected.
// Procedure 'rm__' disposes all passed keys automatically, unless a key is
// a manually disposed map, or a value/map contained in a map.
dcl-pr rm__ pointer extproc(*dclcase);
  map pointer value;
// Parameters k01 .. k10: pointer
/include _TLIB_/INCLUDERPG,RPGMAPI051
end-pr;
dcl-pr rm__i pointer extproc(*dclcase);
  map pointer value;
// Parameters k01 .. k10: int(20)
/include _TLIB_/INCLUDERPG,RPGMAPI052
end-pr;
dcl-pr rm__p pointer extproc(*dclcase);
  map pointer value;
// Parameters k01 .. k10: packed(46:16)
/include _TLIB_/INCLUDERPG,RPGMAPI053
end-pr;
dcl-pr rm__d pointer extproc(*dclcase);
  map pointer value;
// Parameters k01 .. k10: date(*iso-)
/include _TLIB_/INCLUDERPG,RPGMAPI054
end-pr;
dcl-pr rm__t pointer extproc(*dclcase);
  map pointer value;
// Parameters k01 .. k10: time(*iso.)
/include _TLIB_/INCLUDERPG,RPGMAPI055
end-pr;
dcl-pr rm__z pointer extproc(*dclcase);
  map pointer value;
// Parameters k01 .. k10: timestamp
/include _TLIB_/INCLUDERPG,RPGMAPI056
end-pr;
dcl-pr rm__n pointer extproc(*dclcase);
  map pointer value;
// Parameters k01 .. k10: ind
/include _TLIB_/INCLUDERPG,RPGMAPI057
end-pr;
dcl-pr rm__x pointer extproc(*dclcase);
  map pointer value;
// Parameters k01 .. k10: pointer
/include _TLIB_/INCLUDERPG,RPGMAPI062
end-pr;
dcl-pr rm__xp pointer extproc(*dclcase);
  map pointer value;
// Parameters k01 .. k10: pointer(*proc)
/include _TLIB_/INCLUDERPG,RPGMAPI063
end-pr;
dcl-pr rm__a pointer extproc(*dclcase);
  map pointer value;
// Parameters k01 .. k10: varchar(200)
/include _TLIB_/INCLUDERPG,RPGMAPI058
end-pr;
dcl-pr rm__aa pointer extproc(*dclcase);
  map pointer value;
// Parameters k01 .. k10: varchar(200)
/include _TLIB_/INCLUDERPG,RPGMAPI060
end-pr;
dcl-pr rm__s pointer extproc(*dclcase);
  map pointer value;
// Parameters k01 .. k10: varchar(200) ccsid(*utf8)
/include _TLIB_/INCLUDERPG,RPGMAPI059
end-pr;
dcl-pr rm__sa pointer extproc(*dclcase);
  map pointer value;
// Parameters k01 .. k10: varchar(200) ccsid(*utf8)
/include _TLIB_/INCLUDERPG,RPGMAPI061
end-pr;


////////// rm_hky (rm_has_key) - Has key?
// Return *on if 'map' has a key that is equal to 'key', else return *off.
// This procedure disposes 'key' automatically, unless 'key' is a manually
// disposed map, or a value/map contained in a map.
dcl-pr rm_hky ind extproc(*dclcase);
  map pointer value;
  key pointer value;
end-pr;


////////// rm_hks (rm_has_keys) - Has keys?
// If 'opt' is "*ge" or not passed, then return *on if 'map' has keys that
// are equal to or greater than 'key', else return *off. If 'opt' is "*le"
// then return *on if 'map' has keys that are equal to or less than 'key'.
// This procedure disposes 'key' automatically, unless 'key' is a manually
// disposed map, or a value/map contained in a map.
dcl-pr rm_hks ind extproc(*dclcase);
  map pointer value;
  key pointer value;
  opt char(10) value options(*nopass);
end-pr;


////////// rm_num (rm_num_keys) - Number of key/item pairs
// Return the number of key/item pairs in 'map' with key equal to or
// greater than 'key1', and equal to or less than 'key2'. Both keys
// are optional. If 'key1' is not passed or *null it's assumed to be
// the lowest key. If 'key2' is not passed it's assumed to be the same
// as 'key1' (if 'key1' is passed). If 'key2' is *null it's assumed to
// be the highest key. Return 0 if 'key1' is greater than 'key2', or
// only 'key1' is passed with value *null.
// This procedure is not efficient. Unless both keys are *null or not 
// passed (i.e. all key/item pairs) it counts the number of keys each
// time it's called (no caching).
// This procedure disposes 'key1' and 'key2' automatically, unless 
// 'key1'/'key2' is a manually disposed map, or a value/map contained
// in a map.
dcl-pr rm_num uns(20) extproc(*dclcase);
  map pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;


////////// rm_hit (rm_has_item) - Has item?
// Return *on if 'map' has an item that is equal to 'item', else return *off.
// A slow linear search is performed.
// Items are always compared using the default compare function 'rm_cmp'.
// If 'key1' and/or 'key2' are passed and not *null then only the items with
// keys equal to or greater than 'key1', and equal to or less than 'key2',
// will be considered. Both keys are optional. If 'key1' is not passed or *null
// it's assumed to be the lowest key. If 'key2' is not passed it's assumed to be
// the same as 'key1' (if 'key1' is passed). If 'key2' is *null it's assumed to
// be the highest key. Return *off if 'key1' is greater than 'key2', or if only
// 'key1' is passed with value *null.
// This procedure disposes 'item', 'key1' and 'key2' automatically, unless they're
// a manually disposed map, or a value/map contained in a map.
dcl-pr rm_hit ind extproc(*dclcase);
  map pointer value;
  item pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;


////////// rm_nit (rm_num_items) - Number of items
// Return the number of items in 'map' that are equal to 'item'.
// Items are always compared using the default compare function 'rm_cmp'.
// If 'key1' and/or 'key2' are passed and not *null then only the items with
// keys equal to or greater than 'key1', and equal to or less than 'key2',
// will be considered. Both keys are optional. If 'key1' is not passed or *null
// it's assumed to be the lowest key. If 'key2' is not passed it's assumed to be
// the same as 'key1' (if 'key1' is passed). If 'key2' is *null it's assumed to
// be the highest key. Return 0 if 'key1' is greater than 'key2', or if only
// 'key1' is passed with value *null.
// This procedure disposes 'item', 'key1' and 'key2' automatically, unless they're
// a manually disposed map, or a value/map contained in a map.
dcl-pr rm_nit uns(20) extproc(*dclcase);
  map pointer value;
  item pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;


////////// rm_gik (rm_get_item_key) - Get item key
// Return the key of the item in 'map' that is equal to 'item'.
// A slow linear search is performed.
// Items are always compared using the default compare function 'rm_cmp'.
// In case there are multiple items equal to 'item' then 'opt' indicates
// which item: "*f" or "*first" for the first one (which is the default),
// or "*l" or "*last" for the last one (key order). Using "*f"/"*first" or
// "*l"/"*last" makes no difference in performance.
// If 'key1' and/or 'key2' are passed and not *null then only the items with
// keys equal to or greater than 'key1', and equal to or less than 'key2',
// will be considered. Both keys are optional. If 'key1' is not passed or *null
// it's assumed to be the lowest key. If 'key2' is not passed it's assumed to be
// the same as 'key1' (if 'key1' is passed). If 'key2' is *null it's assumed to
// be the highest key. Return *null if 'key1' is greater than 'key2', or if only
// 'key1' is passed with value *null.
// This procedure disposes 'item', 'key1' and 'key2' automatically, unless they're
// a manually disposed map, or a value/map contained in a map.
dcl-pr rm_gik pointer extproc(*dclcase);
  map pointer value;
  item pointer value;
  opt char(10) value options(*nopass);
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;


////////// rm_cpy (rm_copy) - Copy map or value
// Return a (shallow) copy of 'obj', which must be a map or a value.
// The new map or value has the same properties and attributes as 'obj',
// except that a new copy of a map is always mutable. The copy contains
// the same key/item pairs as 'obj'. The keys/items in the copy that are
// values or automatically disposed maps are copies of the originals in
// 'obj'. Manually disposed maps are not copied; the copy will contain
// the same instances.
// Event handlers are NOT copied; the copy has no event handlers.
// Return *null if 'obj' is *null.
// Use 'rm_cpyd' to make a deep copy of a map, in which case manually
// disposed maps are also (deep) copied.
// The new copy is always mutable. Maps contained in 'obj' that are
// immutable stay immutable and copies of these maps that are included
// in the copy are also immutable.
// Be aware that when manually disposed maps are not used then 'rm_cpy'
// and 'rm_cpyd' have the same effect, i.e. contained maps are copied
// recursively, effectively producing a deep copy. Avoid excessive memory
// use. When only manually disposed maps are used instead of automatically
// disposed maps then 'rm_cpy' will produce a real shallow copy.
// If 'key1' and/or 'key2' are passed and not *null the copy will only
// contain the key/item pairs from 'obj' with key equal to or greater than
// 'key1', and equal to or less than 'key2'. Both keys are optional. If
// 'key1' is not passed or *null it's assumed to be the lowest key. If
// 'key2' is not passed it's assumed to be the same as 'key1' (if 'key1'
// is passed). If 'key2' is *null it's assumed to be the highest key.
// Return an empty map if 'key1' is greater than 'key2', or if only 'key1'
// is passed with value *null.
// Ignore 'key1'/'key2' if 'obj' is a value.
// An alternative way to copy for example an integer value: rm_i(rm_i_(val)).
// This procedure disposes 'key1' and 'key2' automatically, unless 
// 'key1'/'key2' is a manually disposed map, or a value/map contained
// in a map.
dcl-pr rm_cpy pointer extproc(*dclcase);
  obj pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;


////////// rm_cpyd (rm_copy_deep) - Deep copy map or value
// Like 'rm_cpy', but returns a deep copy.
// For values, 'rm_cpyd' has the same effect as 'rm_cpy'.
// For maps, contained manually disposed maps are copied also, recursively,
// like automatically disposed maps.
dcl-pr rm_cpyd pointer extproc(*dclcase);
  obj pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;


////////// rm_cur (rm_cursor) - Create a new cursor
// Return a new cursor for 'map'. The cursor is positioned at the beginning
// or the end, depending on whether 'opt' is "*b"/"*begin" or "*e"/"*end",
// resp. Optional parameter 'opt' defaults to "*b".
// The cursor should be disposed with 'rm_dis' when it's not used anymore. It
// is automatically disposed when 'map' is disposed.
dcl-pr rm_cur pointer extproc(*dclcase);
  map pointer value;
  opt char(10) value options(*nopass);
end-pr;


////////// rm_sll, rm_sgt (rm_setll, rm_setgt) - Set lower limit, Set greater than
// Position cursor 'cur' on 'key' and return 'cur'. 
// Call 'rm_sll' to position the cursor just before the lowest key that is equal
// to or greater than 'key'. Call 'rm_sgt' to position the cursor just after the
// highest key that is equal to or less than 'key'. If 'key' is *null or not passed
// then the cursor is positioned at the beginning or the end, resp.
// After calling one of these procedures cursor 'cur' has no current key/item pair.
// Call 'rm_rdn' or 'rm_rdp' to read the next or previous key/item pair, resp.,
// which then becomes the current key/value pair.
// If 'rm_sll' is called and the next key/item pair is removed from the map the
// cursor is positioned just after the previous pair. If 'rm_sgt' is called and
// the previous key/item pair is removed from the map the cursor is positioned
// just before the next pair.
// If 'rm_sll' is called and there is no key equal to or greater, or if 'rm_sgt'
// is called and there is no key equal to or less, the cursor is positioned at the
// end or beginning resp.
// These procedures dispose 'key' automatically, unless 'key' is a manually
// disposed map, or a value/map contained in a map.
dcl-pr rm_sll pointer extproc(*dclcase);
  cur pointer value;
  key pointer value options(*nopass);
end-pr;
dcl-pr rm_sgt pointer extproc(*dclcase);
  cur pointer value;
  key pointer value options(*nopass);
end-pr;


////////// rm_rdn, rm_rdp (rm_read_next, rm_read_prev) - Read next or previous key/item pair
// Call 'rm_rdn' to read the next key/item pair for cursor 'cur', or
// call 'rm_rdp' to read the previous key/item pair. The next/previous
// pair becomes the current key/item pair. Procedures 'rm_key' and
// 'rm_itm' are used to read the current key or item, resp.
// Return *on if there was a next or previous key/item. Return *off if
// the cursor is at the end or the beginning, in which case there is no
// current key/item anymore.
// Key/item pairs can be removed while a cursor iterates over them.
// If the current key/item pair is removed from the map then there is no
// current key/item pair anymore, and 'rm_key' and 'rm_itm' will return
// *null. If 'rm_rdn' was used to read the current key/item the cursor is
// positioned just before the key/item pair that comes after the removed
// key/item. If 'rm_rdp' was used the cursor is positioned just after the
// key/item pair that comes before the removed key/item. Procedures 'rm_rdn'
// and 'rm_rdp' must be used to get a current key/item pair again. The cursor
// is positioned at the end or beginning, resp., when there is no next or
// previous pair anymore. 
// If 'key1' and/or 'key2' are passed then the next or previous key must be
// equal to or greater than 'key1', and equal to or less than 'key2', else
// return *off (the cursor is at the end/beginning and there is no current
// key/item anymore). Both keys are optional. If 'key1' is not passed or
// *null it's assumed to be the lowest key. If 'key2' is not passed it's
// assumed to be the same as 'key1' (if 'key1' is passed). If 'key2' is
// *null it's assumed to be the highest key. Always return *off if 'key1'
// is greater than 'key2', or if only 'key1' is passed with value *null.
// These procedures dispose 'key1' and 'key2' automatically, unless
// 'key1'/'key2' is a manually disposed map, or a value/map contained
// in a map.
dcl-pr rm_rdn ind extproc(*dclcase);
  cur pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;
dcl-pr rm_rdp ind extproc(*dclcase);
  cur pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;


////////// rm_key - Return current key
// Return the current key for cursor 'cur', after calling 'rm_rdn' or 'rm_rdp'.
// Return *null if there is no current key/item pair.
dcl-pr rm_key pointer extproc(*dclcase);
  cur pointer value;
end-pr;


////////// rm_itm (rm_item) - Return current item
// Return the current item for cursor 'cur', after calling 'rm_rdn' or 'rm_rdp'.
// The current item may be *null.
// Call 'rm_key' to check whether there is a current key/item pair.
dcl-pr rm_itm pointer extproc(*dclcase);
  cur pointer value;
end-pr;


////////// rm_slln (rm_setll_read_next) - Set lower limit, read next
// This procedure combines 'rm_sll' and 'rm_rdn' into one, so that
// one expression enables both positioning the cursor and repeatedly
// reading the next key/item pair. Positioning is only done when
// input/output parameter 'pos' is *on, which is set to *off automatically
// when 'rm_slln' is called. This parameter should be *on the first time
// 'rm_slln' is called to trigger the positioning.
// Each time 'rm_slln' is called: 1. if 'pos' is *on the cursor is
// positioned with 'rm_sll' on 'key1', 2. 'pos' is set to *off, 3.
// 'rm_rdn' is called with 'key1' and 'key2' to read the next key/item
// pair, 4. the result of calling 'rm_rdn' is returned.
// When doing a read-equal (i.e. when specifying only 'key1' for 'rm_rdn'
// or 'rm_rdp'), 'key1' must be specified twice ('rm_sll' and 'rm_rdn').
// Using this method, 'key1' needs to be specified only once, but at the
// cost of the extra indicator which makes the code a little more complex.
// Parameter 'key1' is passed as argument 'key' to 'rm_sll' and 'key1'
// and 'key2' are passed to 'rm_rdn'. See the docs for 'rm_sll' and
// 'rm_rdn' on how optional parameters 'key1' and 'key2' are specified.
// The following code loops through all keys equal to d'2017-01-01'.
//     pos = *on;
//     dow rm_slln(cur:pos:rm_d(d'2017-01-01')); // 'pos' is set to *off
//       ... // set 'pos' to *on to trigger 'rm_sll' again while looping
//     enddo;
// If 'pos' is not passed or is *OMITted then the procedure behaves as if
// 'pos' would have been passed with value *on. This can be used to position
// the cursor and read the next key/item pair in one call without having
// to provide an indicator field.
// This procedure disposes 'key1' and 'key2' automatically, unless
// 'key1'/'key2' is a manually disposed map, or a value/map contained
// in a map.
dcl-pr rm_slln ind extproc(*dclcase);
  cur pointer value;
  pos ind options(*nopass:*omit);
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;


////////// rm_sgtp (rm_setgt_read_prev) - Set greater than, read previous
// Analogous to 'rm_slln', this procedure combines 'rm_sgt' and 
// 'rm_rdp' into one.
// Each time 'rm_sgtp' is called: 1. if 'pos' is *on the cursor is
// positioned with 'rm_sgt' on 'key1', 2. 'pos' is set to *off, 3.
// 'rm_rdp' is called with 'key1' and 'key2' to read the previous
// key/item pair, 4. the result of calling 'rm_rdp' is returned.
// Parameter 'key1' is passed as argument 'key' to 'rm_sgt' and 'key1'
// and 'key2' are passed to 'rm_rdp'. See the docs for 'rm_sgt' and
// 'rm_rdp' on how optional parameters 'key1' and 'key2' are specified.
// The following code loops through all keys equal to d'2017-01-01',
// but backwards.
//     pos = *on;
//     dow rm_sgtp(cur:pos:rm_d(d'2017-01-01')); // 'pos' is set to *off
//       ... // set 'pos' to *on to trigger 'rm_sgt' again while looping
//     enddo;
// If 'pos' is not passed or is *OMITted then the procedure behaves as if
// 'pos' would have been passed with value *on. This can be used to position
// the cursor and read the previous key/item pair in one call without having
// to provide an indicator field.
// This procedure disposes 'key1' and 'key2' automatically, unless
// 'key1'/'key2' is a manually disposed map, or a value/map contained
// in a map.
dcl-pr rm_sgtp ind extproc(*dclcase);
  cur pointer value;
  pos ind options(*nopass:*omit);
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;


////////// rm_hsn, rm_hsp (rm_has_next, rm_has_prev) - Has next/previous?
// Return *on if cursor 'cur' has a next or previous ('rm_hsn'/'rm_hsp')
// key/item pair, i.e. whether 'rm_rdn'/'rm_rdp' will return *on or not.
// If 'key1' and/or 'key2' are passed then the next or previous key must be
// equal to or greater than 'key1', and equal to or less than 'key2', else
// return *off. Both keys are optional. If 'key1' is not passed or *null
// it's assumed to be the lowest key. If 'key2' is not passed it's assumed
// to be the same as 'key1' (if 'key1' is passed). If 'key2' is *null it's
// assumed to be the highest key. Always return *off if 'key1' is greater
// than 'key2', or if only 'key1' is passed with value *null.
// These procedures dispose 'key1' and 'key2' automatically, unless
// 'key1'/'key2' is a manually disposed map, or a value/map contained
// in a map.
dcl-pr rm_hsn ind extproc(*dclcase);
  cur pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;
dcl-pr rm_hsp ind extproc(*dclcase);
  cur pointer value;
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;


////////// rm_fed, rm_fedr (rm_for_each_do, rm_for_each_do_rev) - For each do (reversed)
// Call procedure 'proc' for each key/item pair in 'map', injecting a
// pointer, then return the pointer that was returned with the last call
// to 'proc'.
// Procedure 'proc' must have the following signature:
//   rtn type: pointer
//   par. 1  : key  pointer value
//        2  : item pointer value
//        3  : usrd pointer value
//        4  : stop ind  
// Procedure 'proc' is executed for each key/item pair in 'map', starting
// with the lowest key, up to the highest key, or until 'proc' sets output
// parameter 'stop' to *on.
// Use 'rm_fedr' to start with the highest key down to the lowest key.
// Each time 'proc' is executed the key and item are passed as arguments 'key'
// and 'item'. Parameter 'usrd' is a pointer to data that is user defined and
// can be anything (e.g. a map or a value), or the pointer is *null. Procedure
// 'proc' returns this, or another, pointer which is then passed as argument
// 'usrd' the next time 'proc' is called again. So the return value of 'proc'
// is used as input for 'proc' the next time it's called. The initial user data
// pointer that is passed the first time 'proc' is called is passed to 'rm_fed'
// or 'rm_fedr' with parameter 'usrd'.
// Parameter 'usrd' is optional; if not passed the user data pointer is *null.
// If no key/item pair is read (and 'proc' doesn't get called) the return
// value will be 'usrd', or *null if 'usrd' is not passed.
// If 'key1' and/or 'key2' are passed then the key/item pairs that are
// processed are equal to or greater than 'key1', and equal to or less than
// 'key2'. Both keys are optional. If 'key1' is not passed or *null it's
// assumed to be the lowest key. If 'key2' is not passed it's assumed to
// be the same as 'key1' (if 'key1' is passed). If 'key2' is *null it's
// assumed to be the highest key. Read nothing if 'key1' is greater than
// 'key2', or if only 'key1' is passed with value *null.
// These procedures dispose 'key1' and 'key2' automatically, unless
// 'key1'/'key2' is a manually disposed map, or a value/map contained
// in a map.
dcl-pr rm_fed pointer extproc(*dclcase);
  map pointer value;
  proc pointer(*proc) value;
  usrd pointer value options(*nopass);
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;
dcl-pr rm_fedr pointer extproc(*dclcase);
  map pointer value;
  proc pointer(*proc) value;
  usrd pointer value options(*nopass);
  key1 pointer value options(*nopass);
  key2 pointer value options(*nopass);
end-pr;


////////// rm_scf (rm_set_comp_fun) - Set compare function
// Set the compare function of 'map', which must be empty, to 'comp',
// and return 'map'. Send escape messsage RM00041 if 'map' is not empty.
// The compare function of 'map' determines how the keys in 'map' are
// compared/ordered. Normally 'rm_cmp' is used as the compare function,
// but this can be overridden with another compare function, 'comp', for
// a specific map. When two keys that are both maps are compared, the
// order in which the keys and items are compared is determined by the
// compare functions of the two maps. But when two keys or items, from
// these two maps, are compared then the compare function of the containing
// map is used. Unless this behavior is changed with another compare function.
// Procedure 'comp' must have the following signature:
//   rtn type: int(10)
//   par. 1  : obj1 pointer value
//        2  : obj2 pointer value
// Procedure 'comp' compares 'obj1' and 'obj2', which can be *null or
// a value or a map, and returns 0 of they're equal, -1 if 'obj1' is
// less than 'obj2', or 1 if 'obj1' is greater than 'obj2'.
// If 'comp' returns something else than 0, 1 or -1 then the comparison
// falls back to 'rm_cmp'.
// If 'comp' is *null then 'rm_cmp' is reset to be used as the compare
// function again.
// The following is a simple example of a 'comp' procedure body, which
// has the effect that the sort order is reversed: return rm_cmp(obj1:obj2)*-1;.
dcl-pr rm_scf pointer extproc(*dclcase);
  map pointer value;
  comp pointer(*proc) value;
end-pr;


////////// rm_gcf (rm_get_comp_fun) - Get compare function
// Return the current compare function for 'map'. Return *null if the default
// function, 'rm_cmp', is in effect.
dcl-pr rm_gcf pointer(*proc) extproc(*dclcase);
  map pointer value;
end-pr;


////////// rm_sav (rm_set_attr_val) - Set attribute values
// Set up to 100 attributes of 'map' to a value and return 'map'.
// Each map can have one or more attributes set to a value, where
// each attribute has an utf-8 name, and an utf-8 value, both max.
// 100 bytes. There is no restriction on attribute names and values.
// The first attribute name and value is passed with parameters 2 and 3,
// 'a001' and 'v001', the second with 'a002' and 'v002', etc.
// Send escape message RM00102 if an attribute name is blank or empty. 
// If a value is not passed or it is blank or empty then the attribute
// is "unset".
// If no attribute names or values are passed at all (i.e. only 'map'
// is passed) then every attribute of 'map' is unset (all are cleared).
// Attributes are used to store settings and meta data that is used
// by different software modules/applications, either built-in or external.
// Attributes should be named "module-name" where module is the name of the
// module or function and name is the attribute name. The module's docs
// should specify the attributes that are used and their meaning.
// Attribute names starting with "_" (underscore) should not be used
// as these are reserved for RpgMap.
dcl-pr rm_sav pointer extproc(*dclcase);
  map pointer value;
// Parameters a001/v001 .. a100/v100
// a001 varchar(100) ccsid(*utf8) value options(*nopass);
// v001 varchar(100) ccsid(*utf8) value options(*nopass);
// a002 varchar(100) ccsid(*utf8) value options(*nopass);
// v002 varchar(100) ccsid(*utf8) value options(*nopass);
// ...
/include _TLIB_/INCLUDERPG,RPGMAPI064
end-pr;


////////// rm_gav (rm_get_attr_val) - Get attribute value
// Return the value of attribute 'attr' of 'map', or '' if the
// attribute is not set.
dcl-pr rm_gav varchar(100) ccsid(*utf8) extproc(*dclcase);
  map pointer value;
  attr varchar(100) ccsid(*utf8) value;
end-pr;


////////// rm_usrd (rm_user_data) - Return user data
// Return the user data of 'obj', which must be a map or a value.
// Return 0 if there is no user data.
// See 'rm_'.
dcl-pr rm_usrd int(10) extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_i* - Create a new integer value, 10/20 digits
// Create a new integer value, with 10 or 20 digits.
// Pass 'opt' to set special property or user data (see 'rm_').
dcl-pr rm_i pointer extproc(*dclcase);
  value int(10) value;
  opt int(10) value options(*nopass);
end-pr;
dcl-pr rm_i1 pointer extproc(*dclcase);
  value int(10) value;
  opt int(10) value options(*nopass);
end-pr;
dcl-pr rm_i2 pointer extproc(*dclcase);
  value int(20) value;
  opt int(10) value options(*nopass);
end-pr;


////////// rm_isi - Is any integer?
// Return *on if 'obj' is any integer type, else return *off.
dcl-pr rm_isi ind extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_isi1, rm_isi2 - Is integer with 10/20 digits?
// Return *on if 'obj' is an integer with 10 or 20 digits, else return *off.
dcl-pr rm_isi1 ind extproc(*dclcase);
  obj pointer value;
end-pr;
dcl-pr rm_isi2 ind extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_i*_ - Convert a number to an RPG integer value
// Return an RPG int(10) or int(20) from 'value', which must be a number.
// If 'value' is *null then return 0, or 'default' when passed. If 'value'
// is not a number escape message RM00011 (value not compatible) is sent.
// If the value is too big for the returned integer format then message
// MCH1210 (receiver value too small) is sent.
dcl-pr rm_i_ int(10) extproc(*dclcase);
  value pointer value;
  default int(10) value options(*nopass);
end-pr;
dcl-pr rm_i1_ int(10) extproc(*dclcase);
  value pointer value;
  default int(10) value options(*nopass);
end-pr;
dcl-pr rm_i2_ int(20) extproc(*dclcase);
  value pointer value;
  default int(20) value options(*nopass);
end-pr;


////////// rm_i*__ - Same as rm_i*_, and dispose the number
// Same as rm_i*_. Additionally, 'value' is immediately disposed.
dcl-pr rm_i__ int(10) extproc(*dclcase);
  value pointer value;
  default int(10) value options(*nopass);
end-pr;
dcl-pr rm_i1__ int(10) extproc(*dclcase);
  value pointer value;
  default int(10) value options(*nopass);
end-pr;
dcl-pr rm_i2__ int(20) extproc(*dclcase);
  value pointer value;
  default int(20) value options(*nopass);
end-pr;


////////// rm_p* - Create a new packed decimal value, 10.4/20.8/30.16 digits
// Create a new packed decimal value, with 10.4, 20.8 or 30.16 digits.
// Pass 'opt' to set special property or user data (see 'rm_').
dcl-pr rm_p pointer extproc(*dclcase);
  value packed(14:4) value;
  opt int(10) value options(*nopass);
end-pr;
dcl-pr rm_p1 pointer extproc(*dclcase);
  value packed(14:4) value;
  opt int(10) value options(*nopass);
end-pr;
dcl-pr rm_p2 pointer extproc(*dclcase);
  value packed(28:8) value;
  opt int(10) value options(*nopass);
end-pr;
dcl-pr rm_p3 pointer extproc(*dclcase);
  value packed(46:16) value;
  opt int(10) value options(*nopass);
end-pr;


////////// rm_isp - Is any packed decimal?
// Return *on if 'obj' is any packed decimal type, else return *off.
dcl-pr rm_isp ind extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_isp1, rm_isp2, rm_isp3 - Is packed decimal with 10.4/20.8/30.16 digits?
// Return *on if 'obj' is a packed decimal with 10.4, 20.8 or 30.16 digits,
// else return *off.
dcl-pr rm_isp1 ind extproc(*dclcase);
  obj pointer value;
end-pr;
dcl-pr rm_isp2 ind extproc(*dclcase);
  obj pointer value;
end-pr;
dcl-pr rm_isp3 ind extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_p*_ - Convert a number to an RPG packed decimal value
// Return an RPG packed(14:4), packed(28:8) or packed(46:16) from 'value',
// which must be a number. If 'value' is *null then return 0, or 'default'
// when passed. If 'value' is not a number escape message RM00011 (value not
// compatible) is sent. If the value is too big for the returned packed
// decimal format then message MCH1210 (receiver value too small) is sent.
dcl-pr rm_p_ packed(14:4) extproc(*dclcase);
  value pointer value;
  default packed(14:4) value options(*nopass);
end-pr;
dcl-pr rm_p1_ packed(14:4) extproc(*dclcase);
  value pointer value;
  default packed(14:4) value options(*nopass);
end-pr;
dcl-pr rm_p2_ packed(28:8) extproc(*dclcase);
  value pointer value;
  default packed(28:8) value options(*nopass);
end-pr;
dcl-pr rm_p3_ packed(46:16) extproc(*dclcase);
  value pointer value;
  default packed(46:16) value options(*nopass);
end-pr;


////////// rm_p*__ - Same as rm_p*_, and dispose the number
// Same as rm_p*_. Additionally, 'value' is immediately disposed.
dcl-pr rm_p__ packed(14:4) extproc(*dclcase);
  value pointer value;
  default packed(14:4) value options(*nopass);
end-pr;
dcl-pr rm_p1__ packed(14:4) extproc(*dclcase);
  value pointer value;
  default packed(14:4) value options(*nopass);
end-pr;
dcl-pr rm_p2__ packed(28:8) extproc(*dclcase);
  value pointer value;
  default packed(28:8) value options(*nopass);
end-pr;
dcl-pr rm_p3__ packed(46:16) extproc(*dclcase);
  value pointer value;
  default packed(46:16) value options(*nopass);
end-pr;


////////// rm_d, rm_t, rm_z - Create a new date/time/timestamp value
// Create a new date, time or timestamp value.
// Pass 'opt' to set special property or user data (see 'rm_').
dcl-pr rm_d pointer extproc(*dclcase);
  value date(*iso-) value;
  opt int(10) value options(*nopass);
end-pr;
dcl-pr rm_t pointer extproc(*dclcase);
  value time(*iso.) value;
  opt int(10) value options(*nopass);
end-pr;
dcl-pr rm_z pointer extproc(*dclcase);
  value timestamp value;
  opt int(10) value options(*nopass);
end-pr;


////////// rm_isd, rm_ist, rm_isz - Is date/time/timestamp?
// Return *on if 'obj' is a date, time or timestamp, else return *off.
dcl-pr rm_isd ind extproc(*dclcase);
  obj pointer value;
end-pr;
dcl-pr rm_ist ind extproc(*dclcase);
  obj pointer value;
end-pr;
dcl-pr rm_isz ind extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_d_, rm_t_, rm_z_ - Convert a date/time/ts to an RPG date/time/ts value
// Return an RPG date, time or timestamp from 'value', which must be a date,
// time or timestamp. If 'value' is *null then return *loval, or 'default'
// when passed. If 'value' is not compatible escape message RM00011 (value
// not compatible) is sent.
// Dates and times are not compatible.
// Times can only be converted to times.
// Dates are converted to timestamps using BIF %timestamp.
// Timestamps are converted to dates and times using BIF's %date and %time.
dcl-pr rm_d_ date(*iso-) extproc(*dclcase);
  value pointer value;
  default date(*iso-) value options(*nopass);
end-pr;
dcl-pr rm_t_ time(*iso.) extproc(*dclcase);
  value pointer value;
  default time(*iso.) value options(*nopass);
end-pr;
dcl-pr rm_z_ timestamp extproc(*dclcase);
  value pointer value;
  default timestamp value options(*nopass);
end-pr;


////////// rm_d__, rm_t__, rm_z__ - Same as rm_d/t/z_, and dispose the date/time/ts
// Same as rm_d/t/z_. Additionally, 'value' is immediately disposed.
dcl-pr rm_d__ date(*iso-) extproc(*dclcase);
  value pointer value;
  default date(*iso-) value options(*nopass);
end-pr;
dcl-pr rm_t__ time(*iso.) extproc(*dclcase);
  value pointer value;
  default time(*iso.) value options(*nopass);
end-pr;
dcl-pr rm_z__ timestamp extproc(*dclcase);
  value pointer value;
  default timestamp value options(*nopass);
end-pr;


////////// rm_n - Create a new indicator value
// Create a new indicator value.
// Pass 'opt' to set special property or user data (see 'rm_').
dcl-pr rm_n pointer extproc(*dclcase);
  value ind value;
  opt int(10) value options(*nopass);
end-pr;


////////// rm_isn - Is indicator?
// Return *on if 'obj' is an indicator, else return *off.
dcl-pr rm_isn ind extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_n_ - Convert an indicator to an RPG indicator value
// Return an RPG ind from 'value', which must be an indicator.
// If 'value' is *null then return *off, or 'default' when passed.
// If 'value' is not compatible escape message RM00011 (value not
// compatible) is sent.
dcl-pr rm_n_ ind extproc(*dclcase);
  value pointer value;
  default ind value options(*nopass);
end-pr;


////////// rm_n__ - Same as rm_n_, and dispose the indicator
// Same as rm_n_. Additionally, 'value' is immediately disposed.
dcl-pr rm_n__ ind extproc(*dclcase);
  value pointer value;
  default ind value options(*nopass);
end-pr;


////////// rm_x - Create a new pointer value
// Create a new pointer value.
// Pass 'opt' to set special property or user data (see 'rm_').
dcl-pr rm_x pointer extproc(*dclcase);
  value pointer value;
  opt int(10) value options(*nopass);
end-pr;


////////// rm_isx - Is pointer?
// Return *on if 'obj' is a pointer, else return *off.
dcl-pr rm_isx ind extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_x_ - Convert a pointer to an RPG pointer value
// Return an RPG pointer from 'value', which must be a pointer.
// If 'value' is *null then return *null, or 'default' when passed.
// If 'value' is not compatible escape message RM00011 (value not
// compatible) is sent.
dcl-pr rm_x_ pointer extproc(*dclcase);
  value pointer value;
  default pointer value options(*nopass);
end-pr;


////////// rm_x__ - Same as rm_x_, and dispose the pointer
// Same as rm_x_. Additionally, 'value' is immediately disposed.
dcl-pr rm_x__ pointer extproc(*dclcase);
  value pointer value;
  default pointer value options(*nopass);
end-pr;


////////// rm_xp - Create a new procedure pointer value
// Create a new pointer value.
// Pass 'opt' to set special property or user data (see 'rm_').
dcl-pr rm_xp pointer extproc(*dclcase);
  value pointer(*proc) value;
  opt int(10) value options(*nopass);
end-pr;


////////// rm_isx - Is procedure pointer?
// Return *on if 'obj' is a pointer, else return *off.
dcl-pr rm_isxp ind extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_xp_ - Convert a procedure pointer to an RPG procedure pointer value
// Return an RPG pointer(*proc) from 'value', which must be a procedure pointer.
// If 'value' is *null then return *null, or 'default' when passed.
// If 'value' is not compatible escape message RM00011 (value not
// compatible) is sent.
dcl-pr rm_xp_ pointer(*proc) extproc(*dclcase);
  value pointer value;
  default pointer(*proc) value options(*nopass);
end-pr;


////////// rm_xp__ - Same as rm_xp_, and dispose the procedure pointer
// Same as rm_xp_. Additionally, 'value' is immediately disposed.
dcl-pr rm_xp__ pointer(*proc) extproc(*dclcase);
  value pointer value;
  default pointer(*proc) value options(*nopass);
end-pr;


////////// rm_a - Create a new character data value
// Create a new character data value, up to 30.000 bytes long.
// Pass 'opt' to set special property or user data (see 'rm_').
dcl-pr rm_a pointer extproc(*dclcase);
  value varchar(30000) const;
  opt int(10) value options(*nopass);
end-pr;


////////// rm_ap - Create a new character data value, pointer to data
// Like 'rm_a', but the data is taken from a pointer and a number of bytes (i.e. size).
// The size must be between 1 and 30.000.
// The passed number of bytes ('size') are copied from the address to which
// the pointer ('addr') points. 
// Pass 'opt' to set special property or user data (see 'rm_').
dcl-pr rm_ap pointer extproc(*dclcase);
  addr pointer value;
  size int(10) value;
  opt int(10) value options(*nopass);
end-pr;


////////// rm_aa - Create a new character data value, alt. sort sequence
// Like 'rm_a', but the character data is compared using an alternate sort
// sequence. When two character data values are compared which are both
// created with 'rm_aa' or 'rm_aap' the comparison is done using the alternate
// sort sequence, instead of the default. Which sort sequence that is depends on 
// the build options that were used, but usually it is *langidshr.
// Comparing data using an alternate sort sequence may take more resources than
// when the default sort sequence is used.
// Pass 'opt' to set special property or user data (see 'rm_').
dcl-pr rm_aa pointer extproc(*dclcase);
  value varchar(30000) const;
  opt int(10) value options(*nopass);
end-pr;


////////// rm_aap - Create a new character data value, alt. sort seq., pointer to data
// Like 'rm_aa', but the data is taken from a pointer and a number of bytes (i.e. size).
// The size must be between 0 and 30.000.
// The passed number of bytes ('size') are copied from the address to which
// the pointer ('addr') points. 
// Pass 'opt' to set special property or user data (see 'rm_').
dcl-pr rm_aap pointer extproc(*dclcase);
  addr pointer value;
  size int(10) value;
  opt int(10) value options(*nopass);
end-pr;


////////// rm_isa - Is character data?
// Return *on if 'obj' is character data, else return *off.
dcl-pr rm_isa ind extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_isaa - Is character data with alt. sort seq.?
// Return *on if 'obj' is character data with alt. sort seq., else return *off.
dcl-pr rm_isaa ind extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_a*_ - Convert character data to RPG character data
// Return an RPG varchar from 'value', which must be character data
// or a string. If 'value' is a string then the raw bytes are returned;
// no text conversion. If 'value' is *null then return '', or 'default'
// when passed. If 'value' is not compatible escape message RM00011 (value
// not compatible) is sent.
// Procedures 'rm_a1_', 'rm_a2_' and 'rm_a3_' are a bit faster because
// of the shorter return value (100, 1000 or 10000).
dcl-pr rm_a_ varchar(30000) rtnparm extproc(*dclcase);
  value pointer value;
  default varchar(30000) const options(*nopass);
end-pr;
dcl-pr rm_a1_ varchar(100) rtnparm extproc(*dclcase);
  value pointer value;
  default varchar(100) const options(*nopass);
end-pr;
dcl-pr rm_a2_ varchar(1000) rtnparm extproc(*dclcase);
  value pointer value;
  default varchar(1000) const options(*nopass);
end-pr;
dcl-pr rm_a3_ varchar(10000) rtnparm extproc(*dclcase);
  value pointer value;
  default varchar(10000) const options(*nopass);
end-pr;


////////// rm_a*__ - Same as rm_a*_, and dispose the character data
// Same as rm_a*_. Additionally, 'value' is immediately disposed.
dcl-pr rm_a__ varchar(30000) rtnparm extproc(*dclcase);
  value pointer value;
  default varchar(30000) const options(*nopass);
end-pr;
dcl-pr rm_a1__ varchar(100) rtnparm extproc(*dclcase);
  value pointer value;
  default varchar(100) const options(*nopass);
end-pr;
dcl-pr rm_a2__ varchar(1000) rtnparm extproc(*dclcase);
  value pointer value;
  default varchar(1000) const options(*nopass);
end-pr;
dcl-pr rm_a3__ varchar(10000) rtnparm extproc(*dclcase);
  value pointer value;
  default varchar(10000) const options(*nopass);
end-pr;


////////// rm_s - Create a new string value
// Create a new string value, up to 30.000 bytes long.
// A string is character data (text) in utf-8 format.
// The raw bytes can be accessed with 'rm_a*_'.
// Pass 'opt' to set special property or user data (see 'rm_').
// The argument for parameter 'value' is converted to utf-8 when it's CCSID is
// not 65535. Each utf-8 character consists of one to four bytes. This means care
// should be taken that the converted value does not exceed 30.000 bytes.
dcl-pr rm_s pointer extproc(*dclcase);
  value varchar(30000) ccsid(*utf8) const;
  opt int(10) value options(*nopass);
end-pr;


////////// rm_sb - Create a new string value, from binary
// Like 'rm_s', but 'value' passes the raw bytes that is already in utf-8 format.
// Pass 'opt' to set special property or user data (see 'rm_').
dcl-pr rm_sb pointer extproc(*dclcase);
  value varchar(30000) const;
  opt int(10) value options(*nopass);
end-pr;


////////// rm_sa - Create a new string value, alt. sort sequence
// Like 'rm_s', but the string is compared using an alternate sort sequence.
// When two strings are compared which are both created with 'rm_sa'
// or 'rm_sab' the comparison is done using the alternate sort sequence,
// instead of the default. Which sort sequence depends on the build options
// that were used, but usually it is *langidshr. 
// Comparing strings using the alternate sort sequence takes considerably
// more resources than normal comparisons. Strings must be converted
// to the job CCSID first before they can be compared using the alternate
// sort sequence.
// Pass 'opt' to set special property or user data (see 'rm_').
dcl-pr rm_sa pointer extproc(*dclcase);
  value varchar(30000) ccsid(*utf8) const;
  opt int(10) value options(*nopass);
end-pr;


////////// rm_sab - Create a new string value, alt. sort sequence, from binary
// Like 'rm_sa', but 'value' passes the raw bytes that is already in utf-8 format.
// Pass 'opt' to set special property or user data (see 'rm_').
dcl-pr rm_sab pointer extproc(*dclcase);
  value varchar(30000) const;
  opt int(10) value options(*nopass);
end-pr;


////////// rm_iss - Is string?
// Return *on if 'obj' is a string, else return *off.
dcl-pr rm_iss ind extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_issa - Is string with alt. sort seq.?
// Return *on if 'obj' is a string with alt. sort seq., else return *off.
dcl-pr rm_issa ind extproc(*dclcase);
  obj pointer value;
end-pr;


////////// rm_s*_ - Convert string to RPG utf-8 character data
// Return an RPG varchar in utf-8 format from 'value', which must
// be a string. If 'value' is *null then return '', or 'default' when
// passed. If 'value' is not compatible escape message RM00011 (value
// not compatible) is sent.
// Procedures 'rm_s1_', 'rm_s2_', 'rm_s3_' are a bit faster because
// of the shorter return value (100, 1000 or 10000).
dcl-pr rm_s_ varchar(30000) ccsid(*utf8) rtnparm extproc(*dclcase);
  value pointer value;
  default varchar(30000) ccsid(*utf8) const options(*nopass);
end-pr;
dcl-pr rm_s1_ varchar(100) ccsid(*utf8) rtnparm extproc(*dclcase);
  value pointer value;
  default varchar(100) ccsid(*utf8) const options(*nopass);
end-pr;
dcl-pr rm_s2_ varchar(1000) ccsid(*utf8) rtnparm extproc(*dclcase);
  value pointer value;
  default varchar(1000) ccsid(*utf8) const options(*nopass);
end-pr;
dcl-pr rm_s3_ varchar(10000) ccsid(*utf8) rtnparm extproc(*dclcase);
  value pointer value;
  default varchar(10000) ccsid(*utf8) const options(*nopass);
end-pr;


////////// rm_s*__ - Same as rm_s*_, and dispose the string
// Same as rm_s*_. Additionally, 'value' is immediately disposed.
dcl-pr rm_s__ varchar(30000) ccsid(*utf8) rtnparm extproc(*dclcase);
  value pointer value;
  default varchar(30000) ccsid(*utf8) const options(*nopass);
end-pr;
dcl-pr rm_s1__ varchar(100) ccsid(*utf8) rtnparm extproc(*dclcase);
  value pointer value;
  default varchar(100) ccsid(*utf8) const options(*nopass);
end-pr;
dcl-pr rm_s2__ varchar(1000) ccsid(*utf8) rtnparm extproc(*dclcase);
  value pointer value;
  default varchar(1000) ccsid(*utf8) const options(*nopass);
end-pr;
dcl-pr rm_s3__ varchar(10000) ccsid(*utf8) rtnparm extproc(*dclcase);
  value pointer value;
  default varchar(10000) ccsid(*utf8) const options(*nopass);
end-pr;


////////// rm_add_event_handler - Add event handler
// Add event handler 'hproc' to the list of event handlers registered
// for 'map', and return 'map'.
// Events are fired when key/item pairs are inserted into and removed
// from 'map'. When an event is fired then all event handlers added to
// the map are called in the reversed order they were added (last one
// first).
// Procedure 'hproc' must have the following signature:
//   rtn type: int(10)
//   par. 1  : event int(10) value
//        2  : map   pointer value
//        3  : key   pointer value
//        4  : item  pointer value
//        5  : usrd  pointer value
// Parameter 'event' is 1 when the "inserted" event has been triggered
// just after a key/item pair has been inserted, or 2 when the "removed"
// event has been triggered just before a key/item pair is removed.
// Parameters 'key' and 'item' is the key/item pair that has been inserted,
// or is about to be removed. In the latter case the key and value will be
// removed immediately after all the event handlers have been called. When
// the key and value are removed they're disposed (unless they're manually
// disposed maps).
// Parameter 'map' is the map where the event was fired, 'usrd' is the
// user data that was optionally passed with parameter 'usrd' when adding
// the event handler with 'rm_add_event_handler' (or *null if not passed).
// The handler's return value is ignored.
// If the same handler is added multiple times it will be called as many 
// times as it was added.
// Event handlers are removed with procedure 'rm_remove_event_handler'.
// If a map is disposed then no event handlers will be called. Use 'rm_rmva'
// first to remove all key/value pairs and fire events, then dispose the map.
dcl-pr rm_add_event_handler pointer extproc(*dclcase);
  map pointer value;
  hproc pointer(*proc) value;
  usrd pointer value options(*nopass);
end-pr;


////////// rm_remove_event_handler - Remove event handler
// Remove event handler 'hproc' from the list of event handlers registered
// for 'map', and return 'map'.
// If the handler was added mutiple times then only the last one added
// is removed. 
// Do nothing if the handler isn't found.
dcl-pr rm_remove_event_handler pointer extproc(*dclcase);
  map pointer value;
  hproc pointer(*proc) value;
end-pr;


/include _TLIB_/INCLUDERPG,RPGMAPLPNH
