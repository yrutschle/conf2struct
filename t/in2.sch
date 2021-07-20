header: "c2s.h"
parser: "c2s.c"

printer: true;

includes: ( "stdio.h", " <stdlib.h>" );

conffile_option: ("F", "conffile");

# Imaginary config file to demonstrate options, overrides,
# on global options and on lists.

config: {
         name : "eg",
         type: "list",
         items: (
            # Mandatory
            { name: "mybool"; type: "bool"; short: "b"; },
            { name: "myint"; type: "int"; short: "i"; },
            { name: "myint64"; type: "int64"; short: "I"; },
            { name: "myfloat"; type: "float";  short: "f"; },
            { name: "mystring"; type: "string";  short: "s"; },

            # Mandatory with default
            { name: "mymbool"; type: "bool"; default: true; },
            { name: "mymint"; type: "int";  default: 42; },
            { name: "mymint64"; type: "int64"; default: 42; },
            { name: "mymfloat"; type: "float"; default: 3.14159;  },
            { name: "mymstring"; type: "string"; default: "hello world"; },

            # Optional
            { name: "myobool"; type: "bool"; optional: true; },
            { name: "myoint"; type: "int";  optional: true;},
            { name: "myoint64"; type: "int64"; optional: true; },
            { name: "myofloat"; type: "float";  optional: true; },
            { name: "myostring"; type: "string";  optional: true; },

            # A variable string
            { name: "myvarstr"; type: "string"; var: true; },

            # A single group
            { name: "group", 
                type: "group", 
                no_cl_accessors: true;
                items: (
                    { name: "gmybool"; type: "bool"; short: "b"; },
                    { name: "gmyint"; type: "int"; short: "i"; },
                    { name: "gmyint64"; type: "int64"; short: "I"; },
                    { name: "gmyfloat"; type: "float";  short: "f"; },
                    { name: "gmystring"; type: "string";  short: "s"; }
                )
            },

            # A deep group
            { name: "dgroup", 
              type: "group", 
              items: (
              {name: "dlvl2"; type: "group"; items: (
                  {name: "dlvl3"; type: "group"; items: (
                      { name: "gdmybool"; type: "bool"; short: "b"; },
                      { name: "gdmyint"; type: "int"; short: "i"; },
                      { name: "gdmyint64"; type: "int64"; short: "I"; },
                      { name: "gdmyfloat"; type: "float";  short: "f"; },
                      { name: "gdmystring"; type: "string";  short: "s"; }
                  )},
                  {name: "list"; type: "list"; items: (
                      { name: "gdlint"; type: "int" }
                  )}
              )}
             )
            },

            # A list of groups
            { name: "list",
                type: "list",
                items: (
                      { name: "lmybool"; type: "bool"; short: "b"; },
                      { name: "lmyint"; type: "int"; short: "i"; },
                      { name: "lmyint64"; type: "int64"; short: "I"; },
                      { name: "lmyfloat"; type: "float";  short: "f"; },
                      { name: "lmystring"; type: "string";  short: "s"; }
                )
            },

            # Some runtime variables
            { name: "myrun1"; type: "runtime"; c_type: "void*"; },
            { name: "myrun2"; type: "runtime"; c_type: "int"; }

        )
}

# Compound options.
cl_groups: (
    { name: "group1"; pattern: "([[:digit:]]),([[:digit:]]+),(.*)";
      argdesc: "<bool>,<int>,<str>";   # in deep group
      list: "dgroup.dlvl2.dlvl3";
      override: "gdmystring";
      targets: (
                { path: "gdmybool"; value: "$1" },
                { path: "gdmyint"; value: "$2" },
                { path: "gdmyint64"; value: "12341234" },
                { path: "gdmystring"; value: "$3" }
               );
      },

    { name: "list-edit"; pattern: "([[:digit:]]),([[:digit:]]+),(.*)";
      list: "list";
      override: "lmystring";
      targets: (
                { path: "lmybool"; value: "$1" },
                { path: "lmyint"; value: "$2" },
                { path: "lmyint64"; value: "12341234" },
                { path: "lmystring"; value: "$3" }
               );
      },

    { name: "list_add"; pattern: "([[:digit:]]),([[:digit:]]+)";
      list: "list";
      targets: (
                { path: "lmybool"; value: "$1" },
                { path: "lmyint"; value: "$2" },
                { path: "lmyint64"; value: "12341234" },
                { path: "lmystring"; value: "initialised string" }
               );
      }
)
