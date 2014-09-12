
NOTE: AST definitions coming soon-ish.

Arrays
======

An array data structure is a systematic placement container for multiple elements of the same type. In AnLang, it comes in three different flavors:

 * Dynamic array
 * Static array
 * Associative array

Generally, if an array is supposed to contain non-reference values, it will contain the values in-place. For reference values, the array will contain the references to the data.

If the element type is constant and the elements is a non-reference types, the single values may not be mutated. If the elements is a reference type, only the references themselves may not be mutated, the referenced values may still be mutated by the references.

Its index is a zero-based unsigned integer (`size_t` for system programmers, though this is not guaranteed by an implementation). Except for associative arrays, of course.

Dynamic array
==============

A dynamic array is dynamically allocated during runtime. Its length might vary during runtime. It may be initialized eagerly at program start / creation or lazily at first use.

Dynamic arrays are mutable in length by default to allow range operations and other common dynamic array operations like `pop`ing and `append`ing, even when no mutability modifier has been supplied (e.g. `int[]`). Its length may be declared constant by explicitly declaring the entire array type as constant (`const(int[])`).

If no initial value exists, it may be lazily allocated later once it receives a value. Until that happens, it acts as a zero-length array. The array itself can be accessed, though its values may not. It may be operated upon and modified, e.g. `append`ing is possible. `Pop`ping an empty dynamic array is not allowed (though it looks like we're going to end up in a runtime error).

Static array
=============

A static array is fixed in size. Its size has to be known at compile time. The entirety of the array should be allocated at creation. If not all elements of the static array are inhabited during the initialization, the remaining spots should be initialized to the initial value of the respective type.

A static array cannot be mutated in size, e.g. you can't pop nor append values. Thus, using an static array as a range primitive is not allowed.

Associative array
=================

An associative array, or dictionary in some circles, indexes its values contrary to a dynamic or static array by an arbitrary value of (nearly) any key type. Its implementation is usually a hash map and has to be provided in the implementation's runtime. Index type restrictions may be applied in reason by an implementation (e.g. requiring the type to be hashable).

For the initialization value, an implementation may provide a syntax akin to the array initialization syntax. Indexes have to be supplied unless the index type is known to be incrementable, in that case an implementation has to use the last-known incremented index value for the missing index.

Example: For `[2 => 'a', 5 => 'b', 'c', 10 => 'd']` (PHP 5.4+ syntax), the value `'c'` would have the index `6`.

The index type is immutable without exceptions. When using a reference type as the index type, the reference itself is used as the index value (it may be further hashed / processed depending on the implementation), not the referenced value.

A value may be accessed by the `#get(key)` operation. When a value for the specified key does not exist, an error must be emitted. Alternatively, one can use the `#get(key, default)` operation to avoid an error. The default value must be evaluated lazily once lazy evaluation has made it into the standard.

An associative array is mutable by default. Elements can be added with the `#set(key, val)` operation and removed with the `#remove(key)` operation. An implementation is free to provide syntactic sugar.

When specified constant, elements cannot be added or removed. At runtime, an error must be emitted. An implementation is free to assist with static analysis / compile-time errors. The mutability of its values is specified by the element type mutability.
