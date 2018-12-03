SYNOPSIS
========

 conf2struct -h schema.cfg > config.h
 conf2struct -c schema.cfg > config.c

DESCRIPTION
===========

`conf2struct` takes a configuration file that describes a
configuration file in the [libconfig](https://hyperrealm.github.io/libconfig/) format, and generates a C parser that will read a configuration file directly into a C structure. The goal is to accept any file that is valid for `libconfig`, which in particular means using `conf2struct` does not introduce restrictions to what the configuration file should look like.

`conf2struct` manageѕ optional settings and default values.

(A bit of history:
[sslh](http://www.rutschle.net/tech/sslh/README.html) uses
`libconfig`, which provides a C API. There are two downsides
to that: with the increase of the number of settings, the
code to read the configuration file grew and became harder
to read, while being all mostly boilerplate code; also,
every time it reads a setting `libconfig` traverses a tree
doing string compares on the setting names, which is very
inefficient for settings that get used very often: those
setting need to be copied to a structure. Put both problems
together, and you get this program as a solution by taking a
step up.)

Options
=======

* `-h` outputs the headers that describe the data structures
  and the main parser function.

* `-c` outputs the C code for the parser and printer.


Configuration file
==================

The format of the configuration file is itself described as
a configuration file which is somewhat similar to a schema
file. The file must contain a single list named `config`,
which contains entries for each configuration setting.

- `name` specifies the name of the setting
- `type` specifies the type of the setting. It is one of the
  libconfig types: `boolean`, `int`, `int64`, `float`,
`list`, `array`. Type can also be specified as `runtime` if
you want to add runtime data to the struct. The C type will
then be specified by the additionnal `c_type` setting. `c2s`
will do nothing with these types (no init, no alloc, no printing).


Scalars
-------

Scalar types take the additional following options:

- `default` specifies its default value. If the setting has no default,
then it is mandatory.
- `optional` specifies that a setting can be undefined.
  Undefined strings will point to NULL, and optional
settings receive an additional `<id>_is_present` boolean in the
final struct.


Lists
-----

List entries must contain an `items` setting which contains
another list. The items of that list are setting
configurations same as in the `config` list. Lists can
contain anything, include other lists.

Arrays
------

Settings of type `array` must contain an `item_type`
setting which specifies the type of the scalars contained in
the array.

Lists and arrays both get converted to a static array. A
field `<name>_len` is added containing the number of
elements in the array.


Parser API
==========

The prototype for the parser produced is:

```
int config_parser(
        config_setting_t* cfg, 
        struct config_items* config, 
        const char** errmsg);
```

- `cfg` is the root setting of a `libconfig` file that has
  been previously opened (using `config_init()`,
`config_read_file()`, and `config_lookup()` to extract the
root setting).

- `config` is the root configuration struct as output by
  `conf2struct`. The parser will fill that structure and
allocate memory for lists and arrays as required.

- `errmsg` is a text string that explains what went wrong if
  parsing failed (e.g. a mandatory option is missing).

`config_parser()` returns 0 on failure, 1 on success.


TODO
====

validation parameters, e.g. `min_length` / `max_length` for arrays and
lists, and strings, which can be verified to check the validity
of the configuration.

Similar project
===============

[x2struct](https://github.com/xyz347/x2struct) does a
similar job, but for C++, added constraints to the target
configuration file (while I did not want users to have to
change existing configuration files), and I didn't see how
to extend it to get useful error messages, default values,
and setting validation.
